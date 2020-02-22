# Multiple servers

Terraform module for creating multiple OpenStack Compute V2 Instances with a
local root volume and connected to a specified network.

## Variables

  * `replicas_count` - count of instances to create (Default: 1).

  * `server_vcpus` - Server virtual CPUs (Default: 4).

  * `server_ram_mb` - Server RAM (MB) (Default: 8192).

  * `server_root_disk_gb` - Size of the root disk (GB) (Default: 8).

  * `server_network_id` - ID of a network to connect to.

  * `server_subnet_id` - ID of a subnet to connect to.

  * `server_name` - Prefix name of the server, random string will be added to prevent collisions (Default: "server")

  * `server_image_name` - Name of the image to find to create a server.

  * `server_zone` - Server availability zone.

  * `server_ssh_key` - SSH keypair name.

  * `server_ssh_key_user` - Owner of the SSH keypair.

## Outputs

  * `server_ids` - List with IDs of the created OpenStack Servers.

  * `server_port_ids` - List of IDs of Servers ports.
