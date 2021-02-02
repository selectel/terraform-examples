output "proxy_server_ip" {
  value = module.routing_network.proxy_server_public_subnet_port_ip
}

output "main_server_ip" {
  value = module.routing_network.main_server_subnet_three_port
}
