module "project" {
  source       = "../project"
  project_name = var.project_name
}
resource "selectel_iam_serviceuser_v1" "serviceuser_1" {
  name     = var.project_user_name
  password = var.user_password
  role {
    role_name = "member"
    scope     = "project"
    project_id = module.project.project_id
  }
}

module "keypair" {
  count  = var.keypair_name != "" ? 1 : 0
  source = "../keypair"

  keypair_name       = var.keypair_name
  keypair_public_key = file("~/.ssh/id_rsa.pub")
  keypair_user_id    = selectel_iam_serviceuser_v1.serviceuser_1.id
}
