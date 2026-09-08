import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { Slot } from 'radix-ui'

import { cn } from '@/lib/utils'

const fabVariants = cva(
  'inline-flex shrink-0 items-center justify-center rounded-full font-medium transition-all outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:pointer-events-none disabled:bg-bg-disabled disabled:text-text-disabled disabled:shadow-none aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&_svg]:pointer-events-none [&_svg]:shrink-0',
  {
    variants: {
      variant: {
        primary:
          'bg-bg-brand text-text-on-brand hover:bg-bg-brand-hover shadow-lg active:bg-bg-brand-pressed',
      },
      size: {
        large: 'size-[72px] [&_svg]:size-7',
        medium: 'size-14 [&_svg]:size-6',
        small: 'size-10 [&_svg]:size-5',
      },
    },
    defaultVariants: {
      variant: 'primary',
      size: 'medium',
    },
  },
)

export interface FabProps
  extends React.ComponentProps<'button'>, VariantProps<typeof fabVariants> {
  asChild?: boolean
}

function Fab({
  className,
  variant = 'primary',
  size = 'medium',
  asChild = false,
  ...props
}: FabProps) {
  const Comp = asChild ? Slot.Root : 'button'

  return (
    <Comp
      data-slot="fab"
      data-variant={variant}
      data-size={size}
      className={cn(fabVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Fab, fabVariants }
