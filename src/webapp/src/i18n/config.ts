import i18n from 'i18next'
import { initReactI18next } from 'react-i18next'

import enAbout from '@/i18n/locales/en/about.json'
import enGlobalComponents from '@/i18n/locales/en/globalComponents.json'
import enHome from '@/i18n/locales/en/home.json'
import enLayout from '@/i18n/locales/en/layout.json'
import enNotFound from '@/i18n/locales/en/notFound.json'
import enPricing from '@/i18n/locales/en/pricing.json'
import viAbout from '@/i18n/locales/vi/about.json'
import viGlobalComponents from '@/i18n/locales/vi/globalComponents.json'
import viHome from '@/i18n/locales/vi/home.json'
import viLayout from '@/i18n/locales/vi/layout.json'
import viNotFound from '@/i18n/locales/vi/notFound.json'
import viPricing from '@/i18n/locales/vi/pricing.json'

export const supportedLanguages = ['en', 'vi'] as const
export type SupportedLanguage = (typeof supportedLanguages)[number]

export const namespaces = [
  'layout',
  'home',
  'about',
  'pricing',
  'notFound',
  'globalComponents',
] as const

const languageStorageKey = 'app-language'

const resources = {
  en: {
    about: enAbout,
    globalComponents: enGlobalComponents,
    home: enHome,
    layout: enLayout,
    notFound: enNotFound,
    pricing: enPricing,
  },
  vi: {
    about: viAbout,
    globalComponents: viGlobalComponents,
    home: viHome,
    layout: viLayout,
    notFound: viNotFound,
    pricing: viPricing,
  },
}

function normalizeLanguage(language: string | null | undefined) {
  return language?.trim().toLowerCase().split('-')[0]
}

function isSupportedLanguage(
  language: string | undefined,
): language is SupportedLanguage {
  return supportedLanguages.some((supported) => supported === language)
}

export function detectBrowserLanguage({
  navigatorLanguages,
  storedLanguage,
}: {
  navigatorLanguages: readonly string[]
  storedLanguage: string | null
}): SupportedLanguage {
  const stored = normalizeLanguage(storedLanguage)
  if (isSupportedLanguage(stored)) return stored

  for (const language of navigatorLanguages) {
    const normalized = normalizeLanguage(language)
    if (isSupportedLanguage(normalized)) return normalized
  }

  return 'en'
}

export async function initializeBrowserLanguage() {
  if (typeof window === 'undefined') return

  let storedLanguage: string | null = null
  try {
    storedLanguage = window.localStorage.getItem(languageStorageKey)
  } catch {
    // Browsers may block storage; navigator language remains a safe fallback.
  }

  const language = detectBrowserLanguage({
    navigatorLanguages: window.navigator.languages.length
      ? window.navigator.languages
      : [window.navigator.language],
    storedLanguage,
  })

  await i18n.changeLanguage(language)
}

export function persistLanguage(language: SupportedLanguage) {
  if (typeof window === 'undefined') return

  try {
    window.localStorage.setItem(languageStorageKey, language)
  } catch {
    // Language switching still works when browser storage is unavailable.
  }
}

void i18n.use(initReactI18next).init({
  defaultNS: 'layout',
  enableSelector: 'strict',
  fallbackLng: 'en',
  initAsync: false,
  interpolation: {
    escapeValue: false,
  },
  lng: 'en',
  load: 'languageOnly',
  ns: namespaces,
  react: {
    useSuspense: false,
  },
  resources,
  returnNull: false,
  supportedLngs: supportedLanguages,
})

export default i18n
