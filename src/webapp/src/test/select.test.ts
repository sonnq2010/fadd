import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  SelectField,
  selectFieldBoxVariants,
} from '@/components/ui/select-field'

const sampleOptions = [
  { value: '1', label: 'Option 1' },
  { value: '2', label: 'Option 2' },
]

describe('SelectField public contract', () => {
  it('generates the three Figma size contracts', () => {
    expect(selectFieldBoxVariants({ size: 'large' })).toContain('h-12')
    expect(selectFieldBoxVariants({ size: 'large' })).toContain('px-4')
    expect(selectFieldBoxVariants({ size: 'large' })).toContain(
      'text-body-medium',
    )
    expect(selectFieldBoxVariants({ size: 'medium' })).toContain('h-10')
    expect(selectFieldBoxVariants({ size: 'medium' })).toContain('px-3')
    expect(selectFieldBoxVariants({ size: 'medium' })).toContain(
      'text-body-small',
    )
    expect(selectFieldBoxVariants({ size: 'small' })).toContain('h-9')
    expect(selectFieldBoxVariants({ size: 'small' })).toContain(
      'text-body-small',
    )
    expect(selectFieldBoxVariants({ size: 'small' })).toContain('rounded-md')
  })

  it('generates default, error, and disabled state styles', () => {
    expect(selectFieldBoxVariants({ state: 'default' })).toContain(
      'focus-within:border-border-focus',
    )
    expect(selectFieldBoxVariants({ state: 'error' })).toContain(
      'border-border-error',
    )
    expect(selectFieldBoxVariants({ state: 'disabled' })).toContain(
      'bg-bg-disabled',
    )
  })

  it('connects label, helper text, and placeholder correctly', () => {
    const markup = renderToStaticMarkup(
      createElement(SelectField, {
        id: 'category',
        label: 'Category',
        placeholder: 'Select category',
        helperText: 'Choose one option',
        options: sampleOptions,
      }),
    )

    expect(markup).toContain('for="category"')
    expect(markup).toContain('id="category"')
    expect(markup).toContain('Select category')
    expect(markup).toContain('Choose one option')
  })

  it('shows error message and hides helper text when errorText is provided', () => {
    const markup = renderToStaticMarkup(
      createElement(SelectField, {
        id: 'category',
        label: 'Category',
        helperText: 'Choose one option',
        errorText: 'Category is required',
        options: sampleOptions,
      }),
    )

    expect(markup).toContain('Category is required')
    expect(markup).not.toContain('Choose one option')
    expect(markup).toContain('aria-invalid="true"')
  })
})
