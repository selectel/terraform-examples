output "server_id" {
  value = openstack_compute_instance_v2.instance_1.id
}

output "public_ip" {
  value = selectel_vpc_public_port_v1.public_port_1.ip_address
}

output "security_group_id" {
  value = openstack_networking_secgroup_v2.secgroup_1.id
}
