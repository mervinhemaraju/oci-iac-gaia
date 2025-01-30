

# Create a compute instance for web-01
resource "oci_core_instance" "web_01" {
  compartment_id      = local.values.compartments.production
  availability_domain = data.oci_identity_availability_domain.this.name
  fault_domain        = data.oci_identity_fault_domains.this.fault_domains[0].name

  display_name = local.values.compute.web_01.name

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 18
    ocpus         = 2
    vcpus         = 2
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.public_web.id
    assign_public_ip       = true
    private_ip             = local.networking.ip_address.web_01
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "100"
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
    ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPUTE_KEY_PUBLIC
  }

}

# Create a compute instance for web-02
# resource "oci_core_instance" "web_02" {
#   compartment_id = local.values.compartments.production

#   availability_domain = data.oci_identity_availability_domain.this.name
#   fault_domain        = data.oci_identity_fault_domains.this.fault_domains[1].name

#   display_name = local.values.compute.web_02.name

#   shape = local.values.compute.shape


#   shape_config {
#     memory_in_gbs = 6
#     ocpus         = 2
#     vcpus         = 2
#   }

#   create_vnic_details {
#     subnet_id              = oci_core_subnet.public_web.id
#     assign_public_ip       = true
#     private_ip             = local.networking.ip_address.web_02
#     skip_source_dest_check = true
#   }

#   source_details {
#     source_type             = "image"
#     source_id               = local.values.compute.image
#     boot_volume_size_in_gbs = "100"
#   }

#   agent_config {
#     dynamic "plugins_config" {
#       for_each = local.values.compute.plugins_config
#       content {
#         desired_state = plugins_config.value.desired_state
#         name          = plugins_config.value.name
#       }
#     }
#   }

#   metadata = {
#     ssh_authorized_keys = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPUTE_KEY_PUBLIC
#   }

# }
