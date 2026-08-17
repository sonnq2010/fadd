import { beforeEach, describe, expect, it } from 'vitest'

import { useAppStore } from '@/stores/app-store'

beforeEach(() => {
  useAppStore.setState({ mobileNavigationOpen: false })
})

describe('app store', () => {
  it('opens and closes mobile navigation', () => {
    useAppStore.getState().setMobileNavigationOpen(true)
    expect(useAppStore.getState().mobileNavigationOpen).toBe(true)

    useAppStore.getState().closeMobileNavigation()
    expect(useAppStore.getState().mobileNavigationOpen).toBe(false)
  })
})
