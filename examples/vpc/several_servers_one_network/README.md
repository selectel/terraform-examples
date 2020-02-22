# Multiple servers in the same network

This environment will create a Selectel VPC project with multiple servers in the same network.

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
