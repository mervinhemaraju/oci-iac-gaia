
# Create a policy for DRG management as a requestor
resource "oci_identity_policy" "helios_cross_conection_statements" {

  compartment_id = local.values.compartments.root
  name           = "helios-cross-connection-statements"
  description    = "Allow the requestor to manage DRG and RPC in this tenancy and account HELIOS tenancy."

  statements = [
    # Definitions
    "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
    "define group ${local.values.groups.helios_groups.vcn_admins.name} as ${local.values.groups.helios_groups.vcn_admins.id}",
    "define tenancy heliosTenancy as ${local.values.compartments.root_helios}",

    # Allow
    "Allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
    "Allow group ${local.values.groups.helios_groups.vcn_admins.name} to manage virtual-network-family in tenancy",
    # Endorse
    "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy heliosTenancy",
    # Admit
    "admit group ${local.values.groups.helios_groups.vcn_admins.name} of tenancy heliosTenancy to manage drg in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
