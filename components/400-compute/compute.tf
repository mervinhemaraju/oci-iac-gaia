
# Create compute instance for database
resource "oci_core_instance" "database" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.instances.database.name

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 24
    ocpus         = 4
    vcpus         = 4
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.private_database.subnets[0].id
    assign_public_ip       = false
    private_ip             = local.instances.database.private_ip
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "200"
    boot_volume_vpus_per_gb = 120
  }

  agent_config {
    dynamic "plugins_config" {
      for_each = local.values.compute.plugins_config
      content {
        desired_state = plugins_config.value.desired_state
        name          = plugins_config.value.name
      }
    }
  }

  freeform_tags = local.tags.defaults

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
    # User data from YAML template file
    user_data = base64encode(templatefile("${path.module}/templates/cloud_init.yml", {
      hostname               = local.instances.database.name
      authorized_ssh_key     = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
      github_pat             = data.doppler_secrets.apps_creds.map.GH_TERRAFORM_TOKEN
      postgres_user_password = data.doppler_secrets.oci_creds.map.OCI_ZEUS_DATABASE_USER_PASSWORD
    }))
  }
}
