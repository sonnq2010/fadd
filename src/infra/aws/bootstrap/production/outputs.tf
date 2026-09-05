output "state_bucket_name" {
  description = "S3 bucket used for Terraform state"
  value       = module.terraform_state.bucket_name
}
