

# Create a private subnet for the database resources
resource "oci_core_subnet" "private_db" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_db
  vcn_id     = oci_core_vcn.database.id

  display_name               = "private-db"
  dns_label                  = "privatedb"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_db.id]

  route_table_id = oci_core_route_table.private_db.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.database
  ]
}


# Create a private subnet for the mgmt resources
resource "oci_core_subnet" "private_mgmt" {

  compartment_id = local.values.compartments.production

  cidr_block = local.networking.cidr.subnets.private_mgmt
  vcn_id     = oci_core_vcn.database.id

  display_name               = "private-mgmt"
  dns_label                  = "privatemgmt"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_mgmt.id]

  route_table_id = oci_core_route_table.private_mgmt.id

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.database
  ]
}
