
# Create a public and private key for aikido security
resource "tls_private_key" "aikido_security" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a new user
resource "oci_identity_user" "aikido_security" {

  compartment_id = local.values.compartments.root
  name           = "aikido-security"
  email          = "mervinhemaraju16@gmail.com"
  description    = "Aikido Security user."

  freeform_tags = local.tags.defaults
}

# Create a new api key for aikido security
resource "oci_identity_api_key" "aikido_security_key" {
  user_id   = oci_identity_user.aikido_security.id
  key_value = tls_private_key.aikido_security.public_key_pem
}

# Creates a new user group for aikido security
resource "oci_identity_group" "aikido_security" {

  compartment_id = local.values.compartments.root
  name           = "aikido-security"
  description    = "Aikido Security group."

  freeform_tags = local.tags.defaults
}

# Creates a user group membership
resource "oci_identity_user_group_membership" "aikido_security" {
  group_id = oci_identity_group.aikido_security.id
  user_id  = oci_identity_user.aikido_security.id
}

# Create a policy for aikido-security
resource "oci_identity_policy" "aikido_security_policy" {

  compartment_id = local.values.compartments.root
  name           = "aikido-security-policy"
  description    = "Allows aikido-security to view resources in this tenancy."

  statements = [
    # Allow
    "allow group ${oci_identity_group.aikido_security.name} to inspect all-resources in tenancy",
    "allow group ${oci_identity_group.aikido_security.name} to read all-resources in tenancy",
    "allow group ${oci_identity_group.aikido_security.name} to read audit-events in tenancy"
  ]

  freeform_tags = local.tags.defaults
}

# Create the vault
resource "oci_kms_vault" "aikido_security" {
  compartment_id = local.values.compartments.production
  display_name   = "aikido-security-vault"
  vault_type     = "DEFAULT"

  freeform_tags = local.tags.defaults
}

# Create Master Encryption Key in the Vault
resource "oci_kms_key" "aikido_security" {
  compartment_id = local.values.compartments.production
  display_name   = "aikido-security-key"

  key_shape {
    algorithm = "AES"
    length    = 32
  }

  management_endpoint = oci_kms_vault.aikido_security.management_endpoint

  freeform_tags = local.tags.defaults
}

# Create one secret for each entry
resource "oci_vault_secret" "aikido_security_secrets" {

  for_each = {
    "aikido-security-private-key"         = base64encode(tls_private_key.aikido_security.private_key_pem),
    "aikido-security-public-key"          = base64encode(tls_private_key.aikido_security.public_key_pem),
    "aikido-security-api-key"             = base64encode(tls_private_key.aikido_security.public_key_pem),
    "aikido-security-api-key-fingerprint" = base64encode(oci_identity_api_key.aikido_security_key.fingerprint),
  }

  compartment_id = local.values.compartments.production
  key_id         = oci_kms_key.aikido_security.id
  vault_id       = oci_kms_vault.aikido_security.id

  secret_name = each.key

  description = "Secret (in BASE64) for '${each.key}' that is managed by Terraform."

  secret_content {
    content_type = "BASE64"
    content      = each.value
  }

  freeform_tags = local.tags.defaults

  # OCI does not return secret content via API, so ignore drift on this attribute
  lifecycle {
    ignore_changes = [secret_content]
  }
}
