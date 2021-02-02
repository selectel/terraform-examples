output "network_id" {
  value = selectel_vpc_subnet_v2.subnet_1.network_id
}

output "subnet_id" {
  value = selectel_vpc_subnet_v2.subnet_1.subnet_id
}

output "subnet_cidr" {
  value = selectel_vpc_subnet_v2.subnet_1.cidr
}
