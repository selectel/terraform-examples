# NAT

Terraform module to create a NAT objects in project

## Variables

  * `router_external_net_name` - OpenStack Networking external Network reference (Default: "external-network").

  * `router_name` - OpenStack Networking Router name (Default: "router_1").

  * `network_name` - OpenStack Networking Network name (Default: "network_1").

  * `subnet_cidr` - OpenStack Networking Subnet CIDR (Default: "192.168.0.0/24").

## Outputs

  * `router_id` - UUID of the created router.

  * `network_id` - UUID of the created network.

  * `subnet_id` - UUID of the created subnet.