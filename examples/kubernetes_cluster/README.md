# Kubernetes cluster

This environment will create following resources in the OpenStack project:

 * keypair
 * flavor
 * Kubernetes multi-master cluster with several nodes

To run this environment you need to export authorization variables that can be
obtained from [VPC access page](https://my.selectel.ru/vpc/access):

```bash
$ source rc.sh
$ terraform init
$ terraform apply 
```