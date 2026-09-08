import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { MobileActionSheet } from '@/components/ui/mobile-action-sheet'

describe('MobileActionSheet public contract', () => {
  it('renders actions list and cancel button', () => {
    const markup = renderToStaticMarkup(
      createElement(MobileActionSheet, {
        actions: [
          { label: 'Share' },
          { label: 'Add to favorites' },
          { label: 'Duplicate' },
          { label: 'Report' },
        ],
        cancelLabel: 'Cancel',
      }),
    )

    expect(markup).toContain('Share')
    expect(markup).toContain('Add to favorites')
    expect(markup).toContain('Duplicate')
    expect(markup).toContain('Report')
    expect(markup).toContain('Cancel')
    expect(markup).toContain('w-[375px]')
  })
})
