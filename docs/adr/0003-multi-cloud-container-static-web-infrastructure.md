# ADR 0003: Multi-cloud container and static-web infrastructure

- Status: Accepted
- Date: 2026-08-29

## Context

FADD is a project template and needs a production-shaped infrastructure baseline without forcing future projects into Kubernetes or a provider-specific application architecture. The existing API service is a stateless long-running Go HTTP process, the web application is a client-rendered SPA, and PostgreSQL is already the persistence contract.

## Decision

Provide separate Terraform implementations for AWS and GCP:

- AWS uses ECS Fargate, ALB, CloudFront, RDS PostgreSQL, ECR, S3, Secrets Manager, and CloudWatch.
- GCP uses Cloud Run, the global external Application Load Balancer, Cloud CDN, Cloud SQL PostgreSQL, Artifact Registry, Cloud Storage, Secret Manager, and Cloud Monitoring/Logging.
- The web application is deployed as static assets, while `/api/*` is routed to the API service at the same origin.
- Staging and production use separate AWS accounts or GCP projects and separate remote state, not workspaces.
- Production is regional HA; staging favors low cost.
- Database migrations are explicit one-off jobs and never run during `terraform apply`.
- Terraform consumes immutable application artifacts and does not build or upload them.
- API and migration workloads use discrete `POSTGRES_*` settings. Only the password is secret-bearing; GCP pins a numeric Secret Manager version, while AWS uses a password-only secret and an explicit credential version for its write-only RDS password update.
- Password rotation uses an explicit maintenance procedure. Running workloads are replaced after a credential change; zero-downtime dual-user rotation is outside this baseline.

## Consequences

The baseline has low operational overhead and maps cleanly to the current application. Cloud-specific modules remain explicit rather than hiding important behavior behind a cross-cloud abstraction. Teams must maintain equivalent capabilities in two providers, populate the GCP password secret after initial provisioning, perform credential rotation during a maintenance window, and run a separate artifact release process.

Authentication providers, Supabase resources, Redis, queues, Kubernetes, DNS-zone ownership, and multi-region failover remain separate decisions.
