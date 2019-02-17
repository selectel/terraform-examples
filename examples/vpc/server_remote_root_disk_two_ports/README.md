# Server with remote root disk

This environment will create a Selectel VPC project with a single server booted
from a remote disk that has two network ports in different subnets.

## Example usage

```sh
terraform init

env \
  TF_VAR_sel_account=xxxxx\
  TF_VAR_sel_token=yyy_xxx \
  TF_VAR_user_password=secret \
  terraform apply -target=module.project_with_user

env \
  TF_VAR_sel_account=xxxxx\
  TF_VAR_sel_token=yyy_xxx \
  TF_VAR_user_password=secret \
  terraform apply
```
