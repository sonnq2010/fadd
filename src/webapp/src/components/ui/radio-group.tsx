'use client'

import * as React from 'react'
import { RadioGroup as RadioGroupPrimitive } from 'radix-ui'

import { cn } from '@/lib/utils'

function RadioGroup({
  className,
  ...props
}: React.ComponentProps<typeof RadioGroupPrimitive.Root>) {
  return (
    <RadioGroupPrimitive.Root
      data-slot="radio-group"
      className={cn('grid gap-3', className)}
      {...props}
    />
  )
}

export interface RadioGroupItemProps extends React.ComponentProps<
  typeof RadioGroupPrimitive.Item
> {
  label?: string
}

function RadioGroupItem({
  className,
  id,
  label,
  disabled,
  ...props
}: RadioGroupItemProps) {
  const generatedId = React.useId()
  const itemId = id ?? (label ? generatedId : undefined)

  const control = (
    <RadioGroupPrimitive.Item
      id={itemId}
      data-slot="radio-group-item"
      disabled={disabled}
      className={cn(
        'peer bg-bg-primary inline-flex size-5 shrink-0 items-center justify-center rounded-full border-[1.5px] border-solid transition-all outline-none',
        'border-border-default hover:border-border-brand focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
        'data-[state=checked]:border-border-brand',
        'disabled:border-border-disabled disabled:bg-bg-primary disabled:cursor-not-allowed',
        className,
      )}
      {...props}
    >
      <RadioGroupPrimitive.Indicator
        data-slot="radio-group-indicator"
        className="flex items-center justify-center"
      >
        <span
          className={cn(
            'size-2.5 rounded-full',
            disabled ? 'bg-icon-disabled' : 'bg-bg-brand',
          )}
        />
      </RadioGroupPrimitive.Indicator>
    </RadioGroupPrimitive.Item>
  )

  if (!label) {
    return control
  }

  return (
    <div className="inline-flex items-center gap-2">
      {control}
      <label
        htmlFor={itemId}
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

export { RadioGroup, RadioGroupItem }
