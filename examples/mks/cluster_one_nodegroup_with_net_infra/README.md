# Cluster with nodegroup based on local disks and all required network infrastructure

This environment will create a Selectel VPC Project with a single MKS Cluster with a nodegroup based on local disks and all required network infrastructure.

# Example usage

```sh
terraform init

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply
```
