import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Badge } from '@/components/ui/badge'

const variants = [
  { label: 'Neutral', variant: 'neutral' },
  { label: 'Brand', variant: 'brand' },
  { label: 'Secondary', variant: 'secondary' },
  { label: 'Success', variant: 'success' },
  { label: 'Warning', variant: 'warning' },
  { label: 'Error', variant: 'error' },
  { label: 'Info', variant: 'info' },
] as const

export function BadgeShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.badge.desc)}
      title={t(($) => $.globalComponents.badge.title)}
    >
      <div className="flex flex-wrap items-center gap-3">
        {variants.map((item) => (
          <Badge key={item.variant} variant={item.variant}>
            {item.label}
          </Badge>
        ))}
      </div>
    </ComponentDemo>
  )
}
