output "lb_floating" {
  value = openstack_networking_floatingip_v2.floatingip.address
}
