# Server with direct public IP port

This environment creates a Selectel Cloud project with a single server that has a direct public IP via `selectel_vpc_public_port_v1` resource.

Unlike the floating IP approach (which uses a private port + floating IP association), the public port provides a direct public IP address on the port itself.

## What is created

- Selectel project with service user and keypair
- Security group with SSH (port 22) and ICMP access rules
- Direct public IP port (`selectel_vpc_public_port_v1`) with the security group attached
- Compute instance separately attached to the public port

## Example usage

```sh
terraform init

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply -target=module.project_with_user

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply
```
