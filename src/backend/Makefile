SHELL := /bin/bash

DATABASE_URL ?= postgres://postgres:postgres@localhost:5432/fadd?sslmode=disable
COVERAGE_MIN ?= 80

.PHONY: run gen gen-code gen-sqlc gen-swagger check-generated create-migration migrate-up migrate-down migrate-status fmt fmt-check lint test test-unit test-integration test-e2e coverage verify

run:
	go run . -f etc/backend-api.yaml

gen: gen-code gen-sqlc gen-swagger

gen-code:
	@echo "Generating API code..."
	goctl api go --api api/main.api --dir .

gen-sqlc:
	@echo "Generating repository code..."
	go tool sqlc generate

gen-swagger:
	@echo "Generating Swagger documentation..."
	goctl api swagger --api api/main.api --dir api/apidocs --yaml

check-generated:
	./tool/check_generated.sh

create-migration:
	@test -n "$(NAME)" || { echo "NAME is required"; exit 1; }
	go tool goose -dir migrations -s create "$(NAME)" sql

migrate-up:
	go tool goose -dir migrations postgres "$(DATABASE_URL)" up

migrate-down:
	go tool goose -dir migrations postgres "$(DATABASE_URL)" down

migrate-status:
	go tool goose -dir migrations postgres "$(DATABASE_URL)" status

fmt:
	gofmt -w $$(find . -name '*.go')

fmt-check:
	@files="$$(gofmt -l $$(find . -name '*.go'))"; \
	if [[ -n "$$files" ]]; then printf '%s\n' "$$files"; exit 1; fi

lint:
	go tool golangci-lint run ./...

test: test-unit test-integration test-e2e

test-unit:
	go test -race ./...

test-integration:
	go test -race -tags=integration ./internal/repository

test-e2e:
	go test -race -tags=e2e ./tests/e2e

coverage:
	@profile="$$(mktemp)"; \
	trap 'rm -f "$$profile"' EXIT; \
	go test -coverprofile="$$profile" ./internal/logic/...; \
	coverage="$$(go tool cover -func="$$profile" | awk '/^total:/ {gsub("%", "", $$3); print $$3}')"; \
	awk -v coverage="$$coverage" -v minimum="$(COVERAGE_MIN)" 'BEGIN { if (coverage + 0 < minimum + 0) { printf "logic coverage %.1f%% is below %.1f%%\n", coverage, minimum; exit 1 } }'

verify: check-generated fmt-check lint test coverage
