module "terraform_state" {
  source = "../../modules/terraform_state"

  bucket_name = var.state_bucket_name
  common_tags = {
    Application = var.application_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "TerraformState"
  }
}

check "account_identity" {
  assert {
    condition     = data.aws_caller_identity.current.account_id == var.expected_account_id
    error_message = "Authenticated AWS account does not match expected_account_id."
  }
}
