# Create a remote peering connection
resource "oci_core_remote_peering_connection" "database" {
  compartment_id = local.values.compartments.root
  drg_id         = oci_core_drg.database.id

  display_name = "database-rpc"
  # peer_id = oci_core_remote_peering_connection.test_remote_peering_connection2.id
  peer_region_name = var.region

  freeform_tags = local.tags.defaults
}
