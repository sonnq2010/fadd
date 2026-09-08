import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  TextareaField,
  textareaFieldBoxVariants,
} from '@/components/ui/textarea-field'

describe('TextareaField public contract', () => {
  it('generates default, error, and disabled state styles', () => {
    expect(textareaFieldBoxVariants({ state: 'default' })).toContain(
      'focus-within:ring-[3px]',
    )
    expect(textareaFieldBoxVariants({ state: 'error' })).toContain(
      'border-border-error',
    )
    expect(textareaFieldBoxVariants({ state: 'disabled' })).toContain(
      'bg-bg-disabled',
    )
  })

  it('connects label, placeholder, and helper text', () => {
    const markup = renderToStaticMarkup(
      createElement(TextareaField, {
        id: 'bio',
        label: 'Bio',
        placeholder: 'Tell us about yourself',
        helperText: 'Max 500 characters',
      }),
    )

    expect(markup).toContain('for="bio"')
    expect(markup).toContain('id="bio"')
    expect(markup).toContain('placeholder="Tell us about yourself"')
    expect(markup).toContain('Max 500 characters')
  })

  it('shows error text and overrides helper text', () => {
    const markup = renderToStaticMarkup(
      createElement(TextareaField, {
        id: 'bio',
        label: 'Bio',
        helperText: 'Max 500 characters',
        errorText: 'Bio is required',
        disabled: true,
      }),
    )

    expect(markup).toContain('Bio is required')
    expect(markup).not.toContain('Max 500 characters')
    expect(markup).toContain('aria-invalid="true"')
    expect(markup).toContain('disabled=""')
  })
})
