variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_name" {}

variable "target_zone" {}

variable "keypair_name" {
  default = "loadbalancer_example_keypair"
}

variable "auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "lb_active_name" {
  default = "terraform-lb-active-standby"
}

variable "lb_active_flavor_uuid" {
  default = "d3b8898c-af94-47f8-9996-65b9c6aa95e2"
}

variable "server_image_name" {
  default = "Ubuntu 20.04 LTS 64-bit"
}

variable "lb_active_components" {
  default = {
    component_1 = {
      listener_protocol          = "HTTP"
      listener_protocol_port     = 8090
      listener_x_forwarded_for   = true
      listener_x_forwarded_port  = false
      listener_x_forwarded_proto = false
      monitor_type               = "HTTP"
      monitor_url_path           = "/"
      monitor_delay              = 20
      monitor_timeout            = 10
      monitor_retries            = 5
      pool_lb_method             = "ROUND_ROBIN"
      pool_cookie_type           = "APP_COOKIE"
      pool_cookie_name           = "testCookie"
      pool_protocol              = "HTTP"
      member_protocol_port       = 80
    }
  }
}

variable "lb_sngl_name" {
  default = "terraform-lb-sngl"
}

variable "lb_sngl_flavor_uuid" {
  default = "3265f75f-01eb-456d-9088-44b813d29a60"
}

variable "lb_sngl_components" {
  default = {
    component_1 = {
      listener_protocol      = "TCP"
      listener_protocol_port = 8080
      monitor_type           = "TCP"
      monitor_delay          = 20
      monitor_timeout        = 10
      monitor_retries        = 5
      pool_lb_method         = "LEAST_CONNECTIONS"
      pool_protocol          = "TCP"
      member_protocol_port   = 80
    }
    component_2 = {
      listener_protocol      = "UDP"
      listener_protocol_port = 5353
      monitor_type           = "UDP-CONNECT"
      monitor_delay          = 20
      monitor_timeout        = 10
      monitor_retries        = 5
      pool_lb_method         = "LEAST_CONNECTIONS"
      pool_protocol          = "UDP"
      member_protocol_port   = 53
    }
  }
}
