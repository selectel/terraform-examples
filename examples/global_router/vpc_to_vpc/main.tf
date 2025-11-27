# initialize Openstack providers
provider "openstack" {
  alias               = "ru-1"
  region              = var.region_name1
  user_name           = var.username
  tenant_name         = var.project_name
  password            = var.password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
}

provider "openstack" {
  alias               = "ru-2"
  region              = var.region_name2
  user_name           = var.username
  tenant_name         = var.project_name
  password            = var.password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
}

# initialize Selectel provider
provider "selectel" {
  domain_name = var.domain_name
  username    = var.username
  password    = var.password
  auth_region = var.region_name1
  auth_url    = var.auth_url
}

# cloud region one
module "resources_cloud_ru_1" {
  source            = "./networks_with_vm"
  router_ip1        = var.router_ip11
  subnet_cidr1      = var.subnet_cidr11
  dest_subnet_cidr1 = var.subnet_cidr21
  gw_ip1            = var.gw_ip11
  vm_ip1            = var.vm_ip11
  target_zone       = var.target_zone1
  public_ssh_key    = file("~/.ssh/id_rsa.pub")
  user_data1        = var.user_data1

  providers = {
    openstack = openstack.ru-1
  }
}

# cloud region two
module "resources_cloud_ru_2" {
  source            = "./networks_with_vm"
  router_ip1        = var.router_ip21
  subnet_cidr1      = var.subnet_cidr21
  dest_subnet_cidr1 = var.subnet_cidr11
  gw_ip1            = var.gw_ip21
  vm_ip1            = var.vm_ip21
  target_zone       = var.target_zone2
  public_ssh_key    = file("~/.ssh/id_rsa.pub")
  user_data1        = var.user_data1

  providers = {
    openstack = openstack.ru-2
  }
}

module "global_router" {
  source = "./global_router_resources"

  region_name1 = var.region_name1
  region_name2 = var.region_name2
  project_id   = var.project_id

  os_network_id_region_1 = module.resources_cloud_ru_1.os_network_id
  subnet_cidr1           = var.subnet_cidr11
  os_subnet_id_region_1  = module.resources_cloud_ru_1.os_subnet_id
  gw_ip1                 = var.gw_ip11
  gr_service_addresses1  = var.gr_service_addresses11

  os_network_id_region_2 = module.resources_cloud_ru_2.os_network_id
  subnet_cidr2           = var.subnet_cidr21
  gw_ip2                 = var.gw_ip21
  gr_service_addresses2  = var.gr_service_addresses21
  os_subnet_id_region_2  = module.resources_cloud_ru_2.os_subnet_id
}
