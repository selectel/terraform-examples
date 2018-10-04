data "openstack_networking_network_v2" "network_1" {
  name = "${var.server_network_name}"
}

resource "openstack_networking_port_v2" "port_1" {
  name           = "${var.server_name}-eth0"
  admin_state_up = "true"
  network_id     = "${data.openstack_networking_network_v2.network_1.id}"
}

resource "openstack_compute_instance_v2" "instance_1" {
  name              = "${var.server_name}"
  image_id          = "${var.server_image_id}"
  flavor_id         = "${var.server_flavor_id}"
  key_pair          = "${var.server_keypair_name}"
  availability_zone = "${var.server_availability_zone}"

  network {
    port = "${openstack_networking_port_v2.port_1.id}"
  }

  lifecycle {
    ignore_changes = ["image_id"]
  }

  metadata {
    x_sel_server_default_addr = "{\"ipv4\":\"${openstack_networking_port_v2.port_1.all_fixed_ips.0}\"}"
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
