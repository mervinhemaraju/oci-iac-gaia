
# # Create a network security group for web servers
# resource "oci_core_network_security_group" "web" {

#   compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
#   vcn_id         = oci_core_vcn.web.id
#   display_name   = "nsg-web"
#   freeform_tags  = local.tags.defaults
# }

# # Enable HTTP traffic
# resource "oci_core_network_security_group_security_rule" "web" {

#   network_security_group_id = oci_core_network_security_group.web.id
#   direction                 = "INGRESS"
#   protocol                  = 6 # TCP

#   description = "Enable HTTP traffic"
#   source      = "0.0.0.0/0"
#   source_type = "CIDR_BLOCK"
#   stateless   = false

#   tcp_options {
#     source_port_range {
#       max = 80
#       min = 80
#     }
#   }
# }
