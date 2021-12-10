resource "openstack_lb_listener_v2" "listener" {
  name                      = "Listener"
  protocol                  = var.lb_components["listener_protocol"]
  protocol_port             = var.lb_components["listener_protocol_port"]
  loadbalancer_id           = var.loadbalancer_id
  default_tls_container_ref = var.default_tls_container_ref
  insert_headers = {
    X-Forwarded-For   = var.lb_components["listener_x_forwarded_for"]
    X-Forwarded-Port  = var.lb_components["listener_x_forwarded_port"]
    X-Forwarded-Proto = var.lb_components["listener_x_forwarded_proto"]
  }
}

resource "openstack_lb_pool_v2" "pool" {
  name        = "Pool"
  protocol    = var.lb_components["pool_protocol"]
  lb_method   = var.lb_components["pool_lb_method"]
  listener_id = openstack_lb_listener_v2.listener.id

  persistence {
    type        = var.lb_components["pool_cookie_type"]
    cookie_name = var.lb_components["pool_cookie_name"]
  }
}

resource "openstack_lb_monitor_v2" "monitor" {
  name        = "Monitor"
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = var.lb_components["monitor_type"]
  url_path    = var.lb_components["monitor_url_path"]
  delay       = var.lb_components["monitor_delay"]
  timeout     = var.lb_components["monitor_timeout"]
  max_retries = var.lb_components["monitor_retries"]
}

resource "openstack_lb_member_v2" "member" {
  count         = length(var.server_access_ips)
  name          = "Member"
  subnet_id     = var.vip_subnet_id
  pool_id       = openstack_lb_pool_v2.pool.id
  address       = var.server_access_ips[count.index]
  protocol_port = var.lb_components["member_protocol_port"]
}
