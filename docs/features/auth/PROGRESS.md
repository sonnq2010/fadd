# Auth Progress

## Status

Swagger authentication contract documented; runtime authentication remains pending as of 2026-08-16.

## Completed

- Added Swagger 2.0 `bearerAuth` security definition for the `Authorization` header.
- Marked the users API group with `authType: bearerAuth`.
- Regenerated `api/apidocs/main.yaml`; `GET /api/v1/users/{id}` now declares `security: [{ bearerAuth: [] }]`.

## Next Steps

1. Replace the pass-through auth middleware with real Bearer token validation.
2. Propagate the authenticated principal through request context.
3. Add authentication failure and authorization tests.
