provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Application = var.application_name
      Environment = "production"
      ManagedBy   = "Terraform"
    }
  }
}
