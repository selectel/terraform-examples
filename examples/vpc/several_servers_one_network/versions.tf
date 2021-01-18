terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
  required_version = ">= 0.13"
}
