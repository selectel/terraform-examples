# Keypair

Terraform module for creating a single OpenStack Compute V2 Keypair.

## Variables

  * `keypair_name` - Name of the OpenStack Compute Keypair
  (Default: "keypair_1").

  * `keypair_public_key` - Public key for the OpenStack Compute Keypair.

## Outputs

  * `keypair_id` - ID of the created OpenStack Keypair.