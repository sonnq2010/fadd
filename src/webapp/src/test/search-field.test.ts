import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { SearchField, searchFieldVariants } from '@/components/ui/search-field'

describe('SearchField public contract', () => {
  it('generates the three Figma size contracts', () => {
    expect(searchFieldVariants({ size: 'large' })).toContain('h-12')
    expect(searchFieldVariants({ size: 'large' })).toContain('px-4')
    expect(searchFieldVariants({ size: 'large' })).toContain('text-body-medium')
    expect(searchFieldVariants({ size: 'medium' })).toContain('h-10')
    expect(searchFieldVariants({ size: 'medium' })).toContain('px-3')
    expect(searchFieldVariants({ size: 'medium' })).toContain('text-body-small')
    expect(searchFieldVariants({ size: 'small' })).toContain('h-9')
    expect(searchFieldVariants({ size: 'small' })).toContain('text-body-small')
    expect(searchFieldVariants({ size: 'small' })).toContain('rounded-md')
  })

  it('generates default and disabled state styles', () => {
    expect(searchFieldVariants({ state: 'default' })).toContain(
      'focus-within:border-border-focus',
    )
    expect(searchFieldVariants({ state: 'disabled' })).toContain(
      'bg-bg-disabled',
    )
  })

  it('renders search input with placeholder and clear button when default value is present', () => {
    const markup = renderToStaticMarkup(
      createElement(SearchField, {
        defaultValue: 'Query',
        placeholder: 'Search docs...',
      }),
    )

    expect(markup).toContain('placeholder="Search docs..."')
    expect(markup).toContain('value="Query"')
    expect(markup).toContain('aria-label="Clear search"')
  })

  it('disables input when disabled prop is true', () => {
    const markup = renderToStaticMarkup(
      createElement(SearchField, {
        disabled: true,
        placeholder: 'Search...',
      }),
    )

    expect(markup).toContain('disabled=""')
  })
})
