# Routing example Openstack section

Terraform module for creating Openstack resources
Networking - routers, networks, subnets, ports, routes
Compute - instances, volumes

## Variables

  * `selvpc_network_id` - ID of the Selectel VPC subnet's Network created at Selectel section.

  * `selvpc_subnet_id` - ID of the Selectel VPC Subnet created at Selectel section.

  * `selvpc_subnet_cidr` -  CIDR of the Selectel VPC Subnet created at Selectel section.

  * `keypair_name` - Name of the ssh key.

  * `target_zone` - Target zone for resources creation.

  * `server_image_name` - Name of the OS image.

## Outputs

  * `proxy_server_ip` - IP address of the PROXY SERVER.

  * `main_server_ip` - IP address of the MAIN SERVER.
