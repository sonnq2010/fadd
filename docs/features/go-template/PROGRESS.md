# Go Template Progress

## Status

Complete as of 2026-08-16.

## Completed

- Added PostgreSQL Goose migration workflow and initial `users` schema.
- Added sqlc configuration, `GetUser` query, generated pgx access, repository interface, and PostgreSQL adapter.
- Added `GET /api/v1/users/:id` vertical slice through route, auth middleware hook, handler, logic, repository, sqlc, and PostgreSQL.
- Added pass-through auth middleware placeholder with explicit production TODO.
- Wired database pool lifecycle and repository dependencies through `ServiceContext`.
- Completed health response logic.
- Added unit, PostgreSQL integration, and go-zero HTTP end-to-end tests.
- Added generation, migration, lint, test, and verification Make targets.
- Updated Go architecture and contributor workflow documentation.
- Moved shared test helpers to `tests/testsupport`.
- Kept sqlc-generated database access under `internal/repository/sqlc`.
- Consolidated user repository code into `userrepository.go`; shortened contracts and dependency fields to `UserRepo`.

## Verification

Verified on 2026-08-16:

- `make -C src/go test-unit`: passed with race detector.
- `make -C src/go test-integration`: passed against PostgreSQL 18 testcontainer.
- `make -C src/go test-e2e`: passed against real go-zero server and PostgreSQL 18 testcontainer.
- `make -C src/go lint`: passed with 0 issues.
- `go -C src/go tool goose -dir migrations validate`: passed.
- `go -C src/go tool sqlc vet`: passed.
- Business-logic coverage: 100.0% (80% minimum).
- Root `make verify`: passed.

## Next Steps

1. Replace pass-through auth middleware with real credential validation and authenticated principal propagation.
2. Add production secret/config injection instead of local database credentials.
3. Add authorization rules for user-resource access before exposing the example endpoint outside development.
