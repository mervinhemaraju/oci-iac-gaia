
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-gaia",
      "environment" = "Production"
      "Component"   = "300-networking"
    }
  }

  networking = {

    cidr = {
      vcn = {
        mgmt     = "10.200.100.0/24"
        database = "10.18.0.0/16"
      }
      subnets = {
        private_mgmt = "10.200.100.0/28"
        private_db   = "10.18.10.0/24"
        # TODO(Remove temporary subnet)
        public = "10.50.10.0/24"
      }
    }
  }

  values = {

    tenancy = data.doppler_secrets.oci_creds.map.OCI_GAIA_TENANCY_OCID

    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_ROOT_ID
    }
  }
}
