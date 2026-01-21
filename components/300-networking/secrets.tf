# Add a secret to store drg details
resource "doppler_secret" "database_connection_details" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_GAIA_CONNECTIONS"
  value_type = "json"
  value = jsonencode(
    {
      "drg" : {
        "id" : oci_core_drg.database.id
      },
      "lpg" : {
        "zeus_prod_id" : oci_core_local_peering_gateway.to_zeus_prod.id,
        "helios_prod_id" : oci_core_local_peering_gateway.to_helios_prod.id
      }
    }
  )
}
