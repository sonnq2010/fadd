import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { CircleAlert, CircleCheck, Info, TriangleAlert, X } from 'lucide-react'

import { cn } from '@/lib/utils'

const alertVariants = cva(
  'flex w-full items-center gap-2 rounded-lg p-3 text-sm transition-colors',
  {
    variants: {
      variant: {
        success: 'bg-bg-success-subtle text-text-primary',
        warning: 'bg-bg-warning-subtle text-text-primary',
        error: 'bg-bg-error-subtle text-text-primary',
        info: 'bg-bg-info-subtle text-text-primary',
        // Compatibility
        default: 'bg-bg-info-subtle text-text-primary',
        destructive: 'bg-bg-error-subtle text-text-primary',
      },
    },
    defaultVariants: {
      variant: 'info',
    },
  },
)

const variantIcons = {
  success: {
    icon: CircleCheck,
    className: 'text-text-success',
  },
  warning: {
    icon: TriangleAlert,
    className: 'text-text-warning',
  },
  error: {
    icon: CircleAlert,
    className: 'text-text-error',
  },
  info: {
    icon: Info,
    className: 'text-text-info',
  },
  default: {
    icon: Info,
    className: 'text-text-info',
  },
  destructive: {
    icon: CircleAlert,
    className: 'text-text-error',
  },
} as const

export interface AlertProps
  extends React.ComponentProps<'div'>, VariantProps<typeof alertVariants> {
  icon?: React.ReactNode
  showClose?: boolean
  onClose?: () => void
  closeAriaLabel?: string
}

function Alert({
  children,
  className,
  closeAriaLabel = 'Close alert',
  icon,
  onClose,
  showClose = true,
  variant = 'info',
  ...props
}: AlertProps) {
  const activeVariant = variant ?? 'info'
  const config = variantIcons[activeVariant] ?? variantIcons.info
  const DefaultIcon = config.icon

  return (
    <div
      data-slot="alert"
      data-variant={activeVariant}
      role="alert"
      className={cn(alertVariants({ variant: activeVariant }), className)}
      {...props}
    >
      <div
        className="flex size-5 shrink-0 items-center justify-center"
        data-slot="alert-icon"
      >
        {icon ?? <DefaultIcon className={cn('size-5', config.className)} />}
      </div>
      <div className="text-text-primary min-w-0 flex-1 leading-[21px] font-normal">
        {children}
      </div>
      {showClose && (
        <button
          aria-label={closeAriaLabel}
          className="text-text-secondary hover:text-text-primary flex size-4 shrink-0 cursor-pointer items-center justify-center transition-colors"
          data-slot="alert-close"
          onClick={onClose}
          type="button"
        >
          <X className="size-4" />
        </button>
      )}
    </div>
  )
}

function AlertTitle({ className, ...props }: React.ComponentProps<'div'>) {
  return (
    <div
      data-slot="alert-title"
      className={cn('font-medium tracking-tight', className)}
      {...props}
    />
  )
}

function AlertDescription({
  className,
  ...props
}: React.ComponentProps<'div'>) {
  return (
    <div
      data-slot="alert-description"
      className={cn('text-text-secondary text-sm', className)}
      {...props}
    />
  )
}

export { Alert, AlertTitle, AlertDescription, alertVariants }
