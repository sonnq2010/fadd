'use client'

import * as React from 'react'

import { Button } from '@/components/ui/button'
import { MenuItem } from '@/components/ui/menu-item'
import { cn } from '@/lib/utils'

type ActionSheetItem = {
  label: React.ReactNode
  icon?: React.ReactNode
  destructive?: boolean
  disabled?: boolean
  onClick?: () => void
}

type MobileActionSheetProps = Omit<React.ComponentProps<'div'>, 'children'> & {
  actions: readonly ActionSheetItem[]
  cancelLabel?: React.ReactNode
  onCancel?: () => void
}

function MobileActionSheet({
  actions,
  cancelLabel = 'Cancel',
  className,
  onCancel,
  ...props
}: MobileActionSheetProps) {
  return (
    <div
      className={cn(
        'bg-bg-primary flex w-[375px] flex-col items-center gap-3 overflow-hidden rounded-t-xl px-4 pt-3 pb-6 shadow-xl',
        className,
      )}
      data-slot="mobile-action-sheet"
      {...props}
    >
      {/* Handle */}
      <div
        aria-hidden="true"
        className="bg-border-strong h-1 w-9 shrink-0 rounded-full"
      />

      {/* Actions */}
      <div className="flex w-full flex-col">
        {actions.map((action, index) => (
          <MenuItem
            className="w-full"
            destructive={action.destructive}
            disabled={action.disabled}
            key={index}
            label={action.label}
            leadingIcon={action.icon}
            onClick={action.onClick}
          />
        ))}
      </div>

      {/* Cancel button */}
      <Button
        className="w-full"
        onClick={onCancel}
        size="large"
        variant="secondary"
      >
        {cancelLabel}
      </Button>
    </div>
  )
}

export { MobileActionSheet }
export type { ActionSheetItem, MobileActionSheetProps }
