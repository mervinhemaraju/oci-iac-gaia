# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Get the Adminsitrator group
data "oci_identity_groups" "administrators" {
  compartment_id = local.values.compartments.root
  name           = "Administrators"
}

# Get the Administrator group memberships
data "oci_identity_user_group_memberships" "administrators" {
  compartment_id = local.values.compartments.root
  group_id       = data.oci_identity_groups.administrators.groups[0].id
}
