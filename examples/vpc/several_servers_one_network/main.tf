# Initialize Selectel provider with service user credentials.
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

# Initialize Openstack provider
provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = var.region
}

# Create the main project with user.
# This module should be applied first.
module "project_with_user" {
  source = "../../../modules/vpc/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Create a network
module "nat" {
  source = "../../../modules/vpc/nat"
}

# Create OpenStack Compute instances.
module "multiple_servers" {
  source = "../../../modules/vpc/multiple_servers"

  replicas_count = var.count_of_servers

  # OpenStack Instance parameters.
  server_name         = var.server_name
  server_zone         = var.server_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_image_name   = var.server_image_name
  keypair_name        = var.keypair_name

  server_network_id = module.nat.network_id
  server_subnet_id  = module.nat.subnet_id
}
