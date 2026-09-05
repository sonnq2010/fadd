check "production_safety" {
  assert {
    condition = var.environment != "production" || (
      try(trimspace(var.domain_name), "") != "" &&
      var.database_availability_type == "REGIONAL" &&
      var.database_deletion_protection &&
      var.database_pitr_enabled &&
      var.backup_retention_count >= 7 &&
      var.api_min_instances >= 2 &&
      var.storage_versioning &&
      !var.force_destroy_buckets &&
      (!var.enable_workloads || (can(regex("@sha256:[0-9a-f]{64}$", var.api_image)) && can(regex("@sha256:[0-9a-f]{64}$", var.migration_image))))
    )
    error_message = "Production requires a custom HTTPS domain, regional/deletion-protected Cloud SQL with PITR, seven backups, two warm API instances, versioned protected buckets, and digest-pinned images."
  }
}
