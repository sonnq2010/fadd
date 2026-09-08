import { describe, expect, it } from 'vitest'
import { buttonGroupVariants } from '@/components/ui/button-group'

describe('ButtonGroup layout contracts', () => {
  it('generates correct classes for all 5 Figma layouts', () => {
    const justify = buttonGroupVariants({ layout: 'justify' })
    expect(justify).toContain('justify-between')
    expect(justify).toContain('w-full')

    const start = buttonGroupVariants({ layout: 'start' })
    expect(start).toContain('justify-start')
    expect(start).toContain('gap-3')

    const end = buttonGroupVariants({ layout: 'end' })
    expect(end).toContain('justify-end')
    expect(end).toContain('gap-3')

    const center = buttonGroupVariants({ layout: 'center' })
    expect(center).toContain('justify-center')
    expect(center).toContain('gap-3')

    const stack = buttonGroupVariants({ layout: 'stack' })
    expect(stack).toContain('flex-col')
    expect(stack).toContain('items-stretch')
    expect(stack).toContain('gap-3')
  })
})
