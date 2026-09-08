import type { ReactNode } from 'react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Switch } from '@/components/ui/switch'

export function SwitchShowcase() {
  const { t } = useTranslation('globalComponents')
  const [checked, setChecked] = useState(true)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.switch.desc)}
      title={t(($) => $.globalComponents.switch.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Off
          </h3>
          <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
            <StateExample label="Default">
              <Switch
                checked={false}
                label={t(($) => $.globalComponents.switch.label)}
              />
            </StateExample>

            <StateExample label="Hover">
              <Switch
                checked={false}
                className="bg-border-strong"
                label={t(($) => $.globalComponents.switch.label)}
              />
            </StateExample>

            <StateExample label="Disabled">
              <Switch
                disabled
                checked={false}
                label={t(($) => $.globalComponents.switch.label)}
              />
            </StateExample>
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            On
          </h3>
          <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
            <StateExample label="Default">
              <Switch
                checked={true}
                label={t(($) => $.globalComponents.switch.label)}
              />
            </StateExample>

            <StateExample label="Hover">
              <Switch
                checked={true}
                className="bg-bg-brand-hover"
                label={t(($) => $.globalComponents.switch.label)}
              />
            </StateExample>

            <StateExample label="Disabled">
              <Switch
                disabled
                checked={true}
                label={t(($) => $.globalComponents.switch.label)}
              />
            </StateExample>
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Interactive
          </h3>
          <Switch
            checked={checked}
            label={`${t(($) => $.globalComponents.switch.label)} (${checked ? 'On' : 'Off'})`}
            onCheckedChange={setChecked}
          />
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
