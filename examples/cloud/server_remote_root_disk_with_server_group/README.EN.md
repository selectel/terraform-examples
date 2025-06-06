# Server with remote root disk and server group

This environment will create a Selectel Cloud project with a single server booted
from a remote disk with a server group.

## Example usage

```sh
terraform init

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply
```
