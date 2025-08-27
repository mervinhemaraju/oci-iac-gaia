
resource "oci_bastion_bastion" "private_jumpbox" {

  for_each = local.values.bastions

  compartment_id = local.values.compartments.production

  bastion_type     = "STANDARD"
  target_subnet_id = data.oci_core_subnets.private_mgmt.subnets[0].id

  max_session_ttl_in_seconds = each.value.max_session_ttl_in_seconds
  name                       = each.key

  client_cidr_block_allow_list = each.value.client_cidr_block_allow_list

  freeform_tags = local.tags.defaults
}
