# Server local root disk

Terraform module for creating a single OpenStack Compute V2 Instance with a
remote root volume, preemtible tag and GPU.

## Variables

  * `user_name` - OpenStack username.

  * `project_name` - OpenStack username.

  * `user_password` - OpenStack username.

  * `domain_name` - OpenStack username.

  * `auth_url` - OpenStack username.

  * `region` - OpenStack username.

  * `flavor_id` - Server configuration ID.

  * `server_volume_type` - Server remote root disk type (Default: "fast.ru-9a")

  * `server_root_disk_gb` - Size of the root disk (GB) (Default: 8).

  * `server_name` - Name of the server (Default: "server_1")

  * `server_image_name` - Name of the image to find to create a server.

  * `server_zone` - Server availability zone.

  * `server_ssh_key` - SSH keypair name.

  * `server_ssh_key_user` - Owner of the SSH keypair.

  * `server_license_type` - Windows license type.

## Outputs

  * `server_id` - ID of the created OpenStack Server.

  * `server_port_id` - ID of the Server's port.

  * `server_root_volume_id` - ID of the Server's root volume.
