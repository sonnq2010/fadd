import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Divider } from '@/components/ui/divider'

describe('Divider public contract', () => {
  it('renders horizontal divider with border-border-subtle token', () => {
    const markup = renderToStaticMarkup(createElement(Divider))

    expect(markup).toContain('data-slot="divider"')
    expect(markup).toContain('data-orientation="horizontal"')
    expect(markup).toContain('bg-border-subtle')
  })

  it('renders horizontal divider with centered label', () => {
    const markup = renderToStaticMarkup(createElement(Divider, { label: 'OR' }))

    expect(markup).toContain('data-slot="divider"')
    expect(markup).toContain('OR')
    expect(markup).toContain('text-text-tertiary')
    expect(markup).toContain('bg-border-subtle')
  })

  it('renders vertical divider', () => {
    const markup = renderToStaticMarkup(
      createElement(Divider, { orientation: 'vertical' }),
    )

    expect(markup).toContain('data-slot="divider"')
    expect(markup).toContain('data-orientation="vertical"')
    expect(markup).toContain('bg-border-subtle')
  })
})
