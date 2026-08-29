# Mobile API Client Progress

## Status

Complete as of 2026-08-29.

## Completed

- Selected pinned OpenAPI Generator `7.19.0` with the stable `dart-dio` and
  `built_value` output.
- Added a standalone generated `backend_api_client` Dart package sourced from
  the backend Swagger document.
- Located the generated package at `src/mobileapp/api-client` and renamed
  application source generation to `make gen-code`.
- Added backend Swagger tags so mobile operations generate as separate
  `HealthApi` and `UsersApi` classes instead of `DefaultApi`.
- Added application configuration and a Riverpod composition provider.
- Added generation, stale-output checking, and repository-level command wiring.
- Completed the historical Flutter project rename in tracked iOS and web
  metadata and regenerated ignored Flutter state.
- Added transport integration tests for health, bearer authorization, response
  deserialization, and Dio failure mapping.

## Verification

Verified on 2026-08-29:

- Root `make gen-api-client`: passed for backend Swagger, web Orval, and mobile Dart generation.
- `make -C src/mobileapp check-api-client`: passed with no stale generated output.
- Generated package analysis and `flutter analyze`: passed with no issues.
- Mobile tests: passed, 5 tests.
- Root `make verify`: passed for backend, webapp, and mobileapp.

## Next Steps

1. Inject the Supabase access token when a protected backend operation is first
   consumed by a mobile feature.
2. Map generated transport models to feature-owned domain entities.
3. Add operations only through backend `.api` sources and regenerate all
   clients with root `make gen-api-client`.
