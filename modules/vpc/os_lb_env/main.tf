# Создание сети балансировщика базового типа с резервированием
module "private_nat" {
  source = "../nat"

  router_name  = "terraform-private"
  network_name = "terraform-private-lb-net"
  subnet_cidr  = "192.168.199.0/24"
}

# Создание сети балансировщика базового типа без резервирования
module "public_nat" {
  source = "../nat"

  router_name  = "terraform-public"
  network_name = "terraform-public-lb-net"
  subnet_cidr  = "10.10.0.0/24"
}

# Создание SSH ключа
resource "openstack_compute_keypair_v2" "keypair1" {
  count      = var.keypair_name != "" ? 1 : 0
  name       = var.keypair_name
  public_key = file("~/.ssh/id_rsa.pub")
}

# Создание инстансов
module "instances" {
  count  = 2
  source = "../single_instance"

  server_name         = "terraform-vm-${count.index + 1}"
  server_zone         = var.target_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_image_name   = var.server_image_name
  keypair_name        = var.keypair_name
  user_data           = "#!/bin/bash\n\n# Install packages\nDEBIAN_FRONTEND=noninteractive apt update && apt install -y nginx bind9"

  private_network_id  = module.private_nat.network_id
  private_subnet_id   = module.private_nat.subnet_id

  public_network_id   = module.public_nat.network_id
  public_subnet_id    = module.public_nat.subnet_id
}
