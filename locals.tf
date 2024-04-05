
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-gaia",
      "Environment" = "Production"
    }
  }

  networking = {

    cidr = {
      vcn = {
        web = "10.15.0.0/16"
      }

      subnets = {
        public_web  = "10.15.100.0/24"
        private_web = "10.15.1.0/24"
      }
    }
    ip_address = {
      web_01 = "10.15.1.10"
      web_02 = "10.15.1.20"
    }
  }

  values = {
    compute = {

      shape = "VM.Standard.A1.Flex"
      image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7xvogbygpoelc6373sg547342qojimntnk4dvemmekilet66nppq"

      web_01 = {
        name = "web-01"
      }

      web_02 = {
        name = "web-02"
      }

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
