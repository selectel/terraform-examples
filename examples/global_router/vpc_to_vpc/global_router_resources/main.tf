data "selectel_global_router_zone_v1" "vpc_ru_1" {
  name    = var.region_name1
  service = "vpc"
}

data "selectel_global_router_zone_v1" "vpc_ru_2" {
  name    = var.region_name2
  service = "vpc"
}

resource "selectel_global_router_router_v1" "gr_router" {
  name = "my-router"
}

resource "selectel_global_router_vpc_network_v1" "gr_network_11" {
  router_id     = selectel_global_router_router_v1.gr_router.id
  zone_id       = data.selectel_global_router_zone_v1.vpc_ru_1.id
  os_network_id = var.os_network_id_region_1
  project_id    = var.project_id
  name          = "gr_net_ru_1"
}


resource "selectel_global_router_vpc_network_v1" "gr_network_21" {
  router_id     = selectel_global_router_router_v1.gr_router.id
  zone_id       = data.selectel_global_router_zone_v1.vpc_ru_2.id
  os_network_id = var.os_network_id_region_2
  project_id    = var.project_id
  name          = "gr_net_ru_2"
}


resource "selectel_global_router_vpc_subnet_v1" "gr_subnet_11" {
  network_id        = selectel_global_router_vpc_network_v1.gr_network_11.id
  os_subnet_id      = var.os_subnet_id_region_1
  cidr              = var.subnet_cidr1
  gateway           = var.gw_ip1
  service_addresses = var.gr_service_addresses1
  name              = "gr_subnet_ru_1"
}

resource "selectel_global_router_vpc_subnet_v1" "gr_subnet_21" {
  network_id        = selectel_global_router_vpc_network_v1.gr_network_21.id
  os_subnet_id      = var.os_subnet_id_region_2
  cidr              = var.subnet_cidr2
  gateway           = var.gw_ip2
  service_addresses = var.gr_service_addresses2
  name              = "gr_subnet_ru_2"
}
