variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_name" {
  default = "tf_project"
}

variable "project_user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "keypair_name" {
  default = "tf_keypair"
}

variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "server_name" {
  default = "tf_server"
}

variable "flavor_id" {
  default = "3021"
}

variable "server_root_disk_gb" {
  default = 8
}

variable "server_volume_type" {
  default = "fast.ru-7a"
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "server_preemptible_tag" {
  default = ["preemptible"]
}

variable "server_no_preemptible_tag" {
  default = []
}

### ATTENTION!!! Do not edit this block, please.
variable "server_zone" {
  type        = string
  description = "The name of the Selectel's pool."

  default = "ru-7a"

  validation {
    condition     = can(regex("7a", var.server_zone))
    error_message = "Preemtible servers are available in ru-7a pool only."
  }
}
