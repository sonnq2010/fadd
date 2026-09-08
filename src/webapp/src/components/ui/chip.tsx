import { Check, X } from 'lucide-react'
import * as React from 'react'

import { cn } from '@/lib/utils'

export interface ChipProps extends React.ComponentProps<'button'> {
  selected?: boolean
  onRemove?: (e: React.MouseEvent) => void
  removeAriaLabel?: string
}

function Chip({
  children,
  className,
  disabled = false,
  onClick,
  onRemove,
  removeAriaLabel = 'Remove',
  selected = false,
  ...props
}: ChipProps) {
  const handleRemove = (e: React.MouseEvent) => {
    e.stopPropagation()
    onRemove?.(e)
  }

  return (
    <button
      aria-pressed={selected}
      className={cn(
        'inline-flex items-center gap-1 rounded-full px-2 py-1 text-xs font-medium transition-colors',
        disabled
          ? 'bg-bg-disabled text-text-disabled border-border-disabled cursor-not-allowed border'
          : selected
            ? 'bg-bg-brand text-text-on-brand cursor-pointer border-transparent'
            : 'bg-bg-primary text-text-primary border-border-default hover:bg-bg-secondary-hover cursor-pointer border',
        className,
      )}
      data-disabled={disabled ? '' : undefined}
      data-selected={selected ? '' : undefined}
      data-slot="chip"
      disabled={disabled}
      onClick={disabled ? undefined : onClick}
      type="button"
      {...props}
    >
      {selected && (
        <Check className="size-3.5 shrink-0" data-slot="chip-check" />
      )}
      <span className="leading-4">{children}</span>
      {onRemove && (
        <span
          aria-label={removeAriaLabel}
          className={cn(
            'flex size-3.5 items-center justify-center rounded-full p-0.5 transition-colors',
            disabled
              ? 'cursor-not-allowed'
              : selected
                ? 'hover:bg-bg-brand-hover/30 cursor-pointer'
                : 'hover:bg-bg-tertiary cursor-pointer',
          )}
          data-slot="chip-remove"
          onClick={disabled ? undefined : handleRemove}
          role="button"
          tabIndex={disabled ? -1 : 0}
        >
          <X className="size-3" />
        </span>
      )}
    </button>
  )
}

export { Chip }
