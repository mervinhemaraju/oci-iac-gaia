
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-gaia",
      "environment" = "Production"
      "Component"   = "200-iam"
    }
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_ROOT_ID
    }

    groups = {
      administrators = "Administrators"
    }
  }
}
