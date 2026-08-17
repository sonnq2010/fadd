import { createFileRoute } from '@tanstack/react-router'
import { useTranslation } from 'react-i18next'

import { PagePlaceholder } from '@/components/page-placeholder'
import { Seo } from '@/lib/seo'

export const Route = createFileRoute('/pricing')({
  component: PricingPage,
})

function PricingPage() {
  const { t } = useTranslation('pricing')

  return (
    <>
      <Seo
        description={t(($) => $.pricing.seoDescription)}
        title={t(($) => $.pricing.seoTitle)}
      />
      <PagePlaceholder title={t(($) => $.pricing.heading)} />
    </>
  )
}
