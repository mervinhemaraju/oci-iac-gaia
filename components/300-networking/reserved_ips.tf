# Create a reserved public IP for the nat gateway
resource "oci_core_public_ip" "database_nat" {
  compartment_id = local.values.compartments.production
  lifetime       = "RESERVED"

  display_name = "ip-database-nat"

  freeform_tags = local.tags.defaults
}
