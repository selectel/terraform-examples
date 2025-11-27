# initialize Openstack provider
provider "selectel" {
  domain_name = var.domain_name
  username    = var.username
  password    = var.password
  auth_region = var.region_cloud
  auth_url    = var.auth_url
}

# services
data "selectel_global_router_service_v1" "service_vpc" {
  name = "vpc"
}
data "selectel_global_router_service_v1" "service_ded" {
  name = "dedicated"
}

# zone group
data "selectel_global_router_zone_group_v1" "zone_gr" {
  name = "public_rf"
}

data "selectel_global_router_quota_v1" "quota_sub" {
  name        = "subnets"
  scope       = "account_id"
  scope_value = var.domain_name
}

data "selectel_global_router_zone_v1" "vpc_zone" {
  name    = var.region_cloud
  service = "vpc"
}

data "selectel_global_router_zone_v1" "dedicated_zone" {
  name    = var.region_dedicated
  service = "dedicated"
}

resource "selectel_global_router_router_v1" "gr_router" {
  name = "terraform-router2"
  tags = ["tag1", "tag2"]
}

resource "selectel_global_router_vpc_network_v1" "gr_network_1" {
  router_id     = selectel_global_router_router_v1.gr_router.id
  zone_id       = data.selectel_global_router_zone_v1.vpc_zone.id
  os_network_id = var.os_network_id
  project_id    = var.project_id
  name          = "gr_net_vpc"
}


resource "selectel_global_router_dedicated_network_v1" "gr_network_2" {
  router_id = selectel_global_router_router_v1.gr_router.id
  zone_id   = data.selectel_global_router_zone_v1.dedicated_zone.id
  vlan      = var.dedicated_vlan
  name      = "gr_net_dedicated"
}

resource "selectel_global_router_vpc_subnet_v1" "gr_subnet_1" {
  network_id        = selectel_global_router_vpc_network_v1.gr_network_1.id
  os_subnet_id      = var.os_subnet_id
  cidr              = var.subnet_cidr1
  gateway           = var.gw_ip1
  service_addresses = var.gr_service_addresses1
  name              = "gr_subnet_vpc"
}

resource "selectel_global_router_dedicated_subnet_v1" "gr_subnet_2" {
  network_id        = selectel_global_router_dedicated_network_v1.gr_network_2.id
  cidr              = var.subnet_cidr2
  gateway           = var.gw_ip2
  service_addresses = var.gr_service_addresses2
  name              = "gr_subnet_dedicated"
}

resource "selectel_global_router_static_route_v1" "static_route" {
  router_id = selectel_global_router_router_v1.gr_router.id
  cidr      = var.stat_route_cidr
  next_hop  = var.next_hop_ip
  name      = "gr_subnet_ru_1"
  # explicit dependency, because next_hop should be taken from gr_subnet_1
  # if nexthop belongs to different subnet, this dependency could be removed or updated
  depends_on = [
    selectel_global_router_vpc_subnet_v1.gr_subnet_1,
  ]
  # replacement gr_subnet_1 should trigger recreation dependent static route
  lifecycle {
    replace_triggered_by = [
      selectel_global_router_vpc_subnet_v1.gr_subnet_1.id
    ]
  }
}
