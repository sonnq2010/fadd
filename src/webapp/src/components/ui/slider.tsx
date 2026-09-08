'use client'

import * as React from 'react'
import { Slider as SliderPrimitive } from 'radix-ui'

import { cn } from '@/lib/utils'

function Slider({
  className,
  defaultValue,
  value,
  min = 0,
  max = 100,
  disabled,
  ...props
}: React.ComponentProps<typeof SliderPrimitive.Root>) {
  const _values = React.useMemo(
    () =>
      Array.isArray(value)
        ? value
        : Array.isArray(defaultValue)
          ? defaultValue
          : [min, max],
    [value, defaultValue, min, max],
  )

  return (
    <SliderPrimitive.Root
      data-slot="slider"
      defaultValue={defaultValue}
      value={value}
      min={min}
      max={max}
      disabled={disabled}
      className={cn(
        'relative flex w-full touch-none items-center select-none data-[orientation=horizontal]:h-[18px]',
        disabled && 'cursor-not-allowed opacity-60',
        className,
      )}
      {...props}
    >
      <SliderPrimitive.Track
        data-slot="slider-track"
        className={cn(
          'relative h-1 w-full grow overflow-hidden rounded-xs',
          disabled ? 'bg-bg-secondary' : 'bg-border-strong',
        )}
      >
        <SliderPrimitive.Range
          data-slot="slider-range"
          className={cn(
            'absolute h-full',
            disabled ? 'bg-bg-secondary' : 'bg-bg-brand',
          )}
        />
      </SliderPrimitive.Track>
      {Array.from({ length: _values.length }, (_, index) => (
        <SliderPrimitive.Thumb
          data-slot="slider-thumb"
          key={index}
          className={cn(
            'block size-4 shrink-0 rounded-full border-2 bg-white transition-colors outline-none',
            'focus-visible:ring-border-brand/45 focus-visible:ring-[3px]',
            disabled
              ? 'border-border-default cursor-not-allowed'
              : 'border-bg-brand hover:border-bg-brand-hover cursor-pointer',
          )}
        />
      ))}
    </SliderPrimitive.Root>
  )
}

export { Slider }
