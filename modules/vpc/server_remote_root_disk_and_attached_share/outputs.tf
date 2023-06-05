output "share_id" {
  value = module.share.share_id
}

output "share_export_location_path" {
  value = module.share.share_export_location_path
}

output "server_ip" {
  value = openstack_networking_floatingip_v2.fip_tf.address
}
