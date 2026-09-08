import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { TooltipBubble } from '@/components/ui/tooltip'

describe('Tooltip public contract', () => {
  it('renders TooltipBubble for all 4 positions', () => {
    const positions = ['top', 'bottom', 'left', 'right'] as const

    for (const position of positions) {
      const markup = renderToStaticMarkup(
        createElement(TooltipBubble, {
          label: `Tooltip ${position}`,
          position,
        }),
      )

      expect(markup).toContain('data-slot="tooltip-bubble"')
      expect(markup).toContain(`data-position="${position}"`)
      expect(markup).toContain(`Tooltip ${position}`)
      expect(markup).toContain('bg-bg-inverse')
      expect(markup).toContain('text-text-inverse')
    }
  })
})
