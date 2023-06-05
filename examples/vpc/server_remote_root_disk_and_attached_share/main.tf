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

# Create a server_remote_root_disk_and_attached_share and server, then mount server_remote_root_disk_and_attached_share to server
module "server_remote_root_disk_connected_share" {
  source = "../../../modules/vpc/server_remote_root_disk_and_attached_share"

  base_name = var.base_name

  flavor_id = var.flavor_id
  server_image_name = var.server_image_name
  server_volume_type = var.server_volume_type
  server_volume_size = var.server_volume_size
  server_region = var.server_region
  server_zone = var.server_zone

  subnet_cidr = var.subnet_cidr

  ssh_key_path = var.ssh_key_path
  ssh_user = var.ssh_user

  share_type = var.share_type
  share_size = var.share_size
  share_proto = var.share_proto
  share_allowed_ip = var.share_allowed_ip

  depends_on = [
    module.selectel_section,
  ]
}
