variable "sel_token" {}

variable "user_password" {}

variable "project_name" {
  default = "loadbalancer_example_project"
}

variable "user_name" {
  default = "loadbalancer_example_user"
}

variable "keypair_name" {
  default = "loadbalancer_example_keypair"
}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "target_zone" {
  default = "ru-3a"
}

variable "lb_flavor_id" {
  default = ""
}

variable "lb_components_http" {
  default = {
    component_1 = {
      listener_protocol          = "HTTP"
      listener_protocol_port     = 80
      listener_x_forwarded_for   = true
      listener_x_forwarded_port  = false
      listener_x_forwarded_proto = false
      monitor_type               = "PING"
      monitor_delay              = 20
      monitor_timeout            = 10
      monitor_retries            = 5
      pool_lb_method             = "ROUND_ROBIN"
      pool_cookie_type           = "APP_COOKIE"
      pool_cookie_name           = "testCookie"
      member_protocol_port       = 90
    }
  }
}

variable "lb_components" {
  default = {
    component_1 = {
      listener_protocol      = "TCP"
      listener_protocol_port = 22
      monitor_type           = "PING"
      monitor_delay          = 20
      monitor_timeout        = 10
      monitor_retries        = 5
      pool_lb_method         = "LEAST_CONNECTIONS"
      member_protocol_port   = 22
    }
    component_2 = {
      listener_protocol      = "TCP"
      listener_protocol_port = 9090
      monitor_type           = "TCP"
      monitor_delay          = 25
      monitor_timeout        = 15
      monitor_retries        = 10
      pool_lb_method         = "LEAST_CONNECTIONS"
      member_protocol_port   = 9091
    }
    component_3 = {
      listener_protocol      = "UDP"
      listener_protocol_port = 8080
      monitor_type           = "UDP-CONNECT"
      monitor_delay          = 20
      monitor_timeout        = 10
      monitor_retries        = 5
      pool_lb_method         = "LEAST_CONNECTIONS"
      member_protocol_port   = 8080
    }
  }
}

variable "server_image_name" {
  default = "Ubuntu 18.04 LTS 64-bit"
}

variable "count_of_servers" {
  default = 2
}
