import * as React from 'react'
import { X } from 'lucide-react'

import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import { ButtonGroup } from '@/components/ui/button-group'
import { IconButton } from '@/components/ui/icon-button'
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog'

export interface ModalCardProps extends Omit<
  React.ComponentProps<'div'>,
  'title'
> {
  title: React.ReactNode
  description?: React.ReactNode
  cancelLabel?: string
  confirmLabel?: string
  confirmVariant?: 'destructive' | 'primary'
  onClose?: () => void
  onCancel?: () => void
  onConfirm?: () => void
  footer?: React.ReactNode
}

function ModalCard({
  cancelLabel = 'Cancel',
  children,
  className,
  confirmLabel = 'Delete',
  confirmVariant = 'destructive',
  description,
  footer,
  onCancel,
  onClose,
  onConfirm,
  title,
  ...props
}: ModalCardProps) {
  return (
    <div
      data-slot="modal-card"
      className={cn(
        'bg-bg-primary border-border-subtle flex w-full max-w-[400px] flex-col rounded-xl border shadow-xl',
        className,
      )}
      {...props}
    >
      {/* Header */}
      <div className="flex items-center justify-between pt-4 pr-3 pl-5">
        <h3 className="text-text-primary text-2xl leading-8 font-semibold">
          {title}
        </h3>
        {onClose && (
          <IconButton
            aria-label="Close modal"
            onClick={onClose}
            size="small"
            variant="ghost"
          >
            <X className="size-4" />
          </IconButton>
        )}
      </div>

      {/* Body */}
      <div className="px-5 pt-2 pb-5">
        {description && (
          <p className="text-text-secondary text-base leading-6 font-normal">
            {description}
          </p>
        )}
        {children}
      </div>

      {/* Footer */}
      <div className="border-border-subtle border-t px-5 pt-3 pb-4">
        {footer ?? (
          <ButtonGroup layout="justify">
            <Button onClick={onCancel} size="small" variant="secondary">
              {cancelLabel}
            </Button>
            <Button onClick={onConfirm} size="small" variant={confirmVariant}>
              {confirmLabel}
            </Button>
          </ButtonGroup>
        )}
      </div>
    </div>
  )
}

export interface ModalProps {
  open?: boolean
  onOpenChange?: (open: boolean) => void
  trigger?: React.ReactNode
  children?: React.ReactNode
}

function Modal({ children, onOpenChange, open, trigger }: ModalProps) {
  return (
    <Dialog onOpenChange={onOpenChange} open={open}>
      {trigger && <DialogTrigger asChild>{trigger}</DialogTrigger>}
      <DialogContent
        className="max-w-[400px] border-0 p-0 shadow-none sm:max-w-[400px]"
        showCloseButton={false}
      >
        {children}
      </DialogContent>
    </Dialog>
  )
}

export { Modal, ModalCard }
