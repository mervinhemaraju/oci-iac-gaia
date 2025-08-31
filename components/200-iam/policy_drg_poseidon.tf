
# Create a policy for DRG management as a requestor
resource "oci_identity_policy" "poseidon_cross_conection_statements" {

  compartment_id = local.values.compartments.root
  name           = "poseidon-cross-connection-statements"
  description    = "Allow the requestor to manage DRG and RPC in this tenancy and account POSEIDON tenancy."

  statements = [
    # Definitions
    "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
    "define group ${local.values.groups.poseidon_groups.vcn_admins.name} as ${local.values.groups.poseidon_groups.vcn_admins.id}",
    "define tenancy poseidonTenancy as ${local.values.compartments.root_poseidon}",

    # Allow
    "Allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
    "Allow group ${local.values.groups.poseidon_groups.vcn_admins.name} to manage virtual-network-family in tenancy",
    "Allow group ${oci_identity_group.drg_admins.name} to manage remote-peering-from in tenancy",
    "Allow group ${oci_identity_group.drg_admins.name} to manage drgs in tenancy",
    # Endorse
    "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy poseidonTenancy",
    "Endorse group ${oci_identity_group.drg_admins.name} to manage remote-peering-to in tenancy poseidonTenancy",
    # Admit
    "admit group ${local.values.groups.poseidon_groups.vcn_admins.name} of tenancy poseidonTenancy to manage drg in tenancy",
  ]

  freeform_tags = local.tags.defaults
}
