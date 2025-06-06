terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
      version = ">= 6.5.0"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">= 3.1.0"
    }
  }
  required_version = ">= 1.12.1"
}
