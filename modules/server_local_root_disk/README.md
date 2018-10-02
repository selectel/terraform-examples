# Server local root disk

Terraform module for creating a single OpenStack Compute V2 Instance with a
local root volume.

## Variables

  * `server_name` - Name of the OpenStack Compute Instance
  (Default: "server_1").

  * `server_image_id` - OpenStack Image reference.

  * `server_availability_zone` - OpenStack Compute Availability Zone
  (Default: "ru-3a").

  * `server_flavor_id` - OpenStack Compute Flavor reference (Default: "1003").

  * `server_keypair_name` - OpenStack Compute Keypair reference.

  * `server_network_name` - OpenStack Networking Network reference
  (Default: "nat").

## Outputs

  * `server_id` - ID of the created OpenStack Instance.