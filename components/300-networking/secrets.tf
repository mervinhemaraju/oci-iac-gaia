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
      }
    }
  )
}
