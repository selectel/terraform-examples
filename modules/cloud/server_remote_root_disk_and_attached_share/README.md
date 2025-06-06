# Server with remote root disk and attached share

Terraform module for creating a single OpenStack Compute V2 Instance with a
remote root volume and attached share.

## Variables

  * `base_name` - Base name for resources.

  * `flavor_id` - Server specs.

  * `subnet_cidr` - Subnet address with mask.

  * `ssh_user` - SSH user.

  * `ssh_key_path` - Path to ssh private key.

  * `server_volume_type` - Server root disk volume type.

  * `server_volume_size` - Server root disk volume size.

  * `server_image_name` - OS image name.

  * `server_zone` - Server availability zone.

  * `server_region` - Server region.

  * `share_size` - Share size in gigabytes.

  * `share_proto` - Share protocol (NFS or CIFS).

  * `share_type` - Share type (basic, universal or fast).

  * `share_allowed_ip` - IP access rule.

## Outputs

  * `server_ip` - external server IP address.

  * `share_id` - ID of the created share.

  * `share_export_location_path` - share mount path.
