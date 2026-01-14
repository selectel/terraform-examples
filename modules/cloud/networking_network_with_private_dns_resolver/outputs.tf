output "network_id" {
  value = openstack_networking_network_v2.network_1.id
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.subnet_1.id
}

output "resolver_addresses" {
  value = selectel_private_dns_service_v1.service_1.addresses
}
