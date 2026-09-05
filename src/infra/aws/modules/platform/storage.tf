#trivy:ignore:AVD-AWS-0086 Public ACLs are blocked by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0087 Public policies are blocked by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0088 Encryption is configured by aws_s3_bucket_server_side_encryption_configuration.bucket.
#trivy:ignore:AVD-AWS-0091 Public ACLs are ignored by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0093 Public buckets are restricted by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0132 SSE-S3 is the baseline; customer-managed keys are a compliance extension.
resource "aws_s3_bucket" "application" {
  bucket        = "${local.name}-assets-${data.aws_caller_identity.current.account_id}"
  force_destroy = var.force_destroy_buckets
  tags          = merge(local.tags, { Name = "${local.name}-assets" })
}

#trivy:ignore:AVD-AWS-0086 Public ACLs are blocked by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0087 Public policies are blocked by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0088 Encryption is configured by aws_s3_bucket_server_side_encryption_configuration.bucket.
#trivy:ignore:AVD-AWS-0091 Public ACLs are ignored by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0093 Public buckets are restricted by aws_s3_bucket_public_access_block.bucket.
#trivy:ignore:AVD-AWS-0132 SSE-S3 is the baseline; customer-managed keys are a compliance extension.
resource "aws_s3_bucket" "web" {
  bucket        = "${local.name}-web-${data.aws_caller_identity.current.account_id}"
  force_destroy = var.force_destroy_buckets
  tags          = merge(local.tags, { Name = "${local.name}-web" })
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  for_each = {
    application = aws_s3_bucket.application.id
    web         = aws_s3_bucket.web.id
  }

  bucket                  = each.value
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#trivy:ignore:AVD-AWS-0132 SSE-S3 is the baseline; customer-managed keys are a compliance extension.
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  for_each = {
    application = aws_s3_bucket.application.id
    web         = aws_s3_bucket.web.id
  }

  bucket = each.value

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket" {
  for_each = {
    application = aws_s3_bucket.application.id
    web         = aws_s3_bucket.web.id
  }

  bucket = each.value

  versioning_configuration {
    status = var.storage_versioning ? "Enabled" : "Suspended"
  }
}
