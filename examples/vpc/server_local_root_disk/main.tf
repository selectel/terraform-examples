# Initialize Selectel provider with service user credentials.
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

# Create the main project with user.
# This module should be applied first:
# terraform apply -target=module.project_with_user
module "project_with_user" {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Initialize Openstack provider.
provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = var.region
}

# Create an OpenStack Compute instance.
module "server_local_root_disk" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/server_local_root_disk"

  # OpenStack Instance parameters.
  server_name         = var.server_name
  server_zone         = var.server_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_image_name   = var.server_image_name
  server_ssh_key      = file("~/.ssh/id_rsa.pub")
  server_ssh_key_user = module.project_with_user.user_id

  depends_on = [
    module.project_with_user,
  ]
}
