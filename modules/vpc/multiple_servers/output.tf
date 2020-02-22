output "server_ids" {
  value = openstack_compute_instance_v2.instance[*].id
}

output "server_port_ids" {
  value = openstack_networking_port_v2.port[*].id
}