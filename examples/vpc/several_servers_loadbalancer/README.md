# Multiple servers with loadbalancer udp and http rules

This environment will create a Selectel VPC project with a single windows server booted
from a remote disk.

## Edit vars.tf

  * `lb_flavor_id` - The UUID of a load balancer flavor.
  By default, use ACTIVE_STANDBY load balancer topology - Two amphora per load balancer.
  Set this variable to load balancer flavor UUID. You can get it by Openstack cli (```openstack loadbalancer flavor list```)
  AMPH1.SNGL.2-1024 - SINGLE - One amphora per load balancer.
  AMPH1.ACT_STNDB.2-1024 - ACTIVE_STANDBY - Two amphora per load balancer, 2 CPU, 1024MB RAM.
  AMPH1.ACT_STNDB.4-2048 - ACTIVE_STANDBY - Two amphora per load balancer, 4 CPU, 2048MB RAM.
  Attention. The UUID of a load balancer flavor differ from region to region.

## Example usage

```sh
terraform init

env \
  TF_VAR_sel_token=xxx_yyy \
  TF_VAR_user_password=secret \
  terraform apply
```

## OR use secrets.tfvars

```sh
  terraform apply -var-file secrets.tfvars
```

## Check load balancer

```sh
  ssh root@$(terraform output -raw floating_ip)
```

## Outputs

  * `floating_ip` - IP Address of a created floating IP.
