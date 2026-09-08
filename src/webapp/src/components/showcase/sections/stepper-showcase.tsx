import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Stepper, StepperItem } from '@/components/ui/stepper'

export function StepperShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.stepper.desc)}
      title={t(($) => $.globalComponents.stepper.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex flex-wrap items-center gap-6">
            <StepperItem label="Upcoming" number="1" state="upcoming" />
            <StepperItem label="Active" number="1" state="active" />
            <StepperItem label="Completed" number="1" state="completed" />
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Composite Flow
          </h3>
          <div className="overflow-x-auto pb-2">
            <Stepper
              steps={[
                {
                  label: t(($) => $.globalComponents.stepper.account),
                  state: 'completed',
                },
                {
                  label: t(($) => $.globalComponents.stepper.shipping),
                  state: 'active',
                },
                {
                  label: t(($) => $.globalComponents.stepper.payment),
                  state: 'upcoming',
                },
                {
                  label: t(($) => $.globalComponents.stepper.review),
                  state: 'upcoming',
                },
              ]}
            />
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}
