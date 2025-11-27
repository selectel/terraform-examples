# Configure Networking
data "openstack_networking_network_v2" "external_net" {
  name = "external-network"
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "terraform-public_router1_${substr(var.target_zone, 0, 4)}"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

resource "openstack_networking_network_v2" "network_1" {
  name = "terraform-net1-gr-${substr(var.target_zone, 0, 4)}"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id      = openstack_networking_network_v2.network_1.id
  name            = var.subnet_cidr1
  cidr            = var.subnet_cidr1
  enable_dhcp     = false
  dns_nameservers = var.dns_nameservers
  # connect via FIP
  gateway_ip = var.router_ip1
}

resource "openstack_networking_subnet_route_v2" "subnet_route_1" {
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
  # route to another GlobalRouter network
  destination_cidr = var.dest_subnet_cidr1
  next_hop         = var.gw_ip1
}

# Ports for VM instances
resource "openstack_networking_port_v2" "vm_port_1" {
  name       = "${var.server_name}-eth0"
  network_id = openstack_networking_network_v2.network_1.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_1.id
    ip_address = var.vm_ip1
  }
}

# Router ports
resource "openstack_networking_port_v2" "port_router_1" {
  name       = "${var.server_name}-eth0"
  network_id = openstack_networking_network_v2.network_1.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_1.id
    ip_address = var.router_ip1
  }
}

# Router attachments
resource "openstack_networking_router_interface_v2" "router_1_interface_1" {
  router_id = openstack_networking_router_v2.router_1.id
  port_id   = openstack_networking_port_v2.port_router_1.id
}

resource "openstack_compute_keypair_v2" "my_keypair" {
  name       = "terraform_keypair"
  public_key = var.public_ssh_key
}

resource "openstack_compute_flavor_v2" "flavor_1" {
  name      = "custom-flavor-with-network-volume-terraform"
  vcpus     = 1
  ram       = 1024
  disk      = 5
  is_public = false

  lifecycle {
    create_before_destroy = true
  }

}

# Get information about OS image
module "image_datasource" {
  source     = "../../../../modules/cloud/image_datasource"
  image_name = var.server_image_name
}

# Create VM instance
resource "openstack_compute_instance_v2" "cloud_vm" {
  name              = "${var.server_name}-1-${substr(var.target_zone, 0, 4)}"
  image_id          = module.image_datasource.image_id
  flavor_id         = resource.openstack_compute_flavor_v2.flavor_1.id
  key_pair          = openstack_compute_keypair_v2.my_keypair.id
  availability_zone = var.target_zone
  user_data         = var.user_data1


  network {
    port = openstack_networking_port_v2.vm_port_1.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}

# FIP to VMs

module "floatingip_1" {
  source = "../../../../modules/cloud/floatingip"
}

resource "openstack_networking_floatingip_associate_v2" "association_vm1" {
  port_id     = openstack_networking_port_v2.vm_port_1.id
  floating_ip = module.floatingip_1.floatingip_address
}
