import { useTranslation } from 'react-i18next'

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { supportedLanguages, type SupportedLanguage } from '@/i18n/config'

function isSupportedLanguage(language: string): language is SupportedLanguage {
  return supportedLanguages.some((supported) => supported === language)
}

export function LanguageSwitcher() {
  const { i18n, t } = useTranslation('layout')
  const currentLanguage =
    supportedLanguages.find((language) =>
      (i18n.resolvedLanguage ?? i18n.language).startsWith(language),
    ) ?? 'en'

  const changeLanguage = (language: string) => {
    if (isSupportedLanguage(language)) {
      void i18n.changeLanguage(language)
    }
  }

  return (
    <Select onValueChange={changeLanguage} value={currentLanguage}>
      <SelectTrigger
        aria-label={t(($) => $.layout.language.label)}
        className="w-32"
        size="sm"
      >
        <SelectValue />
      </SelectTrigger>
      <SelectContent align="end">
        <SelectItem value="en">
          {t(($) => $.layout.language.english)}
        </SelectItem>
        <SelectItem value="vi">
          {t(($) => $.layout.language.vietnamese)}
        </SelectItem>
      </SelectContent>
    </Select>
  )
}
