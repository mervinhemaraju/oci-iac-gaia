# Create a remote peering connection
resource "oci_core_remote_peering_connection" "database" {
  compartment_id = local.values.compartments.root
  drg_id         = oci_core_drg.database.id

  display_name     = "database-rpc"
  peer_id          = local.networking.gateways.rpc_id_poseidon
  peer_region_name = var.region

  freeform_tags = local.tags.defaults
}
