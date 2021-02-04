# Initialize providers.
provider "selectel" {
  token = var.sel_token
}

provider "openstack" {
  user_name           = var.user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = regex("[[:digit:]]+$", var.sel_token)
  user_domain_name    = regex("[[:digit:]]+$", var.sel_token)
  auth_url            = var.os_auth_url
  region              = substr(var.target_zone, 0, 4)
  use_octavia         = true
}

# Create the main project with user.
module "selectel_section" {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/lb_selvpc"

  user_password = var.user_password
  project_name  = var.project_name
  user_name     = var.user_name
  target_zone   = var.target_zone
  keypair_name  = var.keypair_name
}

# Openstack Loadbalancer section
module "openstack_section" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/lb_os"

  target_zone        = var.target_zone
  keypair_name       = var.keypair_name
  count_of_servers   = var.count_of_servers
  server_image_name  = var.server_image_name
  lb_flavor_id       = var.lb_flavor_id
  lb_components_http = var.lb_components_http
  lb_components      = var.lb_components

  depends_on = [
    module.selectel_section,
  ]
}
