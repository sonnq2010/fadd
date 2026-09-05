# AWS Terraform template

Default region: `ap-northeast-1`. Use separate AWS accounts for staging and production.

## 1. Bootstrap state

```sh
cd src/infra/aws/bootstrap/staging
cp terraform.tfvars.example terraform.tfvars
terraform init -backend=false
terraform apply
cp backend.hcl.example backend.hcl
terraform init -migrate-state -backend-config=backend.hcl
```

Repeat in `bootstrap/production` while authenticated to the production account. Verify the account ID before every apply.

## 2. Create platform foundations

```sh
cd ../../environments/staging
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl

read -rsp 'Database password: ' DATABASE_PASSWORD
printf '\n'
export DATABASE_PASSWORD
export TF_VAR_database_user_password="$DATABASE_PASSWORD"
export TF_VAR_database_credential_version=1

terraform apply -var='enable_workloads=false'
```

Use a password manager or another secured input source. Never put the password in HCL, `.tfvars`, command literals, or Terraform outputs. Terraform passes it to RDS through the provider's ephemeral write-only field, so the password is not stored in state.

This creates networking, RDS, buckets, registries, edge resources, and a password-only Secrets Manager container. Add the same password to the secret before creating workloads:

```sh
aws secretsmanager put-secret-value \
  --secret-id "$(terraform output -raw database_password_secret_arn)" \
  --secret-string "$DATABASE_PASSWORD"
```

API and migration tasks read only `POSTGRES_PASSWORD` from Secrets Manager. Terraform supplies the other `POSTGRES_*` values directly from RDS configuration.

## 3. Publish images and enable workloads

```sh
# From src/backend; replace repository URLs with Terraform outputs.
IMAGE_TAG="$(git rev-parse --verify HEAD)"

docker build --target api -t "$API_REPOSITORY:$IMAGE_TAG" .
docker build --target migrations -t "$MIGRATION_REPOSITORY:$IMAGE_TAG" .
# Authenticate with ECR, push both unique tags, and resolve each pushed sha256 digest.
```

Set digest-pinned image URIs in the ignored `terraform.tfvars`, set `enable_workloads = true`, and apply again while `TF_VAR_database_user_password` and `TF_VAR_database_credential_version` are available. Production safety checks reject mutable tags.

```sh
terraform apply
unset DATABASE_PASSWORD TF_VAR_database_user_password TF_VAR_database_credential_version
```

## 4. Run migrations

Use `migration_task_definition_arn`, `task_subnet_ids`, and `task_security_group_id` from the module/root outputs with `aws ecs run-task`. Wait for the task to finish successfully before shifting application traffic. Terraform never runs this task.

## 5. Rotate the database credential

Rotation uses a maintenance window because running ECS tasks retain the password injected when they started:

1. Start the maintenance window.
2. Generate a new password and publish it as the current secret value.
3. Apply Terraform with that same ephemeral password and an incremented `database_credential_version`.
4. Force replacement API tasks:

   ```sh
   aws ecs update-service \
     --cluster "$(terraform output -raw ecs_cluster_name)" \
     --service "$(terraform output -raw api_service_name)" \
     --force-new-deployment
   ```

5. Wait until the ECS service is stable and verify a database-backed request.
6. Start migration tasks only after rotation; newly started tasks read the current secret.
7. End the maintenance window and unset the password variables.

The version number is a non-secret change token shared by the RDS write-only password update and the operational secret version. This baseline intentionally uses the RDS master identity and maintenance-window rotation. Add a dedicated application user or automated rotation only when required.

## 6. Upload web assets

```sh
cd src/webapp
VITE_API_BASE_URL= npm run build
aws s3 sync .output/public "s3://$(terraform -chdir=../infra/aws/environments/staging output -raw static_web_bucket)" --delete
```

Apply long immutable cache headers to hashed assets and `no-cache` to `_shell.html`, then invalidate CloudFront when the shell changes.

## 7. Verify and roll back

```sh
curl "$(terraform output -raw application_endpoint)/api/v1/health"
```

Roll back application code by applying the prior API image digest. After a password rotation, restoring an old ECS task revision does not restore the old database password; publish a new matching secret value and apply another incremented credential version. Database migrations require an explicit compatible rollback decision.

For a custom frontend domain, provide an ACM certificate from `us-east-1` through `cloudfront_certificate_arn`; the template does not own Route 53 zones.

State-bucket destruction is a break-glass manual operation because the module has `prevent_destroy`.
