variable "bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
}

variable "common_tags" {
  description = "Tags applied to state resources"
  type        = map(string)
  default     = {}
}
