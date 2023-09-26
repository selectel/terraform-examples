terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 4.0.0-aplha"
    }
  }
  required_version = ">= 1.5.3"
}
