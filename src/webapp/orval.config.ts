import { defineConfig } from 'orval'

export default defineConfig({
  backend: {
    input: {
      target: '../go/api/apidocs/main.yaml',
    },
    output: {
      baseUrl: {
        runtime: 'import.meta.env.VITE_API_BASE_URL',
      },
      clean: true,
      client: 'react-query',
      formatter: 'prettier',
      httpClient: 'fetch',
      mode: 'split',
      override: {
        fetch: {
          runtimeValidation: true,
        },
        query: {
          runtimeValidation: true,
          shouldExportQueryKey: true,
          signal: true,
          useQuery: true,
          version: 5,
        },
        zod: {
          version: 4,
        },
      },
      schemas: {
        path: './src/api-client/models',
        type: 'zod',
      },
      target: './src/api-client/api.ts',
    },
  },
})
