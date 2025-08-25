

# The Terraform Module
terraform {

  # Required providers
  required_providers {

    # Doppler provider
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1"
    }

    # OCI provider
    oci = {
      source  = "oracle/oci"
      version = "6.25.0"
    }

    # AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}
