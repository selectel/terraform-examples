# Several servers loadbalancer exmaple, OpenStack section

Terraform module for creating Openstack load balancer resources.
NAT, compute instances, load balancer, loadbalancer's components.

## Variables

  * `target_zone` - Target zone for resources creation.

  * `server_image_name` - Name of the OS image.

  * `keypair_name` - Name of the ssh key.

  * `count_of_servers` - Count of instances to create.

  * `lb_flavor_id` - ID of the load balancer flavor.

  * `lb_components` - Options for the TCP/UDP listener's components (Default: "").

  * `lb_components_http` - Options for the HTTP listener's components (Default: "").

  * `server_vcpus` - Server virtual CPUs (Default: 4).

  * `server_ram_mb` - Server RAM (MB) (Default: 8192).

  * `server_root_disk_gb` - Size of the root disk (GB) (Default: 8).

## Output

  * `floating_ip` - IP Address of a created floating IP.
