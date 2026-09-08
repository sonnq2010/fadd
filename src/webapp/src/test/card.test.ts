import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card'

describe('Card public contract', () => {
  it('renders standard card structure with design system styling', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Card,
        { className: 'w-[320px]' },
        createElement(
          CardHeader,
          null,
          createElement(CardTitle, null, 'Card title'),
        ),
        createElement(
          CardContent,
          null,
          createElement(CardDescription, null, 'Card description'),
        ),
        createElement(
          CardFooter,
          null,
          createElement(CardAction, null, 'Action'),
        ),
      ),
    )

    expect(markup).toContain('w-[320px]')
    expect(markup).toContain('Card title')
    expect(markup).toContain('Card description')
    expect(markup).toContain('Action')
  })
})
