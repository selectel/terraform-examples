output "cluster_id" {
  value = selectel_dbaas_datastore_v1.datastore_1.id
}

output "cluster_status" {
  value = selectel_dbaas_datastore_v1.datastore_1.status
}

output "master_host" {
  value = selectel_dbaas_datastore_v1.datastore_1.connections["master"]
}
