# Cluster

Terraform module for creating a single Selectel MKS cluster.

## Variables

  * `cluster_name` - The name of the cluster (Default: "cluster-1").

  * `project_id` - An associated Selectel Cloud project.

  * `region` - A Selectel Cloud region of where the cluster is located.

  * `kube_version` - The current Kubernetes version of the cluster.

  * `enable_autorepair` - Reflects if worker nodes are allowed to be reinstalled automatically (Default: true).

  * `enable_patch_version_auto_upgrade` - Specifies if Kubernetes patch version of the cluster is allowed
  to be upgraded automatically (Default: true).

  * `network_id` - An OpenStack Networking service network ID.

  * `subnet_id` - An OpenStack Networking service subnet ID.

  * `maintenance_window_start` - UTC time in "hh:mm:ss" format of when the cluster will start its maintenance tasks.

  * `enable_audit_logs` - (Optional) Enables or disables collection of audit logs. Learn how to [configure export of audit logs to a logging system](https://docs.selectel.ru/en/cloud/managed-kubernetes/clusters/logs/#configure-export-of-audit-logs).

    * `false` (default) - Audit logs are not collected and are not available for export;

    * `true` - Audit logs are collected and available for export.

## Outputs

  * `cluster_id` - ID of the created MKS cluster.

  * `project_id` - ID of the Cloud project of where the cluster is located.

  * `region` - Cloud region of where the cluster is located.
