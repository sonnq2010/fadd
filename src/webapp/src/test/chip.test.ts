import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Chip } from '@/components/ui/chip'

describe('Chip public contract', () => {
  it('renders default state with border and text tokens', () => {
    const markup = renderToStaticMarkup(createElement(Chip, {}, 'Filter'))

    expect(markup).toContain('data-slot="chip"')
    expect(markup).toContain('Filter')
    expect(markup).toContain('bg-bg-primary')
    expect(markup).toContain('border-border-default')
    expect(markup).toContain('text-text-primary')
  })

  it('renders selected state with brand background and checkmark', () => {
    const markup = renderToStaticMarkup(
      createElement(Chip, { selected: true }, 'Filter'),
    )

    expect(markup).toContain('data-slot="chip"')
    expect(markup).toContain('bg-bg-brand')
    expect(markup).toContain('text-text-on-brand')
    expect(markup).toContain('data-slot="chip-check"')
  })

  it('renders close button when onRemove is provided', () => {
    const markup = renderToStaticMarkup(
      createElement(Chip, { onRemove: () => {} }, 'Filter'),
    )

    expect(markup).toContain('data-slot="chip-remove"')
  })

  it('renders disabled state with disabled tokens', () => {
    const markup = renderToStaticMarkup(
      createElement(Chip, { disabled: true }, 'Filter'),
    )

    expect(markup).toContain('bg-bg-disabled')
    expect(markup).toContain('text-text-disabled')
    expect(markup).toContain('border-border-disabled')
  })
})
