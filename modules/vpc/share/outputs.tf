output "share_id" {
  value = openstack_sharedfilesystem_share_v2.share_1.id
}

output "share_export_location_path" {
  value = openstack_sharedfilesystem_share_v2.share_1.export_locations[0]["path"]
}

output "share_proto" {
  value = openstack_sharedfilesystem_share_v2.share_1.share_proto
}
