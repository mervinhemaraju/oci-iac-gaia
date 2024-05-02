# Create a virtual cloud network for OCI
resource "oci_core_vcn" "web" {

  compartment_id = local.values.compartments.production

  cidr_blocks = [
    local.networking.cidr.vcn.web
  ]

  display_name   = "web"
  dns_label      = "web"
  is_ipv6enabled = false

  freeform_tags = local.tags.defaults
}

# Create a public web subnet
resource "oci_core_subnet" "public_web" {

  cidr_block     = local.networking.cidr.subnets.public_web
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name               = "public-web"
  dns_label                  = "publicweb"
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.public_web.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web,
    oci_core_security_list.public_web
  ]
}

# Create a private subnet
resource "oci_core_subnet" "private_mgmt" {

  cidr_block     = local.networking.cidr.subnets.private_mgmt
  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name               = "private-mgmt"
  dns_label                  = "privatemgmt"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private_mgmt.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web,
    oci_core_security_list.private_mgmt
  ]
}
