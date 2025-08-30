resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "private-mgmt-sl"

  ingress_security_rules {
    # Allows SSH traffic from the internet

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allows SSH traffic from the internet."
  }

  egress_security_rules {

    destination      = local.networking.cidr.subnets.private_db
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allows all outbound traffic to the private-db subnet."

  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "private_db" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "private-db-sl"


  # Allows all traffic from the private mgmt subnet
  ingress_security_rules {
    source      = local.networking.cidr.subnets.private_mgmt
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the private-mgmt subnet."
  }

  # Allows all traffic from the private web HELIOS subnet
  ingress_security_rules {
    source      = local.networking.cidr.subnets.private_web_helios
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the private-web HELIOS subnet."
  }

  # Allows all traffic from the private k8 POSEIDON subnet
  ingress_security_rules {
    source      = local.networking.cidr.subnets.private_k8_poseidon
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the private-k8 POSEIDON subnet."
  }

  # Allows all traffic on egress
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."
  }

  freeform_tags = local.tags.defaults
}
