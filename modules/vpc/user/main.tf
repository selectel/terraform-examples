resource "selectel_vpc_user_v2" "user_1" {
  name     = var.project_user_name
  password = var.user_password
}
