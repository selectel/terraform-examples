resource "openstack_compute_flavor_v2" "openstack_compute_flavor_1" {
    name  = "${var.flavor_name}"
    ram   = "${var.flavor_ram_mb}"
    vcpus = "${var.flavor_vcpus}"
    disk  = "${var.flavor_local_disk_gb}"
}