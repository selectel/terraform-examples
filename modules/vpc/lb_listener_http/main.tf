resource "openstack_lb_listener_v2" "listener" {
  protocol        = "HTTP"
  protocol_port   = var.protocol_port
  loadbalancer_id = var.loadbalancer_id
  insert_headers = {
    X-Forwarded-For   = var.x_forwarded_for
    X-Forwarded-Port  = var.x_forwarded_port
    X-Forwarded-Proto = var.x_forwarded_proto
  }
}

resource "openstack_lb_pool_v2" "pool" {
  protocol    = openstack_lb_listener_v2.listener.protocol
  lb_method   = var.lb_method
  listener_id = openstack_lb_listener_v2.listener.id

  persistence {
    type        = var.pool_type
    cookie_name = var.pool_cookie
  }
}

resource "openstack_lb_monitor_v2" "monitor" {
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = var.monitor_type
  delay       = var.monitor_delay
  timeout     = var.monitor_timeout
  max_retries = var.monitor_retries
}
