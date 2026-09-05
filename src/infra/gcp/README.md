# GCP Terraform template

Default region: `asia-northeast1`. Use separate GCP projects for staging and production.

## 1. Bootstrap state

```sh
cd src/infra/gcp/bootstrap/staging
cp terraform.tfvars.example terraform.tfvars
terraform init -backend=false
terraform apply
cp backend.hcl.example backend.hcl
terraform init -migrate-state -backend-config=backend.hcl
```

Repeat in `bootstrap/production` while authenticated to the production project.

## 2. Create platform foundations

```sh
cd ../../environments/staging
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl

read -rsp 'Application database password: ' DATABASE_PASSWORD
printf '\n'
export DATABASE_PASSWORD
export TF_VAR_database_user_password="$DATABASE_PASSWORD"
export TF_VAR_database_credential_version=1

terraform apply -var='enable_workloads=false'
```

Use a password manager or another secured input source. Never put the password in HCL, `.tfvars`, command arguments, or Terraform outputs. Terraform passes the ephemeral value to Cloud SQL through the provider's write-only password field, so the password is not stored in state.

This creates networking, Cloud SQL, a dedicated application user, buckets, registries, a password-only Secret Manager container, and the frontend load balancer. The ephemeral password must be supplied for every applicable plan or apply.

Add the matching password as Secret Manager version 1 without placing it in command history:

```sh
printf '%s' "$DATABASE_PASSWORD" | gcloud secrets versions add \
  "$(terraform output -raw database_password_secret_id | awk -F/ '{print $NF}')" \
  --data-file=-
```

## 3. Publish images and enable workloads

```sh
# From src/backend; replace repository URLs with Terraform outputs.
IMAGE_TAG="$(git rev-parse --verify HEAD)"

docker build --target api -t "$API_REPOSITORY/api:$IMAGE_TAG" .
docker build --target migrations -t "$MIGRATION_REPOSITORY/migration:$IMAGE_TAG" .
# Authenticate with Artifact Registry, push both unique tags, and resolve each pushed sha256 digest.
```

Set digest-pinned image URIs in the ignored `terraform.tfvars`, set `enable_workloads = true`, and apply again while `TF_VAR_database_user_password` and `TF_VAR_database_credential_version` are available. API and migration revisions receive the same six `POSTGRES_*` values and pin `POSTGRES_PASSWORD` to the numeric secret version. Production safety checks reject mutable tags.

```sh
terraform apply
unset DATABASE_PASSWORD TF_VAR_database_user_password TF_VAR_database_credential_version
```

## 4. Rotate the database credential

A single PostgreSQL user cannot keep its old and new passwords valid simultaneously. Rotation therefore uses a maintenance window rather than claiming zero downtime:

1. Start the maintenance window.
2. Generate a new password and add it as a new password-secret version:

   ```sh
   read -rsp 'New application database password: ' DATABASE_PASSWORD
   printf '\n'
   export DATABASE_PASSWORD
   SECRET_VERSION="$(printf '%s' "$DATABASE_PASSWORD" | gcloud secrets versions add \
     "$(terraform output -raw database_password_secret_id | awk -F/ '{print $NF}')" \
     --data-file=- --format='value(name)')"
   export TF_VAR_database_user_password="$DATABASE_PASSWORD"
   export TF_VAR_database_credential_version="${SECRET_VERSION##*/}"
   ```

3. Apply Terraform. The Cloud SQL password update and both Cloud Run templates use the same credential version.
4. Wait until the new API revision is ready and receives all traffic. Verify a database-backed request.
5. Confirm the migration job template uses the same version, then end the maintenance window.
6. Unset the password variables.

Existing revisions stay pinned to their original secret version, so one revision never mixes old and new passwords. Temporary authentication failures can still occur while the single database user's password and the new revision are being applied; the maintenance window is intentional.

## 5. Run migrations

```sh
gcloud run jobs execute "$(terraform output -raw migration_job_name)" \
  --region asia-northeast1 \
  --wait
```

Terraform defines but never executes this job.

## 6. Upload web assets

```sh
cd src/webapp
VITE_API_BASE_URL= npm run build
gcloud storage rsync --recursive --delete-unmatched-destination \
  .output/public "gs://$(terraform -chdir=../infra/gcp/environments/staging output -raw static_web_bucket)"
```

Set long immutable cache headers on hashed assets and `no-cache` on `_shell.html`. The URL map serves `_shell.html` when an application route is not a stored object.

HTTP access by frontend IP is available only for staging. Production requires `domain_name`, redirects port 80 to HTTPS, and creates a Google-managed certificate. Point the domain's DNS record to `frontend_ip` and wait until the managed certificate is active before considering production traffic ready.

## 7. Verify and roll back

```sh
curl "$(terraform output -raw application_endpoint)/api/v1/health"
```

Roll back application code by applying the prior API image digest. After a password rotation, routing to an old revision does not restore the old database password; publish a new matching password version and apply another incremented credential version instead. Database migrations remain an explicit compatibility decision.

State-bucket destruction is a break-glass manual operation because the module has `prevent_destroy`.
