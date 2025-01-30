# resource "oci_core_drg_attachment" "database_cross_tenancy" {

#   drg_id = data.oci_core_drgs.database.drgs[0].id

#   display_name = "database-cross-drg-attachment"

#   freeform_tags = local.tags.defaults

#   #   drg_route_table_id = oci_core_drg_route_table.test_drg_route_table.id

#   network_details {
#     id             = oci_core_vcn.web.id
#     type           = "VCN"
#     vcn_route_type = "SUBNET_CIDRS"
#   }
# }
