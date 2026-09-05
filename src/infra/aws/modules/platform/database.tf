resource "aws_db_subnet_group" "main" {
  name       = local.name
  subnet_ids = values(aws_subnet.database)[*].id
  tags       = merge(local.tags, { Name = "${local.name}-database" })
}

resource "aws_db_instance" "main" {
  identifier = local.name

  allocated_storage         = var.database_storage_gib
  backup_retention_period   = var.backup_retention_days
  db_name                   = var.database_name
  db_subnet_group_name      = aws_db_subnet_group.main.name
  deletion_protection       = var.database_deletion_protection
  engine                    = "postgres"
  engine_version            = "17"
  final_snapshot_identifier = var.database_deletion_protection ? "${local.name}-final" : null
  instance_class            = var.database_instance_class
  multi_az                  = var.database_multi_az
  password_wo               = var.database_user_password
  password_wo_version       = var.database_credential_version
  publicly_accessible       = false
  skip_final_snapshot       = !var.database_deletion_protection
  storage_encrypted         = true
  storage_type              = "gp3"
  username                  = var.database_username
  vpc_security_group_ids    = [aws_security_group.database.id]

  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true

  tags = merge(local.tags, { Name = local.name })
}

resource "aws_secretsmanager_secret" "database_password" {
  name                    = "${local.name}/database-password"
  recovery_window_in_days = var.environment == "production" ? 30 : 7
  tags                    = local.tags
}
