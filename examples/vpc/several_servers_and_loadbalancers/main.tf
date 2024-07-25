# Инициализация terraform провайдера Selectel
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

# Создание проекта, пользователя и роли
module "selectel_section" {
  providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Создание сертификата в менеджере секретов Селектел
module "secrets_manager_certificate" {
    providers = {
    selectel = selectel,
  }
  source = "../../../modules/vpc/secrets_manager_certificate"

  project_id        = module.selectel_section.project_id
  certificates_file = [file("./ssl_certificate/_cert.pem")]
  private_key_file  = file("./ssl_certificate/_private_key.pem")
}

# Инициализация провайдера Openstack
provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = substr(var.target_zone, 0, 4)
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

  depends_on = [
    module.selectel_section,
  ]
}

# Создание балансировщика базового типа без резервирования с TCP/UDP правилами
module "openstack_lb_sngl" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/lb_sngl"

  lb_sngl_name          = var.lb_sngl_name
  lb_sngl_components    = var.lb_sngl_components
  lb_sngl_flavor_name   = var.lb_sngl_flavor_name
  lb_public_subnet_id   = module.openstack_environment.public_subnet_id
  lb_servers_access_ips = module.openstack_environment.public_network_ips

  depends_on = [
    module.openstack_environment,
  ]
}

# Создание балансировщика базового типа с резервированием, HTTPS правилом
module "openstack_lb_active_standby" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/lb_active_standby"

  lb_active_name        = var.lb_active_name
  lb_active_components  = var.lb_active_components
  lb_active_flavor_name = var.lb_active_flavor_name
  lb_private_subnet_id  = module.openstack_environment.private_subnet_id
  lb_servers_access_ips = module.openstack_environment.private_network_ips

  depends_on = [
    module.openstack_environment,
  ]
}

# Создание балансировщика базового типа с резервированием, HTTPS правилом и сертификатом
module "openstack_lb_active_standby_with_certificate" {
  providers = {
    openstack = openstack,
  }
  source = "../../../modules/vpc/lb_active_standby_with_certificate"

  lb_active_name        = var.lb_active_name
  lb_active_components  = var.lb_active_https_components
  lb_active_flavor_name = var.lb_active_flavor_name
  lb_private_subnet_id  = module.openstack_environment.private_subnet_id
  lb_servers_access_ips = module.openstack_environment.private_network_ips
  tls_container_ref     = module.secrets_manager_certificate.tls_container_ref

  depends_on = [
    module.openstack_environment,
  ]
}
