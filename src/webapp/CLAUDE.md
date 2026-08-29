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

1. Define or update operations in `../backend/api/modules` and shared types in `../backend/api`.
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

1. Use `/tdd` and agree the public seams with the user before writing tests.
2. Select the smallest vertical behavior slice and identify its route or UI boundary, state owner, API needs, and localization namespace.
3. For API-dependent behavior, define backend operations in `.api` sources and regenerate the client before writing handwritten frontend integration code.
4. Write one failing behavior test at an agreed public seam; do not test implementation details.
5. Implement only enough to pass using `/vercel-react-best-practices`: add the required route and components, use generated TanStack Query hooks, keep state in the nearest appropriate owner, and add user-facing text through the localization workflow.
6. Run the targeted test until it is green, then repeat the red → green loop for the next behavior slice without speculative implementation.
7. Refactor only after the behavior is green, during review, while keeping public-interface tests passing.
8. Add HTTP integration tests for changed client behavior and Playwright end-to-end tests for cross-component behavior.
9. Regenerate affected artifacts—the route tree, API client, or i18next declarations—through their source workflows.
10. Run the repository-root `make verify` before completion; do not skip required test levels.
