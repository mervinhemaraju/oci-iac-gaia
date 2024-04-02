
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
        public_web     = "10.15.100.0/24"
        private_web_01 = "10.15.1.0/24"
        private_web_02 = "10.15.2.0/24"
      }
    }
    ip_address = {
      web_01 = "10.15.1.10"
      web_02 = "10.15.2.10"
    }
  }

  values = {
    compute = {

      shape = "VM.Standard.A1.Flex"
      image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaascxwbn7sovafprhcbtehiipbc56aidb5jvkoatl4gigpeqlgmaxa"

      web_01 = {
        name = "web-01"
      }

      web_02 = {
        name = "web-02"
      }
    }
  }
}
