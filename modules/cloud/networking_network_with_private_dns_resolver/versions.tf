terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
     selectel = {
      source = "selectel/selectel"
      version = ">= 7.4.0"
    }
  }
  required_version = ">= 0.13"
}
