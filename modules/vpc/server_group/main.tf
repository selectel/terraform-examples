resource "openstack_compute_servergroup_v2" "server_group_1" {
  name     = var.server_group_name
  policies = var.policies
}