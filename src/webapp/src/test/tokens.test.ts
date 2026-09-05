import { describe, it, expect } from 'vitest'
import {
  primitives,
  semanticColors,
  spacing,
  radius,
  shadows,
  typography,
  gradients,
} from '@/lib/tokens'

describe('Webapp Design Tokens', () => {
  it('has all primitive color palettes defined', () => {
    expect(primitives.blue[500]).toBe('#3b82f6')
    expect(primitives.violet[500]).toBe('#8b5cf6')
    expect(primitives.gray[900]).toBe('#0f172a')
    expect(primitives.green[500]).toBe('#22c55e')
    expect(primitives.amber[500]).toBe('#f59e0b')
    expect(primitives.red[500]).toBe('#ef4444')
    expect(primitives.cyan[500]).toBe('#06b6d4')
    expect(primitives.white1000).toBe('#ffffff')
    expect(primitives.black1000).toBe('#000000')
  })

  it('has light and dark semantic colors matching Figma spec', () => {
    expect(semanticColors.light.bg.primary).toBe('#ffffff')
    expect(semanticColors.light.bg.brand).toBe('#3b82f6')
    expect(semanticColors.light.text.primary).toBe('#0f172a')
    expect(semanticColors.light.border.default).toBe('#e2e8f0')

    expect(semanticColors.dark.bg.primary).toBe('#0f172a')
    expect(semanticColors.dark.bg.brand).toBe('#3b82f6')
    expect(semanticColors.dark.text.primary).toBe('#ffffff')
    expect(semanticColors.dark.border.default).toBe('#334155')
  })

  it('has spacing tokens from 2xs to 6xl', () => {
    expect(spacing['2xs']).toBe('2px')
    expect(spacing.xs).toBe('4px')
    expect(spacing.sm).toBe('8px')
    expect(spacing.md).toBe('12px')
    expect(spacing.lg).toBe('16px')
    expect(spacing.xl).toBe('20px')
    expect(spacing['2xl']).toBe('24px')
    expect(spacing['3xl']).toBe('32px')
    expect(spacing['4xl']).toBe('40px')
    expect(spacing['5xl']).toBe('48px')
    expect(spacing['6xl']).toBe('64px')
  })

  it('has border radius tokens from none to full', () => {
    expect(radius.none).toBe('0px')
    expect(radius.xs).toBe('2px')
    expect(radius.sm).toBe('4px')
    expect(radius.md).toBe('8px')
    expect(radius.lg).toBe('12px')
    expect(radius.xl).toBe('16px')
    expect(radius['2xl']).toBe('24px')
    expect(radius.full).toBe('9999px')
  })

  it('has elevation / shadow tokens', () => {
    expect(shadows.xs).toBeDefined()
    expect(shadows.sm).toBeDefined()
    expect(shadows.md).toBeDefined()
    expect(shadows.lg).toBeDefined()
    expect(shadows.xl).toBeDefined()
    expect(shadows.focusRing).toBeDefined()
  })

  it('has typography definitions for 15 styles', () => {
    expect(typography.displayLarge.fontSize).toBe('60px')
    expect(typography.displayLarge.fontWeight).toBe(700)
    expect(typography.displaySmall.fontSize).toBe('48px')
    expect(typography.headingH1.fontSize).toBe('36px')
    expect(typography.headingH2.fontSize).toBe('30px')
    expect(typography.headingH3.fontSize).toBe('24px')
    expect(typography.headingH4.fontSize).toBe('20px')
    expect(typography.bodyLarge.fontSize).toBe('18px')
    expect(typography.bodyMedium.fontSize).toBe('16px')
    expect(typography.bodySmall.fontSize).toBe('14px')
    expect(typography.bodyEmphasis.fontSize).toBe('16px')
    expect(typography.bodyEmphasis.fontWeight).toBe(600)
    expect(typography.bodyLink.fontSize).toBe('16px')
    expect(typography.labelLarge.fontSize).toBe('16px')
    expect(typography.labelMedium.fontSize).toBe('14px')
    expect(typography.labelSmall.fontSize).toBe('12px')
    expect(typography.caption.fontSize).toBe('11px')
  })

  it('has gradient definitions', () => {
    expect(gradients.brand).toContain('#3b82f6')
    expect(gradients.brandSubtle).toContain('#eff6ff')
    expect(gradients.overlayScrim).toContain('rgba(0, 0, 0, 0.6)')
  })
})
