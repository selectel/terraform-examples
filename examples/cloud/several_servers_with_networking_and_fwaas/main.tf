# Инициализация провайдера Selectel
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

# Инициализация провайдера Openstack
provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = var.region
}

# Создание ресурсов Selectel
module "selectel_section" {
  source = "../../../modules/cloud/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Создание ресурсов Openstack
module "multiple_servers_with_fwaas" {
  source = "../../../modules/cloud/multiple_servers_with_fwaas"

  server_name            = var.server_name
  server_zone            = var.server_zone
  server_image_name      = var.server_image_name
  server_root_disk_gb    = var.server_root_disk_gb
  server_flavor_id       = var.server_flavor_id
  server_volume_type     = var.server_volume_type
  server_ssh_key         = file("~/.ssh/id_rsa.pub")
  server_ssh_key_user    = module.selectel_section.user_id

  depends_on = [
    module.selectel_section,
  ]
}
