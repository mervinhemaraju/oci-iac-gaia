
# Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_global
}

# OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.doppler_secrets.oci_creds.map.OCI_GAIA_TENANCY_OCID
  user_ocid    = data.doppler_secrets.oci_creds.map.OCI_GAIA_USER_OCID
  fingerprint  = data.doppler_secrets.oci_creds.map.OCI_API_FINGERPRINT
  private_key  = data.doppler_secrets.oci_creds.map.OCI_API_KEY_PRIVATE
  region       = var.region
}
