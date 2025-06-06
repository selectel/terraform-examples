terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 1.9.2"
}
