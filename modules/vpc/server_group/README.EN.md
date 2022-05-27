# Server group

Terraform module for creating a server group.

## Variables

* `name` - A unique name for the server group.
* `policies` - The set of policies for the server group.

## Policies

* `anti-affinity` - Hard anti-affinity. All instances/servers launched in this group will be hosted on different compute nodes
* `soft-anti-affinity` - Soft anti-affinity. All instances/servers launched in this group will be hosted on different compute nodes if possible, but if not possible they still will be scheduled instead of failure.
