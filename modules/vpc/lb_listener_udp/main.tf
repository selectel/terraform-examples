resource "openstack_lb_listener_v2" "listener" {
  protocol        = "UDP"
  protocol_port   = var.protocol_port
  loadbalancer_id = var.loadbalancer_id
}

resource "openstack_lb_pool_v2" "pool" {
  protocol    = openstack_lb_listener_v2.listener.protocol
  lb_method   = var.lb_method
  listener_id = openstack_lb_listener_v2.listener.id
}

resource "openstack_lb_monitor_v2" "monitor" {
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = var.monitor_type
  delay       = var.monitor_delay
  timeout     = var.monitor_timeout
  max_retries = var.monitor_retries
}
