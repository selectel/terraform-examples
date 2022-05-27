# Инициализация провайдера Selectel
provider "selectel" {
  token = var.sel_token
}

# Создание проекта, пользователя и роли
module "selectel_section" {
  source = "../../../modules/vpc/project_with_user"

  project_name  = var.project_name
  user_name     = var.user_name
  user_password = var.user_password
}

# Создание лицензии Windows
module "win_license" {
  source = "../../../modules/vpc/license"

  license_project_id = module.selectel_section.project_id
  license_region     = substr(var.server_zone, 0, 4)
  license_type       = var.license_type
}

# Инициализация провайдера Openstack
provider "openstack" {
  user_name           = var.user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = regex("[[:digit:]]+$", var.sel_token)
  user_domain_name    = regex("[[:digit:]]+$", var.sel_token)
  auth_url            = var.os_auth_url
  region              = substr(var.server_zone, 0, 4)
}

# Создание ресурсов Openstack
module "server_remote_root_disk" {
  source = "../../../modules/vpc/server_remote_root_disk"

  server_name         = var.server_name
  server_zone         = var.server_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_volume_type  = var.server_volume_type
  server_image_name   = var.server_image_name
  server_ssh_key      = file("~/.ssh/id_rsa.pub")
  server_ssh_key_user = module.selectel_section.user_id
  server_license_type = var.license_type
  depends_on = [
    module.selectel_section,
    module.win_license,
  ]
}
