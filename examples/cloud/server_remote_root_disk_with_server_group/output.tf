output "server_id" {
  value = module.server_remote_root_disk.server_id
}

output "floating_ip" {
  value = module.server_remote_root_disk.floating_ip
}

output "server_group_name" {
  value = module.custom_server_group.server_group_name
}

output "server_group_id" {
  value = module.custom_server_group.server_group_id
}
