import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Checkbox } from '@/components/ui/checkbox'

describe('Checkbox public contract', () => {
  it('renders unchecked checkbox with label', () => {
    const markup = renderToStaticMarkup(
      createElement(Checkbox, {
        id: 'agree',
        label: 'I agree',
      }),
    )

    expect(markup).toContain('id="agree"')
    expect(markup).toContain('for="agree"')
    expect(markup).toContain('I agree')
    expect(markup).toContain('size-5')
    expect(markup).toContain('rounded-xs')
  })

  it('renders disabled state and disabled label style', () => {
    const markup = renderToStaticMarkup(
      createElement(Checkbox, {
        id: 'agree',
        label: 'I agree',
        disabled: true,
      }),
    )

    expect(markup).toContain('disabled=""')
    expect(markup).toContain('text-text-disabled')
  })
})
