# Server with remote root disk and server group

This environment will create a Selectel VPC project with a single server booted
from a remote disk with a server group.

## Example usage

```sh
terraform init

env \
  TF_VAR_sel_token=yyy_xxx \
  TF_VAR_user_password=secret \
  terraform apply
```
