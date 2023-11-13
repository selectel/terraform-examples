# Инициализация провайдера Selectel
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

# Создание проекта, пользователя и роли
module "selectel_section" {
  source = "../../../modules/vpc/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Инициализация провайдера Openstack
provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
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
  depends_on = [
    module.selectel_section,
  ]
}
