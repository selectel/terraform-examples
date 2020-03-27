variable "protocol_port" {}

variable "loadbalancer_id" {}

variable "lb_method" {}

variable "monitor_type" {
  default = "UDP-CONNECT"
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
