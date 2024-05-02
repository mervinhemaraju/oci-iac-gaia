
# Create a policy for VCN management as a acceptor
resource "oci_identity_policy" "acceptor_vcn_management" {

  compartment_id = local.values.compartments.root
  description    = "Allow the acceptor to manage VCN and DRG attachments in this tenancy"
  name           = "acceptor-vcn-management"
  statements = [
    "define group ${oci_identity_group.vcn_admins.name} as ${oci_identity_group.vcn_admins.id}",
    "Allow group ${oci_identity_group.vcn_admins.name} to manage virtual-network-family in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
