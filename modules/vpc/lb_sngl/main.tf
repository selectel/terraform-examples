# Создание балансировщика
resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_sngl_name
  vip_subnet_id = var.lb_public_subnet_id
  flavor_id     = var.lb_sngl_flavor_uuid
}

# Создание компонентов балансировщика
module "lb_components" {
  count  = length(var.lb_sngl_components)
  source = "../lb_components"

  lb_components     = var.lb_sngl_components["component_${count.index + 1}"]
  loadbalancer_id   = openstack_lb_loadbalancer_v2.lb.id
  vip_subnet_id     = var.lb_public_subnet_id
  server_access_ips = var.lb_servers_access_ips
}

# Создание плавающего адреса и ассоциирование его с портом балансировщика
resource "openstack_networking_floatingip_v2" "floatingip" {
  pool    = "external-network"
  port_id = openstack_lb_loadbalancer_v2.lb.vip_port_id
}
