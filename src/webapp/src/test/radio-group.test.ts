import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'

describe('RadioGroup public contract', () => {
  it('renders radio group item with label and 20px circle', () => {
    const markup = renderToStaticMarkup(
      createElement(
        RadioGroup,
        { defaultValue: '1' },
        createElement(RadioGroupItem, {
          id: 'opt1',
          value: '1',
          label: 'Option 1',
        }),
      ),
    )

    expect(markup).toContain('id="opt1"')
    expect(markup).toContain('for="opt1"')
    expect(markup).toContain('Option 1')
    expect(markup).toContain('size-5')
    expect(markup).toContain('rounded-full')
  })

  it('renders disabled state and disabled label style', () => {
    const markup = renderToStaticMarkup(
      createElement(
        RadioGroup,
        {},
        createElement(RadioGroupItem, {
          id: 'opt1',
          value: '1',
          label: 'Option 1',
          disabled: true,
        }),
      ),
    )

    expect(markup).toContain('disabled=""')
    expect(markup).toContain('text-text-disabled')
  })
})
