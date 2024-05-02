resource "oci_core_drg_attachment" "database_cross_tenancy" {

  drg_id = data.oci_core_drgs.database.drgs[0].id

  display_name = "database-cross-drg-attachment"

  freeform_tags = local.tags.defaults

  #   drg_route_table_id = oci_core_drg_route_table.test_drg_route_table.id

  # network_details {
  #     #Required
  #     id = oci_core_vcn.test_vcn.id
  #     type = var.drg_attachment_network_details_type

  #     #Optional
  #     id = var.drg_attachment_network_details_id
  #     route_table_id = oci_core_route_table.test_route_table.id
  #     vcn_route_type = var.drg_attachment_network_details_vcn_route_type
  # }
}
