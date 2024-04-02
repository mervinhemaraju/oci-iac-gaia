# Creates a zero spend budget
resource "oci_budget_budget" "oci_zero_spend_budget" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_ROOT_ID
  amount         = 1
  reset_period   = "MONTHLY"

  description  = "A zero spend budget for OCI"
  display_name = "zero-spend-budget"
  target_type  = "COMPARTMENT"
  targets = [
    data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  ]

  freeform_tags = local.tags.defaults
}

resource "oci_budget_alert_rule" "oci_zsb_rule" {
  budget_id      = oci_budget_budget.oci_zero_spend_budget.id
  threshold      = 0.1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "0-strict-threshold"
  message      = "The zero spend budget has been breached on OCI."
  recipients   = "mervinhemaraju16@gmail.com"

  freeform_tags = local.tags.defaults

  depends_on = [
    oci_budget_budget.oci_zero_spend_budget
  ]
}
