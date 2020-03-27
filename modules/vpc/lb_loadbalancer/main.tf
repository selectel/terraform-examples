resource "openstack_lb_loadbalancer_v2" "lb" {
  vip_subnet_id = var.vip_subnet_id
}

resource "openstack_networking_floatingip_v2" "floatingip" {
  pool    = "external-network"
  port_id = openstack_lb_loadbalancer_v2.lb.vip_port_id
}
