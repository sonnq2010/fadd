'use client'

import * as React from 'react'
import { clsx } from 'clsx'
import { Check } from 'lucide-react'

import { cn } from '@/lib/utils'

export interface MenuItemProps extends React.ComponentProps<'div'> {
  label: React.ReactNode
  leadingIcon?: React.ReactNode
  shortcut?: string
  selected?: boolean
  disabled?: boolean
  destructive?: boolean
}

function MenuItem({
  className,
  label,
  leadingIcon,
  shortcut,
  selected = false,
  disabled = false,
  destructive = false,
  onClick,
  ...props
}: MenuItemProps) {
  let contentLeading = leadingIcon
  if (!contentLeading && selected) {
    contentLeading = <Check className="text-text-brand size-4 shrink-0" />
  }

  return (
    <div
      role="menuitem"
      aria-selected={selected}
      aria-disabled={disabled}
      onClick={disabled ? undefined : onClick}
      className={clsx(
        'text-body-medium flex w-full cursor-pointer items-center gap-2 rounded-sm px-3 py-2 transition-colors select-none',
        selected && 'bg-bg-selected text-text-brand',
        !selected &&
          !destructive &&
          !disabled &&
          'text-text-primary hover:bg-bg-secondary-hover',
        destructive &&
          !disabled &&
          'text-text-error hover:bg-bg-error-subtle hover:text-text-error',
        disabled && 'text-text-disabled pointer-events-none cursor-not-allowed',
        className,
      )}
      {...props}
    >
      {contentLeading && (
        <span className="flex size-4 shrink-0 items-center justify-center">
          {contentLeading}
        </span>
      )}
      <span className="flex-1 truncate">{label}</span>
      {shortcut && (
        <span
          className={cn(
            'ml-auto text-xs font-normal',
            disabled ? 'text-text-disabled' : 'text-text-tertiary',
          )}
        >
          {shortcut}
        </span>
      )}
    </div>
  )
}

function Menu({ className, children, ...props }: React.ComponentProps<'div'>) {
  return (
    <div
      role="menu"
      className={cn(
        'border-border-subtle bg-bg-primary flex w-[220px] flex-col rounded-md border p-1 shadow-md',
        className,
      )}
      {...props}
    >
      {children}
    </div>
  )
}

function MenuDivider({ className, ...props }: React.ComponentProps<'div'>) {
  return (
    <div
      role="separator"
      className={cn('bg-border-subtle my-1 h-px w-full', className)}
      {...props}
    />
  )
}

export { MenuItem, Menu, MenuDivider }
