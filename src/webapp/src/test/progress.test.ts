import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { ProgressBar } from '@/components/ui/progress'

describe('ProgressBar public contract', () => {
  it('renders all 3 states with label and percentage', () => {
    const states = ['default', 'success', 'error'] as const
    const fillClasses = {
      default: 'bg-bg-brand',
      success: 'bg-bg-success',
      error: 'bg-bg-error',
    }

    for (const state of states) {
      const markup = renderToStaticMarkup(
        createElement(ProgressBar, {
          value: 60,
          state,
          label: 'Uploading file.pdf',
        }),
      )

      expect(markup).toContain('data-slot="progress-bar"')
      expect(markup).toContain(`data-state="${state}"`)
      expect(markup).toContain('Uploading file.pdf')
      expect(markup).toContain('60%')
      expect(markup).toContain(fillClasses[state])
    }
  })

  it('hides label when showLabel is false', () => {
    const markup = renderToStaticMarkup(
      createElement(ProgressBar, {
        value: 60,
        label: 'Hidden file',
        showLabel: false,
      }),
    )

    expect(markup).not.toContain('Hidden file')
  })
})
