resource "oci_bastion_bastion" "private_jump_01" {

  compartment_id   = local.values.compartments.production
  bastion_type     = "STANDARD"
  target_subnet_id = oci_core_subnet.private_mgmt.id

  max_session_ttl_in_seconds = 10800
  name                       = "private-jump-01"

  client_cidr_block_allow_list = ["0.0.0.0/0"]

  freeform_tags = local.tags.defaults
}

resource "oci_bastion_bastion" "private_jump_02" {
  compartment_id   = local.values.compartments.production
  bastion_type     = "STANDARD"
  target_subnet_id = oci_core_subnet.private_mgmt.id

  max_session_ttl_in_seconds = 10800
  name                       = "private-jump-02"

  client_cidr_block_allow_list = ["0.0.0.0/0"]

  freeform_tags = local.tags.defaults
}
