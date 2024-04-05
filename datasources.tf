# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Get the latest Oracle 9 Image
data "oci_core_images" "oracle_linux" {
  compartment_id           = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = local.values.compute.shape
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  ad_number      = 1
}

# Gets the fault domains from this AZ
data "oci_identity_fault_domains" "this" {
  availability_domain = data.oci_identity_availability_domain.this.name
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
}

data "oci_core_vnic_attachments" "web_01" {
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  availability_domain = data.oci_identity_availability_domain.this.name
  instance_id         = oci_core_instance.web_01.id

  depends_on = [oci_core_instance.web_01]
}

data "oci_core_private_ips" "web_01" {
  vnic_id    = lookup(data.oci_core_vnic_attachments.web_01.vnic_attachments[0], "vnic_id")
  depends_on = [oci_core_instance.web_01]
}

data "oci_core_vnic_attachments" "web_02" {
  compartment_id      = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  availability_domain = data.oci_identity_availability_domain.this.name
  instance_id         = oci_core_instance.web_02.id

  depends_on = [oci_core_instance.web_02]
}

data "oci_core_private_ips" "web_02" {
  vnic_id    = lookup(data.oci_core_vnic_attachments.web_02.vnic_attachments[0], "vnic_id")
  depends_on = [oci_core_instance.web_02]
}
