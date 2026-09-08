import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { InputField, inputFieldBoxVariants } from '@/components/ui/input-field'

describe('InputField public contract', () => {
  it('generates the three Figma size contracts', () => {
    expect(inputFieldBoxVariants({ size: 'large' })).toContain('h-12')
    expect(inputFieldBoxVariants({ size: 'large' })).toContain('px-4')
    expect(inputFieldBoxVariants({ size: 'medium' })).toContain('h-10')
    expect(inputFieldBoxVariants({ size: 'medium' })).toContain('px-3')
    expect(inputFieldBoxVariants({ size: 'small' })).toContain('h-9')
    expect(inputFieldBoxVariants({ size: 'small' })).toContain('rounded-xs')
  })

  it('generates default, error, and disabled state styles', () => {
    expect(inputFieldBoxVariants({ state: 'default' })).toContain(
      'focus-within:ring-[3px]',
    )
    expect(inputFieldBoxVariants({ state: 'error' })).toContain(
      'border-border-error',
    )
    expect(inputFieldBoxVariants({ state: 'disabled' })).toContain(
      'bg-bg-disabled',
    )
  })

  it('connects label, helper text, and validation semantics', () => {
    const markup = renderToStaticMarkup(
      createElement(InputField, {
        id: 'email',
        label: 'Email',
        helperText: 'Use your work email',
        placeholder: 'name@example.com',
      }),
    )

    expect(markup).toContain('for="email"')
    expect(markup).toContain('aria-describedby="email-helper"')
    expect(markup).toContain('id="email-helper"')
    expect(markup).toContain('placeholder="name@example.com"')
  })

  it('shows error text instead of helper text and disables the native input', () => {
    const markup = renderToStaticMarkup(
      createElement(InputField, {
        id: 'email',
        label: 'Email',
        helperText: 'Use your work email',
        errorText: 'Invalid email',
        disabled: true,
      }),
    )

    expect(markup).toContain('aria-invalid="true"')
    expect(markup).toContain('aria-describedby="email-error"')
    expect(markup).toContain('disabled=""')
    expect(markup).toContain('Invalid email')
    expect(markup).not.toContain('Use your work email')
  })
})
