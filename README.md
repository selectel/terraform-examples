# Terraform examples

This repository contains Terraform manifests examples for different Selectel
services.

## Repository structure

```bash
.
├── examples
│   └── mks
│       └── cluster_one_nodegroup
│   └── vpc
│       ├── server_local_and_remote_disks
│       ├── server_local_root_disk
│       ├── server_remote_root_disk
│       ├── server_remote_root_disk_two_ports
│       ├── server_windows
│       ├── several_servers_loadbalancer
│       ├── several_servers_one_network
│       └── several_servers_routing
└── modules
    └── mks
        ├── cluster
        └── nodegroup
    └── vpc
        ├── account_token
        ├── flavor
        ├── floatingip
        ├── image_datasource
        ├── keypair
        ├── lb_components
        ├── lb_components_http
        ├── lb_loadbalancer
        ├── lb_os
        ├── lb_selvpc
        ├── license
        ├── multiple_servers
        ├── nat
        ├── project
        ├── project_token
        ├── project_with_user
        ├── role
        ├── routing_network
        ├── routing_os
        ├── routing_selvpc
        ├── routing_servers
        ├── server_local_and_remote_disks
        ├── server_local_root_disk
        ├── server_remote_root_disk
        ├── server_remote_root_disk_two_ports
        ├── subnet
        ├── user
        └── vrrp_subnet
```

  * `examples` - Contains Terraform environments examples that usually have
  several resources and use modules from `modules` directory.
  Those examples can be used as-is or they can be updated to suit your specific
  needs.

  * `modules` - Contains reusable small Terraform modules that can be used in
  many Terraform environments.
  Those modules wrap Terraform resources and datasources and provide
  configurable variables.
  All of those modules are fully compatible with the Selectel VPC service.
