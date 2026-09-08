import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Badge } from '@/components/ui/badge'

describe('Badge public contract', () => {
  it('renders all semantic token styles', () => {
    const variants = [
      'neutral',
      'brand',
      'secondary',
      'success',
      'warning',
      'error',
      'info',
    ] as const

    for (const variant of variants) {
      const markup = renderToStaticMarkup(
        createElement(Badge, { variant }, variant),
      )
      expect(markup).toContain(variant)
    }
  })

  it('renders brand subtle background and brand text', () => {
    const markup = renderToStaticMarkup(
      createElement(Badge, { variant: 'brand' }, 'Brand'),
    )

    expect(markup).toContain('bg-bg-brand-subtle')
    expect(markup).toContain('text-text-brand')
  })
})
