# Routing example Openstack compute section

Terraform module for creating Openstack compute resources - instances, volumes.

## Variables

  * `keypair_name` - Name of the ssh key.

  * `target_zone` - Target zone for resources creation.

  * `main_server_subnet_one_port_id` - Port ID of the subnet one, main server.

  * `main_server_subnet_three_port_id` - Port ID of the subnet three, main server.

  * `server_with_docker_subnet_two_port_id` - Port ID of the subnet two, server with docker.

  * `proxy_server_subnet_three_port_id` - Port ID of the subnet three, proxy server.

  * `proxy_server_public_subnet_port_id` - Port ID of the public subnet, proxy server.

  * `main_server_subnet_one_port_ip` - IP address of the main server, subnet one.

  * `main_server_subnet_three_port` - IP address of the main server, subnet three.

  * `server_with_docker_subnet_two_port_ip` - IP address of the server with docker, subnet two.

  * `proxy_server_public_subnet_port_ip` - IP address of the proxy server, public subnet.
