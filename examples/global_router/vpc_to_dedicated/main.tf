# initialize Openstack provider
provider "openstack" {
  region              = var.region_name1
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
module "resources_cloud" {
  source            = "./networks_with_vm"
  router_ip1        = var.router_ip11
  subnet_cidr1      = var.subnet_cidr1
  gw_ip1            = var.gw_ip11
  vm_ip1            = var.vm_ip11
  target_zone       = var.target_zone1
  public_ssh_key    = file("~/.ssh/id_rsa.pub")
  user_data1        = var.user_data1
  dest_subnet_cidr1 = var.subnet_cidr2
}

# dedicated region 
module "resources_dedicated" {
  source          = "./dedicated_server_with_net"
  subnet_cidr1    = var.subnet_cidr2
  price_plan_name = var.price_plan_name
  region_name     = var.region_name2
  project_id      = var.project_id
}

module "global_router" {
  source = "./global_router_resources"

  region_name1 = var.region_name1
  region_name2 = var.region_name2
  project_id   = var.project_id

  os_network_id         = module.resources_cloud.os_network_id
  subnet_cidr1          = var.subnet_cidr1
  os_subnet_id          = module.resources_cloud.os_subnet_id
  gw_ip1                = var.gw_ip11
  gr_service_addresses1 = var.gr_service_addresses11

  subnet_cidr2          = var.subnet_cidr2
  gw_ip2                = var.gw_ip21
  dedicated_vlan        = var.dedicated_vlan
  gr_service_addresses2 = var.gr_service_addresses21
}
