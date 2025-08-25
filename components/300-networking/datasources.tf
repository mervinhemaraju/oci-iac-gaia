# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

# Get ths private ips for web computes
# data "oci_core_private_ips" "web_01" {
#   ip_address = local.networking.ip_address.web_01
#   subnet_id  = oci_core_subnet.public_web.id

#   depends_on = [
#     oci_core_subnet.public_web
#   ]
# }

# data "oci_core_private_ips" "web_02" {
#   ip_address = local.networking.ip_address.web_02
#   subnet_id  = oci_core_subnet.public_web.id

#   depends_on = [
#     oci_core_subnet.public_web
#   ]
# }
