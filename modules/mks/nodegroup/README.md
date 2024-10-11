# Nodegroup

Terraform module for creating a single Selectel MKS nodegroup.

## Variables

  * `cluster_id` - ID of the associated MKS cluster.

  * `project_id` - ID of the associated Selectel VPC project.

  * `region` - A Selectel VPC region of where the nodegroup is located.

  * `availability_zone` - An OpenStack availability zone for all nodes in the nodegroup.

  * `nodes_count` - Count of worker nodes in the nodegroup (Default: 1).

  * `keypair_name` - Name of the SSH key that will be added to all nodes.

  * `affinity_policy` - Parameter to tune nodes affinity policy.

  * `cpus` - CPU count for each node (Default: 1).

  * `ram_mb` - RAM count for each node (MB) (Default: 4096). 

  * `volume_gb` - Volume size for each node (GB) (Default: 20).

  * `volume_type` - An OpenStack blockstorage volume type for each node.

  * `user_data` - (Optional) Base64-encoded script that worker nodes run on the first boot. Changing this creates a new node group. Learn more about [User data](https://docs.selectel.ru/en/cloud/managed-kubernetes/node-groups/user-data/).

  * `install_nvidia_device_plugin` - (Required) Enables or disables installation of the NVIDIA Device Plugin and GPU drivers.  
  Boolean flag: 
    * `true` — for flavors with GPU enables installation of the NVIDIA Device Plugin and GPU drivers. 
    * `false` — for flavors without GPU and flavors with GPU disables installation of the NVIDIA Device Plugin and GPU drivers. Learn more about [manual installation of GPU drivers](https://docs.selectel.ru/en/cloud/managed-kubernetes/node-groups/install-gpu-drivers/).

  * `labels` - List of user-defined Kubernetes labels, that will be applied for each node in the group.

  * `taints` - List of user-defined Kubernetes taints, that will be applied for each node in the group.

## Outputs

  * `nodegroup_id` - ID of the created MKS nodegroup.
