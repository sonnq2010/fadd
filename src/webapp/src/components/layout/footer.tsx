import { useTranslation } from 'react-i18next'

export function Footer() {
  const { t } = useTranslation('layout')

  return (
    <footer className="border-t">
      <div className="text-muted-foreground mx-auto flex w-full max-w-7xl items-center px-6 py-6 text-sm">
        {t(($) => $.layout.app.name)}
      </div>
    </footer>
  )
}
