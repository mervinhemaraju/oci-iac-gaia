# Add a secret to store drg details
resource "doppler_secret" "database_drg_details" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_GAIA_DRG_DATABASE"
  value_type = "json"
  value = jsonencode(
    {
      "id" : oci_core_drg.database.id
    }
  )
}
