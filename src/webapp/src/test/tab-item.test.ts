import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { TabItem, TabsNav } from '@/components/ui/tab-item'

describe('TabItem public contract', () => {
  it('renders default tab item with secondary text color', () => {
    const markup = renderToStaticMarkup(
      createElement(TabItem, { label: 'Overview' }),
    )

    expect(markup).toContain('Overview')
    expect(markup).toContain('text-text-secondary')
    expect(markup).toContain('bg-transparent')
  })

  it('renders active tab item with brand text and indicator', () => {
    const markup = renderToStaticMarkup(
      createElement(TabItem, {
        isActive: true,
        label: 'Settings',
      }),
    )

    expect(markup).toContain('Settings')
    expect(markup).toContain('text-text-brand')
    expect(markup).toContain('bg-border-brand')
    expect(markup).toContain('h-[2px]')
  })

  it('renders TabsNav composite', () => {
    const markup = renderToStaticMarkup(
      createElement(TabsNav, {
        selectedIndex: 1,
        tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
      }),
    )

    expect(markup).toContain('role="tablist"')
    expect(markup).toContain('Tab 1')
    expect(markup).toContain('Tab 2')
    expect(markup).toContain('Tab 3')
  })
})
