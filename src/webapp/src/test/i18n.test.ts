import { afterEach, describe, expect, it } from 'vitest'

import i18n from '@/i18n/config'

afterEach(async () => {
  await i18n.changeLanguage('en')
})

describe('i18n', () => {
  it('translates selectors across English feature namespaces', async () => {
    await i18n.changeLanguage('en')

    expect(i18n.t(($) => $.layout.navigation.about)).toBe('About')
    expect(i18n.t(($) => $.home.seoTitle)).toBe('Home | Application')
  })

  it('translates selectors across Vietnamese feature namespaces', async () => {
    await i18n.changeLanguage('vi')

    expect(i18n.t(($) => $.layout.navigation.about)).toBe('Giới thiệu')
    expect(i18n.t(($) => $.notFound.returnHome)).toBe('Về trang chủ')
  })
})
