# The virtual cloud network 'Database' and its attachments
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

# > The DRG attachment
resource "oci_core_drg_attachment" "database" {

  drg_id = oci_core_drg.database.id

  display_name = "database-drg-attachment"

  freeform_tags = local.tags.defaults

  network_details {
    id             = oci_core_vcn.database.id
    type           = "VCN"
    vcn_route_type = "SUBNET_CIDRS"
  }
}
