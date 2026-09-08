import { afterEach, describe, expect, it, vi } from 'vitest'

import i18n, {
  detectBrowserLanguage,
  initializeBrowserLanguage,
  persistLanguage,
} from '@/i18n/config'

afterEach(async () => {
  vi.unstubAllGlobals()
  await i18n.changeLanguage('en')
})

describe('i18n', () => {
  it('starts in English before browser language detection', () => {
    expect(i18n.resolvedLanguage ?? i18n.language).toBe('en')
  })

  it('prefers a supported stored browser language', () => {
    expect(
      detectBrowserLanguage({
        navigatorLanguages: ['en-US'],
        storedLanguage: 'vi',
      }),
    ).toBe('vi')
  })

  it('falls back to a supported navigator language', () => {
    expect(
      detectBrowserLanguage({
        navigatorLanguages: ['vi-VN', 'en-US'],
        storedLanguage: null,
      }),
    ).toBe('vi')
  })

  it('falls back to English for unsupported browser languages', () => {
    expect(
      detectBrowserLanguage({
        navigatorLanguages: ['fr-FR'],
        storedLanguage: 'invalid',
      }),
    ).toBe('en')
  })

  it('uses navigator language when browser storage is unavailable', async () => {
    vi.stubGlobal('window', {
      localStorage: {
        getItem: () => {
          throw new Error('Storage blocked')
        },
      },
      navigator: {
        language: 'vi-VN',
        languages: ['vi-VN'],
      },
    })

    await initializeBrowserLanguage()

    expect(i18n.resolvedLanguage ?? i18n.language).toBe('vi')
  })

  it('persists an explicit supported language selection', () => {
    const setItem = vi.fn()
    vi.stubGlobal('window', { localStorage: { setItem } })

    persistLanguage('vi')

    expect(setItem).toHaveBeenCalledWith('app-language', 'vi')
  })
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
