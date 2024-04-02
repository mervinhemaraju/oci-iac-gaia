# Route Tables

resource "oci_core_route_table" "public_web" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name = "route-table-public-web"

  route_rules {

    network_entity_id = oci_core_internet_gateway.prod.id

    description      = "Route to the Internet Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.web_02.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to web-02"
      destination      = local.networking.cidr.subnets.private_web_02
      destination_type = "CIDR_BLOCK"
    }
  }

  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.web_01.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to web-01"
      destination      = local.networking.cidr.subnets.private_web_01
      destination_type = "CIDR_BLOCK"
    }
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_web_01" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name = "route-table-private-web-01"
  route_rules {

    network_entity_id = oci_core_nat_gateway.prod.id

    description      = "Route to the NAT Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.web_02.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to web-02"
      destination      = local.networking.cidr.subnets.private_web_02
      destination_type = "CIDR_BLOCK"
    }
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_web_02" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name = "route-table-private-web-02"
  route_rules {

    network_entity_id = oci_core_nat_gateway.prod.id

    description      = "Route to the NAT Gateway (Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  dynamic "route_rules" {
    for_each = data.oci_core_private_ips.web_01.private_ips
    content {

      network_entity_id = route_rules.value["id"]

      description      = "Route to web-01"
      destination      = local.networking.cidr.subnets.private_web_01
      destination_type = "CIDR_BLOCK"
    }
  }

  freeform_tags = local.tags.defaults
}


# Route Table Attachments
# resource "oci_core_route_table_attachment" "public_web" {
#   subnet_id      = oci_core_subnet.public_web.id
#   route_table_id = oci_core_route_table.public_web.id
# }

# resource "oci_core_route_table_attachment" "private_web_01" {
#   subnet_id      = oci_core_subnet.private_web_01.id
#   route_table_id = oci_core_route_table.private_web_01.id
# }

# resource "oci_core_route_table_attachment" "private_web_02" {
#   subnet_id      = oci_core_subnet.private_web_02.id
#   route_table_id = oci_core_route_table.private_web_02.id
# }
