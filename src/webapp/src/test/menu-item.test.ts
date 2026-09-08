import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Menu, MenuItem } from '@/components/ui/menu-item'

describe('MenuItem public contract', () => {
  it('renders menu item with label and shortcut', () => {
    const markup = renderToStaticMarkup(
      createElement(MenuItem, {
        label: 'Cut',
        shortcut: '⌘X',
      }),
    )

    expect(markup).toContain('Cut')
    expect(markup).toContain('⌘X')
    expect(markup).toContain('text-text-primary')
    expect(markup).toContain('text-body-medium')
    expect(markup).toContain('hover:bg-bg-secondary-hover')
  })

  it('renders selected menu item with checkmark and brand styling', () => {
    const markup = renderToStaticMarkup(
      createElement(MenuItem, {
        label: 'Show line numbers',
        selected: true,
      }),
    )

    expect(markup).toContain('Show line numbers')
    expect(markup).toContain('bg-bg-selected')
    expect(markup).toContain('text-text-brand')
    expect(markup.indexOf('<svg')).toBeLessThan(
      markup.indexOf('Show line numbers'),
    )
  })

  it('renders destructive variant', () => {
    const markup = renderToStaticMarkup(
      createElement(MenuItem, {
        destructive: true,
        label: 'Delete',
      }),
    )

    expect(markup).toContain('Delete')
    expect(markup).toContain('text-text-error')
  })

  it('renders composite Menu container', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Menu,
        null,
        createElement(MenuItem, { label: 'Item 1' }),
        createElement(MenuItem, { label: 'Item 2' }),
      ),
    )

    expect(markup).toContain('w-[220px]')
    expect(markup).toContain('border-border-subtle')
    expect(markup).toContain('shadow-md')
  })
})
