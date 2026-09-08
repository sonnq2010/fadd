import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { Search, X } from 'lucide-react'

import { cn } from '@/lib/utils'

const searchFieldVariants = cva(
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

export interface SearchFieldProps
  extends
    Omit<React.ComponentProps<'input'>, 'size'>,
    VariantProps<typeof searchFieldVariants> {
  onClear?: () => void
  clearLabel?: string
}

const SearchField = React.forwardRef<HTMLInputElement, SearchFieldProps>(
  (
    {
      className,
      size = 'medium',
      disabled,
      value,
      defaultValue,
      onChange,
      onClear,
      clearLabel = 'Clear search',
      placeholder = 'Search...',
      ...props
    },
    ref,
  ) => {
    const [internalValue, setInternalValue] = React.useState(
      defaultValue?.toString() ?? '',
    )
    const isControlled = value !== undefined
    const currentValue = isControlled ? value.toString() : internalValue
    const hasValue = currentValue.length > 0
    const state = disabled ? 'disabled' : 'default'

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
      if (!isControlled) {
        setInternalValue(e.target.value)
      }
      onChange?.(e)
    }

    const handleClear = () => {
      if (!isControlled) {
        setInternalValue('')
      }
      onClear?.()
    }

    return (
      <div
        className={cn(searchFieldVariants({ size, state, className }))}
        data-slot="search-field"
      >
        <span
          aria-hidden="true"
          className={cn(
            'size-4 shrink-0 [&_svg]:size-4',
            disabled ? 'text-icon-disabled' : 'text-icon-secondary',
          )}
        >
          <Search />
        </span>

        <input
          ref={ref}
          type="search"
          value={value}
          defaultValue={defaultValue}
          onChange={handleChange}
          disabled={disabled}
          placeholder={placeholder}
          className={cn(
            'text-text-primary placeholder:text-text-placeholder disabled:text-text-disabled w-full min-w-0 bg-transparent outline-none disabled:cursor-not-allowed [&::-webkit-search-cancel-button]:hidden',
          )}
          {...props}
        />

        {hasValue && !disabled ? (
          <button
            type="button"
            aria-label={clearLabel}
            onClick={handleClear}
            className="text-icon-secondary hover:text-text-primary focus-visible:ring-border-focus -m-1 inline-flex size-6 shrink-0 items-center justify-center rounded-sm outline-none focus-visible:ring-2 [&_svg]:size-4"
          >
            <X />
          </button>
        ) : null}
      </div>
    )
  },
)

SearchField.displayName = 'SearchField'

export { SearchField, searchFieldVariants }
