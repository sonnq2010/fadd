import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Avatar, AvatarBadge, AvatarFallback } from '@/components/ui/avatar'

describe('Avatar public contract', () => {
  it('renders fallback initials for all 5 design scale sizes', () => {
    const sizes = ['xs', 'sm', 'md', 'lg', 'xl'] as const
    const sizeClasses = {
      xs: 'size-5',
      sm: 'size-7',
      md: 'size-9',
      lg: 'size-12',
      xl: 'size-16',
    }

    for (const size of sizes) {
      const markup = renderToStaticMarkup(
        createElement(
          Avatar,
          { size },
          createElement(AvatarFallback, null, 'JD'),
        ),
      )

      expect(markup).toContain('JD')
      expect(markup).toContain(sizeClasses[size])
    }
  })

  it('renders status dot badge with success indicator', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Avatar,
        { size: 'xl' },
        createElement(AvatarFallback, null, 'JD'),
        createElement(AvatarBadge, null),
      ),
    )

    expect(markup).toContain('data-slot="avatar-badge"')
    expect(markup).toContain('bg-bg-success')
  })
})
