# Commands

- `npm run dev`: Run the TanStack Start development server.
- `make gen-api`: Generate TanStack Query hooks, Fetch operations, and Zod models from backend Swagger.
- `make gen-i18n`: Extract feature-namespace selectors and generate typed i18next declarations.
- `make check-i18n`: Verify namespace extraction and generated selector declarations are current.
- `make format-check`: Check Prettier formatting.
- `make lint`: Run ESLint with zero warnings allowed.
- `make typecheck`: Run strict TypeScript checks.
- `make test-unit`: Run Vitest unit tests.
- `make test-integration`: Run generated-client HTTP integration tests.
- `make test-e2e`: Run Playwright browser tests.
- `make build`: Build client assets, the static SPA shell, and Nitro output.
- `make verify`: Regenerate clients and run all required checks.

# Generated files

Do not manually edit generated files, including:

- `src/routeTree.gen.ts`
- `src/api-client/**`
- `src/i18n/generated/**`
- `.output/**`

Change route files, backend `.api` sources, or locale resources and regenerate instead.

# API client workflow

1. Define or update operations in `../go/api/modules` and shared types in `../go/api`.
2. Run `make gen-api-client` from the repository root to regenerate Swagger and the web client.
3. Import generated hooks or query options from `@/api-client/api`.
4. Pass bearer authorization through generated Fetch options when the documented operation requires it.
5. Add unit tests for generated configuration and integration tests for HTTP behavior.
6. Never add handwritten endpoint clients or consume operations absent from backend Swagger.

# Localization workflow

1. Give each feature its own namespace file under both `src/i18n/locales/en` and `src/i18n/locales/vi`.
2. Register new namespaces and bundled resources in `src/i18n/config.ts`.
3. Bind `useTranslation` to the owning namespace and use strict selectors, such as `t(($) => $.home.heading)`.
4. Run `make gen-i18n`, then translate the matching English and Vietnamese values.
5. Run `make check-i18n` before completion.
6. Never use literal translation keys or manually edit generated declarations.

# Feature workflow

1. Add the route, components, feature namespace, and tests using skill /vercel-react-best-practices for the requested behavior.
2. Define backend operations in `.api` sources before adding any API-dependent frontend behavior.
3. Use generated TanStack Query hooks and keep state in the appropriate owner.
4. Add unit tests, integration tests for HTTP changes, and end-to-end tests for cross-component behavior.
5. Regenerate the route tree, API client, and i18next declarations through their source workflows.
6. Run `make verify` before completion; do not skip required test levels.
