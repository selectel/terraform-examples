output "lb_pool_id" {
  value = openstack_lb_pool_v2.pool.id
}

output "lb_protocol_port" {
  value = openstack_lb_listener_v2.listener.protocol_port
}
