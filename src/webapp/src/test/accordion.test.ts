import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion'

describe('Accordion public contract', () => {
  it('renders AccordionItem, Trigger and Content with design system tokens', () => {
    const markup = renderToStaticMarkup(
      createElement(
        Accordion,
        { type: 'single', defaultValue: 'item-1', collapsible: true },
        createElement(
          AccordionItem,
          { value: 'item-1' },
          createElement(AccordionTrigger, null, 'Accordion item title'),
          createElement(
            AccordionContent,
            null,
            'This is the expandable content area.',
          ),
        ),
      ),
    )

    expect(markup).toContain('data-slot="accordion"')
    expect(markup).toContain('data-slot="accordion-item"')
    expect(markup).toContain('data-slot="accordion-trigger"')
    expect(markup).toContain('data-slot="accordion-content"')
    expect(markup).toContain('Accordion item title')
    expect(markup).toContain('This is the expandable content area.')
    expect(markup).toContain('border-border-default')
  })
})
