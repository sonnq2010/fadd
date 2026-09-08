import { createElement } from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import { Slider } from '@/components/ui/slider'

describe('Slider public contract', () => {
  it('renders slider markup with track, range, and thumb', () => {
    const markup = renderToStaticMarkup(
      createElement(Slider, {
        defaultValue: [50],
        max: 100,
        min: 0,
      }),
    )

    expect(markup).toContain('data-slot="slider"')
    expect(markup).toContain('data-slot="slider-track"')
    expect(markup).toContain('data-slot="slider-range"')
    expect(markup).toContain('data-slot="slider-thumb"')
    expect(markup).toContain('h-[18px]')
    expect(markup).toContain('border-bg-brand')
  })

  it('renders disabled state styling', () => {
    const markup = renderToStaticMarkup(
      createElement(Slider, {
        defaultValue: [50],
        disabled: true,
      }),
    )

    expect(markup).toContain('cursor-not-allowed')
    expect(markup).toContain('border-border-default')
  })
})
