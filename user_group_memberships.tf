# Creates a user group membership for the VCN admins group
resource "oci_identity_user_group_membership" "vcn_admins" {
  group_id = oci_identity_group.vcn_admins.id
  user_id  = data.oci_identity_users.main_admin.users[0].id
}
