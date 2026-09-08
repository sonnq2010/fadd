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
    const selectValues = selectDemo.locator('[data-slot="select-field-value"]')
    await expect(selectTriggers).toHaveCount(15)
    await expect(selectValues).toHaveCount(15)

    // Large triggers (first 5) must be 48px high
    const largeBox = await selectTriggers.nth(0).boundingBox()
    expect(largeBox?.height).toBe(48)

    // Medium triggers (next 5) must be 40px high
    const mediumBox = await selectTriggers.nth(5).boundingBox()
    expect(mediumBox?.height).toBe(40)

    // Small triggers (last 5) must be 36px high
    const smallBox = await selectTriggers.nth(10).boundingBox()
    expect(smallBox?.height).toBe(36)
    // Font size contracts: Large = 16px (Body/Medium), Medium/Small = 14px (Body/Small)
    const largeFontSize = await selectValues
      .nth(0)
      .evaluate((el) => window.getComputedStyle(el).fontSize)
    expect(largeFontSize).toBe('16px')

    const mediumFontSize = await selectValues
      .nth(5)
      .evaluate((el) => window.getComputedStyle(el).fontSize)
    expect(mediumFontSize).toBe('14px')

    const smallFontSize = await selectValues
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

  test('matches the revised Figma contracts', async ({ page }) => {
    await page.goto('/global-components')

    const demos = page.getByTestId('component-demo')
    const demo = (name: string) =>
      demos.filter({
        has: page.getByRole('heading', { level: 2, name, exact: true }),
      })

    const inputControls = demo('Input Field').locator(
      '[data-slot="input-field-control"]',
    )
    await expect(inputControls.nth(10)).toHaveCSS('border-radius', '8px')
    await expect(inputControls.nth(0)).toHaveCSS('font-size', '16px')
    await expect(inputControls.nth(5)).toHaveCSS('font-size', '14px')
    await expect(inputControls.nth(10)).toHaveCSS('font-size', '14px')

    const textarea = demo('Textarea Field')
      .locator('[data-slot="textarea-field-input"]')
      .first()
    await expect(textarea).toHaveCSS('font-size', '14px')
    await expect(textarea).toHaveCSS('resize', 'vertical')
    const textareaControl = demo('Textarea Field')
      .locator('[data-slot="textarea-field-control"]')
      .first()
    expect(
      (await textareaControl.boundingBox())?.height,
    ).toBeGreaterThanOrEqual(96)

    const resolveColor = (variable: string) =>
      page.evaluate((name) => {
        const probe = document.createElement('span')
        probe.style.color = `var(${name})`
        document.body.append(probe)
        const color = getComputedStyle(probe).color
        probe.remove()
        return color
      }, variable)

    const checkboxDemo = demo('Checkbox')
    const unchecked = checkboxDemo.locator('[data-slot="checkbox"]').first()
    await unchecked.hover()
    const brandBorder = await resolveColor('--border-brand')
    await expect(unchecked).toHaveCSS('border-color', brandBorder)

    const checked = checkboxDemo.locator('[data-slot="checkbox"]').nth(3)
    await checked.hover()
    const brandHover = await resolveColor('--bg-brand-hover')
    await expect(checked).toHaveCSS('background-color', brandHover)

    const switchDemo = demo('Switch')
    const onSwitch = switchDemo.locator('[data-slot="switch"]').nth(3)
    await onSwitch.hover()
    await expect(onSwitch).toHaveCSS('background-color', brandHover)

    const menuItem = demo('Menu Item').getByRole('menuitem').first()
    await menuItem.hover()
    const secondaryHoverColor = await resolveColor('--bg-secondary-hover')
    await expect(menuItem).toHaveCSS('background-color', secondaryHoverColor)

    const sideNav = demo('Side Nav Item')
      .locator('[data-slot="side-nav-item"]')
      .first()
    await sideNav.hover()
    await expect(sideNav).toHaveCSS('background-color', secondaryHoverColor)
    await expect(sideNav).toHaveCSS('font-size', '14px')

    const bottomTab = demo('Mobile Bottom Tab Item & Bar')
    const tabItem = bottomTab.locator('[data-slot="bottom-tab-item"]').first()
    await expect(tabItem).toHaveCSS('width', '67.5px')
    await expect(tabItem.locator('span').last()).toHaveCSS('font-size', '14px')
    const tabBar = bottomTab.locator('[data-slot="bottom-tab-bar"]')
    await expect(tabBar).toHaveCSS('column-gap', '12px')
    await expect(tabBar).toHaveCSS('padding', '8px 16px 24px')
  })
})
