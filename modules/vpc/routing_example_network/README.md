# Routing example Openstack network section

Terraform module for creating net resources - routers, networks, subnets, ports, routes

## Variables

  * `selvpc_network_id` - ID of the Selectel VPC subnet's Network created at Selectel section.

  * `selvpc_subnet_id` - ID of the Selectel VPC Subnet created at Selectel section.

  * `selvpc_subnet_cidr` -  CIDR of the Selectel VPC Subnet created at Selectel section.

  * `router_external_net_name` - Name of the external network.

## Outputs

  * `main_server_subnet_one_port_id` - Port ID of the subnet one, main server.

  * `main_server_subnet_three_port_id` - Port ID of the subnet three, main server.

  * `server_with_docker_subnet_two_port_id` - Port ID of the subnet two, server with docker.

  * `proxy_server_subnet_three_port_id` - Port ID of the subnet three, proxy server.

  * `proxy_server_public_subnet_port_id` - Port ID of the public subnet, proxy server.

  * `main_server_subnet_one_port_ip` - IP address of the main server, subnet one.

  * `main_server_subnet_three_port` - IP address of the main server, subnet three.

  * `server_with_docker_subnet_two_port_ip` - IP address of the server with docker, subnet two.

  * `proxy_server_public_subnet_port_ip` - IP address of the proxy server, public subnet.
