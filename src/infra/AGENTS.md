# Commands

- `make fmt`: Format all Terraform files.
- `make fmt-check`: Check Terraform formatting.
- `make init`: Initialize every module and root without remote backends.
- `make validate`: Validate every Terraform module and root.
- `make lint`: Run TFLint through Docker.
- `make security`: Scan Terraform configuration with Trivy through Docker.
- `make test`: Run native Terraform tests with mocked providers.
- `make verify`: Run all infrastructure checks.

# Rules

- Never commit state, plans, real `backend.hcl`, real `.tfvars`, credentials, or secret values.
- Commit `.terraform.lock.hcl` only for bootstrap and environment roots.
- Do not use Terraform workspaces; staging and production use separate accounts/projects and state.
- Terraform defines migration jobs but never executes migrations during `apply`.
- Application images must use immutable digests in production.
