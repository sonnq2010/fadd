'use client'

import * as React from 'react'

import { cn } from '@/lib/utils'

type MobileTopAppBarProps = Omit<React.ComponentProps<'header'>, 'children'> & {
  title: React.ReactNode
  leading?: React.ReactNode
  trailing?: React.ReactNode
}

function MobileTopAppBar({
  className,
  leading,
  title,
  trailing,
  ...props
}: MobileTopAppBarProps) {
  return (
    <header
      className={cn(
        'bg-bg-primary border-border-subtle flex h-14 w-[375px] items-center justify-between border-b p-2',
        className,
      )}
      data-slot="mobile-top-app-bar"
      {...props}
    >
      <div className="flex size-10 shrink-0 items-center justify-center">
        {leading}
      </div>
      <h2 className="text-text-primary min-w-0 flex-1 truncate text-center text-xl leading-[30px] font-semibold">
        {title}
      </h2>
      <div className="flex size-10 shrink-0 items-center justify-center">
        {trailing}
      </div>
    </header>
  )
}

export { MobileTopAppBar }
export type { MobileTopAppBarProps }
