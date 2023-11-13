# Initialize Selectel provider with service user.
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

# Create the main project with user.
# This module should be applied first:
# terraform apply -target=module.project_with_user
module "project_with_user" {
  source = "../../../modules/vpc/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Create an OpenStack Compute instance.
module "server_local_and_remote_disks" {
  source = "../../../modules/vpc/server_local_and_remote_disks"

  # OpenStack auth.
  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
  domain_name       = var.domain_name
  auth_url          = var.auth_url
  region            = var.region

  # OpenStack Instance parameters.
  server_name               = var.server_name
  server_zone               = var.server_zone
  server_vcpus              = var.server_vcpus
  server_ram_mb             = var.server_ram_mb
  server_root_disk_gb       = var.server_root_disk_gb
  server_second_disk_gb     = var.server_second_disk_gb
  server_second_volume_type = var.server_second_volume_type
  server_image_name         = var.server_image_name
  server_ssh_key            = file("~/.ssh/id_rsa.pub")
  server_ssh_key_user       = module.project_with_user.user_id
}
