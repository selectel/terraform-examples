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
    name = "${var.server_network_name}"
  }

  block_device {
    uuid             = "${openstack_blockstorage_volume_v3.volume_1.id}"
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
