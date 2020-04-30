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

  * `ram_mb` - RAM count for each node (MB) (Default: 1024). 

  * `volume_gb` - Volume size for each node (GB) (Default: 10).

  * `volume_type` - An OpenStack blockstorage volume type for each node.

## Outputs

  * `nodegroup_id` - ID of the created MKS nodegroup.
