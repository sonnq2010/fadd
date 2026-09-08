import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Alert } from '@/components/ui/alert'

describe('Alert public contract', () => {
  it('renders all 4 semantic styles with subtle background tokens', () => {
    const variants = ['success', 'warning', 'error', 'info'] as const
    const bgClasses = {
      success: 'bg-bg-success-subtle',
      warning: 'bg-bg-warning-subtle',
      error: 'bg-bg-error-subtle',
      info: 'bg-bg-info-subtle',
    }

    for (const variant of variants) {
      const markup = renderToStaticMarkup(
        createElement(
          Alert,
          { variant },
          `${variant} alert message goes here.`,
        ),
      )

      expect(markup).toContain('data-slot="alert"')
      expect(markup).toContain(`data-variant="${variant}"`)
      expect(markup).toContain(bgClasses[variant])
      expect(markup).toContain(`${variant} alert message goes here.`)
    }
  })

  it('renders close button by default and allows hiding it', () => {
    const withClose = renderToStaticMarkup(
      createElement(Alert, { showClose: true }, 'With close'),
    )
    expect(withClose).toContain('data-slot="alert-close"')

    const withoutClose = renderToStaticMarkup(
      createElement(Alert, { showClose: false }, 'Without close'),
    )
    expect(withoutClose).not.toContain('data-slot="alert-close"')
  })
})
