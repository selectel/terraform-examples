output "datastore_types" {
  value = data.selectel_dbaas_datastore_type_v1.dt.datastore_types
}

output "datastore_flavors" {
  value = data.selectel_dbaas_flavor_v1.flavors.flavors
}

output "postgres_extentions" {
  value = data.selectel_dbaas_available_extension_v1.pg_extensions.available_extensions
}

output "postgres_user_setting_parameters" {
  value = data.selectel_dbaas_user_setting_parameter_v1.user_setting_parameters.user_setting_parameters
}

output "postgres_user_roles" {
  value = data.selectel_dbaas_roles_v1.user_roles.roles
}
