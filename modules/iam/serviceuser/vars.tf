variable "user_name" {
  default = "serviceuser_1"
}

variable "password" {}

variable "roles" {
  type = list(map(string))
  default = []
}