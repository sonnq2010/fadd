mock_provider "aws" {
  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
      arn        = "arn:aws:iam::123456789012:user/test"
      user_id    = "test"
    }
  }

  mock_data "aws_availability_zones" {
    defaults = {
      names = ["ap-northeast-1a", "ap-northeast-1c"]
    }
  }


  mock_data "aws_ec2_managed_prefix_list" {
    defaults = {
      id   = "pl-cloudfront"
      name = "com.amazonaws.global.cloudfront.origin-facing"
    }
  }

  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
    }
  }
}

mock_provider "random" {}

run "staging_is_cost_optimized" {
  command = plan

  variables {
    assign_public_ip             = true
    api_desired_count            = 1
    backup_retention_days        = 1
    database_deletion_protection = false
    database_instance_class      = "db.t4g.micro"
    database_multi_az            = false
    database_user_password       = "test-only-password"
    enable_nat_gateway           = false
    enable_workloads             = false
    environment                  = "staging"
    expected_account_id          = "123456789012"
    log_retention_days           = 14
    storage_versioning           = false
  }

  assert {
    condition     = aws_db_instance.main.multi_az == false
    error_message = "Staging database must remain single-AZ by default."
  }

  assert {
    condition     = length(aws_nat_gateway.main) == 0
    error_message = "Staging must not create NAT Gateways by default."
  }

  assert {
    condition     = aws_db_instance.main.publicly_accessible == false
    error_message = "The database must never be public."
  }
}

run "production_has_ha_and_protection" {
  command = plan

  variables {
    assign_public_ip             = false
    api_desired_count            = 2
    api_image                    = "example.com/api@sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    backup_retention_days        = 14
    database_deletion_protection = true
    database_instance_class      = "db.t4g.small"
    database_multi_az            = true
    database_user_password       = "test-only-password"
    enable_nat_gateway           = true
    enable_workloads             = true
    environment                  = "production"
    expected_account_id          = "123456789012"
    log_retention_days           = 90
    migration_image              = "example.com/migration@sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    storage_versioning           = true
  }

  assert {
    condition     = aws_db_instance.main.multi_az && aws_db_instance.main.deletion_protection
    error_message = "Production database must be Multi-AZ and deletion protected."
  }

  assert {
    condition     = length(aws_nat_gateway.main) == 2
    error_message = "Production creates one NAT Gateway per application AZ."
  }

  assert {
    condition     = aws_ecs_service.api[0].desired_count == 2
    error_message = "Production must start with at least two API tasks."
  }

  assert {
    condition = toset(concat(
      [for item in local.postgres_environment : item.name],
      [for item in local.postgres_secrets : item.name]
    )) == toset(["POSTGRES_USER", "POSTGRES_PASSWORD", "POSTGRES_DB", "POSTGRES_HOST", "POSTGRES_PORT", "POSTGRES_SSLMODE"])
    error_message = "AWS workloads must use the complete POSTGRES_* contract."
  }

  assert {
    condition     = aws_cloudfront_distribution.main.default_root_object == "_shell.html"
    error_message = "CloudFront must serve the generated SPA shell."
  }

  assert {
    condition     = length([for association in aws_cloudfront_distribution.main.default_cache_behavior[0].function_association : association if association.event_type == "viewer-request"]) == 1
    error_message = "Static requests must use the SPA rewrite function without rewriting API errors."
  }
}

run "unsafe_production_is_rejected" {
  command = plan

  variables {
    assign_public_ip             = false
    api_desired_count            = 1
    backup_retention_days        = 1
    database_deletion_protection = false
    database_instance_class      = "db.t4g.micro"
    database_multi_az            = false
    database_user_password       = "test-only-password"
    enable_nat_gateway           = true
    enable_workloads             = false
    environment                  = "production"
    expected_account_id          = "123456789012"
    force_destroy_buckets        = true
    log_retention_days           = 14
    storage_versioning           = false
  }

  expect_failures = [check.production_safety]
}
