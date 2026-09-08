import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { Slot } from 'radix-ui'

import { cn } from '@/lib/utils'

const iconButtonVariants = cva(
  'inline-flex shrink-0 items-center justify-center rounded-md font-medium transition-all outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:pointer-events-none disabled:bg-bg-disabled disabled:text-text-disabled disabled:border-border-disabled aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&_svg]:pointer-events-none [&_svg]:shrink-0',
  {
    variants: {
      variant: {
        primary:
          'bg-bg-brand text-text-on-brand hover:bg-bg-brand-hover shadow-xs active:bg-bg-brand-pressed',
        secondary:
          'bg-bg-secondary text-text-primary border-[1.5px] border-border hover:bg-bg-secondary-hover shadow-xs',
        outline:
          'border-[1.5px] border-border-brand text-text-brand hover:bg-bg-brand-subtle bg-transparent shadow-xs',
        ghost: 'text-text-primary hover:bg-bg-secondary-hover bg-transparent',
        destructive:
          'bg-bg-error text-text-on-brand hover:bg-bg-error-hover shadow-xs active:bg-bg-error-pressed',
        destructiveOutline:
          'border-[1.5px] border-border-error text-text-error hover:bg-bg-error-subtle bg-transparent shadow-xs',
      },
      size: {
        large: 'size-12 rounded-md [&_svg]:size-6',
        medium: 'size-10 rounded-md [&_svg]:size-5',
        small: 'size-9 rounded-md [&_svg]:size-4',
      },
    },
    defaultVariants: {
      variant: 'primary',
      size: 'medium',
    },
  },
)

export interface IconButtonProps
  extends
    React.ComponentProps<'button'>,
    VariantProps<typeof iconButtonVariants> {
  asChild?: boolean
}

function IconButton({
  className,
  variant = 'primary',
  size = 'medium',
  asChild = false,
  ...props
}: IconButtonProps) {
  const Comp = asChild ? Slot.Root : 'button'

  return (
    <Comp
      data-slot="icon-button"
      data-variant={variant}
      data-size={size}
      className={cn(iconButtonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { IconButton, iconButtonVariants }
