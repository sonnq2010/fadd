import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'

describe('Table public contract', () => {
  it('renders semantic table structure with correct design token classes', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Table,
        {},
        createElement(
          TableHeader,
          {},
          createElement(
            TableRow,
            {},
            createElement(TableHead, {}, 'Name'),
            createElement(TableHead, {}, 'Status'),
          ),
        ),
        createElement(
          TableBody,
          {},
          createElement(
            TableRow,
            {},
            createElement(TableCell, {}, 'Alex Kim'),
            createElement(TableCell, {}, 'Active'),
          ),
        ),
      ),
    )

    expect(markup).toContain('data-slot="table-container"')
    expect(markup).toContain('data-slot="table"')
    expect(markup).toContain('border-border-default')
    expect(markup).toContain('bg-bg-secondary')
    expect(markup).toContain('text-text-tertiary')
    expect(markup).toContain('Name')
    expect(markup).toContain('Status')
    expect(markup).toContain('Alex Kim')
    expect(markup).toContain('Active')
  })
})
