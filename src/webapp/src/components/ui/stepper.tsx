import * as React from 'react'
import { Check } from 'lucide-react'

import { cn } from '@/lib/utils'

export type StepperState = 'upcoming' | 'active' | 'completed'

export interface StepperItemProps extends React.ComponentProps<'div'> {
  label: React.ReactNode
  number?: React.ReactNode
  state?: StepperState
}

function StepperItem({
  className,
  label,
  number = '1',
  state = 'upcoming',
  ...props
}: StepperItemProps) {
  const isCompleted = state === 'completed'
  const isActive = state === 'active'

  return (
    <div
      data-slot="stepper-item"
      data-state={state}
      className={cn('inline-flex items-center gap-2', className)}
      {...props}
    >
      <div
        className={cn(
          'flex size-7 shrink-0 items-center justify-center rounded-full text-sm leading-[19px] font-medium',
          isCompleted && 'bg-bg-brand text-text-on-brand',
          isActive && 'border-border-brand text-text-primary border-[1.5px]',
          state === 'upcoming' &&
            'border-border-default text-text-disabled border-[1.5px]',
        )}
      >
        {isCompleted ? <Check className="size-3.5" /> : number}
      </div>
      <span
        className={cn(
          'text-sm leading-[19px] font-medium whitespace-nowrap',
          isCompleted && 'text-text-secondary',
          isActive && 'text-text-primary',
          state === 'upcoming' && 'text-text-disabled',
        )}
      >
        {label}
      </span>
    </div>
  )
}

export interface StepData {
  label: React.ReactNode
  state: StepperState
  number?: React.ReactNode
}

export interface StepperProps extends React.ComponentProps<'div'> {
  steps: StepData[]
}

function Stepper({ className, steps, ...props }: StepperProps) {
  return (
    <div
      data-slot="stepper"
      className={cn('flex items-center gap-2 overflow-x-auto', className)}
      {...props}
    >
      {steps.map((step, idx) => {
        const isPrevCompleted = idx > 0 && steps[idx - 1]?.state === 'completed'

        return (
          <React.Fragment key={idx}>
            {idx > 0 && (
              <div
                className={cn(
                  'h-[1.5px] w-8 shrink-0',
                  isPrevCompleted ? 'bg-border-brand' : 'bg-border-default',
                )}
              />
            )}
            <StepperItem
              label={step.label}
              number={step.number ?? `${idx + 1}`}
              state={step.state}
            />
          </React.Fragment>
        )
      })}
    </div>
  )
}

export { Stepper, StepperItem }
