import { describe, expect, it } from 'vitest'
import { buttonVariants } from '@/components/ui/button'

describe('Button variant and size contracts', () => {
  it('generates correct classes for all 6 Figma styles', () => {
    const primary = buttonVariants({ variant: 'primary', size: 'medium' })
    expect(primary).toContain('bg-bg-brand')
    expect(primary).toContain('text-text-on-brand')

    const secondary = buttonVariants({ variant: 'secondary', size: 'medium' })
    expect(secondary).toContain('bg-bg-secondary')
    expect(secondary).toContain('border-border')

    const outline = buttonVariants({ variant: 'outline', size: 'medium' })
    expect(outline).toContain('border-border-brand')
    expect(outline).toContain('text-text-brand')

    const ghost = buttonVariants({ variant: 'ghost', size: 'medium' })
    expect(ghost).toContain('bg-transparent')

    const destructive = buttonVariants({
      variant: 'destructive',
      size: 'medium',
    })
    expect(destructive).toContain('bg-bg-error')

    const destructiveOutline = buttonVariants({
      variant: 'destructiveOutline',
      size: 'medium',
    })
    expect(destructiveOutline).toContain('border-border-error')
    expect(destructiveOutline).toContain('text-text-error')
  })

  it('generates correct height classes for Figma sizes', () => {
    const large = buttonVariants({ size: 'large' })
    expect(large).toContain('h-12')

    const medium = buttonVariants({ size: 'medium' })
    expect(medium).toContain('h-10')

    const small = buttonVariants({ size: 'small' })
    expect(small).toContain('h-9')
  })
})
