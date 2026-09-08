'use client'

import * as React from 'react'
import { Avatar as AvatarPrimitive } from 'radix-ui'

import { cn } from '@/lib/utils'

type AvatarSize = 'xs' | 'sm' | 'md' | 'lg' | 'xl' | 'default'

function Avatar({
  className,
  size = 'md',
  ...props
}: React.ComponentProps<typeof AvatarPrimitive.Root> & {
  size?: AvatarSize
}) {
  return (
    <AvatarPrimitive.Root
      data-size={size}
      data-slot="avatar"
      className={cn(
        'group/avatar relative flex shrink-0 overflow-hidden rounded-full select-none',
        'data-[size=xs]:size-5',
        'data-[size=sm]:size-7',
        'data-[size=md]:size-9',
        'data-[size=default]:size-9',
        'data-[size=lg]:size-12',
        'data-[size=xl]:size-16',
        className,
      )}
      {...props}
    />
  )
}

function AvatarImage({
  className,
  ...props
}: React.ComponentProps<typeof AvatarPrimitive.Image>) {
  return (
    <AvatarPrimitive.Image
      data-slot="avatar-image"
      className={cn('aspect-square size-full object-cover', className)}
      {...props}
    />
  )
}

function AvatarFallback({
  className,
  ...props
}: React.ComponentProps<typeof AvatarPrimitive.Fallback>) {
  return (
    <AvatarPrimitive.Fallback
      data-slot="avatar-fallback"
      className={cn(
        'bg-bg-brand text-text-on-brand flex size-full items-center justify-center rounded-full font-medium',
        'group-data-[size=xs]/avatar:text-[9px]',
        'group-data-[size=sm]/avatar:text-[11px]',
        'group-data-[size=md]/avatar:text-xs',
        'group-data-[size=default]/avatar:text-xs',
        'group-data-[size=lg]/avatar:text-base',
        'group-data-[size=xl]/avatar:text-xl',
        className,
      )}
      {...props}
    />
  )
}

function AvatarBadge({ className, ...props }: React.ComponentProps<'span'>) {
  return (
    <span
      data-slot="avatar-badge"
      className={cn(
        'bg-bg-success ring-bg-primary absolute right-0 bottom-0 z-10 inline-flex items-center justify-center rounded-full ring-2 select-none',
        'group-data-[size=xs]/avatar:size-1.5',
        'group-data-[size=sm]/avatar:size-2',
        'group-data-[size=md]/avatar:size-2.5',
        'group-data-[size=default]/avatar:size-2.5',
        'group-data-[size=lg]/avatar:size-3.5',
        'group-data-[size=xl]/avatar:size-4.5',
        className,
      )}
      {...props}
    />
  )
}

function AvatarGroup({ className, ...props }: React.ComponentProps<'div'>) {
  return (
    <div
      data-slot="avatar-group"
      className={cn(
        'group/avatar-group *:data-[slot=avatar]:ring-bg-primary flex -space-x-2 *:data-[slot=avatar]:ring-2',
        className,
      )}
      {...props}
    />
  )
}

function AvatarGroupCount({
  className,
  ...props
}: React.ComponentProps<'div'>) {
  return (
    <div
      data-slot="avatar-group-count"
      className={cn(
        'bg-bg-tertiary text-text-secondary ring-bg-primary relative flex size-9 shrink-0 items-center justify-center rounded-full text-xs font-medium ring-2',
        className,
      )}
      {...props}
    />
  )
}

export {
  Avatar,
  AvatarBadge,
  AvatarFallback,
  AvatarGroup,
  AvatarGroupCount,
  AvatarImage,
}
