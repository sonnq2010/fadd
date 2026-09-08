import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { ModalCard } from '@/components/ui/modal'

describe('Modal public contract', () => {
  it('renders ModalCard with title, description, and actions', () => {
    const markup = renderToStaticMarkup(
      createElement(ModalCard, {
        title: 'Delete project?',
        description: 'This action cannot be undone.',
        cancelLabel: 'Cancel',
        confirmLabel: 'Delete',
      }),
    )

    expect(markup).toContain('data-slot="modal-card"')
    expect(markup).toContain('Delete project?')
    expect(markup).toContain('This action cannot be undone.')
    expect(markup).toContain('Cancel')
    expect(markup).toContain('Delete')
    expect(markup).toContain('max-w-[400px]')
  })
})
