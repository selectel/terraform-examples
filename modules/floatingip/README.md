# Floating IP

Terraform module for creating a single SelVPC Floating IP.

## Variables

  * `floatingip_project_id` - ID of the SelVPC project for managing Floating IP.

  * `floatingip_region` - Floating region (Default: "ru-3").

## Outputs

  * `floatingip_id` - ID of the SelVPC Floating IP.

  * `floatingip_address` - Address of the SelVPC Floating IP.