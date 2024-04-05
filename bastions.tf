resource "oci_bastion_bastion" "private_jump_01" {
  bastion_type     = "STANDARD"
  compartment_id   = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  target_subnet_id = oci_core_subnet.private_web.id

  max_session_ttl_in_seconds = 10800
  name                       = "private-jump-01"

  client_cidr_block_allow_list = ["0.0.0.0/0"]

  freeform_tags = local.tags.defaults
}

resource "oci_bastion_bastion" "private_jump_02" {
  bastion_type     = "STANDARD"
  compartment_id   = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  target_subnet_id = oci_core_subnet.private_web.id

  max_session_ttl_in_seconds = 10800
  name                       = "private-jump-02"

  client_cidr_block_allow_list = ["0.0.0.0/0"]

  freeform_tags = local.tags.defaults
}
