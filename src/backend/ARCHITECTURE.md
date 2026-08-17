# Go backend architecture

## Overview

`src/go` is a go-zero REST service backed by PostgreSQL. Goose migrations define the database schema, sqlc generates type-safe pgx queries, and repository interfaces keep business logic independent from generated database code.

## Project structure

```text
go/
├── api/
│   ├── apidocs/                 # generated Swagger document
│   ├── modules/                 # go-zero API modules
│   ├── common.api               # shared API types
│   └── main.api                 # API entrypoint
├── etc/
│   └── backend-api.yaml         # local service configuration
├── internal/
│   ├── config/                  # typed configuration
│   ├── handler/                 # generated HTTP handlers and routes
│   ├── logic/                   # business logic
│   ├── middleware/              # custom middleware
│   ├── repository/
│   │   ├── query/               # hand-written sqlc queries
│   │   ├── sqlc/                # generated database access
│   │   └── userrepository.go    # repository contract and PostgreSQL adapter
│   ├── svc/                     # shared dependencies and lifecycle
│   └── types/                   # generated request/response types
├── migrations/                  # Goose SQL migrations
├── tests/
│   ├── e2e/                     # cross-layer HTTP tests
│   └── testsupport/             # shared PostgreSQL test helper
├── backend.go                   # process entrypoint
└── sqlc.yaml                    # sqlc generation configuration
```
