module "project_with_user" {
  source = "../project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
  keypair_name      = var.keypair_name
}

module "public_subnet_29" {
  source = "../subnet"

  subnet_region     = substr(var.target_zone, 0, 4)
  subnet_project_id = module.project_with_user.project_id
}
