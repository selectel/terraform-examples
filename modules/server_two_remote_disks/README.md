# Server two remote volumes

Terraform module for creating a single OpenStack Compute V2 Instance with two
Blockstorage V3 Volumes.

## Variables

  * `server_name` - Name of the OpenStack Compute Instance
  (Default: "server_1").

  * `server_image_id` - OpenStack Image reference.

  * `server_root_volume_size_gb` - OpenStack Blockstorage root Volume size
  (Default: 10).

  * `server_root_volume_type` - OpenStack Blockstorage root Volume type
  (Default: "fast.ru-3a").

  * `server_second_volume_size_gb` - OpenStack Blockstorage second Volume size
  (Default: 20).

  * `server_second_volume_type` - OpenStack Blockstorage root Volume type
  (Default: "fast.ru-3a").

  * `server_availability_zone` - OpenStack Compute Availability Zone
  (Default: "ru-3a").

  * `server_flavor_id` - OpenStack Compute Flavor reference (Default: "1003").

  * `server_keypair_name` - OpenStack Compute Keypair reference.

  * `server_network_name` - OpenStack Networking Network reference
  (Default: "nat").

## Outputs

  * `server_id` - ID of the created OpenStack Instance.

  * `server_root_volume_id` - ID of the created OpenStack root Volume.

  * `server_second_volume_id` - ID of the created OpenStack second Volume.