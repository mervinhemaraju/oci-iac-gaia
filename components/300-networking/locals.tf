
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
        database = "10.18.0.0/16"
      }
      subnets = {
        private_mgmt        = "10.18.10.0/24"
        private_db          = "10.18.20.0/24"
        private_k8_helios   = "10.16.31.0/24" # (This is found in the HELIOS account)
        private_k8_poseidon = "10.15.31.0/24" # (This is found in the POSEIDON account)
        private_k8_zeus     = "10.17.31.0/24" # (This is found in the ZEUS account)
      }
    }

    gateways = {
      rpc_id_poseidon = jsondecode(data.doppler_secrets.oci_creds.map.OCI_POSEIDON_CONNECTIONS)["rpc"]["gaia_database_id"]
    }
  }

  secrets = {
    oci = "cloud-oci-creds"
  }

  values = {

    tenancy = data.doppler_secrets.oci_creds.map.OCI_GAIA_TENANCY_OCID

    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_ROOT_ID
    }
  }
}
