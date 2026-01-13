
# Create a policy for DRG management as a requestor
resource "oci_identity_policy" "zeus_cross_conection_statements" {

  compartment_id = local.values.compartments.root
  name           = "zeus-cross-connection-statements"
  description    = "Allow the requestor to manage DRG and RPC in this tenancy and account ZEUS tenancy."

  statements = [
    # # Definitions
    # "define group ${oci_identity_group.drg_admins.name} as ${oci_identity_group.drg_admins.id}",
    # "define group ${local.values.groups.zeus_groups.vcn_admins.name} as ${local.values.groups.zeus_groups.vcn_admins.id}",
    # "define tenancy zeusTenancy as ${local.values.compartments.root_zeus}",

    # # Allow
    # "Allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
    # "Allow group ${local.values.groups.zeus_groups.vcn_admins.name} to manage virtual-network-family in tenancy",
    # "allow group ${oci_identity_group.drg_admins.name} to manage local-peering-gateways in tenancy",

    # # Endorse
    # "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy zeusTenancy",

    # # Admit
    # "admit group ${local.values.groups.zeus_groups.vcn_admins.name} of tenancy zeusTenancy to manage drg in tenancy",
    # "admit group ${local.values.groups.zeus_groups.vcn_admins.name} of tenancy zeusTenancy to manage local-peering-from in tenancy",
    # "admit group ${local.values.groups.zeus_groups.vcn_admins.name} of tenancy zeusTenancy to manage virtual-network-family in tenancy",

    # # Explicitly add associate permission for clarity
    # "admit group ${local.values.groups.zeus_groups.vcn_admins.name} of tenancy zeusTenancy to associate local-peering-gateways in tenancy",

    # Definitions
    "define group ZeusVcnAdmins as ${local.values.groups.zeus_groups.vcn_admins.id}",
    "define tenancy zeusTenancy as ${local.values.compartments.root_zeus}",

    # 1. Allow (Local Gaia admins managing Gaia resources)
    "allow group ${oci_identity_group.drg_admins.name} to manage virtual-network-family in tenancy",
    "allow group ${oci_identity_group.drg_admins.name} to manage local-peering-gateways in tenancy",

    # 2. Endorse (Local Gaia admins going to Zeus)
    "endorse group ${oci_identity_group.drg_admins.name} to manage drg-attachment in tenancy zeusTenancy",

    # 3. Admit (Remote Zeus admins coming into Gaia)
    # CHANGE: Replaced 'associate' with 'manage'
    "admit group ZeusVcnAdmins of tenancy zeusTenancy to manage virtual-network-family in tenancy",
    "admit group ZeusVcnAdmins of tenancy zeusTenancy to manage local-peering-from in tenancy",
    "admit group ZeusVcnAdmins of tenancy zeusTenancy to manage drg in tenancy"

  ]

  freeform_tags = local.tags.defaults
}
