import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { ProgressBar } from '@/components/ui/progress'

export function ProgressBarShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.progressBar.desc)}
      title={t(($) => $.globalComponents.progressBar.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex flex-col gap-4">
            <ProgressBar
              label={t(($) => $.globalComponents.progressBar.sampleLabel)}
              state="default"
              value={60}
            />
            <ProgressBar
              label={t(($) => $.globalComponents.progressBar.sampleLabel)}
              state="success"
              value={60}
            />
            <ProgressBar
              label={t(($) => $.globalComponents.progressBar.sampleLabel)}
              state="error"
              value={60}
            />
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Without label
          </h3>
          <ProgressBar showLabel={false} value={60} />
        </div>
      </div>
    </ComponentDemo>
  )
}
