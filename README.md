# Terraform examples

This repository contains Terraform manifests examples for different Selectel
services.

## Repository structure

```bash
.
├── examples                                  
│   ├── kubernetes_cluster
│   ├── project
│   ├── server_with_local_root_disk
│   ├── server_with_remote_root_disk
│   ├── server_with_remote_root_disk_two_ports 
│   └── server_with_two_remote_disks
└── modules
    ├── flavor
    ├── floatingip
    ├── image_datasource
    ├── keypair
    ├── kubernetes_cluster
    ├── kubernetes_cluster_template_datasource
    ├── project
    ├── server_local_root_disk
    ├── server_remote_root_disk
    ├── server_remote_root_disk_two_ports
    └── server_two_remote_disks
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
