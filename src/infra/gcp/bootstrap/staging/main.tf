module "terraform_state" {
  source = "../../modules/terraform_state"

  bucket_name = var.state_bucket_name
  labels = {
    application = var.application_name
    environment = var.environment
    managed-by  = "terraform"
    purpose     = "terraform-state"
  }
  location = upper(var.region)
}
