# Creates a minimal spend budget
resource "oci_budget_budget" "minimal_spend" {
  compartment_id = local.values.compartments.root
  amount         = 10
  reset_period   = "MONTHLY"

  description  = "A minimal spend budget for OCI GAIA"
  display_name = "budget-minimal-spend"
  target_type  = "COMPARTMENT"
  targets = [
    local.values.compartments.production
  ]
}
