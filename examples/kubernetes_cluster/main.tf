# Generate random string that will be used as name for all resources.
resource "random_string" "random_name" {
  length  = 12
  special = false
  upper   = false
}

# Create OpenStack keypair with current public key.
module "keypair" {
  source = "../../modules/keypair"

  keypair_name       = "${random_string.random_name.result}"
  keypair_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCcmMiseLWl02zyXd1aY31D4BAPwGOXd9PyJUCIAf/SOCADxlyANbN0S+ijb8crXWuveSUKf2bl8g9BVxzwo4mhBksnYBbFcOUegIcUHooA9z7VaDk70d3R5Ge5YGgSU07TzECgnLHZvzd223sNIoDaN0sIQXuYOf40FTJNlu3Aah0mA1pgiPSObm+FEDri546ChEt4+X1+czznG4WrIGCfRq3Gfi3Vaw0Cfe9pKn5yF21UNR51Dbf7Bwpr7Wz5Y1T8f4ThqJ0eC54byK1WLBAxVZioo3qxD6YN/fB9rueLf37I1FMaqokJ1d3pqXBD/QxyB+3ylu3hE+r2esrM0URjC9mylQ1GqSYOyHgm9kEktzr75B+tgcUuOI37H4FYh1L1MSHYq7i/nuqgOLQbIalKKzlv92vViMH42FDRYmBoU5LRIQ/qeRLlZh4p5hL0NRkZ6LdBwU0aQSOBUXzoFML2/1BSI3KJLQb2/aKqSDKqyzYw6vMiPlfCgbE6HOr1/ZFh3l0kVJ1sP/M8EnVGhDe6sBeQ5YFa5Acs4OhBEX2sQOVqf11xPeqg7kiz9PpmaeSybYdnnoFt7enWrUJpvBxj8IrlyfBV4H9R+mDnkEVC9q+VZoraiKDjMJNDvoMQSLA5xw7B1Tn53lWASgVsKwQZTNKS8C7sLnaxzI8AK/oiw== ozerov@selectel.com"
}

# Create OpenStack flavor without local disk.
module "flavor" {
  source = "../../modules/flavor"

  flavor_name          = "${random_string.random_name.result}"
  flavor_vcpus         = 2
  flavor_ram_mb        = 2048
  flavor_local_disk_gb = 0
}

# Find public Kubernetes cluster template.
module "kubernetes_cluster_template_datasource" {
  source = "../../modules/kubernetes_cluster_template_datasource"
}

# Create a single Kubernetes cluster.
module "kubernetes_cluster" {
  source = "../../modules/kubernetes_cluster"

  cluster_template_id   = "${module.kubernetes_cluster_template_datasource.cluster_template_id}"
  cluster_keypair       = "${module.keypair.keypair_id}"
  cluster_master_flavor = "${module.flavor.flavor_id}"
  cluster_flavor        = "${module.flavor.flavor_id}"
  cluster_master_count  = 3
  cluster_node_count    = 3
}
