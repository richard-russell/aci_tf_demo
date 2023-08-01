terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

  }
}

provider "aci" {
  # cisco-aci user name
  username = var.apic_user
  # cisco-aci password
  password = var.apic_password
  # cisco-aci url
  url      = var.apic_url
  insecure = true
}
