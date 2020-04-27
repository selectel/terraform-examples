# Kubernetes cluster

This environment will create a Selectel VPC project with a single Kubernetes
cluster.

Note: manifests for OpenStack Magnum were removed. They will be replaced by Managed Kubernetes Service manifests later.
Progress on MKS Terraform is traced there: https://github.com/terraform-providers/terraform-provider-selectel/issues/74

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
