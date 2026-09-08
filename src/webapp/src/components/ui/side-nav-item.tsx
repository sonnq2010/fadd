'use client'

import * as React from 'react'

import { cn } from '@/lib/utils'

type SideNavItemProps = Omit<React.ComponentProps<'button'>, 'children'> & {
  label: React.ReactNode
  icon?: React.ReactNode
  isActive?: boolean
}

function SideNavItem({
  className,
  disabled = false,
  icon,
  isActive = false,
  label,
  type = 'button',
  ...props
}: SideNavItemProps) {
  return (
    <button
      aria-current={isActive ? 'page' : undefined}
      className={cn(
        'flex w-[200px] items-center gap-2 rounded-xs px-3 py-2 text-left text-base leading-6 transition-colors outline-none select-none',
        'focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
        disabled
          ? 'text-text-disabled [&_svg]:text-text-disabled cursor-not-allowed bg-transparent'
          : isActive
            ? 'bg-bg-selected text-text-brand [&_svg]:text-text-brand font-medium'
            : 'hover:bg-bg-secondary-hover text-text-secondary hover:text-text-primary [&_svg]:text-text-secondary hover:[&_svg]:text-text-primary bg-transparent',
        className,
      )}
      data-slot="side-nav-item"
      disabled={disabled}
      type={type}
      {...props}
    >
      {icon && (
        <span className="flex size-[18px] shrink-0 items-center justify-center [&_svg]:size-[18px]">
          {icon}
        </span>
      )}
      <span className="min-w-0 flex-1 truncate">{label}</span>
    </button>
  )
}

export { SideNavItem }
export type { SideNavItemProps }
