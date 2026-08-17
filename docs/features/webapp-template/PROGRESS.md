# Webapp Template Progress

## Status

Complete as of 2026-08-16.

## Completed

- Initialized TanStack Start v1 with React 19, strict TypeScript, Vite 7, Tailwind CSS v4, and Nitro Node output.
- Added dark-default theme variables and Google Font links for Space Grotesk and Inter.
- Added the complete requested shadcn/ui component set: accordion, alert dialog, alert, aspect ratio, avatar, badge, breadcrumb, button, calendar, card, carousel, chart, checkbox, collapsible, command, context menu, dialog, drawer, dropdown menu, form, hover card, input OTP, input, label, menubar, navigation menu, pagination, popover, progress, radio group, resizable panels, scroll area, select, separator, sheet, sidebar, skeleton, slider, sonner, switch, table, tabs, textarea, toggle group, toggle, and tooltip.
- Added global document shell, header, footer, toaster, public routes, and 404 page.
- Added SEO metadata to every UI leaf route.
- Added Orval generation from the backend Swagger 2.0 document, producing TanStack Query hooks, Fetch operations, query keys, query options, and Zod response models in `src/api-client`.
- Generated only documented operations: public health and bearer-protected user retrieval.
- Removed undocumented authentication calls, auth state, auth page, protected route guard, dashboard, settings, and the handwritten API client.
- Added runtime validation for generated API responses and TanStack Query integration coverage for public and bearer-protected operations.
- Added one `QueryClient` per browser router instance and a typed root `QueryClientProvider`; no component calls the generated hooks yet.
- Added Zustand 5 shared client state and used it to control mobile navigation visibility.
- Added i18next 26 and react-i18next 17 with bundled English/Vietnamese resources, browser detection, localStorage persistence, translated route metadata, and an accessible language selector.
- Split translations into `layout`, `home`, `about`, `pricing`, and `notFound` feature namespaces and converted all calls to i18next's strict selector API.
- Added i18next-cli selector extraction, `make gen-i18n`, `make check-i18n`, and generated namespace-aware TypeScript declarations under `src/i18n/generated`.
- Kept Orval output in `src/api-client` and handwritten API client tests in `src/test`.
- Switched TanStack Start to official CSR SPA mode with a static `/_shell.html`; route components, loaders, metadata, and navigation run only in the browser.
- Moved leaf-route metadata to a React 19 `Seo` component so client-rendered metadata remains unique during SPA startup and navigation.
- Added ESLint, Prettier, Vitest unit/integration tests, Playwright E2E tests, and production build scripts.
- Updated root verification to include the web application.
- Aligned webapp architecture and contributor guidance with the Go project's concise structure and workflow-oriented documentation.

## Verification

Verified on 2026-08-16:

- `npm run format:check`: passed.
- `npm run lint`: passed with zero warnings.
- `npm run typecheck`: passed under strict TypeScript settings.
- `npm run test:unit`: passed, 3 generated-client tests, 2 i18n tests, and 1 Zustand store test.
- `npm run test:integration`: passed, 2 documented endpoint tests.
- `npm run test:e2e`: passed, 7 Chromium CSR, language persistence, Zustand navigation, and public-route tests.
- `npm run api:generate`: passed with Orval 8.24.0 against backend Swagger 2.0.
- `npm run i18n:generate`: passed with synchronized English/Vietnamese feature namespaces and generated strict-selector declarations.
- `npm run i18n:check`: passed with no stale namespace or generated type files.
- `npm run build`: passed for client assets, static SPA shell generation, and Nitro node-server output.
- Root `make verify`: passed for both Go and webapp projects.

## Next Steps

1. Add new operations to backend `.api` sources before consuming them in the webapp.
2. Run `make gen-api-client` after backend contract changes.
3. Add translations to the namespace owned by each new feature and use strict selectors.
4. Configure backend CORS for the deployed web origin.
