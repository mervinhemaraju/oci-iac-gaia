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

# Create a virtual cloud network for mgmt
resource "oci_core_vcn" "mgmt" {

  compartment_id = local.values.compartments.production

  display_name   = "mgmt"
  dns_label      = "mgmt"
  is_ipv6enabled = false

  cidr_blocks = [
    local.networking.cidr.vcn.mgmt
  ]

  freeform_tags = local.tags.defaults
}
