# Create a reserved public IP for the nat gateway
resource "oci_core_public_ip" "prod_nat" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  lifetime       = "RESERVED"

  display_name = "res-prod-nat"

  freeform_tags = local.tags.defaults
}

# Create a reserved public IP for the web network load balancer
# resource "oci_core_public_ip" "web_nlb" {
#   compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
#   lifetime       = "RESERVED"

#   display_name = "res-web-nlb"

#   freeform_tags = local.tags.defaults
# }
