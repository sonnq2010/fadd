'use client'

import * as React from 'react'
import { clsx } from 'clsx'
import { Switch as SwitchPrimitive } from 'radix-ui'

import { cn } from '@/lib/utils'

export interface SwitchProps extends React.ComponentProps<
  typeof SwitchPrimitive.Root
> {
  label?: string
}

function Switch({ className, id, label, disabled, ...props }: SwitchProps) {
  const generatedId = React.useId()
  const switchId = id ?? (label ? generatedId : undefined)

  const control = (
    <SwitchPrimitive.Root
      id={switchId}
      data-slot="switch"
      disabled={disabled}
      className={cn(
        'peer inline-flex h-[22px] w-10 shrink-0 cursor-pointer items-center rounded-full p-[2px] transition-colors outline-none',
        'focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
        'data-[state=unchecked]:bg-border-strong data-[state=unchecked]:hover:bg-border-strong',
        'data-[state=checked]:bg-bg-brand data-[state=checked]:hover:bg-bg-brand-hover',
        'disabled:bg-bg-disabled data-[state=checked]:disabled:bg-bg-disabled disabled:cursor-not-allowed',
        className,
      )}
      {...props}
    >
      <SwitchPrimitive.Thumb
        data-slot="switch-thumb"
        className={cn(
          'bg-icon-on-brand pointer-events-none block size-[18px] rounded-full shadow-xs transition-transform duration-200',
          'data-[state=checked]:translate-x-[18px] data-[state=unchecked]:translate-x-0',
        )}
      />
    </SwitchPrimitive.Root>
  )

  if (!label) {
    return control
  }

  return (
    <div className="inline-flex items-center gap-2">
      {control}
      <label
        htmlFor={switchId}
        className={clsx(
          'text-body-small select-none',
          disabled
            ? 'text-text-disabled cursor-not-allowed'
            : 'text-text-primary cursor-pointer',
        )}
      >
        {label}
      </label>
    </div>
  )
}

export { Switch }
