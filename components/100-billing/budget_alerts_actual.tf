# Create budget alerts for actual spend
resource "oci_budget_alert_rule" "actual_minimum" {
  budget_id      = oci_budget_budget.minimal_spend.id
  threshold      = 3
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "actual-minimum-threshold"
  message      = <<EOF
  Minimum actual alert for the minimal spend budget has been trigerred. 
  You have already spent 3 USD in the OCI GAIA Account.
  Please take action ASAP if this was not intended.
  EOF
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.minimal_spend
  ]
}

resource "oci_budget_alert_rule" "actual_critical" {
  budget_id      = oci_budget_budget.minimal_spend.id
  threshold      = 10
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "actual-critical-threshold"
  message      = <<EOF
  Critical actual alert for the minimal spend budget has been trigerred. 
  You have already spent all of the 10 USD in the OCI GAIA Account.
  Please take action ASAP if this was not intended.
  EOF
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.minimal_spend
  ]
}
