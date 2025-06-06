module "routing_network" {
  source = "../routing_network"

  selvpc_subnet_cidr = var.selvpc_subnet_cidr
  selvpc_subnet_id   = var.selvpc_subnet_id
  selvpc_network_id  = var.selvpc_network_id
}

module "routing_servers" {
  source = "../routing_servers"

  keypair_name                          = var.keypair_name
  target_zone                           = var.target_zone
  server_image_name                     = var.server_image_name
  main_server_subnet_one_port_id        = module.routing_network.main_server_subnet_one_port_id
  main_server_subnet_three_port_id      = module.routing_network.main_server_subnet_three_port_id
  server_with_docker_subnet_two_port_id = module.routing_network.server_with_docker_subnet_two_port_id
  proxy_server_subnet_three_port_id     = module.routing_network.proxy_server_subnet_three_port_id
  proxy_server_public_subnet_port_id    = module.routing_network.proxy_server_public_subnet_port_id
  main_server_subnet_one_port_ip        = module.routing_network.main_server_subnet_one_port_ip
  server_with_docker_subnet_two_port_ip = module.routing_network.server_with_docker_subnet_two_port_ip
  proxy_server_public_subnet_port_ip    = module.routing_network.proxy_server_public_subnet_port_ip

  depends_on = [
    module.routing_network,
  ]
}
