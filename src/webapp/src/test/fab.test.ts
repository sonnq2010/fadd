import { describe, expect, it } from 'vitest'
import { fabVariants } from '@/components/ui/fab'

describe('Fab variant and size contracts', () => {
  it('generates correct classes for primary style with shadow-lg and rounded-full', () => {
    const primary = fabVariants({ variant: 'primary', size: 'medium' })
    expect(primary).toContain('bg-bg-brand')
    expect(primary).toContain('text-text-on-brand')
    expect(primary).toContain('rounded-full')
    expect(primary).toContain('shadow-lg')
  })

  it('generates correct size classes for all 3 Figma sizes', () => {
    const large = fabVariants({ size: 'large' })
    expect(large).toContain('size-[72px]')
    expect(large).toContain('[&_svg]:size-7')

    const medium = fabVariants({ size: 'medium' })
    expect(medium).toContain('size-14')
    expect(medium).toContain('[&_svg]:size-6')

    const small = fabVariants({ size: 'small' })
    expect(small).toContain('size-10')
    expect(small).toContain('[&_svg]:size-5')
  })
})
