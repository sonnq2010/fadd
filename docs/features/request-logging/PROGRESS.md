# Request Logging Progress

## Status

Implemented on 2026-08-29.

## Completed

- Added structured request audit middleware for matched routes and 404/405 fallback responses.
- Added request ID generation/propagation and `X-Request-ID` response header.
- Added bounded request-body capture with recursive JSON credential redaction.
- Added response status/size capture and API error code/message extraction.
- Added request-scoped principal context accessors for future authentication wiring.
- Added `request_id` to go-zero logx context so downstream business logs inherit it automatically.
- Wired the middleware globally without editing generated route files.
- Disabled go-zero's generic access logger so the audit event is canonical.
- Added unit coverage for request metadata, redaction, identity, status levels, and errors.

## Verification

- `go vet ./...`: passed.
- `go tool golangci-lint run ./...`: passed.
- `go test ./...`: passed.

## Next Steps

1. Update the authentication middleware to call `WithPrincipal` after validating credentials.
2. Decide whether audit logs should be routed to a dedicated sink or retained in go-zero logx output.
