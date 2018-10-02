# Kubernetes cluster

Terraform module for creating a single Kubernetes cluster in the OpenStack
Container Infra service.

## Variables

  * `cluster_name` - Name of the OpenStack Container Infra Cluster
  (Default: "cluster_1").

  * `cluster_template_id` - ID of the OpenStack Container Infra Cluster Template.

  * `cluster_keypair` - Name for the keypair of the OpenStack Container Infra
  Cluster.

  * `cluster_master_flavor` - Reference of the flavor for the OpenStack
  Container Infra Cluster nodes (Default: "1003").

  * `cluster_flavor` - Reference of the flavor for the OpenStack Container Infra
  Cluster nodes (Default: "1003").

  * `cluster_master_count` - Count of the OpenStack Container Infra Cluster
  master nodes (Default: 3).

  * `cluster_node_count` - Count of the OpenStack Container Infra Cluster nodes
  (Default: 3).

## Outputs

  * `cluster_id` - ID of the new Kubernetes cluster.