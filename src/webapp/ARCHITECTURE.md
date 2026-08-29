# Web application architecture

## Overview

`src/webapp` is a TanStack Start v1 application built with React 19, strict TypeScript, Vite 7, Tailwind CSS v4, and shadcn/ui. It runs as a client-rendered SPA served by Nitro's Node preset, calls the external documented HTTP API directly through an Orval-generated TanStack Query client, uses Zustand for shared client state, and provides English/Vietnamese feature namespaces through i18next.

## Project structure

```text
webapp/
├── public/
│   └── robots.txt                 # static public assets
├── src/
│   ├── api-client/                # generated Fetch, TanStack Query, and Zod API client
│   ├── components/
│   │   ├── layout/                # application shell components
│   │   └── ui/                    # local shadcn/ui primitives
│   ├── hooks/                     # shared React hooks
│   ├── i18n/
│   │   ├── generated/             # generated i18next TypeScript declarations
│   │   ├── locales/               # English and Vietnamese feature namespaces
│   │   └── config.ts              # bundled resources and browser language detection
│   ├── lib/                       # handwritten application utilities
│   ├── routes/                    # TanStack Router file-based routes
│   ├── stores/                    # typed Zustand client stores
│   ├── test/                      # unit and HTTP integration tests
│   ├── routeTree.gen.ts           # generated TanStack Router tree
│   ├── router.tsx                 # router and QueryClient construction
│   ├── start.ts                   # TanStack Start CSR configuration
│   └── styles.css                 # Tailwind theme and global styles
├── tests/
│   └── e2e/                       # Playwright browser tests
├── .env.example                   # browser-visible environment template
├── i18next.config.ts              # extraction and selector type generation
├── orval.config.ts                # backend contract client generation
├── vite.config.ts                 # Vite and TanStack Start SPA configuration
└── package.json                   # scripts and pinned dependencies
```
