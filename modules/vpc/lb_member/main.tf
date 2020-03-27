resource "openstack_lb_member_v2" "member" {
  count         = length(var.lb_members)
  pool_id       = var.lb_pool_id
  address       = var.lb_members[count.index]
  protocol_port = var.lb_protocol_port
}
