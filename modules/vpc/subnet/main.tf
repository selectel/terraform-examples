resource "selectel_vpc_subnet_v2" "subnet_1" {
  project_id    = var.subnet_project_id
  region        = var.subnet_region
  prefix_length = var.subnet_prefix_length
  ip_version    = var.subnet_ip_version
}
