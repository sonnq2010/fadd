import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { MobileTopAppBar } from '@/components/ui/mobile-top-app-bar'

describe('MobileTopAppBar public contract', () => {
  it('renders title', () => {
    const markup = renderToStaticMarkup(
      createElement(MobileTopAppBar, { title: 'Screen title' }),
    )

    expect(markup).toContain('Screen title')
    expect(markup).toContain('w-[375px]')
    expect(markup).toContain('border-border-subtle')
  })

  it('renders leading and trailing actions', () => {
    const markup = renderToStaticMarkup(
      createElement(MobileTopAppBar, {
        leading: createElement('button', { type: 'button' }, 'Back'),
        title: 'Profile',
        trailing: createElement('button', { type: 'button' }, 'Menu'),
      }),
    )

    expect(markup).toContain('Back')
    expect(markup).toContain('Profile')
    expect(markup).toContain('Menu')
  })
})
