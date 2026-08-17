import { createServer, type Server } from 'node:http'
import type { AddressInfo } from 'node:net'
import { QueryClient } from '@tanstack/react-query'
import { afterAll, beforeAll, describe, expect, it, vi } from 'vitest'

import {
  getHealthGetHealthQueryOptions,
  getUsersGetUserQueryOptions,
} from '@/api-client/api'

let apiServer: Server
let queryClient: QueryClient

beforeAll(async () => {
  queryClient = new QueryClient({
    defaultOptions: {
      queries: {
        retry: false,
      },
    },
  })

  apiServer = createServer((request, response) => {
    response.setHeader('Content-Type', 'application/json')

    if (request.url === '/api/v1/health') {
      response.end(JSON.stringify({ status: 'ok', version: 'test' }))
      return
    }

    if (
      request.url === '/api/v1/users/user-id' &&
      request.headers.authorization === 'Bearer access-token'
    ) {
      response.end(
        JSON.stringify({
          createdAt: '2026-08-16T00:00:00Z',
          displayName: 'User',
          email: 'user@example.test',
          id: 'user-id',
          updatedAt: '2026-08-16T00:00:00Z',
        }),
      )
      return
    }

    response.statusCode = 401
    response.end(JSON.stringify({ message: 'Unauthorized' }))
  })

  await new Promise<void>((resolve) => {
    apiServer.listen(0, '127.0.0.1', resolve)
  })

  const address = apiServer.address() as AddressInfo
  vi.stubEnv('VITE_API_BASE_URL', `http://127.0.0.1:${address.port}`)
})

afterAll(async () => {
  queryClient.clear()
  vi.unstubAllEnvs()
  await new Promise<void>((resolve, reject) => {
    apiServer.close((error) => {
      if (error) {
        reject(error)
        return
      }

      resolve()
    })
  })
})

describe('generated TanStack Query API integration', () => {
  it('calls the documented public endpoint', async () => {
    const response = await queryClient.fetchQuery(
      getHealthGetHealthQueryOptions(),
    )

    expect(response.data).toEqual({ status: 'ok', version: 'test' })
  })

  it('calls the documented secured endpoint with bearer auth', async () => {
    const response = await queryClient.fetchQuery(
      getUsersGetUserQueryOptions('user-id', {
        fetch: {
          headers: { Authorization: 'Bearer access-token' },
        },
      }),
    )

    expect(response.data.id).toBe('user-id')
  })
})
