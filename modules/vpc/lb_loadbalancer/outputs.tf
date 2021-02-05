output "loadbalancer_id" {
  value = openstack_lb_loadbalancer_v2.lb.id
}

output "floating_ip" {
  value = openstack_networking_floatingip_v2.floatingip.address
}
