resource "oci_identity_policy" "buckets_administrators" {

  compartment_id = local.values.compartments.root
  description    = "Allow the Administrators to manage buckets in this tenancy"
  name           = "buckets-administrators"
  statements = [
    "Allow group ${local.values.groups.administrators} to manage buckets in tenancy"
  ]

  freeform_tags = local.tags.defaults
}
