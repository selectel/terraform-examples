variable "protocol_port" {}

variable "loadbalancer_id" {}

variable "lb_method" {}

variable "pool_type" {}

variable "pool_cookie" {
  default = ""
}

variable "x_forwarded_for" {
  default = false
}

variable "x_forwarded_port" {
  default = false
}

variable "x_forwarded_proto" {
  default = false
}

variable "monitor_type" {
  default = "PING"
}

variable "monitor_delay" {
  default = 20
}

variable "monitor_timeout" {
  default = 10
}

variable "monitor_retries" {
  default = 5
}
