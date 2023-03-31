terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.6.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

  }
}

provider "aci" {
  # cisco-aci user name
  username = "admin"
  # cisco-aci password
  password = "!v3G@!4@Y"
  # cisco-aci url
  url      = "https://sandboxapicdc.cisco.com"
  insecure = true
}

resource "aci_tenant" "this" {
  name        = "CX_UKI_automation"
  description = "terraform demo"
  annotation  = "tag"
}

resource "aci_application_profile" "this" {
  tenant_dn   = aci_tenant.this.id
  name        = "CX_UKI_automation_AP1"
  annotation  = "tag"
  description = "terraform demo"
  name_alias  = "test_ap"
  prio        = "level1"
}

resource "aci_bridge_domain" "this" {
  tenant_dn   = aci_tenant.this.id
  description = "from terraform"
  name        = "CX_UKI_automation_BD1"
}

resource "random_pet" "epgs" {
  count  = 10
  length = 2
}

resource "aci_application_epg" "demo_epgs" {
  for_each               = toset(random_pet.epgs[*].id)
  application_profile_dn = aci_application_profile.this.id
  name                   = "epg-${each.value}"
  description            = "terraform demo"
  annotation             = "tag_epg"
  exception_tag          = "0"
  flood_on_encap         = "disabled"
  fwd_ctrl               = "none"
  has_mcast_source       = "no"
  is_attr_based_epg      = "no"
  match_t                = "AtleastOne"
  name_alias             = "alias_epg"
  pc_enf_pref            = "unenforced"
  pref_gr_memb           = "exclude"
  prio                   = "unspecified"
  shutdown               = "no"
  relation_fv_rs_bd      = aci_bridge_domain.this.id
}