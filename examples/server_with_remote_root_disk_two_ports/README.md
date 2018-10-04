# Server with remote root disk and two network ports

This environment will create following resources in the OpenStack project:

 * keypair
 * flavor
 * network subnet and port
 * server with remote root disk, two network ports and associated floating IP

To run this environment you need to export authorization variables that can be
obtained from [VPC access page](https://my.selectel.ru/vpc/access):

```bash
$ source rc.sh
$ terraform init
$ terraform apply 
```
