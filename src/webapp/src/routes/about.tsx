import { createFileRoute } from '@tanstack/react-router'
import { useTranslation } from 'react-i18next'

import { PagePlaceholder } from '@/components/page-placeholder'
import { Seo } from '@/lib/seo'

export const Route = createFileRoute('/about')({
  component: AboutPage,
})

function AboutPage() {
  const { t } = useTranslation('about')

  return (
    <>
      <Seo
        description={t(($) => $.about.seoDescription)}
        title={t(($) => $.about.seoTitle)}
      />
      <PagePlaceholder title={t(($) => $.about.heading)} />
    </>
  )
}
