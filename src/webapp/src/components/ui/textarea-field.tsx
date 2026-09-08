import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'

import { cn } from '@/lib/utils'

const textareaFieldBoxVariants = cva(
  'flex w-full items-start overflow-hidden border-[1.5px] border-solid bg-bg-primary transition-all outline-none',
  {
    variants: {
      state: {
        default:
          'border-border-default focus-within:border-border-brand focus-within:ring-[3px] focus-within:ring-border-brand/45',
        error: 'border-border-error',
        disabled:
          'cursor-not-allowed border-border-disabled bg-bg-disabled text-text-disabled',
      },
    },
    defaultVariants: {
      state: 'default',
    },
  },
)

export interface TextareaFieldProps
  extends
    React.ComponentProps<'textarea'>,
    VariantProps<typeof textareaFieldBoxVariants> {
  label?: string
  helperText?: string
  errorText?: string
  minHeight?: string
}

const TextareaField = React.forwardRef<HTMLTextAreaElement, TextareaFieldProps>(
  (
    {
      className,
      id,
      label,
      helperText,
      errorText,
      disabled,
      minHeight = 'min-h-24', // 96px minimum height
      ...props
    },
    ref,
  ) => {
    const generatedId = React.useId()
    const textareaId = id ?? generatedId
    const isError = Boolean(errorText)
    const state = disabled ? 'disabled' : isError ? 'error' : 'default'

    return (
      <div className="flex w-full flex-col gap-1.5" data-slot="textarea-field">
        {label ? (
          <label
            htmlFor={textareaId}
            className={cn(
              'text-sm font-medium select-none',
              disabled ? 'text-text-disabled' : 'text-text-secondary',
            )}
          >
            {label}
          </label>
        ) : null}

        <div
          className={cn(
            textareaFieldBoxVariants({ state }),
            'rounded-md px-3 py-2',
            minHeight,
            className,
          )}
          data-slot="textarea-field-control"
        >
          <textarea
            id={textareaId}
            ref={ref}
            disabled={disabled}
            aria-invalid={isError ? true : undefined}
            aria-describedby={
              errorText
                ? `${textareaId}-error`
                : helperText
                  ? `${textareaId}-helper`
                  : undefined
            }
            className={cn(
              'text-text-primary placeholder:text-text-placeholder disabled:text-text-disabled h-full w-full min-w-0 resize-y bg-transparent text-base outline-none disabled:cursor-not-allowed',
            )}
            data-slot="textarea-field-input"
            {...props}
          />
        </div>

        {errorText ? (
          <p id={`${textareaId}-error`} className="text-text-error text-xs">
            {errorText}
          </p>
        ) : helperText ? (
          <p
            id={`${textareaId}-helper`}
            className={cn(
              'text-xs',
              disabled ? 'text-text-disabled' : 'text-text-tertiary',
            )}
          >
            {helperText}
          </p>
        ) : null}
      </div>
    )
  },
)

TextareaField.displayName = 'TextareaField'

export { TextareaField, textareaFieldBoxVariants }
