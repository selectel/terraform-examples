provider selectel {
  token = var.sel_token
}

provider openstack {
  user_name           = var.user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = regex("[[:digit:]]+$", var.sel_token)
  user_domain_name    = regex("[[:digit:]]+$", var.sel_token)
  auth_url            = var.os_auth_url
  region              = substr(var.target_zone, 0, 4)
}

module selectel_section {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/routing_example_selvpc"

  user_password = var.user_password
  project_name  = var.project_name
  user_name     = var.user_name
  target_zone   = var.target_zone
  keypair_name  = var.keypair_name
}

module openstack_section {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/routing_example_os"

  selvpc_network_id   = module.selectel_section.selvpc_network_id
  selvpc_subnet_id    = module.selectel_section.selvpc_subnet_id
  selvpc_subnet_cidr  = module.selectel_section.selvpc_subnet_cidr
  keypair_name        = var.keypair_name
  target_zone         = var.target_zone
  server_image_name   = var.server_image_name

  depends_on = [
    module.selectel_section,
  ]
}
