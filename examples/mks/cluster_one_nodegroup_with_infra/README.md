# Cluster with one nodegroup

This environment will create a Selectel VPC Project with a single MKS Cluster with one nodegroup and all network's environments.

# Example usage

```sh
terraform init

env \
  TF_VAR_sel_token=yyy_xxx \
  TR_TF_VAR_user_password=xxx \
  terraform apply
```
