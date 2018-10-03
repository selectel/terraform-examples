# Server with two remote disks

This environment will create following resources in the OpenStack project:

 * keypair
 * flavor
 * server with associated floating IP and two remote disks

To run this environment you need to export authorization variables that can be
obtained from [VPC access page](https://my.selectel.ru/vpc/access):

```bash
$ source rc.sh
$ terraform init
$ terraform apply 
```
