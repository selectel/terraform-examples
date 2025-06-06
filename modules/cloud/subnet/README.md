# Subnet

Terraform module for creating a single Selectel Cloud Subnet.

## Variables

  * `subnet_project_id` - Project of the Selectel Cloud Subnet.

  * `subnet_region` - Region of the Selectel Cloud Subnet.

  * `subnet_prefix_length` - Prefix length of the Selectel Cloud Subnet.

  * `subnet_ip_version` - IP version of the Selectel Cloud Subnet.

## Outputs

  * `network_id` - ID of the created Selectel Cloud public subnet's Network.

  * `subnet_id` - ID of the created Selectel Cloud Subnet.

  * `subnet_cidr` - CIDR of the created Selectel Cloud Subnet.
