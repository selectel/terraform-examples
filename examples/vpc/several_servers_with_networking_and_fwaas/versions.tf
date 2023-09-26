terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
      version = "~> 4.0.0-aplha"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.52.0"
    }
  }
  required_version = ">= 1.5.3"
}
