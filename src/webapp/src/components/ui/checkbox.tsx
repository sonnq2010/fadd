'use client'

import * as React from 'react'
import { Check, Minus } from 'lucide-react'
import { Checkbox as CheckboxPrimitive } from 'radix-ui'

import { cn } from '@/lib/utils'

export interface CheckboxProps extends React.ComponentProps<
  typeof CheckboxPrimitive.Root
> {
  label?: string
}

function Checkbox({
  className,
  id,
  label,
  checked,
  disabled,
  ...props
}: CheckboxProps) {
  const generatedId = React.useId()
  const checkboxId = id ?? (label ? generatedId : undefined)

  const control = (
    <CheckboxPrimitive.Root
      id={checkboxId}
      data-slot="checkbox"
      checked={checked}
      disabled={disabled}
      className={cn(
        'peer inline-flex size-5 shrink-0 items-center justify-center rounded-xs border-[1.5px] border-solid transition-all outline-none',
        'border-border-default bg-bg-primary hover:border-border-brand focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
        'data-[state=checked]:border-bg-brand data-[state=checked]:bg-bg-brand data-[state=checked]:text-text-on-brand data-[state=checked]:hover:bg-bg-brand-hover',
        'data-[state=indeterminate]:border-bg-brand data-[state=indeterminate]:bg-bg-brand data-[state=indeterminate]:text-text-on-brand data-[state=indeterminate]:hover:bg-bg-brand-hover',
        'disabled:border-border-disabled disabled:bg-bg-disabled disabled:text-text-disabled data-[state=checked]:disabled:bg-bg-disabled data-[state=checked]:disabled:text-text-disabled data-[state=indeterminate]:disabled:bg-bg-disabled data-[state=indeterminate]:disabled:text-text-disabled disabled:cursor-not-allowed',
        className,
      )}
      {...props}
    >
      <CheckboxPrimitive.Indicator
        data-slot="checkbox-indicator"
        className="flex items-center justify-center text-current transition-none"
      >
        {checked === 'indeterminate' ? (
          <Minus className="size-3.5 stroke-[2.5]" />
        ) : (
          <Check className="size-3.5 stroke-[2.5]" />
        )}
      </CheckboxPrimitive.Indicator>
    </CheckboxPrimitive.Root>
  )

  if (!label) {
    return control
  }

  return (
    <div className="inline-flex items-center gap-2">
      {control}
      <label
        htmlFor={checkboxId}
        className={cn(
          'text-base font-normal select-none md:text-sm',
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

export { Checkbox }
