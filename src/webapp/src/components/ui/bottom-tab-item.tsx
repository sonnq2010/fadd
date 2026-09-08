'use client'

import * as React from 'react'

import { cn } from '@/lib/utils'

type MobileBottomTabItemProps = Omit<
  React.ComponentProps<'button'>,
  'children'
> & {
  label: React.ReactNode
  icon?: React.ReactNode
  isActive?: boolean
}

function MobileBottomTabItem({
  className,
  disabled = false,
  icon,
  isActive = false,
  label,
  type = 'button',
  ...props
}: MobileBottomTabItemProps) {
  return (
    <button
      aria-selected={isActive}
      className={cn(
        'flex flex-1 flex-col items-center gap-1 bg-transparent text-center transition-colors outline-none select-none',
        'focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
        isActive
          ? 'text-text-brand [&_svg]:text-text-brand'
          : 'text-text-tertiary hover:text-text-secondary [&_svg]:text-text-tertiary hover:[&_svg]:text-text-secondary',
        disabled && 'cursor-not-allowed opacity-50',
        className,
      )}
      data-slot="bottom-tab-item"
      disabled={disabled}
      role="tab"
      type={type}
      {...props}
    >
      {icon && (
        <span className="flex size-[22px] shrink-0 items-center justify-center [&_svg]:size-[22px]">
          {icon}
        </span>
      )}
      <span className="text-[11px] leading-[17px] font-normal tracking-normal whitespace-nowrap">
        {label}
      </span>
    </button>
  )
}

type BottomTabItemData = {
  label: React.ReactNode
  icon?: React.ReactNode
}

type MobileBottomTabBarProps = Omit<React.ComponentProps<'nav'>, 'children'> & {
  items: readonly BottomTabItemData[]
  selectedIndex?: number
  onTabSelected?: (index: number) => void
}

function MobileBottomTabBar({
  className,
  items,
  onTabSelected,
  selectedIndex = 0,
  ...props
}: MobileBottomTabBarProps) {
  return (
    <nav
      aria-label="Bottom Navigation"
      className={cn(
        'bg-bg-primary border-border-subtle flex w-[375px] items-center gap-3 border-t px-4 pt-2 pb-6',
        className,
      )}
      data-slot="bottom-tab-bar"
      role="tablist"
      {...props}
    >
      {items.map((item, index) => (
        <MobileBottomTabItem
          icon={item.icon}
          isActive={selectedIndex === index}
          key={index}
          label={item.label}
          onClick={() => onTabSelected?.(index)}
        />
      ))}
    </nav>
  )
}

export { MobileBottomTabBar, MobileBottomTabItem }
export type {
  BottomTabItemData,
  MobileBottomTabBarProps,
  MobileBottomTabItemProps,
}
