provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Application = var.application_name
      Environment = "staging"
      ManagedBy   = "Terraform"
    }
  }
}
