terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">= 1.45.0"
    }
  }
  required_version = ">= 0.13"
}
