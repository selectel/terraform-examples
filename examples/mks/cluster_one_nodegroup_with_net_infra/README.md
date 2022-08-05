# Cluster with nodegroup based on local disks and all required network infrastructure

This environment will create a Selectel VPC Project with a single MKS Cluster with a nodegroup based on local disks and all required network infrastructure.

# Example usage

```sh
terraform init

env \
  TF_VAR_sel_token=yyy_xxx \
  TR_TF_VAR_user_password=xxx \
  terraform apply
```
