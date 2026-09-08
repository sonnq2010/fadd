import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Stepper, StepperItem } from '@/components/ui/stepper'

describe('Stepper public contract', () => {
  it('renders StepperItem for all 3 states', () => {
    const states = ['upcoming', 'active', 'completed'] as const

    for (const state of states) {
      const markup = renderToStaticMarkup(
        createElement(StepperItem, {
          label: `Step ${state}`,
          number: '1',
          state,
        }),
      )

      expect(markup).toContain('data-slot="stepper-item"')
      expect(markup).toContain(`data-state="${state}"`)
      expect(markup).toContain(`Step ${state}`)
    }
  })

  it('renders Stepper composite with steps and connectors', () => {
    const markup = renderToStaticMarkup(
      createElement(Stepper, {
        steps: [
          { label: 'Account', state: 'completed' },
          { label: 'Shipping', state: 'active' },
          { label: 'Payment', state: 'upcoming' },
        ],
      }),
    )

    expect(markup).toContain('data-slot="stepper"')
    expect(markup).toContain('Account')
    expect(markup).toContain('Shipping')
    expect(markup).toContain('Payment')
  })
})
