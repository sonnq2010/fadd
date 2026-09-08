import * as React from 'react'
import { Tooltip as TooltipPrimitive } from 'radix-ui'

import { cn } from '@/lib/utils'

function TooltipProvider({
  delayDuration = 0,
  ...props
}: React.ComponentProps<typeof TooltipPrimitive.Provider>) {
  return (
    <TooltipPrimitive.Provider
      data-slot="tooltip-provider"
      delayDuration={delayDuration}
      {...props}
    />
  )
}

function Tooltip({
  ...props
}: React.ComponentProps<typeof TooltipPrimitive.Root>) {
  return <TooltipPrimitive.Root data-slot="tooltip" {...props} />
}

function TooltipTrigger({
  ...props
}: React.ComponentProps<typeof TooltipPrimitive.Trigger>) {
  return <TooltipPrimitive.Trigger data-slot="tooltip-trigger" {...props} />
}

function TooltipContent({
  className,
  sideOffset = 4,
  children,
  ...props
}: React.ComponentProps<typeof TooltipPrimitive.Content>) {
  return (
    <TooltipPrimitive.Portal>
      <TooltipPrimitive.Content
        data-slot="tooltip-content"
        sideOffset={sideOffset}
        className={cn(
          'animate-in bg-bg-inverse text-text-inverse fade-in-0 zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=closed]:zoom-out-95 z-50 w-fit origin-(--radix-tooltip-content-transform-origin) rounded-sm px-2 py-1 text-[11px] leading-[17px] font-normal shadow-md',
          className,
        )}
        {...props}
      >
        {children}
        <TooltipPrimitive.Arrow className="fill-bg-inverse z-50 size-2.5 translate-y-[calc(-50%_-_2px)] rotate-45 rounded-[2px]" />
      </TooltipPrimitive.Content>
    </TooltipPrimitive.Portal>
  )
}

export type TooltipPosition = 'top' | 'bottom' | 'left' | 'right'

export interface TooltipBubbleProps extends React.ComponentProps<'div'> {
  label: string
  position?: TooltipPosition
}

function TooltipBubble({
  className,
  label,
  position = 'top',
  ...props
}: TooltipBubbleProps) {
  const isLeftOrRight = position === 'left' || position === 'right'

  const arrowSvg = (
    <svg
      className={cn(
        'text-bg-inverse shrink-0 fill-current',
        position === 'top' && 'h-[6px] w-[10px] rotate-180',
        position === 'bottom' && 'h-[6px] w-[10px]',
        position === 'left' && 'h-[10px] w-[6px] -rotate-90',
        position === 'right' && 'h-[10px] w-[6px] rotate-90',
      )}
      viewBox="0 0 10 6"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path d="M5 0L10 6H0L5 0Z" />
    </svg>
  )

  return (
    <div
      data-position={position}
      data-slot="tooltip-bubble"
      className={cn(
        'inline-flex items-center',
        isLeftOrRight ? 'flex-row' : 'flex-col',
        className,
      )}
      {...props}
    >
      {position === 'bottom' && arrowSvg}
      {position === 'right' && arrowSvg}
      <div className="bg-bg-inverse text-text-inverse rounded-sm px-2 py-1 text-[11px] leading-[17px] font-normal whitespace-nowrap">
        {label}
      </div>
      {position === 'top' && arrowSvg}
      {position === 'left' && arrowSvg}
    </div>
  )
}

export {
  Tooltip,
  TooltipTrigger,
  TooltipContent,
  TooltipProvider,
  TooltipBubble,
}
