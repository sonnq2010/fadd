import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { Slot } from 'radix-ui'

import { cn } from '@/lib/utils'

const buttonVariants = cva(
  'inline-flex shrink-0 items-center justify-center gap-2 rounded-md font-medium whitespace-nowrap transition-all outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:pointer-events-none disabled:bg-bg-disabled disabled:text-text-disabled disabled:border-border-disabled aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&_svg]:pointer-events-none [&_svg]:shrink-0',
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
        // Compatibility aliases with existing shadcn/legacy references
        default: 'bg-primary text-primary-foreground hover:bg-primary/90',
        link: 'text-primary underline-offset-4 hover:underline',
      },
      size: {
        large: 'h-12 px-5 py-3 text-base [&_svg]:size-4',
        medium: 'h-10 px-4 py-2 text-sm [&_svg]:size-4',
        small: 'h-9 px-3 py-1 text-xs [&_svg]:size-3.5',
        // Compatibility aliases
        default: 'h-10 px-4 py-2 text-sm [&_svg]:size-4',
        xs: 'h-6 gap-1 rounded-md px-2 text-xs [&_svg]:size-3',
        sm: 'h-9 px-3 py-1 text-xs [&_svg]:size-3.5',
        lg: 'h-12 px-5 py-3 text-base [&_svg]:size-4',
        icon: 'size-10',
        'icon-xs': 'size-6 rounded-md [&_svg]:size-3',
        'icon-sm': 'size-9',
        'icon-lg': 'size-12',
      },
    },
    defaultVariants: {
      variant: 'primary',
      size: 'medium',
    },
  },
)

function Button({
  className,
  variant = 'primary',
  size = 'medium',
  asChild = false,
  ...props
}: React.ComponentProps<'button'> &
  VariantProps<typeof buttonVariants> & {
    asChild?: boolean
  }) {
  const Comp = asChild ? Slot.Root : 'button'

  return (
    <Comp
      data-slot="button"
      data-variant={variant}
      data-size={size}
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
