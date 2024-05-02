# Create a reserved public IP for the nat gateway
resource "oci_core_public_ip" "prod_nat" {
  compartment_id = local.values.compartments.production
  lifetime       = "RESERVED"

  display_name = "res-prod-nat"

  freeform_tags = local.tags.defaults
}

# Create a reserved public IP for the web network load balancer
resource "oci_core_public_ip" "web_nlb" {
  compartment_id = local.values.compartments.production
  lifetime       = "RESERVED"

  display_name = "res-web-nlb"

  freeform_tags = local.tags.defaults

  lifecycle {
    ignore_changes = [
      private_ip_id
    ]
  }
}
