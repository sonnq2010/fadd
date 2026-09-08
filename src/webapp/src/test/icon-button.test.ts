import { describe, expect, it } from 'vitest'
import { iconButtonVariants } from '@/components/ui/icon-button'

describe('IconButton variant and size contracts', () => {
  it('generates correct classes for all 6 Figma styles', () => {
    const primary = iconButtonVariants({ variant: 'primary', size: 'medium' })
    expect(primary).toContain('bg-bg-brand')
    expect(primary).toContain('text-text-on-brand')

    const secondary = iconButtonVariants({
      variant: 'secondary',
      size: 'medium',
    })
    expect(secondary).toContain('bg-bg-secondary')
    expect(secondary).toContain('border-border')

    const outline = iconButtonVariants({ variant: 'outline', size: 'medium' })
    expect(outline).toContain('border-border-brand')
    expect(outline).toContain('text-text-brand')

    const ghost = iconButtonVariants({ variant: 'ghost', size: 'medium' })
    expect(ghost).toContain('bg-transparent')

    const destructive = iconButtonVariants({
      variant: 'destructive',
      size: 'medium',
    })
    expect(destructive).toContain('bg-bg-error')

    const destructiveOutline = iconButtonVariants({
      variant: 'destructiveOutline',
      size: 'medium',
    })
    expect(destructiveOutline).toContain('border-border-error')
    expect(destructiveOutline).toContain('text-text-error')
  })

  it('generates correct size classes for Figma sizes', () => {
    const large = iconButtonVariants({ size: 'large' })
    expect(large).toContain('size-12')
    expect(large).toContain('[&_svg]:size-6')

    const medium = iconButtonVariants({ size: 'medium' })
    expect(medium).toContain('size-10')
    expect(medium).toContain('[&_svg]:size-5')

    const small = iconButtonVariants({ size: 'small' })
    expect(small).toContain('size-9')
    expect(small).toContain('[&_svg]:size-4')
  })
})
