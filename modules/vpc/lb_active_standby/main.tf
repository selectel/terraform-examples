# Создание контейнера Barbican
resource "openstack_keymanager_secret_v1" "secret_1" {
  name                      = "tls_secret_sni"
  payload_content_type      = "application/octet-stream"
  payload_content_encoding  = "base64"
  payload                   = filebase64("${var.lb_ssl_container}")
  algorithm                 = "aes"
  bit_length                = 256
  mode                      = "cbc"
  expiration                = "${timeadd(timestamp(), format("%dh", 8760))}"

  lifecycle {
    ignore_changes = [
      payload,
      expiration,
    ]
  }
}

# Создание балансировщика
resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_active_name
  vip_subnet_id = var.lb_private_subnet_id
  flavor_id     = var.lb_active_flavor_uuid
}

# Создание компонентов балансировщика
module "lb_components" {
  count  = length(var.lb_active_components)
  source = "../lb_components_http"

  lb_components             = var.lb_active_components["component_${count.index + 1}"]
  loadbalancer_id           = openstack_lb_loadbalancer_v2.lb.id
  vip_subnet_id             = var.lb_private_subnet_id
  server_access_ips         = var.lb_servers_access_ips
  default_tls_container_ref = openstack_keymanager_secret_v1.secret_1.secret_ref

  depends_on = [
    openstack_keymanager_secret_v1.secret_1,
  ]
}

# Создание плавающего адреса и ассоциирование его с портом балансировщика
resource "openstack_networking_floatingip_v2" "floatingip" {
  pool    = "external-network"
  port_id = openstack_lb_loadbalancer_v2.lb.vip_port_id
}
