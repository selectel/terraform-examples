variable "server_name" {
  description = "Name of the OpenStack Compute Instance"
  default     = "server_1"
}

variable "server_image_id" {
  description = "OpenStack Imageservice Image reference"
}

variable "server_volume_size_gb" {
  description = "OpenStack Blockstorage Volume size"
}

variable "server_volume_type" {
  description = "OpenStack Blockstorage Volume type"
}

variable "server_availability_zone" {
  description = "OpenStack Compute Availability Zone"
}

variable "server_flavor_id" {
  description = "OpenStack Compute Flavor reference"
  default     = "1003"
}

variable "server_keypair_name" {
  description = "OpenStack Compute Keypair reference"
}

variable "server_network_name" {
  description = "OpenStack Networking Network reference"
  default     = "nat"
}