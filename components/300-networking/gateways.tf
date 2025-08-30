# Create a main NAT gateway for Database
resource "oci_core_nat_gateway" "database" {
  compartment_id = local.values.compartments.production

  display_name = "db-ng"
  vcn_id       = oci_core_vcn.database.id

  public_ip_id = oci_core_public_ip.database_nat.id

  freeform_tags = local.tags.defaults
}

# Create a Dynamic Routing Gateway for VCN peering
resource "oci_core_drg" "database" {
  compartment_id = local.values.compartments.production

  display_name = "db-drg"

  freeform_tags = local.tags.defaults
}
