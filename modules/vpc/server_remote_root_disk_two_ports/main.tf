resource "random_string" "random_name" {
  length  = 5
  special = false
}

module "flavor" {
  source        = "../flavor"
  flavor_name   = "flavor-${random_string.random_name.result}"
  flavor_vcpus  = var.server_vcpus
  flavor_ram_mb = var.server_ram_mb
}

module "nat" {
  source = "../nat"
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  cidr       = "10.0.0.0/24"
  network_id = module.nat.network_id

  dns_nameservers = ["188.93.16.19", "188.93.17.19"]
}

resource "openstack_networking_port_v2" "port_1" {
  name       = "${var.server_name}-eth0"
  network_id = module.nat.network_id

  fixed_ip {
    subnet_id = module.nat.subnet_id
  }
}

resource "openstack_networking_port_v2" "port_2" {
  name       = "${var.server_name}-eth1"
  network_id = module.nat.network_id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_2.id
  }
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

resource "openstack_blockstorage_volume_v3" "volume_1" {
  name              = "volume-for-${var.server_name}"
  size              = var.server_root_disk_gb
  image_id          = module.image_datasource.image_id
  volume_type       = var.server_volume_type
  availability_zone = var.server_zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_compute_instance_v2" "instance_1" {
  name              = var.server_name
  flavor_id         = module.flavor.flavor_id
  key_pair          = module.keypair.keypair_name
  availability_zone = var.server_zone

  network {
    port = openstack_networking_port_v2.port_1.id
  }

  network {
    port = openstack_networking_port_v2.port_2.id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.volume_1.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  metadata = {
    x_sel_server_default_addr = "{\"ipv4\":\"${openstack_networking_port_v2.port_1.all_fixed_ips.0}\"}"
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}

module "floatingip" {
  source = "../floatingip"
}

resource "openstack_networking_floatingip_associate_v2" "association_1" {
  port_id     = openstack_networking_port_v2.port_1.id
  floating_ip = module.floatingip.floatingip_address
}
