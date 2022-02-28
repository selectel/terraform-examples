resource "openstack_lb_listener_v2" "listener" {
  name            = "Listener"
  protocol        = var.lb_components["listener_protocol"]
  protocol_port   = var.lb_components["listener_protocol_port"]
  loadbalancer_id = var.loadbalancer_id
}

resource "openstack_lb_pool_v2" "pool" {
  name        = "Pool"
  protocol    = var.lb_components["pool_protocol"]
  lb_method   = var.lb_components["pool_lb_method"]
  listener_id = openstack_lb_listener_v2.listener.id
}

resource "openstack_lb_monitor_v2" "monitor" {
  name        = "Monitor"
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = var.lb_components["monitor_type"]
  delay       = var.lb_components["monitor_delay"]
  timeout     = var.lb_components["monitor_timeout"]
  max_retries = var.lb_components["monitor_retries"]
}

resource "openstack_lb_members_v2" "member" {
  pool_id = openstack_lb_pool_v2.pool.id

  dynamic "member" {
    for_each = var.server_access_ips
    content {
        name           = "Member"
        subnet_id      = var.vip_subnet_id
        address        = member.value
        protocol_port  = var.lb_components["member_protocol_port"]
        weight         = 1
        backup         = false
        admin_state_up = true
    }
  }
}
