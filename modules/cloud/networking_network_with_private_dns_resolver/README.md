# DNS resolver

Terraform module to create a Network with dns resolver in project

## Variables

  * `network_name` - OpenStack Networking Network name (Default: "network_1").

  * `subnet_cidr` - OpenStack Networking Subnet CIDR (Default: "192.168.0.0/24").

  * `region` - region name where resources will be created.

  * `project_id` - UUID of the project whre resources will be created.

## Outputs

  * `resolver_addresses` - Addresses of resolver.
  * 
  * `network_id` - UUID of the created network.

  * `subnet_id` - UUID of the created subnet.
