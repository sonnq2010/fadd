import * as React from 'react'

import { cn } from '@/lib/utils'

export type ProgressBarState = 'default' | 'success' | 'error'

export interface ProgressBarProps extends React.ComponentProps<'div'> {
  value: number // 0 to 100
  state?: ProgressBarState
  label?: React.ReactNode
  showLabel?: boolean
  showPercentage?: boolean
}

function ProgressBar({
  className,
  label,
  showLabel = true,
  showPercentage = true,
  state = 'default',
  value,
  ...props
}: ProgressBarProps) {
  const clampedValue = Math.min(100, Math.max(0, value))

  return (
    <div
      aria-valuemax={100}
      aria-valuemin={0}
      aria-valuenow={clampedValue}
      className={cn('flex w-full max-w-[280px] flex-col gap-1', className)}
      data-slot="progress-bar"
      data-state={state}
      role="progressbar"
      {...props}
    >
      {showLabel && (label != null || showPercentage) && (
        <div className="text-text-secondary flex items-center justify-between text-[11px] leading-[17px] font-normal">
          {label ? <span>{label}</span> : <span />}
          {showPercentage && <span>{Math.round(clampedValue)}%</span>}
        </div>
      )}
      <div className="bg-bg-tertiary h-2 w-full overflow-hidden rounded-full">
        <div
          className={cn(
            'h-full rounded-full transition-all duration-300',
            state === 'default' && 'bg-bg-brand',
            state === 'success' && 'bg-bg-success',
            state === 'error' && 'bg-bg-error',
          )}
          style={{ width: `${clampedValue}%` }}
        />
      </div>
    </div>
  )
}

export { ProgressBar }
