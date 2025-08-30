
# Create a policy for DRG management as a requestor
# resource "oci_identity_policy" "requestor_drg_management" {

#   compartment_id = local.values.compartments.root
#   description    = "Allow the requestor to manage DRG in this tenancy"
#   name           = "requestor-drg-management"
#   statements = [
#     "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
#     "define group ${data.oci_identity_groups.vcn_admins_gaia.groups[0].name} as ${data.oci_identity_groups.vcn_admins_gaia.groups[0].id}",
#     "define tenancy acceptorVCN as ${local.values.tenancy_gaia}",
#     "Allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
#     "Allow group ${data.oci_identity_groups.vcn_admins_gaia.groups[0].name} to manage virtual-network-family in tenancy",
#     "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy acceptorVCN",
#     "admit group ${data.oci_identity_groups.vcn_admins_gaia.groups[0].name} of tenancy acceptorVCN to manage drg in tenancy"
#   ]

#   freeform_tags = local.tags.defaults
# }
