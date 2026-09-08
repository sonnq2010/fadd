import type { ReactNode } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'

export function RadioShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.radio.desc)}
      title={t(($) => $.globalComponents.radio.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Unselected
          </h3>
          <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
            <StateExample label="Default">
              <RadioGroup value="other">
                <RadioGroupItem
                  value="1"
                  label={t(($) => $.globalComponents.radio.label)}
                />
              </RadioGroup>
            </StateExample>

            <StateExample label="Hover">
              <RadioGroup value="other">
                <RadioGroupItem
                  value="1"
                  className="border-border-brand"
                  label={t(($) => $.globalComponents.radio.label)}
                />
              </RadioGroup>
            </StateExample>

            <StateExample label="Disabled">
              <RadioGroup value="other">
                <RadioGroupItem
                  disabled
                  value="1"
                  label={t(($) => $.globalComponents.radio.label)}
                />
              </RadioGroup>
            </StateExample>
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Selected
          </h3>
          <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
            <StateExample label="Default">
              <RadioGroup value="1">
                <RadioGroupItem
                  value="1"
                  label={t(($) => $.globalComponents.radio.label)}
                />
              </RadioGroup>
            </StateExample>

            <StateExample label="Hover">
              <RadioGroup value="1">
                <RadioGroupItem
                  value="1"
                  className="border-border-brand"
                  label={t(($) => $.globalComponents.radio.label)}
                />
              </RadioGroup>
            </StateExample>

            <StateExample label="Disabled">
              <RadioGroup value="1">
                <RadioGroupItem
                  disabled
                  value="1"
                  label={t(($) => $.globalComponents.radio.label)}
                />
              </RadioGroup>
            </StateExample>
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}

function StateExample({
  label,
  children,
}: {
  label: string
  children: ReactNode
}) {
  return (
    <div className="min-w-48 space-y-2">
      <p className="text-text-tertiary text-xs font-medium">{label}</p>
      {children}
    </div>
  )
}
