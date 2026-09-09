# Commands

- `make run`: Run the go-zero API with local configuration.
- `make gen`: Generate go-zero code, sqlc code, and Swagger documentation.
- `make gen-code`: Generate handlers, routes, logic scaffolds, and API types from `.api` files.
- `make gen-sqlc`: Generate pgx repository code from migrations and SQL queries.
- `make gen-swagger`: Generate Swagger documentation from `.api` files.
- `make check-generated`: Detect stale goctl, sqlc, and Swagger output without modifying the working tree.
- `make create-migration NAME=<name>`: Create a sequential Goose migration.
- `make migrate-up|migrate-down|migrate-status`: Manage PostgreSQL migrations using `POSTGRES_*` from the process environment.
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
4. Write a failing PostgreSQL repository integration test.
5. Implement the repository adapter until the test passes.
6. Never edit a committed migration; create a new migration.

# Feature workflow

1. Use `/tdd` and agree the public seams with the user before writing tests.
2. Select the smallest vertical behavior slice and identify its logic, repository, persistence, and HTTP boundaries.
3. Define the route and transport types in `api/modules`, then run `make gen-code`.
4. Define the domain model and repository interface required by the behavior.
5. Write one failing test against the logic public interface.
6. Implement only enough logic to pass using `/golang-pro`; construct logic errors through `apperrors`.
7. For persistence behavior, follow the database workflow: prepare the migration and query, run `make gen-sqlc`, write a failing repository integration test, then implement the adapter.
8. Add an HTTP end-to-end test for new or changed public endpoint behavior.
9. Repeat the red → green loop for the next behavior slice without speculative implementation.
10. Refactor only after behavior is green, during review, while keeping public-interface tests passing.
11. Run `make gen-swagger` and update documentation.
12. Run the repository-root `make verify` before completion; do not skip required test levels.
