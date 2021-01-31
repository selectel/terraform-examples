# Subnet

Terraform module for creating a single Selectel VPC Subnet.

## Variables

  * `subnet_project_id` - Project of the Selectel VPC Subnet.

  * `subnet_region` - Region of the Selectel VPC Subnet.

  * `subnet_prefix_length` - Prefix length of the Selectel VPC Subnet.

  * `subnet_ip_version` - IP version of the Selectel VPC Subnet.

## Outputs

  * `network_id` - ID of the created Selectel VPC public subnet's Network.

  * `subnet_id` - ID of the created Selectel VPC Subnet.

  * `subnet_cidr` - CIDR of the created Selectel VPC Subnet.
