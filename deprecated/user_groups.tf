# Creates a new user gorup for vcn admins
resource "oci_identity_group" "vcn_admins" {

  compartment_id = local.values.tenancy

  description = "VCN Admininistrators"
  name        = "vcn-admins"

  freeform_tags = local.tags.defaults
}
