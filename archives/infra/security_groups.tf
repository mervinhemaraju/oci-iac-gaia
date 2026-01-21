resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "private-mgmt-sl"

  egress_security_rules {

    destination      = local.networking.cidr.vcn.web
    destination_type = "CIDR_BLOCK"
    protocol         = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic to the web vcn CIDR."

  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic from the Internet to the private mgmt subnet."
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "public_web" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "public-web-sl"

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  ingress_security_rules {

    source      = local.networking.cidr.vcn.web
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the web vcn's cidr block."
  }

  # ingress_security_rules {

  #   source      = local.networking.cidr.vcn.database
  #   source_type = "CIDR_BLOCK"
  #   protocol    = "all"

  #   description = "Allow all traffic for the database vcn's cidr block."
  # }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 #* TCP protocol code

    description = "Allow Inbound HTTP Traffic from the Internet"

    tcp_options {
      max = 80
      min = 80
    }
  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 #* TCP protocol code

    description = "Allow Inbound HTTPS Traffic from the Internet"

    tcp_options {
      max = 443
      min = 443
    }
  }

  freeform_tags = local.tags.defaults
}
