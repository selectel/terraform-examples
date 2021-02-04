# OpenStack load balancer TCP or UDP listener components

Terraform module for creating Openstack load balancer TCP or UDP listener components.
Listener, pool, monitor, member.

## Variables

  * `loadbalancer_id` - ID of the created load balancer.

  * `server_access_ips` - List of server IPs.

  * `lb_components` - Loadbalancer component's arguments.
