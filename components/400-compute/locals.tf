
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-gaia",
      "environment" = "Production"
      "Component"   = "400-compute"
    }
  }


  instances = {
    database = {
      name = "database"
      # TODO(Change temporary IP)
      private_ip = "10.50.10.10"
    }
  }

  values = {

    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
    }


    bastions = {
      "private-jump-01" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
      "private-jump-02" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
    }

    compute = {

      shape = "VM.Standard.A1.Flex"
      image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaaehryq3hy5scsocnp3rdw467efkqoympbzqyeylr42ysxgs462pka"

      plugins_config = [
        {
          name          = "Bastion"
          desired_state = "ENABLED"
        },
        {
          name          = "OS Management Service Agent"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Run Command"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Monitoring"
          desired_state = "ENABLED"
        }
      ]
    }
  }
}
