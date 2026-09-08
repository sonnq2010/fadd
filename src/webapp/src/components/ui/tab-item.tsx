'use client'

import * as React from 'react'

import { cn } from '@/lib/utils'

type TabItemProps = Omit<React.ComponentProps<'button'>, 'children'> & {
  label: React.ReactNode
  isActive?: boolean
}

function TabItem({
  className,
  disabled = false,
  isActive = false,
  label,
  type = 'button',
  ...props
}: TabItemProps) {
  return (
    <button
      aria-selected={isActive}
      className={cn(
        'inline-flex shrink-0 flex-col items-center bg-transparent px-3 pt-2 text-sm leading-5 font-medium whitespace-nowrap transition-colors outline-none',
        'focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
        disabled
          ? 'text-text-disabled cursor-not-allowed'
          : isActive
            ? 'text-text-brand'
            : 'text-text-secondary hover:text-text-primary',
        className,
      )}
      data-slot="tab-item"
      disabled={disabled}
      role="tab"
      type={type}
      {...props}
    >
      <span>{label}</span>
      <span
        aria-hidden="true"
        className={cn(
          'mt-2 h-[2px] w-full',
          isActive ? 'bg-border-brand' : 'bg-transparent',
        )}
      />
    </button>
  )
}

type TabsNavProps = Omit<React.ComponentProps<'div'>, 'children'> & {
  tabs: readonly string[]
  selectedIndex: number
  onTabSelected?: (index: number) => void
}

function TabsNav({
  className,
  onTabSelected,
  selectedIndex,
  tabs,
  ...props
}: TabsNavProps) {
  return (
    <div
      className={cn('flex w-fit min-w-max items-end', className)}
      data-slot="tabs-nav"
      role="tablist"
      {...props}
    >
      {tabs.map((tab, index) => (
        <TabItem
          isActive={selectedIndex === index}
          key={`${tab}-${index}`}
          label={tab}
          onClick={() => onTabSelected?.(index)}
        />
      ))}
    </div>
  )
}

export { TabItem, TabsNav }
export type { TabItemProps, TabsNavProps }
