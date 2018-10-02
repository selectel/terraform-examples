resource "openstack_compute_instance_v2" "instance_1" {
  name              = "${var.server_name}"
  image_id          = "${var.server_image_id}"
  flavor_id         = "${var.server_flavor_id}"
  key_pair          = "${var.server_keypair_name}"
  availability_zone = "${var.server_availability_zone}"

  network {
    name = "${var.server_network_name}"
  }

  lifecycle {
    ignore_changes = ["image_id"]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
