# Commands

- `make run`: Run the go-zero API with local configuration.
- `make gen`: Generate go-zero code, sqlc code, and Swagger documentation.
- `make gen-code`: Generate handlers, routes, logic scaffolds, and API types from `.api` files.
- `make gen-sqlc`: Generate pgx repository code from migrations and SQL queries.
- `make gen-swagger`: Generate Swagger documentation from `.api` files.
- `make create-migration NAME=<name>`: Create a sequential Goose migration.
- `make migrate-up|migrate-down|migrate-status DATABASE_URL=<url>`: Manage PostgreSQL migrations.
- `make test-unit`: Run race-enabled unit tests.
- `make test-integration`: Run PostgreSQL repository integration tests.
- `make test-e2e`: Run cross-layer HTTP tests.
- `make lint`: Run golangci-lint.
- `make coverage`: Enforce at least 80% business-logic coverage.
- `make verify`: Run all required checks.

# Generated files

Do not manually edit files containing `DO NOT EDIT`, including:

- `internal/handler/routes.go`
- `internal/types/types.go`
- `internal/repository/sqlc/*.go`

Change `.api` or `.sql` source files and regenerate instead. goctl files marked `Safe to edit` may contain business logic.

# Database workflow

1. Create a Goose migration with `make create-migration NAME=<name>`.
2. Add or update queries under `internal/repository/query`.
3. Run `make gen-sqlc`.
4. Add repository adapter behavior and tests.
5. Never edit a committed migration; create a new migration.

# Feature workflow

1. Define the route and types in `api/modules`.
2. Run `make gen-code`.
3. Write tests with `/tdd`.
4. Implement logic with `/golang-pro` through a repository interface until tests pass.
5. Add PostgreSQL integration tests for persistence changes.
6. Add end-to-end tests for cross-component changes.
7. Run `make gen-swagger` and update documentation.
8. Run `make verify` before completion.
