# Cluster

Terraform module for creating a single Selectel MKS cluster.

## Variables

  * `cluster_name` - The name of the cluster (Default: "cluster-1").

  * `project_id` - An associated Selectel VPC project.

  * `region` - A Selectel VPC region of where the cluster is located.

  * `kube_version` - The current Kubernetes version of the cluster.

  * `enable_autorepair` - Reflects if worker nodes are allowed to be reinstalled automatically (Default: true).

  * `enable_patch_version_auto_upgrade` - Specifies if Kubernetes patch version of the cluster is allowed
  to be upgraded automatically (Default: true).

  * `network_id` - An OpenStack Networking service network ID.

  * `subnet_id` - An OpenStack Networking service subnet ID.

  * `maintenance_window_start` - UTC time in "hh:mm:ss" format of when the cluster will start its maintenance tasks.

## Outputs

  * `cluster_id` - ID of the created MKS cluster.

  * `project_id` - ID of the VPC project of where the cluster is located.

  * `region` - VPC region of where the cluster is located.
