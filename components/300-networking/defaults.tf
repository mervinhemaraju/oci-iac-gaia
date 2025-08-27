# The default resources that comes with a VCN for database
resource "oci_core_default_security_list" "database" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.database.default_security_list_id
}

resource "oci_core_default_route_table" "database" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.database.default_route_table_id
}
