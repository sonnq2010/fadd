import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { NavBar } from '@/components/ui/nav-bar'

describe('NavBar public contract', () => {
  it('renders brand title and tabs', () => {
    const markup = renderToStaticMarkup(
      createElement(NavBar, {
        brand: 'Acme',
        selectedTabIndex: 0,
        tabs: ['Tab label', 'Projects', 'Settings'],
      }),
    )

    expect(markup).toContain('Acme')
    expect(markup).toContain('Tab label')
    expect(markup).toContain('Projects')
    expect(markup).toContain('Settings')
  })

  it('renders action elements when provided', () => {
    const markup = renderToStaticMarkup(
      createElement(NavBar, {
        actions: createElement('button', { type: 'button' }, 'New project'),
        brand: 'Acme',
        selectedTabIndex: 0,
        tabs: ['Tab label'],
      }),
    )

    expect(markup).toContain('New project')
    expect(markup).toContain('border-border-subtle')
  })
})
