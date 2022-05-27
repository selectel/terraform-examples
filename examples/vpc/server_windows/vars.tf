variable "sel_account" {}

variable "sel_token" {}

variable "project_name" {
  default = "tf_project"
}

variable "user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "keypair_name" {
  default = "tf_keypair"
}

variable "os_auth_url" {
  default = "https://api.selvpc.ru/identity/v3"
}

variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-3a"
}

variable "server_vcpus" {
  default = 4
}

variable "server_ram_mb" {
  default = 8192
}

variable "server_root_disk_gb" {
  default = 32
}

variable "server_volume_type" {
  default = "fast.ru-3a"
}

variable "server_image_name" {
  default = "Windows Server 2016 Standard"
}

variable "license_type" {
  default = "license_windows_2016_standard"
}
