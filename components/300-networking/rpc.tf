# Create a remote peering connection
resource "oci_core_remote_peering_connection" "database" {
  compartment_id = local.values.compartments.production
  drg_id         = oci_core_drg.database.id

  display_name     = "database-rpc"
  peer_id          = local.networking.gateways.rpc_id_poseidon # Acceptor Poseidon rpc id
  peer_region_name = "uk-south-1"                              # Acceptor Poseidon region

  freeform_tags = local.tags.defaults
}
