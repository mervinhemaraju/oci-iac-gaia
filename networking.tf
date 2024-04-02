# Create a virtual cloud network for OCI
resource "oci_core_vcn" "web" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID

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
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name               = "public-web"
  dns_label                  = "publicweb"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public_web.id
  security_list_ids          = [oci_core_vcn.web.default_security_list_id, oci_core_security_list.public_web.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web,
    oci_core_security_list.public_web
  ]
}

# Create two private subnets
resource "oci_core_subnet" "private_web_01" {

  cidr_block     = local.networking.cidr.subnets.private_web_01
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name               = "private-web-01"
  dns_label                  = "privateweb01"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.private_web_01.id
  security_list_ids          = [oci_core_vcn.web.default_security_list_id, oci_core_security_list.private_web.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web,
    oci_core_security_list.private_web
  ]
}

resource "oci_core_subnet" "private_web_02" {

  cidr_block     = local.networking.cidr.subnets.private_web_02
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.web.id

  display_name               = "private-web-02"
  dns_label                  = "privateweb02"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.private_web_02.id
  security_list_ids          = [oci_core_vcn.web.default_security_list_id, oci_core_security_list.private_web.id]

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_core_vcn.web,
    oci_core_security_list.private_web
  ]
}
