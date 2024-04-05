# The defualt resources that comes with a VCN
resource "oci_core_default_security_list" "default" {
  manage_default_resource_id = oci_core_vcn.web.default_security_list_id
  compartment_id             = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
}

resource "oci_core_default_route_table" "default" {
  manage_default_resource_id = oci_core_vcn.web.default_route_table_id
  compartment_id             = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
}
