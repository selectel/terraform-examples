output "server_id" {
  value = "${openstack_compute_instance_v2.openstack_compute_instance_1.id}"
}

output "server_root_volume_id" {
  value = "${openstack_blockstorage_volume_v3.openstack_blockstorage_volume_1.id}"
}
