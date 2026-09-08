import * as React from 'react'
import { ChevronLeft, ChevronRight } from 'lucide-react'

import { cn } from '@/lib/utils'

function Pagination({ className, ...props }: React.ComponentProps<'nav'>) {
  return (
    <nav
      aria-label="pagination"
      className={cn('flex w-full items-center justify-center', className)}
      data-slot="pagination"
      role="navigation"
      {...props}
    />
  )
}

function PaginationContent({
  className,
  ...props
}: React.ComponentProps<'ul'>) {
  return (
    <ul
      className={cn('flex flex-row items-center gap-1', className)}
      data-slot="pagination-content"
      {...props}
    />
  )
}

function PaginationItem({ ...props }: React.ComponentProps<'li'>) {
  return <li data-slot="pagination-item" {...props} />
}

export interface PaginationLinkProps extends React.ComponentProps<'a'> {
  isActive?: boolean
  disabled?: boolean
}

function PaginationLink({
  className,
  disabled,
  isActive,
  ...props
}: PaginationLinkProps) {
  return (
    <a
      aria-current={isActive ? 'page' : undefined}
      aria-disabled={disabled ? 'true' : undefined}
      className={cn(
        'flex size-8 shrink-0 cursor-pointer items-center justify-center rounded-sm text-sm leading-[19px] font-medium transition-colors outline-none',
        isActive
          ? 'bg-bg-brand text-text-on-brand'
          : disabled
            ? 'text-text-disabled pointer-events-none'
            : 'text-text-primary hover:bg-bg-secondary-hover',
        className,
      )}
      data-active={isActive ? 'true' : undefined}
      data-slot="pagination-link"
      {...props}
    />
  )
}

function PaginationPrevious({
  className,
  ...props
}: React.ComponentProps<typeof PaginationLink>) {
  return (
    <PaginationLink
      aria-label="Go to previous page"
      className={cn(
        'text-text-primary hover:bg-bg-secondary-hover size-8',
        className,
      )}
      {...props}
    >
      <ChevronLeft className="size-5" />
    </PaginationLink>
  )
}

function PaginationNext({
  className,
  ...props
}: React.ComponentProps<typeof PaginationLink>) {
  return (
    <PaginationLink
      aria-label="Go to next page"
      className={cn(
        'text-text-primary hover:bg-bg-secondary-hover size-8',
        className,
      )}
      {...props}
    >
      <ChevronRight className="size-5" />
    </PaginationLink>
  )
}

function PaginationEllipsis({
  className,
  ...props
}: React.ComponentProps<'span'>) {
  return (
    <span
      aria-hidden="true"
      className={cn(
        'text-text-tertiary flex size-8 items-center justify-center text-sm font-medium select-none',
        className,
      )}
      data-slot="pagination-ellipsis"
      {...props}
    >
      ...
    </span>
  )
}

export {
  Pagination,
  PaginationContent,
  PaginationLink,
  PaginationItem,
  PaginationPrevious,
  PaginationNext,
  PaginationEllipsis,
}
