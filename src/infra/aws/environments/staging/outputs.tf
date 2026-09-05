output "api_endpoint" {
  description = "Same-origin API base URL"
  value       = module.platform.api_endpoint
}

output "api_service_name" {
  description = "ECS service running the API"
  value       = module.platform.api_service_name
}

output "application_asset_bucket" {
  description = "Private application asset bucket"
  value       = module.platform.application_asset_bucket
}

output "application_endpoint" {
  description = "Public frontend URL"
  value       = module.platform.application_endpoint
}

output "api_repository_url" {
  description = "API ECR repository URL"
  value       = module.platform.api_repository_url
}


output "migration_repository_url" {
  description = "Migration ECR repository URL"
  value       = module.platform.migration_repository_url
}

output "migration_task_definition_arn" {
  description = "One-off migration task definition ARN"
  value       = module.platform.migration_task_definition_arn
}

output "static_web_bucket" {
  description = "Static web asset bucket"
  value       = module.platform.static_web_bucket
}

output "ecs_cluster_name" {
  description = "ECS cluster for api and migration tasks"
  value       = module.platform.ecs_cluster_name
}

output "task_security_group_id" {
  description = "Security group for one-off migration tasks"
  value       = module.platform.task_security_group_id
}

output "task_subnet_ids" {
  description = "Subnets for one-off migration tasks"
  value       = module.platform.task_subnet_ids
}

output "database_instance_id" {
  description = "RDS database instance identifier"
  value       = module.platform.database_instance_id
}

output "database_password_secret_arn" {
  description = "Secret to populate with POSTGRES_PASSWORD"
  value       = module.platform.database_password_secret_arn
}
