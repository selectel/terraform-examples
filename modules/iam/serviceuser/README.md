# Service user

Terraform module for creating a single Selectel service user.

## Variables

  * `user_name` - Name of the Selectel service user (Default: "serviceuser_1").

  * `user_password` - Password of the Selectel service user.

  * `roles` - List of roles, assigned to the Selectel service user. Each role is a map(string) and contains 2 required keys: "role_name" and "scope". If "scope" is set to project, then "project_id" key must be provided.

## Outputs

  * `user_id` - ID of the created Selectel service user.