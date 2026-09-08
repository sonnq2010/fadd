import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from '@/components/ui/pagination'

describe('Pagination public contract', () => {
  it('renders PaginationLink states including active brand style', () => {
    const defaultLink = renderToStaticMarkup(
      createElement(PaginationLink, { href: '#' }, '1'),
    )
    expect(defaultLink).toContain('1')
    expect(defaultLink).toContain('data-slot="pagination-link"')

    const activeLink = renderToStaticMarkup(
      createElement(PaginationLink, { href: '#', isActive: true }, '2'),
    )
    expect(activeLink).toContain('2')
    expect(activeLink).toContain('data-active="true"')
    expect(activeLink).toContain('bg-bg-brand')
    expect(activeLink).toContain('text-text-on-brand')
  })

  it('renders PaginationEllipsis with three dots', () => {
    const ellipsis = renderToStaticMarkup(
      createElement(PaginationEllipsis, null),
    )
    expect(ellipsis).toContain('data-slot="pagination-ellipsis"')
    expect(ellipsis).toContain('...')
  })

  it('renders full Pagination composite', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Pagination,
        null,
        createElement(
          PaginationContent,
          null,
          createElement(
            PaginationItem,
            null,
            createElement(PaginationPrevious, null),
          ),
          createElement(
            PaginationItem,
            null,
            createElement(PaginationLink, { isActive: true }, '1'),
          ),
          createElement(
            PaginationItem,
            null,
            createElement(PaginationLink, null, '2'),
          ),
          createElement(
            PaginationItem,
            null,
            createElement(PaginationEllipsis, null),
          ),
          createElement(
            PaginationItem,
            null,
            createElement(PaginationLink, null, '12'),
          ),
          createElement(
            PaginationItem,
            null,
            createElement(PaginationNext, null),
          ),
        ),
      ),
    )

    expect(markup).toContain('data-slot="pagination"')
    expect(markup).toContain('data-slot="pagination-content"')
  })
})
