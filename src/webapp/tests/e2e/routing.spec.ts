import { expect, test } from '@playwright/test'

const publicRoutes = [
  { path: '/', title: 'Home | Application', heading: 'Landing page' },
  { path: '/about', title: 'About | Application', heading: 'About' },
  { path: '/pricing', title: 'Pricing | Application', heading: 'Pricing' },
] as const

for (const route of publicRoutes) {
  test(`${route.path} renders route metadata`, async ({ page }) => {
    await page.goto(route.path)

    await expect(page).toHaveTitle(route.title)
    await expect(
      page.getByRole('heading', { name: route.heading }),
    ).toBeVisible()
    await expect(page.locator('meta[name="description"]')).toHaveAttribute(
      'content',
      /.+/,
    )
    await expect(page.locator('meta[property="og:title"]')).toHaveAttribute(
      'content',
      route.title,
    )
    await expect(page.locator('meta[name="twitter:card"]')).toHaveAttribute(
      'content',
      'summary',
    )
  })
}

test('renders route content only after client startup', async ({
  page,
  request,
}) => {
  const response = await request.get('/about')
  expect(response.ok()).toBe(true)

  const initialHtml = await response.text()
  expect(initialHtml).not.toMatch(/<h1[^>]*>\s*About\s*<\/h1>/)

  await page.goto('/about')
  await expect(page.getByRole('heading', { name: 'About' })).toBeVisible()
})

test('switches and persists the interface language', async ({ page }) => {
  await page.goto('/')
  await expect(
    page.getByRole('heading', { name: 'Landing page' }),
  ).toBeVisible()

  await page.getByRole('combobox', { name: 'Language' }).click()
  await page.getByRole('option', { name: 'Vietnamese' }).click()

  await expect(page.getByRole('heading', { name: 'Trang chủ' })).toBeVisible()
  await expect(page).toHaveTitle('Trang chủ | Ứng dụng')
  await expect(page.locator('html')).toHaveAttribute('lang', 'vi')
  expect(await page.evaluate(() => localStorage.getItem('app-language'))).toBe(
    'vi',
  )

  await page.reload()
  await expect(page.getByRole('heading', { name: 'Trang chủ' })).toBeVisible()
})

test('mobile navigation closes after client-side navigation', async ({
  page,
}) => {
  await page.setViewportSize({ width: 390, height: 844 })
  await page.goto('/')
  await expect(
    page.getByRole('heading', { name: 'Landing page' }),
  ).toBeVisible()

  await page.getByRole('button', { name: 'Open navigation' }).click()
  const mobileNavigation = page.getByRole('navigation', { name: 'Mobile' })
  await expect(mobileNavigation).toBeVisible()

  await mobileNavigation.getByRole('link', { name: 'About' }).click()
  await expect(page).toHaveURL('/about')
  await expect(page.getByRole('heading', { name: 'About' })).toBeVisible()
  await expect(mobileNavigation).not.toBeVisible()
})

test('unknown route renders the 404 page', async ({ page }) => {
  await page.goto('/missing-route')

  await expect(
    page.getByRole('heading', { name: 'Page not found' }),
  ).toBeVisible()
})
