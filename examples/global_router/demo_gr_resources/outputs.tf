output "zone_group" {
  value = data.selectel_global_router_zone_group_v1.zone_gr
}

output "service_vpc" {
  value = data.selectel_global_router_service_v1.service_vpc
}

output "service_dedicated" {
  value = data.selectel_global_router_service_v1.service_ded
}

output "quota_subnet" {
  value = data.selectel_global_router_quota_v1.quota_sub
}

output "vpc_zone" {
  value = data.selectel_global_router_zone_v1.vpc_zone
}

output "dedicated_zone" {
  value = data.selectel_global_router_zone_v1.dedicated_zone
}

output "new_router" {
  value = resource.selectel_global_router_router_v1.gr_router
}

output "vpc_net" {
  value = resource.selectel_global_router_vpc_network_v1.gr_network_1
}

output "dedicated_net" {
  value = resource.selectel_global_router_dedicated_network_v1.gr_network_2
}

output "vpc_subnet" {
  value = resource.selectel_global_router_vpc_subnet_v1.gr_subnet_1
}

output "dedicated_subnet" {
  value = resource.selectel_global_router_dedicated_subnet_v1.gr_subnet_2
}

output "stat_route" {
  value = resource.selectel_global_router_static_route_v1.static_route
}
