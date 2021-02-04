module "project_with_user" {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/project_with_user"

  project_name  = var.project_name
  user_name     = var.user_name
  user_password = var.user_password
}

module "keypair" {
  providers = {
    selectel = selectel
  }
  source = "../../../modules/vpc/keypair"

  keypair_name       = var.keypair_name
  keypair_public_key = file("~/.ssh/id_rsa.pub")
  keypair_user_id    = module.project_with_user.user_id
}
