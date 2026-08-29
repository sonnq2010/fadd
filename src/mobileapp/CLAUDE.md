# Commands

- `make gen-api-client`: Generate the Dio client from backend Swagger.
- `make check-api-client`: Check that the committed API client is current.
- `make gen-code`: Generate Riverpod and Freezed files.
- `make analyze`: Analyze the generated package and Flutter app.
- `make test`: Run Flutter tests with coverage.
- `make verify`: Run all required mobile checks.

# Generated files

Do not manually edit:

- `api-client/**`
- `lib/**/*.g.dart`
- `lib/**/*.freezed.dart`

Backend `.api` files under `../backend/api` are the API source of truth. Change backend contracts, Riverpod annotations, Freezed declarations, or generator configuration and regenerate instead.

# API client workflow

1. Define routes and transport types in `../backend/api/modules` and shared types in `../backend/api`.
2. Run `make gen-api-client` from the repository root.
3. Consume generated operations through `lib/core/network/api_client.dart`.
4. Map generated transport models to domain entities in feature data layers.
5. Let `DioException` reach repository boundaries and map it with `Failure.handleException`.
6. Add an integration test for every generated operation the app consumes.

# Localization workflow

1. Keep matching keys in `assets/translations/en.json` and `assets/translations/vi.json`.
2. Use EasyLocalization from presentation code instead of hardcoded user-facing text.
3. When adding a locale, update `lib/core/constants/locale_constant.dart` and asset configuration as needed.
4. Add tests for behavior that depends on translated output or locale selection.

# Feature workflow

1. Use `/tdd` and agree the public seams with the user before writing tests.
2. Build one vertical behavior slice at a time: write one failing test, implement only enough to pass in domain → data → UI order, then repeat.
3. Build domain first: define entities, abstract repository contracts, then use cases.
4. Build data next: define data sources, implement repository contracts, and map transport models and failures at repository boundaries.
5. Build UI last: define states, providers, then screens and widgets follow the localization workflow.
6. Test behavior through public interfaces; do not add speculative implementation or refactor inside the red → green loop.
7. Keep feature code under `lib/features/<feature>` and genuinely reusable infrastructure and widgets under `lib/core`.
8. Register new screens and paths through `lib/core/router/app_router.dart` and `lib/core/router/app_routes.dart`.
9. Define Riverpod and Freezed sources, then run `make gen-code`; never write generated companions manually.
10. Follow the API client workflow for remote operations and add HTTP integration tests for consumed operations.
11. Add end-to-end tests for cross-component behavior.
12. Run the repository-root `make verify` before completion; do not skip required test levels.
