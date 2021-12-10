# Инициализация провайдера Openstack
provider "openstack" {
  user_name           = var.user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.project_domain_name
  user_domain_name    = var.user_domain_name
  auth_url            = var.os_auth_url
  region              = substr(var.target_zone, 0, 4)
  use_octavia         = true
}

# Создание ресурсов Openstack
module "openstack_environment" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/os_lb_env"

  target_zone        = var.target_zone
  keypair_name       = var.keypair_name
  server_image_name  = var.server_image_name
}

# Создание балансировщика базового типа без резервирования и с TCP/UDP правилами
module "openstack_lb_sngl" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/lb_sngl"

  lb_sngl_name          = var.lb_sngl_name
  lb_sngl_components    = var.lb_sngl_components
  lb_sngl_flavor_uuid   = var.lb_sngl_flavor_uuid
  lb_public_subnet_id   = module.openstack_environment.public_subnet_id
  lb_servers_access_ips = module.openstack_environment.public_network_ips
}

# Создание балансировщика базового типа с резервированием, HTTPS правилом и SSL сертификатом
module "openstack_lb_active_standby" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/lb_active_standby"

  lb_active_name        = var.lb_active_name
  lb_active_components  = var.lb_active_components
  lb_active_flavor_uuid = var.lb_active_flavor_uuid
  lb_private_subnet_id  = module.openstack_environment.private_subnet_id
  lb_servers_access_ips = module.openstack_environment.private_network_ips
  lb_ssl_container      = var.ssl_container_file

  depends_on = [
    module.openstack_environment,
  ]
}
