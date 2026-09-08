import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from '@/components/ui/breadcrumb'

describe('Breadcrumb public contract', () => {
  it('renders Breadcrumb hierarchy with semantic tokens', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Breadcrumb,
        null,
        createElement(
          BreadcrumbList,
          null,
          createElement(
            BreadcrumbItem,
            null,
            createElement(BreadcrumbLink, { href: '#' }, 'Home'),
          ),
          createElement(BreadcrumbSeparator, null),
          createElement(
            BreadcrumbItem,
            null,
            createElement(BreadcrumbLink, { href: '#' }, 'Projects'),
          ),
          createElement(BreadcrumbSeparator, null),
          createElement(
            BreadcrumbItem,
            null,
            createElement(BreadcrumbPage, null, 'Design System'),
          ),
        ),
      ),
    )

    expect(markup).toContain('data-slot="breadcrumb"')
    expect(markup).toContain('data-slot="breadcrumb-list"')
    expect(markup).toContain('Home')
    expect(markup).toContain('Projects')
    expect(markup).toContain('Design System')
    expect(markup).toContain('text-text-secondary')
    expect(markup).toContain('text-text-primary')
  })
})
