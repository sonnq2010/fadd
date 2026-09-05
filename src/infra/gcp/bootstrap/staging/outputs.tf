output "state_bucket_name" {
  description = "GCS bucket used for Terraform state"
  value       = module.terraform_state.bucket_name
}
