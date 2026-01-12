# Route Tables
resource "oci_core_route_table" "private_db" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "route-table-private-db"

  # Route to the NAT gateway
  route_rules {

    network_entity_id = oci_core_nat_gateway.database.id

    description      = "Route to the NAT Gateway (Outbound Internet Access)"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  # Route to the DRG gateway for OCI Helios connection
  route_rules {

    network_entity_id = oci_core_drg.database.id

    description      = "Route to the Helios Web tenant's VCN (VCN Peering to HELIOS Account)"
    destination      = local.networking.cidr.subnets.private_web_helios
    destination_type = "CIDR_BLOCK"
  }

  # Route to the DRG gateway for OCI Poseidon connection
  route_rules {

    network_entity_id = oci_core_drg.database.id

    description      = "Route to the Poseidon K8 tenant's VCN (VCN Peering to POSEIDON Account)"
    destination      = local.networking.cidr.subnets.private_k8_poseidon
    destination_type = "CIDR_BLOCK"
  }

  # # Route to the DRG gateway for OCI ZEUS connection
  # route_rules {

  #   network_entity_id = oci_core_drg.database.id

  #   description      = "Route to the Zeus K8 tenant's VCN (VCN Peering to ZEUS Account)"
  #   destination      = local.networking.cidr.subnets.private_k8_zeus
  #   destination_type = "CIDR_BLOCK"
  # }

  # Route to ZEUS via LPG (same region) - REPLACE the existing DRG rule for Zeus
  route_rules {
    network_entity_id = oci_core_local_peering_gateway.to_zeus_prod.id # Use LPG, not DRG

    description      = "Route to the Zeus K8 tenant's VCN (Local VCN Peering to ZEUS Account)"
    destination      = local.networking.cidr.subnets.private_k8_zeus
    destination_type = "CIDR_BLOCK"
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_route_table" "private_mgmt" {
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "route-table-private-mgmt"

  freeform_tags = local.tags.defaults
}


# Route Table Attachments
resource "oci_core_route_table_attachment" "private_mgmt" {
  subnet_id      = oci_core_subnet.private_mgmt.id
  route_table_id = oci_core_route_table.private_mgmt.id
}

resource "oci_core_route_table_attachment" "private_db" {
  subnet_id      = oci_core_subnet.private_db.id
  route_table_id = oci_core_route_table.private_db.id
}
