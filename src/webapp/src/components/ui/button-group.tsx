import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'

import { cn } from '@/lib/utils'

const buttonGroupVariants = cva('flex w-full', {
  variants: {
    layout: {
      justify: 'items-center justify-between',
      start: 'items-center justify-start gap-3',
      end: 'items-center justify-end gap-3',
      center: 'items-center justify-center gap-3',
      stack: 'flex-col items-stretch gap-3',
    },
  },
  defaultVariants: {
    layout: 'justify',
  },
})

export interface ButtonGroupProps
  extends
    React.ComponentProps<'div'>,
    VariantProps<typeof buttonGroupVariants> {}

function ButtonGroup({
  className,
  layout = 'justify',
  ...props
}: ButtonGroupProps) {
  return (
    <div
      data-slot="button-group"
      data-layout={layout}
      className={cn(buttonGroupVariants({ layout, className }))}
      {...props}
    />
  )
}

export { ButtonGroup, buttonGroupVariants }
