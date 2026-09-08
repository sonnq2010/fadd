import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Divider } from '@/components/ui/divider'

export function DividerShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.divider.desc)}
      title={t(($) => $.globalComponents.divider.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            {t(($) => $.globalComponents.divider.withLabel)}
          </h3>
          <div className="max-w-[240px]">
            <Divider label="OR" />
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            {t(($) => $.globalComponents.divider.horizontal)}
          </h3>
          <div className="max-w-[240px]">
            <Divider />
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            {t(($) => $.globalComponents.divider.vertical)}
          </h3>
          <div className="flex h-10 items-center gap-4">
            <span className="text-text-primary text-sm">Item 1</span>
            <Divider orientation="vertical" />
            <span className="text-text-primary text-sm">Item 2</span>
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}
