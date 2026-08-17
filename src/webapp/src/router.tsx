import { QueryClient } from '@tanstack/react-query'
import { createRouter } from '@tanstack/react-router'

import '@/i18n/config'

import { routeTree } from '@/routeTree.gen'

export function getRouter() {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 60_000,
      },
    },
  })

  return createRouter({
    context: { queryClient },
    routeTree,
    defaultPreload: 'intent',
    defaultPreloadStaleTime: 0,
    scrollRestoration: true,
  })
}
