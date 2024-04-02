resource "oci_bastion_bastion" "private_web_01" {
  bastion_type     = "standard"
  compartment_id   = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  target_subnet_id = oci_core_subnet.private_web_01.id

  max_session_ttl_in_seconds = 10800
  name                       = "jump-private-web-01"

  freeform_tags = local.tags.defaults
}

resource "oci_bastion_bastion" "private_web_02" {
  bastion_type     = "standard"
  compartment_id   = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  target_subnet_id = oci_core_subnet.private_web_02.id

  max_session_ttl_in_seconds = 10800
  name                       = "jump-private-web-02"

  freeform_tags = local.tags.defaults
}
