# Module to configure default security group

Terraform module to configure default Security group.

> **Note:**  
> Before using the module, you must remove all rules from default security group using the CLI or the control panel.  
> Pre-created rules will not be automatically deleted or overwritten.

## Variables

  * `default_sg_name` - OpenStack Networking Security group name (Default: "default").
  * `project_id` - UUID of the project.

## Outputs

  * `default_sg_id` - UUID of default Security group in project.
