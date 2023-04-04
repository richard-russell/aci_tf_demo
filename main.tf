resource "aci_tenant" "this" {
  name        = "${var.name_prefix}_tenant"
  description = "terraform demo"
  annotation  = "tag"
}

resource "aci_application_profile" "this" {
  tenant_dn   = aci_tenant.this.id
  name        = "${var.name_prefix}_AP1"
  annotation  = "tag"
  description = "terraform demo"
  name_alias  = "test_ap"
  prio        = "level1"
}

resource "aci_bridge_domain" "this" {
  tenant_dn   = aci_tenant.this.id
  description = "from terraform"
  name        = "${var.name_prefix}_BD1"
}

resource "random_pet" "epg_names" {
  count  = var.epg_count
  length = 2
}

resource "aci_application_epg" "demo_epgs" {
  count                  = var.epg_count
  application_profile_dn = aci_application_profile.this.id
  name                   = "ap-epg-${random_pet.epg_names[count.index].id}"
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
