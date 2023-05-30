# Share

Terraform module for creating a share.

## Variables

**Required:**

  * `neutron_net_id` - UUID of the created network.

  * `neutron_subnet_id` - UUID of the created subnet.

**Optional:**

  * `base_name` - Base name for resources.

  * `share_size` - Share size in gigabytes.

  * `share_proto` - Share protocol (NFS or CIFS).

  * `share_type` - Share type (basic, universal or fast).

  * `share_allowed_ip` - IP access rule.

## Outputs

  * `share_id` - ID of the created share.

  * `share_export_location_path` - share mount path.
