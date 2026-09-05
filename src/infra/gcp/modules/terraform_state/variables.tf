variable "bucket_name" {
  description = "Globally unique GCS bucket name for Terraform state"
  type        = string
}

variable "labels" {
  description = "Labels applied to the state bucket"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "GCS location for Terraform state"
  type        = string
  default     = "ASIA-NORTHEAST1"
}
