output "floating_ip" {
  value = module.floatingip_1.floatingip_address
}

output "os_network_id" {
  value = openstack_networking_network_v2.network_1.id
}

output "os_subnet_id" {
  value = openstack_networking_subnet_v2.subnet_1.id
}


