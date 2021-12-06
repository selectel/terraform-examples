output "public_subnet_id" {
  value = module.public_nat.subnet_id
}

output "private_subnet_id" {
  value = module.private_nat.subnet_id
}

output "public_network_ips" {
  value = module.instances[*].public_network_ips
}

output "private_network_ips" {
  value = module.instances[*].private_network_ips
}
