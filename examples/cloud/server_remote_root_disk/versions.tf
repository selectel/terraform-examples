terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
      version = ">= 5.1.1"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 1.9.2"
}
