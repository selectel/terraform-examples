# Server group

Terraform module for creating a server group

## Variables

* `name` - A unique name for the server group.
* `policies` - The set of policies for the server group.

## Policies

* `anti-affinity` - Обязательно на разных хостах - All instances/servers launched in this group will be hosted on different compute nodes
* `soft-anti-affinity` - Желательно на разных хостах - All instances/servers launched in this group will be hosted on different compute nodes if possible, but if not possible they still will be scheduled instead of failure.

