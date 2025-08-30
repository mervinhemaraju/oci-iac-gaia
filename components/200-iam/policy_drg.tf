
# Create a policy for DRG management as a requestor
resource "oci_identity_policy" "requestor_drg_management" {

  compartment_id = local.values.compartments.root
  description    = "Allow the requestor to manage DRG in this tenancy"
  name           = "requestor-drg-management"
  statements = [
    "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
    "define group ${local.values.groups.helios_groups.vcn_admins.name} as ${local.values.groups.helios_groups.vcn_admins.id}",
    "define tenancy acceptorVCN as ${local.values.compartments.root_helios}",
    "Allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
    "Allow group ${local.values.groups.helios_groups.vcn_admins.name} to manage virtual-network-family in tenancy",
    "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy acceptorVCN",
    "admit group ${local.values.groups.helios_groups.vcn_admins.name} of tenancy acceptorVCN to manage drg in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
