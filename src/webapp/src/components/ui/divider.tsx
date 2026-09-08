import * as React from 'react'

import { cn } from '@/lib/utils'

export type DividerOrientation = 'horizontal' | 'vertical'

export interface DividerProps extends React.ComponentProps<'div'> {
  orientation?: DividerOrientation
  label?: React.ReactNode
}

function Divider({
  className,
  label,
  orientation = 'horizontal',
  ...props
}: DividerProps) {
  if (orientation === 'vertical') {
    return (
      <div
        aria-orientation="vertical"
        className={cn('bg-border-subtle h-full w-px shrink-0', className)}
        data-orientation="vertical"
        data-slot="divider"
        role="separator"
        {...props}
      />
    )
  }

  if (label != null) {
    return (
      <div
        aria-orientation="horizontal"
        className={cn(
          'flex w-full items-center gap-2 text-center text-xs',
          className,
        )}
        data-orientation="horizontal"
        data-slot="divider"
        role="separator"
        {...props}
      >
        <div className="bg-border-subtle h-px flex-1" />
        <span className="text-text-tertiary text-[11px] leading-[17px] font-normal whitespace-nowrap">
          {label}
        </span>
        <div className="bg-border-subtle h-px flex-1" />
      </div>
    )
  }

  return (
    <div
      aria-orientation="horizontal"
      className={cn('bg-border-subtle h-px w-full shrink-0', className)}
      data-orientation="horizontal"
      data-slot="divider"
      role="separator"
      {...props}
    />
  )
}

export { Divider }
