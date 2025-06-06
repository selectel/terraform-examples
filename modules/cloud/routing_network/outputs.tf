output "main_server_subnet_one_port_id" {
  value = openstack_networking_port_v2.main_server_subnet_one_port.id
}

output "main_server_subnet_three_port_id" {
  value = openstack_networking_port_v2.main_server_subnet_three_port.id
}

output "server_with_docker_subnet_two_port_id" {
  value = openstack_networking_port_v2.server_with_docker_subnet_two_port.id
}

output "proxy_server_subnet_three_port_id" {
  value = openstack_networking_port_v2.proxy_server_subnet_three_port.id
}

output "proxy_server_public_subnet_port_id" {
  value = openstack_networking_port_v2.proxy_server_public_subnet_port.id
}

output "main_server_subnet_one_port_ip" {
  value = openstack_networking_port_v2.main_server_subnet_one_port.all_fixed_ips.0
}

output "main_server_subnet_three_port" {
  value = openstack_networking_port_v2.main_server_subnet_three_port.all_fixed_ips.0
}

output "server_with_docker_subnet_two_port_ip" {
  value = openstack_networking_port_v2.server_with_docker_subnet_two_port.all_fixed_ips.0
}

output "proxy_server_public_subnet_port_ip" {
  value = openstack_networking_port_v2.proxy_server_public_subnet_port.all_fixed_ips.0
}
