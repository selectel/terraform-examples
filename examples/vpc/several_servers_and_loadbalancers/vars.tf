variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "user_password" {}

variable "project_name" {
  default = "loadbalancer_project"
}

variable "project_user_name" {
  default = "loadbalancer_user"
}

variable "keypair_name" {
  default = "loadbalancer_keypair"
}

variable "target_zone" {
  default = "ru-7a"
}

variable "auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "lb_active_name" {
  default = "terraform-lb-active-standby"
}

variable "lb_active_flavor_name" {
  default = "AMPH1.ACT_STNDB.4-2048"
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

variable "lb_active_https_components" {
  default = {
    component_1 = {
      listener_protocol          = "TERMINATED_HTTPS"
      listener_protocol_port     = 8443
      monitor_type               = "HTTPS"
      monitor_url_path           = "/"
      monitor_delay              = 20
      monitor_timeout            = 10
      monitor_retries            = 5
      pool_lb_method             = "LEAST_CONNECTIONS"
      pool_cookie_type           = "APP_COOKIE"
      pool_cookie_name           = "testCookie"
      pool_protocol              = "PROXY"
      member_protocol_port       = 443
    }
  }
}

variable "lb_sngl_name" {
  default = "terraform-lb-sngl"
}

variable "lb_sngl_flavor_name" {
  default = "AMPH1.SNGL.2-1024"
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
