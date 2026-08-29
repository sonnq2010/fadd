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

Backend `.api` files under `../backend/api` are the API source of truth. Run
`make gen-api-client` from the repository root after changing the contract.

# API client workflow

1. Define routes and transport types in the backend `.api` files.
2. Run the root `make gen-api-client` target.
3. Consume generated operations through `core/network/api_client.dart`.
4. Map generated transport models to domain entities in feature data layers.
5. Let `DioException` reach repositories and map it with
   `Failure.handleException`.
6. Add integration tests for each consumed operation.
7. Run `make verify` before completion.
