import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { ChevronDown } from 'lucide-react'
import type { Select as SelectPrimitive } from 'radix-ui'

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { cn } from '@/lib/utils'

const selectFieldBoxVariants = cva(
  'flex w-full items-center justify-between gap-2 overflow-hidden border-[1.5px] border-solid bg-bg-primary transition-all outline-none',
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

export interface SelectOption {
  value: string
  label: string
  disabled?: boolean
}

export interface SelectFieldProps
  extends
    Omit<React.ComponentProps<typeof SelectPrimitive.Root>, 'size'>,
    VariantProps<typeof selectFieldBoxVariants> {
  id?: string
  label?: string
  placeholder?: string
  helperText?: string
  errorText?: string
  options: SelectOption[]
  className?: string
}

export function SelectField({
  id,
  label,
  placeholder,
  helperText,
  errorText,
  options,
  size = 'medium',
  disabled,
  className,
  value,
  defaultValue,
  onValueChange,
  ...props
}: SelectFieldProps) {
  const generatedId = React.useId()
  const selectId = id ?? generatedId
  const isError = Boolean(errorText)
  const state = disabled ? 'disabled' : isError ? 'error' : 'default'

  return (
    <div className="flex w-full flex-col gap-1.5" data-slot="select-field">
      {label ? (
        <label
          htmlFor={selectId}
          className={cn(
            'font-medium select-none',
            size === 'small' ? 'text-xs' : 'text-sm',
            disabled ? 'text-text-disabled' : 'text-text-secondary',
          )}
        >
          {label}
        </label>
      ) : null}

      <Select
        value={value}
        defaultValue={defaultValue}
        onValueChange={onValueChange}
        disabled={disabled}
        {...props}
      >
        <SelectTrigger
          id={selectId}
          size="none"
          aria-invalid={isError ? true : undefined}
          aria-describedby={
            errorText
              ? `${selectId}-error`
              : helperText
                ? `${selectId}-helper`
                : undefined
          }
          className={cn(
            selectFieldBoxVariants({ size, state, className }),
            'box-border shadow-none [&>svg]:hidden', // Hide the inner trigger's built-in icon so we use custom chevron
          )}
        >
          <SelectValue placeholder={placeholder} />
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
            <ChevronDown />
          </span>
        </SelectTrigger>

        <SelectContent>
          {options.map((opt) => (
            <SelectItem
              key={opt.value}
              value={opt.value}
              disabled={opt.disabled}
            >
              {opt.label}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>

      {errorText ? (
        <p id={`${selectId}-error`} className="text-text-error text-xs">
          {errorText}
        </p>
      ) : helperText ? (
        <p
          id={`${selectId}-helper`}
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
}

export { selectFieldBoxVariants }
