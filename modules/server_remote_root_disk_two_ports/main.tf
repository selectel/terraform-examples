data "openstack_networking_network_v2" "network_1" {
  name = "${var.server_network_name}"
}

resource "openstack_networking_port_v2" "port_1" {
  name           = "${var.server_name}-eth0"
  admin_state_up = "true"
  network_id     = "${data.openstack_networking_network_v2.network_1.id}"
}

resource "openstack_networking_network_v2" "network_2" {
  name           = "network_2"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  cidr       = "10.0.0.0/24"
  network_id = "${openstack_networking_network_v2.network_2.id}"

  dns_nameservers = ["188.93.16.19", "188.93.17.19", "109.234.159.91"]
}

resource "openstack_networking_port_v2" "port_2" {
  name           = "${var.server_name}-eth1"
  admin_state_up = "true"
  network_id     = "${openstack_networking_network_v2.network_2.id}"

  fixed_ip {
    subnet_id = "${openstack_networking_subnet_v2.subnet_2.id}"
  }
}

resource "openstack_blockstorage_volume_v3" "volume_1" {
  name              = "volume-for-${var.server_name}"
  size              = "${var.server_volume_size_gb}"
  image_id          = "${var.server_image_id}"
  volume_type       = "${var.server_volume_type}"
  availability_zone = "${var.server_availability_zone}"

  lifecycle {
    ignore_changes = ["image_id"]
  }
}

resource "openstack_compute_instance_v2" "instance_1" {
  name              = "${var.server_name}"
  flavor_id         = "${var.server_flavor_id}"
  key_pair          = "${var.server_keypair_name}"
  availability_zone = "${var.server_availability_zone}"

  network {
    port = "${openstack_networking_port_v2.port_1.id}"
  }

  network {
    port = "${openstack_networking_port_v2.port_2.id}"
  }

  block_device {
    uuid             = "${openstack_blockstorage_volume_v3.volume_1.id}"
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  metadata {
    x_sel_server_default_addr = "{\"ipv4\":\"${openstack_networking_port_v2.port_1.all_fixed_ips.0}\"}"
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
