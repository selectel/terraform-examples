# Cluster with one nodegroup

This environment will create a Selectel VPC Project with a single MKS Cluster with one nodegroup.

# Example usage

```sh
terraform init

env \
  TF_VAR_username="USER" \
  TF_VAR_password="PASSWORD" \
  TF_VAR_domain_name="ACCOUNT_ID" \
  terraform apply
```
