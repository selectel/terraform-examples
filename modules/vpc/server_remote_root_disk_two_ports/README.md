# Server local root disk

Terraform module for creating a single OpenStack Compute V2 Instance with two
remote volumes.

## Variables

  * `server_vcpus` - Server virtual CPUs (Default: 4).

  * `server_ram_mb` - Server RAM (MB) (Default: 8192).

  * `server_volume_type` - Server remote root disk type (Default: "fast.ru-9a")

  * `server_root_disk_gb` - Size of the root disk (GB) (Default: 8).

  * `server_name` - Name of the server (Default: "server_1")

  * `server_image_name` - Name of the image to find to create a server.

  * `server_zone` - Server availability zone.

  * `server_ssh_key` - SSH keypair name.

  * `server_ssh_key_user` - Owner of the SSH keypair.

## Outputs

  * `server_id` - ID of the created OpenStack Server.

  * `server_port_id` - ID of the Server's port.

  * `server_root_volume_id` - ID of the Server's root volume.
