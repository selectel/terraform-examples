# Server remote root disk and two network ports

Terraform module for creating a single OpenStack Compute V2 Instance with a
Blockstorage V3 Volume used as root volume and two network ports.

## Variables

  * `server_name` - Name of the OpenStack Compute Instance
  (Default: "server_1").

  * `server_image_id` - OpenStack Image reference.

  * `server_volume_size_gb` - OpenStack Blockstorage Volume size (Default: 10).

  * `server_volume_type` - OpenStack Blockstorage Volume type
  (Default: "fast.ru-3a").

  * `server_availability_zone` - OpenStack Compute Availability Zone
  (Default: "ru-3a").

  * `server_flavor_id` - OpenStack Compute Flavor reference (Default: "1003").

  * `server_keypair_name` - OpenStack Compute Keypair reference.

  * `server_network_name` - OpenStack Networking Network reference
  (Default: "nat").

## Outputs

  * `server_id` - ID of the created OpenStack Instance.

  * `server_first_port_id` - ID of the Instance's eth0.

  * `server_second_port_id` - ID of the Instance's eth1.

  * `server_root_volume_id` - ID of the created OpenStack root Volume.