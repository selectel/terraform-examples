output "floatingip_id" {
  value = "${selvpc_resell_floatingip_v2.floatingip_1.id}"
}

output "floatingip_address" {
  value = "${selvpc_resell_floatingip_v2.floatingip_1.floating_ip_address}"
}
