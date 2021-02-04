resource "random_string" "random_name" {
  length  = 5
  special = false
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = "loadbalancer_${random_string.random_name.result}"
  vip_subnet_id = var.vip_subnet_id
  flavor_id     = var.lb_flavor_id
}

resource "openstack_networking_floatingip_v2" "floatingip" {
  pool    = "external-network"
  port_id = openstack_lb_loadbalancer_v2.lb.vip_port_id
}
