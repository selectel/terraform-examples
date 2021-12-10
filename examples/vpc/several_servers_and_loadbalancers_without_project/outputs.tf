output "single_lb_floating" {
  value = module.openstack_lb_sngl.lb_floating
}

output "active_lb_floating" {
  value = module.openstack_lb_active_standby.lb_floating
}
