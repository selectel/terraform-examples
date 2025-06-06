output "public_network_ips" {
  value = openstack_compute_instance_v2.instance.network[1].fixed_ip_v4
}

output "private_network_ips" {
  value = openstack_compute_instance_v2.instance.network[0].fixed_ip_v4
}
