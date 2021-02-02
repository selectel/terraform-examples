# Routing example Selectel section

Terraform module for creating Selectel resources
Project, user, keypair, /29 public subnet

## Variables

  * `user_name` - Name of the user.

  * `user_password` - Password of the user.

  * `project_name` - Name of the project.

  * `keypair_name` - Name of the ssh key.

  * `target_zone` - Target zone for public subnet.

## Outputs

  * `selvpc_network_id` - ID of the created Selectel VPC Network.

  * `selvpc_subnet_id` - ID of the created Selectel VPC Subnet.

  * `selvpc_subnet_cidr` - CIDR of the created Selectel VPC Subnet.
