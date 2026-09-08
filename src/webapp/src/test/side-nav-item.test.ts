import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { SideNavItem } from '@/components/ui/side-nav-item'

describe('SideNavItem public contract', () => {
  it('renders default state with secondary text and transparent background', () => {
    const markup = renderToStaticMarkup(
      createElement(SideNavItem, { label: 'Dashboard' }),
    )

    expect(markup).toContain('Dashboard')
    expect(markup).toContain('text-text-secondary')
    expect(markup).toContain('text-body-small')
    expect(markup).toContain('hover:bg-bg-secondary-hover')
    expect(markup).toContain('hover:text-text-primary')
  })

  it('renders active state with brand text and selected background', () => {
    const markup = renderToStaticMarkup(
      createElement(SideNavItem, {
        isActive: true,
        label: 'Analytics',
      }),
    )

    expect(markup).toContain('Analytics')
    expect(markup).toContain('bg-bg-selected')
    expect(markup).toContain('text-text-brand')
  })

  it('renders disabled state with disabled text color and attribute', () => {
    const markup = renderToStaticMarkup(
      createElement(SideNavItem, {
        disabled: true,
        label: 'Settings',
      }),
    )

    expect(markup).toContain('Settings')
    expect(markup).toContain('text-text-disabled')
    expect(markup).toContain('disabled=""')
  })
})
