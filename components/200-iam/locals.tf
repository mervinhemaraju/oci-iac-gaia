
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

  secrets = {
    oci = "cloud-oci-creds"
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_ROOT_ID

      root_helios = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_ROOT_ID
    }

    groups = {
      drg_admins     = "drg-admins"
      administrators = "Administrators"
      helios_groups = {
        vcn_admins = {
          name = "vcn-admins"
          id   = jsondecode(data.doppler_secrets.oci_creds.map.OCI_HELIOS_GROUPS)["vcn-admins"]
        }
      }
    }
  }
}
