output "router_id" {
  value = openstack_networking_router_v2.router_1.id
}

output "network_id" {
  value = openstack_networking_network_v2.network_1.id
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.subnet_1.id
}
