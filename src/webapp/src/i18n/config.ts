import i18n from 'i18next'
import LanguageDetector from 'i18next-browser-languagedetector'
import { initReactI18next } from 'react-i18next'

import enAbout from '@/i18n/locales/en/about.json'
import enHome from '@/i18n/locales/en/home.json'
import enLayout from '@/i18n/locales/en/layout.json'
import enNotFound from '@/i18n/locales/en/notFound.json'
import enPricing from '@/i18n/locales/en/pricing.json'
import viAbout from '@/i18n/locales/vi/about.json'
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
] as const

const resources = {
  en: {
    about: enAbout,
    home: enHome,
    layout: enLayout,
    notFound: enNotFound,
    pricing: enPricing,
  },
  vi: {
    about: viAbout,
    home: viHome,
    layout: viLayout,
    notFound: viNotFound,
    pricing: viPricing,
  },
}

function setDocumentLanguage(language: string) {
  if (typeof document !== 'undefined') {
    document.documentElement.lang = language
  }
}

void i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    defaultNS: 'layout',
    detection: {
      caches: ['localStorage'],
      lookupLocalStorage: 'app-language',
      order: ['localStorage', 'navigator'],
    },
    enableSelector: 'strict',
    fallbackLng: 'en',
    initAsync: false,
    interpolation: {
      escapeValue: false,
    },
    load: 'languageOnly',
    ns: namespaces,
    react: {
      useSuspense: false,
    },
    resources,
    returnNull: false,
    supportedLngs: supportedLanguages,
  })

i18n.on('languageChanged', setDocumentLanguage)
setDocumentLanguage(i18n.resolvedLanguage ?? i18n.language)

export default i18n
