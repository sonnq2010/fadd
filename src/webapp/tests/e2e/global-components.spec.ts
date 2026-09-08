import { expect, test } from '@playwright/test'

const componentHeadings = [
  'Button',
  'Icon Button',
  'FAB',
  'Button Group',
  'Input Field',
  'Select',
  'Search Field',
  'Textarea Field',
  'Checkbox',
  'Radio',
  'Switch',
  'Slider',
  'Menu Item',
  'Tab Item',
  'Nav Bar',
  'Side Nav Item',
  'Mobile Bottom Tab Item & Bar',
  'Mobile Top App Bar',
  'Mobile Action Sheet',
  'Badge',
  'Card',
  'Avatar',
  'Alert',
  'Tooltip',
  'Modal / Dialog',
  'Accordion',
  'Pagination',
  'Breadcrumb',
  'Stepper',
  'Progress Bar',
  'Table',
  'Divider',
  'Chip',
] as const

test.describe('/global-components', () => {
  test('renders every component without browser errors', async ({ page }) => {
    const browserErrors: string[] = []

    page.on('pageerror', (error) => browserErrors.push(error.message))
    page.on('console', (message) => {
      if (message.type() === 'error') browserErrors.push(message.text())
    })

    await page.goto('/global-components')
    await expect(
      page.getByRole('heading', { level: 1, name: /global components/i }),
    ).toBeVisible()

    await expect(page.locator('main')).toHaveCount(1)
    await expect(page.locator('main main')).toHaveCount(0)

    const container = page.getByTestId('global-components-container')
    await expect(container).toBeVisible()
    const containerBox = await container.boundingBox()
    expect(containerBox?.width).toBeGreaterThanOrEqual(900)

    const demos = page.getByTestId('component-demo')
    await expect(demos).toHaveCount(componentHeadings.length)

    for (const heading of componentHeadings) {
      const demo = demos.filter({
        has: page.getByRole('heading', {
          level: 2,
          name: heading,
          exact: true,
        }),
      })
      await expect(demo).toHaveCount(1)
      await expect(demo.getByTestId('component-demo-content')).not.toBeEmpty()
    }

    const primaryButton = page
      .locator('[data-slot="button"][data-variant="primary"]')
      .first()
    await expect(primaryButton).toHaveCSS(
      'background-color',
      'rgb(59, 130, 246)',
    )
    await primaryButton.hover()
    await expect(primaryButton).toHaveCSS(
      'background-color',
      'rgb(96, 165, 250)',
    )

    const selectDemo = demos.filter({
      has: page.getByRole('heading', { level: 2, name: 'Select', exact: true }),
    })
    const selectTriggers = selectDemo.locator('[data-slot="select-trigger"]')
    await expect(selectTriggers).toHaveCount(15)

    // Large triggers (first 5) must be 48px high
    const largeBox = await selectTriggers.nth(0).boundingBox()
    expect(largeBox?.height).toBe(48)

    // Medium triggers (next 5) must be 40px high
    const mediumBox = await selectTriggers.nth(5).boundingBox()
    expect(mediumBox?.height).toBe(40)

    // Small triggers (last 5) must be 36px high
    const smallBox = await selectTriggers.nth(10).boundingBox()
    expect(smallBox?.height).toBe(36)
    // Font size contracts: Large = 18px (Body/Large), Medium = 16px (Body/Medium), Small = 14px (Body/Small)
    const largeFontSize = await selectTriggers
      .nth(0)
      .evaluate((el) => window.getComputedStyle(el).fontSize)
    expect(largeFontSize).toBe('18px')

    const mediumFontSize = await selectTriggers
      .nth(5)
      .evaluate((el) => window.getComputedStyle(el).fontSize)
    expect(mediumFontSize).toBe('16px')

    const smallFontSize = await selectTriggers
      .nth(10)
      .evaluate((el) => window.getComputedStyle(el).fontSize)
    expect(smallFontSize).toBe('14px')

    // Placeholder text must be real localized text, not raw key
    await expect(selectTriggers.nth(0)).toContainText('Select an option')

    const themeButton = page.getByRole('button', { name: /toggle theme/i })
    await expect(themeButton).toBeVisible()
    await themeButton.click()
    await expect(page.locator('html')).not.toHaveClass(/dark/)

    expect(browserErrors, browserErrors.join('\n')).toEqual([])
  })
})
