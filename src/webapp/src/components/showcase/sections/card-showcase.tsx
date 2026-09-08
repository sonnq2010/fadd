import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import {} from '@/components/ui/card'

export function CardShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.card.desc)}
      title={t(($) => $.globalComponents.card.title)}
    >
      <div className="border-border-subtle bg-bg-primary w-[320px] overflow-hidden rounded-xl border shadow-sm">
        <div className="bg-bg-tertiary h-40 w-full" />
        <div className="space-y-2 p-4">
          <Badge variant="success">Active</Badge>
          <h4 className="text-text-primary text-xl leading-[30px] font-semibold">
            Card title
          </h4>
          <p className="text-text-secondary text-sm leading-[21px]">
            A short supporting description that explains what this card
            represents and why it matters.
          </p>
          <div className="flex gap-2 pt-2">
            <Button size="small" variant="primary">
              View details
            </Button>
            <Button size="small" variant="ghost">
              Dismiss
            </Button>
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}
