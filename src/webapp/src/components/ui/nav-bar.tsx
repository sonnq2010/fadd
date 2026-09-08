'use client'

import * as React from 'react'

import { TabsNav } from '@/components/ui/tab-item'
import { cn } from '@/lib/utils'

type NavBarProps = Omit<React.ComponentProps<'header'>, 'children'> & {
  brand: React.ReactNode
  tabs?: readonly string[]
  selectedTabIndex?: number
  onTabSelected?: (index: number) => void
  actions?: React.ReactNode
}

function NavBar({
  actions,
  brand,
  className,
  onTabSelected,
  selectedTabIndex = 0,
  tabs = [],
  ...props
}: NavBarProps) {
  return (
    <header
      className={cn(
        'bg-bg-primary border-border-subtle flex w-full items-center justify-between border-b px-6 py-3',
        className,
      )}
      data-slot="nav-bar"
      {...props}
    >
      <div className="flex min-w-0 items-center gap-6 overflow-x-auto">
        <div className="text-text-primary shrink-0 text-lg font-bold whitespace-nowrap">
          {brand}
        </div>
        {tabs.length > 0 && (
          <TabsNav
            onTabSelected={onTabSelected}
            selectedIndex={selectedTabIndex}
            tabs={tabs}
          />
        )}
      </div>

      {actions && (
        <div className="ml-4 flex shrink-0 items-center gap-4">{actions}</div>
      )}
    </header>
  )
}

export { NavBar }
export type { NavBarProps }
