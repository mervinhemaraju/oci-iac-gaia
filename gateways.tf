# Create a main Internet gateway for the compartment
resource "oci_core_internet_gateway" "prod" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  enabled      = true
  display_name = "prod-ig"

  freeform_tags = local.tags.defaults
}

# Create a main NAT gateway for the compartment
resource "oci_core_nat_gateway" "prod" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name = "prod-nat"

  public_ip_id = oci_core_public_ip.prod_nat.id

  freeform_tags = local.tags.defaults
}
