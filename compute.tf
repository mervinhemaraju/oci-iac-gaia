

# Create a compute instance for web-01
resource "oci_core_instance" "web_01" {

  availability_domain = data.oci_identity_availability_domain.this.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  fault_domain        = data.oci_identity_fault_domains.this.fault_domains[0].name

  display_name = local.values.compute.web_01.name

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 12
    ocpus         = 2
    vcpus         = 2
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.private_web_01.id
    assign_public_ip       = false
    private_ip             = local.networking.ip_address.web_01
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "100"
  }

  agent_config {
    plugins_config {
      desired_state = "ENABLED"
      name          = "Bastion"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
  }


  freeform_tags = local.tags.defaults

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPUTE_KEY_PUBLIC
  }

}

# Create a compute instance for web-02
resource "oci_core_instance" "web_02" {

  availability_domain = data.oci_identity_availability_domain.this.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  fault_domain        = data.oci_identity_fault_domains.this.fault_domains[1].name

  display_name = local.values.compute.web_02.name

  shape = local.values.compute.shape


  shape_config {
    memory_in_gbs = 12
    ocpus         = 2
    vcpus         = 2
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.private_web_02.id
    assign_public_ip       = false
    private_ip             = local.networking.ip_address.web_02
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "100"
  }

  agent_config {
    plugins_config {
      desired_state = "ENABLED"
      name          = "Bastion"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
  }

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPUTE_KEY_PUBLIC
  }

}

