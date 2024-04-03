resource "oci_identity_policy" "administrators_load_balancers" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  description    = "Allow Administrators to manage load balancers"
  name           = "allow-administrators-manage-load-balancers"

  statements = [
    "Allow group Administrators to manage load-balancers in tenancy",
    "Allow group Administrators to manage network-load-balancers in tenancy",
    "Allow group Administrators to use load-balancers in tenancy",
    "Allow group Administrators to use network-load-balancers in tenancy",
    "Allow group Administrators to use virtual-network-family in tenancy",
  ]

  freeform_tags = local.tags.defaults
}
