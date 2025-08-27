# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = "cloud-oci-creds"
}

# Define our data source to fetch secrets
data "doppler_secrets" "apps_creds" {
  project = "apps-creds"
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

data "oci_core_vcns" "database" {
  compartment_id = local.values.compartments.production
  display_name   = "database"
}

data "oci_core_subnets" "private_database" {
  compartment_id = local.values.compartments.production
  display_name   = "private-db"
  vcn_id         = data.oci_core_vcns.database.virtual_networks[0].id
}

data "oci_core_subnets" "private_mgmt" {
  compartment_id = local.values.compartments.production
  display_name   = "private-mgmt"
  vcn_id         = data.oci_core_vcns.database.virtual_networks[0].id
}
