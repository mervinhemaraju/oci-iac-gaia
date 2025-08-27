# Create a main NAT gateway for Database
resource "oci_core_nat_gateway" "database" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name  = "db-ng"
  freeform_tags = local.tags.defaults
}
