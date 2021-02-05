# Load balancer

Terraform module for creating load balancer.

## Variables

  * `lb_flavor_id` - ID of the load balancer flavor.

  * `vip_subnet_id` - UUID of the created subnet in NAT module.


## Outputs

  * `loadbalancer_id` - ID of the created load balancer.

  * `floating_ip` - IP Address of a created floating IP.
