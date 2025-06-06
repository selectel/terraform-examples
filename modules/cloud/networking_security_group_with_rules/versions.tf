terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">= 3.1.0"
    }
  }
  required_version = ">= 1.12.1"
}
