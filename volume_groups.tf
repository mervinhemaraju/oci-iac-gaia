resource "oci_core_volume_group" "web" {

  compartment_id      = local.values.compartments.production
  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = "web-volumes"

  source_details {
    type = "volumeIds"
    volume_ids = [
      oci_core_instance.web_01.boot_volume_id,
      oci_core_instance.web_02.boot_volume_id,
    ]
  }
  freeform_tags = local.tags.defaults
}
