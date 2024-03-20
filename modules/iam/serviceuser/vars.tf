variable "user_name" {}

variable "password" {}

variable "roles" {
  type = list(map(string))
  default = []
}