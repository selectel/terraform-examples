resource "openstack_compute_flavor_v2" "flavor_1" {
  name      = var.flavor_name
  ram       = var.flavor_ram_mb
  vcpus     = var.flavor_vcpus
  disk      = var.flavor_local_disk_gb
  is_public = var.flavor_is_public

  lifecycle {
    create_before_destroy = true
  }

}
