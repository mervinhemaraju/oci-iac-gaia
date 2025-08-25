
# * Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_global
}

# * OCI Provider for Oracle cloud connection for account GAIA
provider "oci" {
  tenancy_ocid = data.doppler_secrets.oci_creds.map.OCI_GAIA_TENANCY_OCID
  user_ocid    = data.doppler_secrets.oci_creds.map.OCI_GAIA_USER_OCID
  fingerprint  = data.doppler_secrets.oci_creds.map.OCI_API_FINGERPRINT
  private_key  = data.doppler_secrets.oci_creds.map.OCI_API_KEY_PRIVATE
  region       = var.region
}

# * OCI Provider for Oracle cloud connection for account HELIOS
provider "oci" {
  alias        = "helios"
  tenancy_ocid = data.doppler_secrets.oci_creds.map.OCI_HELIOS_TENANCY_OCID
  user_ocid    = data.doppler_secrets.oci_creds.map.OCI_HELIOS_USER_OCID
  fingerprint  = data.doppler_secrets.oci_creds.map.OCI_API_FINGERPRINT
  private_key  = data.doppler_secrets.oci_creds.map.OCI_API_KEY_PRIVATE
  region       = var.region
}

# * The Terraform Module
terraform {

  # The required tf version
  required_version = "1.8.7"

  # Backend configuration
  backend "s3" {
    region = var.bucket_region
    key    = "${var.bucket_key_prefix_iac}/state.tf"
    bucket = var.bucket_name
  }

  # * Required providers
  required_providers {

    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.7.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "5.34.0"
    }
  }
}
