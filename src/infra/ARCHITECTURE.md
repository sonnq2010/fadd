# Infrastructure architecture

FADD provides equivalent AWS and GCP baselines. Staging and production live in separate cloud accounts/projects and use separate state buckets. Terraform workspaces are not used.

## Workload contract

- API: immutable Go container, `PORT=8888`, database configuration through `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`, `POSTGRES_HOST`, `POSTGRES_PORT`, and `POSTGRES_SSLMODE`, health check at `/api/v1/health`.
- Web: static files from `src/webapp/.output/public`; `_shell.html` is the SPA entry and deep-route fallback.
- Database: private managed PostgreSQL.
- Storage: one private application bucket and a separate static-web bucket.
- Migrations: an explicit one-off container task/job, never a Terraform provisioner.
- Mobile: consumes the `api_endpoint` output at build time; no mobile runtime resources are provisioned.

## AWS

```text
Browser / mobile
       |
   CloudFront
   |       |
 static   /api/*
 S3        |
          ALB
           |
      ECS Fargate ---- private application S3
           |
      private RDS PostgreSQL
```

CloudFront is the supported public origin. The ALB accepts only CloudFront origin-facing addresses and requests carrying a generated origin header. Production uses two application AZs, two ECS tasks, Multi-AZ RDS, protected/versioned storage, and digest-pinned images.

## GCP

```text
Browser / mobile
       |
Global HTTP(S) load balancer
   |                 |
Cloud CDN          /api/*
   |                 |
static GCS       Cloud Run ---- private application GCS
                     |
             private Cloud SQL PostgreSQL
```

A URL-map custom error response serves `_shell.html` for static 404 responses. Cloud Run accepts load-balancer/internal ingress and uses direct VPC egress for private Cloud SQL access. Production uses a managed HTTPS domain, regional Cloud SQL with API and Terraform deletion protection, PITR, protected/versioned storage, two warm instances, and digest-pinned images.

## State and secrets

Each environment first applies its `bootstrap/` root locally to create a protected S3/GCS state bucket, then migrates state using `backend.hcl`. Real backend files and `.tfvars` are ignored.

AWS passes the database password through the provider's ephemeral write-only RDS field and stores the matching runtime value in a password-only Secrets Manager secret; ECS receives it when each task starts. GCP creates a password-only Secret Manager container and a dedicated application database user. Operators supply the same password to the provider's ephemeral write-only field and to a numeric secret version; Cloud Run revisions pin that version. Terraform never stores either cloud password payload in state. Treat Terraform state as sensitive even though these secret payloads are not managed there.

## Release order

1. Bootstrap remote state.
2. Apply the environment with `enable_workloads = false`; on GCP, securely inject the ephemeral application database password.
3. Build and push API and migration images.
4. On GCP, add the application password as the Secret Manager version named by `database_credential_version`; AWS uses its password-only Secrets Manager secret.
5. Apply with immutable image digests and `enable_workloads = true`.
6. Execute the migration task/job once.
7. Build and upload static web assets with `VITE_API_BASE_URL` empty so requests remain same-origin.
8. Verify the public `/api/v1/health` route.

## Credential rotation

Database credentials are read at workload startup and are not dynamically reloaded. AWS rotation updates the password-only secret and RDS write-only password in a maintenance window, then requires an ECS force deployment. GCP revisions pin a numeric password secret version, and the single-user password change is performed during a maintenance window. The baseline does not promise zero-downtime credential rotation; dual users or cloud-specific dynamic credential retrieval are added only when required.

## Deliberate boundaries

This baseline does not provision Supabase, Cognito, Identity Platform, application authentication, Redis, queues, Kubernetes, DNS zones, multi-region failover, customer-managed encryption keys, or cloud deployment pipelines. Projects add them only when requirements justify them.
