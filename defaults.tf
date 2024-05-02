# The defualt resources that comes with a VCN
resource "oci_core_default_security_list" "default" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.web.default_security_list_id
}

resource "oci_core_default_route_table" "default" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.web.default_route_table_id
}
