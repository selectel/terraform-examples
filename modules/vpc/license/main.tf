resource "selectel_vpc_license_v2" "license_1" {
  project_id = var.license_project_id
  region     = var.license_region
  type       = var.license_type
}
