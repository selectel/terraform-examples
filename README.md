# Terraform examples

This repository contains Terraform manifests examples for different Selectel
services.

## Repository structure

```bash
.
├── examples
│   ├── dbaas
│   │   ├── get_params
│   │   ├── mysql_cluster
│   │   ├── postgres_cluster
│   │   └── redis_cluster
│   ├── mks
│   │   ├── cluster_one_nodegroup
│   │   └── cluster_one_nodegroup_with_net_infra
│   └── vpc
│       ├── preemptible_server
│       ├── preemptible_server_with_gpu
│       ├── server_local_and_remote_disks
│       ├── server_local_root_disk
│       ├── server_remote_root_disk
│       ├── server_remote_root_disk_and_attached_share
│       ├── server_remote_root_disk_two_ports
│       ├── server_remote_root_disk_with_server_group
│       ├── server_windows
│       ├── several_servers_and_loadbalancers
│       ├── several_servers_one_network
│       ├── several_servers_routing
│       └── several_servers_with_networking_and_fwaas
└── modules
    ├── mks
    │   ├── cluster
    │   ├── nodegroup
    │   └── nodegroup_local_disk
    └── vpc
        ├── flavor
        ├── floatingip
        ├── image_datasource
        ├── keypair
        ├── lb_active_standby
        ├── lb_active_standby_with_certificate
        ├── lb_components
        ├── lb_components_http
        ├── lb_components_https
        ├── lb_sngl
        ├── license
        ├── multiple_servers
        ├── multiple_servers_with_fwaas
        ├── nat
        ├── os_lb_env
        ├── project
        ├── project_with_user
        ├── routing_network
        ├── routing_os
        ├── routing_selvpc
        ├── routing_servers
        ├── secrets_manager_certificate
        ├── secrets_manager_secret
        ├── server_group
        ├── server_local_and_remote_disks
        ├── server_local_root_disk
        ├── server_remote_root_disk
        ├── server_remote_root_disk_and_attached_share
        ├── server_remote_root_disk_two_ports
        ├── server_remote_root_disk_with_gpu
        ├── share
        ├── single_instance
        ├── subnet
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
