# Routing test environment

This environment will create a Selectel Cloud user and project with multiple servers, routers, networks, subnets, routes at routers and subnets.

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

## OR use secrets.tfvars

```sh
  terraform apply -var-file secrets.tfvars
```

## Check routes
```sh
ssh -J root@$(terraform output -raw proxy_server_ip) root@$(terraform output -raw main_server_ip) route -n
```

## Scheme

![plot](./scheme/terraform_routes.png)

## Outputs

  * `main_server_ip` - IP address of the main server.

  * `proxy_server_ip` - IP address of the proxy server.
