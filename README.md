# Terraform examples

This repository contains Terraform manifests examples for different Selectel
services.

## Repository structure

```bash
.
├── examples
│   └── vpc
│       ├── kubernetes_cluster
│       ├── server_local_and_remote_disks
│       ├── server_local_root_disk
│       ├── server_remote_root_disk
│       ├── server_remote_root_disk_two_ports
│       └── several_servers_one_network
└── modules
    └── vpc
        ├── account_token
        ├── flavor
        ├── floatingip
        ├── image_datasource
        ├── keypair
        ├── kubernetes_cluster
        ├── license
        ├── multiple_servers
        ├── nat
        ├── project
        ├── project_token
        ├── project_with_user
        ├── role
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
