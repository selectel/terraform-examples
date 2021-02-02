module "project" {
  source       = "../project"
  project_name = var.project_name
}

module "user" {
  source        = "../user"
  user_name     = var.user_name
  user_password = var.user_password
}

module "role" {
  source          = "../role"
  role_project_id = module.project.project_id
  role_user_id    = module.user.user_id
}
