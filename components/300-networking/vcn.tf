# Create a virtual cloud network for database
resource "oci_core_vcn" "database" {

  compartment_id = local.values.compartments.production

  display_name   = "database"
  dns_label      = "database"
  is_ipv6enabled = false

  cidr_blocks = [
    local.networking.cidr.vcn.database
  ]

  freeform_tags = local.tags.defaults
}
