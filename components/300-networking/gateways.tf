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

# Create a Local Peering Gateway for GAIA -> ZEUS (same region)
resource "oci_core_local_peering_gateway" "to_zeus_prod" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "lpg-to-zeus-prod"

  # Don't set peer_id here - Zeus will be the requestor

  freeform_tags = local.tags.defaults
}

# Create a Local Peering Gateway for GAIA -> HELIOS (same region)
resource "oci_core_local_peering_gateway" "to_helios_prod" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "lpg-to-helios-prod"

  # Don't set peer_id here - Helios will be the requestor

  freeform_tags = local.tags.defaults
}
