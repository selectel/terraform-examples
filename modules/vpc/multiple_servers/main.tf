resource "random_string" "random_name" {
  length  = 5
  special = false
}

resource "random_string" "random_server_name" {
  count   = var.replicas_count
  length  = 5
  special = false
}

module "flavor" {
  source               = "../flavor"
  flavor_name          = "flavor-${random_string.random_name.result}"
  flavor_vcpus         = var.server_vcpus
  flavor_ram_mb        = var.server_ram_mb
  flavor_local_disk_gb = var.server_root_disk_gb
}

module "image_datasource" {
  source     = "../image_datasource"
  image_name = var.server_image_name
}

module "keypair" {
  source             = "../keypair"
  keypair_name       = "keypair-${random_string.random_name.result}"
  keypair_public_key = var.server_ssh_key
  keypair_user_id    = var.server_ssh_key_user
}

resource "openstack_networking_port_v2" "port" {
  count      = var.replicas_count
  name       = "${var.server_name}-${random_string.random_server_name[count.index].result}-eth0"
  network_id = var.server_network_id

  fixed_ip {
    subnet_id = var.server_subnet_id
  }
}

resource "openstack_compute_instance_v2" "instance" {
  count             = var.replicas_count
  name              = "${var.server_name}-${random_string.random_server_name[count.index].result}"
  image_id          = module.image_datasource.image_id
  flavor_id         = module.flavor.flavor_id
  key_pair          = module.keypair.keypair_name
  availability_zone = var.server_zone

  network {
    port = openstack_networking_port_v2.port[count.index].id
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}