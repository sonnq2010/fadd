import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  MobileBottomTabBar,
  MobileBottomTabItem,
} from '@/components/ui/bottom-tab-item'

describe('MobileBottomTabItem public contract', () => {
  it('renders default state with tertiary text color', () => {
    const markup = renderToStaticMarkup(
      createElement(MobileBottomTabItem, { label: 'Home' }),
    )

    expect(markup).toContain('Home')
    expect(markup).toContain('text-text-tertiary')
  })

  it('renders active state with brand text color', () => {
    const markup = renderToStaticMarkup(
      createElement(MobileBottomTabItem, {
        isActive: true,
        label: 'Home',
      }),
    )

    expect(markup).toContain('Home')
    expect(markup).toContain('text-text-brand')
  })

  it('renders MobileBottomTabBar composite', () => {
    const markup = renderToStaticMarkup(
      createElement(MobileBottomTabBar, {
        items: [{ label: 'Home' }, { label: 'Search' }, { label: 'Profile' }],
        selectedIndex: 0,
      }),
    )

    expect(markup).toContain('w-[375px]')
    expect(markup).toContain('border-border-subtle')
    expect(markup).toContain('Home')
    expect(markup).toContain('Search')
    expect(markup).toContain('Profile')
  })
})
