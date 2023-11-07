# Initialize Selectel provider with service user credentials.
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = substr(var.target_zone, 0, 4)
}

module "selectel_section" {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/routing_selvpc"

  user_password     = var.user_password
  project_name      = var.project_name
  project_user_name = var.project_user_name
  target_zone       = var.target_zone
  keypair_name      = var.keypair_name
}

module "openstack_section" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/routing_os"

  selvpc_network_id  = module.selectel_section.selvpc_network_id
  selvpc_subnet_id   = module.selectel_section.selvpc_subnet_id
  selvpc_subnet_cidr = module.selectel_section.selvpc_subnet_cidr
  keypair_name       = var.keypair_name
  target_zone        = var.target_zone
  server_image_name  = var.server_image_name

  depends_on = [
    module.selectel_section,
  ]
}
