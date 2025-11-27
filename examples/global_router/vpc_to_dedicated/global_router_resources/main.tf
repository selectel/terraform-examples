data "selectel_global_router_zone_v1" "vpc_zone" {
  name    = var.region_name1
  service = "vpc"
}

data "selectel_global_router_zone_v1" "dedicated_zone" {
  name    = var.region_name2
  service = "dedicated"
}

resource "selectel_global_router_router_v1" "gr_router" {
  name = "my-router"
}

resource "selectel_global_router_vpc_network_v1" "vpc_network" {
  router_id     = selectel_global_router_router_v1.gr_router.id
  zone_id       = data.selectel_global_router_zone_v1.vpc_zone.id
  os_network_id = var.os_network_id
  project_id    = var.project_id
  name          = "vpc-net"
}


resource "selectel_global_router_dedicated_network_v1" "dedicated_network" {
  router_id = selectel_global_router_router_v1.gr_router.id
  zone_id   = data.selectel_global_router_zone_v1.dedicated_zone.id
  vlan      = var.dedicated_vlan
  name      = "dedicated-net"
}


resource "selectel_global_router_vpc_subnet_v1" "vpc_subnet" {
  network_id        = selectel_global_router_vpc_network_v1.vpc_network.id
  os_subnet_id      = var.os_subnet_id
  cidr              = var.subnet_cidr1
  gateway           = var.gw_ip1
  service_addresses = var.gr_service_addresses1
  name              = "vpc-subnet"
}

resource "selectel_global_router_dedicated_subnet_v1" "dedicated_subnet" {
  network_id        = selectel_global_router_dedicated_network_v1.dedicated_network.id
  cidr              = var.subnet_cidr2
  gateway           = var.gw_ip2
  service_addresses = var.gr_service_addresses2
  name              = "dedicated-subnet"
}
