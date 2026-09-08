import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { Slot } from 'radix-ui'

import { cn } from '@/lib/utils'

const badgeVariants = cva(
  'inline-flex w-fit shrink-0 items-center justify-center gap-1 overflow-hidden rounded-full border border-transparent px-2 py-1 text-xs font-medium whitespace-nowrap transition-colors outline-none focus-visible:ring-border-brand/45 focus-visible:ring-[3px] [&>svg]:pointer-events-none [&>svg]:size-3',
  {
    variants: {
      variant: {
        neutral: 'bg-bg-tertiary text-text-secondary',
        brand: 'bg-bg-brand-subtle text-text-brand',
        secondary:
          'bg-[#f5f3ff] text-[#7c3aed] dark:bg-[#2e1065] dark:text-[#c4b5fd]',
        success: 'bg-bg-success-subtle text-text-success',
        warning: 'bg-bg-warning-subtle text-text-warning',
        error: 'bg-bg-error-subtle text-text-error',
        info: 'bg-bg-info-subtle text-text-info',
        // Compatibility aliases for existing shadcn callers
        default: 'bg-bg-tertiary text-text-secondary',
        destructive: 'bg-bg-error-subtle text-text-error',
        outline: 'border-border-default text-text-primary',
        ghost: 'text-text-secondary hover:bg-bg-secondary-hover',
        link: 'text-text-brand underline-offset-4 hover:underline',
      },
    },
    defaultVariants: {
      variant: 'neutral',
    },
  },
)

function Badge({
  className,
  variant = 'neutral',
  asChild = false,
  ...props
}: React.ComponentProps<'span'> &
  VariantProps<typeof badgeVariants> & { asChild?: boolean }) {
  const Comp = asChild ? Slot.Root : 'span'

  return (
    <Comp
      data-slot="badge"
      data-variant={variant}
      className={cn(badgeVariants({ variant }), className)}
      {...props}
    />
  )
}

export { Badge, badgeVariants }
