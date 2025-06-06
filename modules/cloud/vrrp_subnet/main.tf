resource "selectel_vpc_vrrp_subnet_v2" "vrrp_subnet_1" {
  project_id    = var.vrrp_subnet_project_id
  master_region = var.vrrp_subnet_master_region
  slave_region  = var.vrrp_subnet_slave_region
  prefix_length = var.vrrp_subnet_prefix_length
  ip_version    = var.vrrp_subnet_ip_version
}
