resource "selectel_vpc_project_v2" "project_1" {
  name        = var.project_name
  auto_quotas = true
}
