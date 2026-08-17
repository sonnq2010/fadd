import { QueryClient } from '@tanstack/react-query'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { ZodError } from 'zod'

import {
  getHealthGetHealthQueryKey,
  getUsersGetUserQueryOptions,
  healthGetHealth,
} from '@/api-client/api'

beforeEach(() => {
  vi.stubEnv('VITE_API_BASE_URL', 'https://api.example.test')
})

afterEach(() => {
  vi.restoreAllMocks()
  vi.unstubAllEnvs()
})

describe('generated TanStack Query API client', () => {
  it('builds query keys from VITE_API_BASE_URL and documented paths', () => {
    expect(getHealthGetHealthQueryKey()).toEqual([
      'https://api.example.test/api/v1/health',
    ])
  })

  it('sends caller-provided bearer authorization through query options', async () => {
    const fetchMock = vi.spyOn(globalThis, 'fetch').mockResolvedValue(
      Response.json({
        createdAt: '2026-08-16T00:00:00Z',
        displayName: 'User',
        email: 'user@example.test',
        id: 'user-id',
        updatedAt: '2026-08-16T00:00:00Z',
      }),
    )

    const queryClient = new QueryClient()
    await queryClient.fetchQuery(
      getUsersGetUserQueryOptions('user-id', {
        fetch: {
          headers: { Authorization: 'Bearer access-token' },
        },
      }),
    )

    const [, options] = fetchMock.mock.calls[0] ?? []
    expect(new Headers(options?.headers).get('Authorization')).toBe(
      'Bearer access-token',
    )
  })

  it('validates documented responses at runtime', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValue(
      Response.json({ status: 42 }),
    )

    await expect(healthGetHealth()).rejects.toBeInstanceOf(ZodError)
  })
})
