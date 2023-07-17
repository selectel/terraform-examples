terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.52.0"
    }
  }
  required_version = ">= 1.5.3"
}
