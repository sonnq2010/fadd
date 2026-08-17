import { Link } from '@tanstack/react-router'
import { useTranslation } from 'react-i18next'

import { Button } from '@/components/ui/button'

export function NotFoundPage() {
  const { t } = useTranslation('notFound')

  return (
    <section className="mx-auto flex w-full max-w-5xl flex-1 flex-col items-start justify-center gap-6 px-6 py-16">
      <div>
        <p className="text-muted-foreground text-sm font-medium">
          {t(($) => $.notFound.code)}
        </p>
        <h1 className="mt-2 text-4xl font-semibold tracking-tight">
          {t(($) => $.notFound.title)}
        </h1>
      </div>
      <Button asChild>
        <Link to="/">{t(($) => $.notFound.returnHome)}</Link>
      </Button>
    </section>
  )
}
