import { createFileRoute } from '@tanstack/react-router'
import { useTranslation } from 'react-i18next'

import { PagePlaceholder } from '@/components/page-placeholder'
import { Seo } from '@/lib/seo'

export const Route = createFileRoute('/')({
  component: HomePage,
})

function HomePage() {
  const { t } = useTranslation('home')

  return (
    <>
      <Seo
        description={t(($) => $.home.seoDescription)}
        title={t(($) => $.home.seoTitle)}
      />
      <PagePlaceholder title={t(($) => $.home.heading)} />
    </>
  )
}
