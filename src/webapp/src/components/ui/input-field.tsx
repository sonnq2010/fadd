import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'

import { cn } from '@/lib/utils'

const inputFieldBoxVariants = cva(
  'flex w-full items-center gap-2 overflow-hidden border-[1.5px] border-solid bg-bg-primary transition-all outline-none',
  {
    variants: {
      size: {
        large: 'h-12 rounded-md px-4 py-3 text-lg',
        medium: 'h-10 rounded-md px-3 py-2 text-base',
        small: 'h-9 rounded-xs px-2 py-1 text-sm',
      },
      state: {
        default:
          'border-border-default focus-within:border-border-brand focus-within:ring-[3px] focus-within:ring-border-brand/45',
        error: 'border-border-error',
        disabled:
          'cursor-not-allowed border-border-disabled bg-bg-disabled text-text-disabled',
      },
    },
    defaultVariants: {
      size: 'medium',
      state: 'default',
    },
  },
)

export interface InputFieldProps
  extends
    Omit<React.ComponentProps<'input'>, 'size'>,
    VariantProps<typeof inputFieldBoxVariants> {
  label?: string
  helperText?: string
  errorText?: string
  leadingIcon?: React.ReactNode
  trailingIcon?: React.ReactNode
  trailingIconLabel?: string
  onTrailingIconClick?: () => void
}

const InputField = React.forwardRef<HTMLInputElement, InputFieldProps>(
  (
    {
      className,
      id,
      label,
      helperText,
      errorText,
      leadingIcon,
      trailingIcon,
      trailingIconLabel,
      onTrailingIconClick,
      size = 'medium',
      disabled,
      ...props
    },
    ref,
  ) => {
    const generatedId = React.useId()
    const inputId = id ?? generatedId
    const isError = Boolean(errorText)
    const state = disabled ? 'disabled' : isError ? 'error' : 'default'

    return (
      <div className="flex w-full flex-col gap-1.5" data-slot="input-field">
        {label ? (
          <label
            htmlFor={inputId}
            className={cn(
              'font-medium select-none',
              size === 'small' ? 'text-xs' : 'text-sm',
              disabled ? 'text-text-disabled' : 'text-text-secondary',
            )}
          >
            {label}
          </label>
        ) : null}

        <div
          className={cn(inputFieldBoxVariants({ size, state, className }))}
          data-slot="input-field-control"
        >
          {leadingIcon ? (
            <span
              aria-hidden="true"
              className={cn(
                'size-4 shrink-0 [&_svg]:size-4',
                disabled
                  ? 'text-icon-disabled'
                  : isError
                    ? 'text-icon-error'
                    : 'text-icon-secondary',
              )}
            >
              {leadingIcon}
            </span>
          ) : null}

          <input
            id={inputId}
            ref={ref}
            disabled={disabled}
            aria-invalid={isError ? true : undefined}
            aria-describedby={
              errorText
                ? `${inputId}-error`
                : helperText
                  ? `${inputId}-helper`
                  : undefined
            }
            className={cn(
              'text-text-primary placeholder:text-text-placeholder disabled:text-text-disabled w-full min-w-0 bg-transparent outline-none disabled:cursor-not-allowed',
            )}
            data-slot="input-field-input"
            {...props}
          />

          {trailingIcon ? (
            onTrailingIconClick ? (
              <button
                type="button"
                aria-label={trailingIconLabel ?? 'Input action'}
                disabled={disabled}
                onClick={onTrailingIconClick}
                className={cn(
                  'focus-visible:ring-border-focus -m-1 inline-flex size-6 shrink-0 items-center justify-center rounded-sm outline-none focus-visible:ring-2 [&_svg]:size-4',
                  disabled
                    ? 'text-icon-disabled cursor-not-allowed'
                    : isError
                      ? 'text-icon-error'
                      : 'text-icon-secondary',
                )}
              >
                {trailingIcon}
              </button>
            ) : (
              <span
                aria-hidden="true"
                className={cn(
                  'size-4 shrink-0 [&_svg]:size-4',
                  disabled
                    ? 'text-icon-disabled'
                    : isError
                      ? 'text-icon-error'
                      : 'text-icon-secondary',
                )}
              >
                {trailingIcon}
              </span>
            )
          ) : null}
        </div>

        {errorText ? (
          <p id={`${inputId}-error`} className="text-text-error text-xs">
            {errorText}
          </p>
        ) : helperText ? (
          <p
            id={`${inputId}-helper`}
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

InputField.displayName = 'InputField'

export { InputField, inputFieldBoxVariants }
