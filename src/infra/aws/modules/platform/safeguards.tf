check "account_identity" {
  assert {
    condition     = data.aws_caller_identity.current.account_id == var.expected_account_id
    error_message = "Authenticated AWS account does not match expected_account_id."
  }
}

check "production_safety" {
  assert {
    condition = var.environment != "production" || (
      var.database_multi_az &&
      var.database_deletion_protection &&
      var.backup_retention_days >= 7 &&
      var.api_desired_count >= 2 &&
      var.storage_versioning &&
      !var.force_destroy_buckets &&
      (!var.enable_workloads || (can(regex("@sha256:[0-9a-f]{64}$", var.api_image)) && can(regex("@sha256:[0-9a-f]{64}$", var.migration_image))))
    )
    error_message = "Production requires Multi-AZ/deletion-protected RDS, at least 7 backup days, two API tasks, versioned protected buckets, and digest-pinned workload images."
  }
}

check "cloudfront_certificate" {
  assert {
    condition     = (var.domain_name == null) == (var.cloudfront_certificate_arn == null)
    error_message = "domain_name and cloudfront_certificate_arn must be provided together."
  }
}
