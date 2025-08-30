# Add a secret to store group details
resource "doppler_secret" "gaia_groups" {
  project    = local.secrets.oci
  config     = "prd"
  name       = "OCI_GAIA_GROUPS"
  value_type = "json"
  value = jsonencode(
    {
      "${local.values.groups.drg_admins}" : oci_identity_group.drg_admins.id
    }
  )
}
