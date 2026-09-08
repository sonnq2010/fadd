import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Switch } from '@/components/ui/switch'

describe('Switch public contract', () => {
  it('renders switch with label', () => {
    const markup = renderToStaticMarkup(
      createElement(Switch, {
        id: 'notifications',
        label: 'Enable notifications',
      }),
    )

    expect(markup).toContain('id="notifications"')
    expect(markup).toContain('for="notifications"')
    expect(markup).toContain('Enable notifications')
    expect(markup).toContain('w-10')
    expect(markup).toContain('h-[22px]')
    expect(markup).toContain('size-[18px]')
  })

  it('renders disabled state with disabled label style', () => {
    const markup = renderToStaticMarkup(
      createElement(Switch, {
        id: 'notifications',
        label: 'Enable notifications',
        disabled: true,
      }),
    )

    expect(markup).toContain('disabled=""')
    expect(markup).toContain('text-text-disabled')
  })
})
