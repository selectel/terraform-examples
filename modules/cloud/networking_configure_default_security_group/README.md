# Module for configure default security group

Terraform module to configure default Security group.

## Variables

  * `default_sg_name` - OpenStack Networking Security group name (Default: "default").
  * `project_id` - UUID of the project.

## Outputs

  * `default_sg_id` - UUID of default Security group in project.
