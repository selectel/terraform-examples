terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 7.3.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "2.1.0"
    }
  }
  required_version = ">= 1.9.8"
}
