resource "oci_core_volume_group" "web" {
  availability_domain = data.oci_identity_availability_domain.this.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID

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
