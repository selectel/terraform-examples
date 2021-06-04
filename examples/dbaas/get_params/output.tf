output "datastore_types" {
  value = data.selectel_dbaas_datastore_type_v1.dt.datastore_types
}

output "datastore_flavors" {
  value = data.selectel_dbaas_flavor_v1.flavors.flavors
}

output "postgres_extentions" {
  value = data.selectel_dbaas_available_extension_v1.pg_extensions.available_extensions
}
