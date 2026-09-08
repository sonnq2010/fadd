import type { ReactNode } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Checkbox } from '@/components/ui/checkbox'

const values = [
  { key: 'unchecked', label: 'Unchecked', checked: false },
  { key: 'checked', label: 'Checked', checked: true },
  {
    key: 'indeterminate',
    label: 'Indeterminate',
    checked: 'indeterminate' as const,
  },
] as const

export function CheckboxShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.checkbox.desc)}
      title={t(($) => $.globalComponents.checkbox.title)}
    >
      <div className="space-y-6">
        {values.map((val) => (
          <div key={val.key} className="space-y-3">
            <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
              {val.label}
            </h3>
            <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
              <StateExample label="Default">
                <Checkbox
                  checked={val.checked}
                  label={t(($) => $.globalComponents.checkbox.label)}
                />
              </StateExample>

              <StateExample label="Hover">
                <Checkbox
                  checked={val.checked}
                  className={
                    val.checked
                      ? 'border-bg-brand-hover bg-bg-brand-hover'
                      : 'border-border-brand'
                  }
                  label={t(($) => $.globalComponents.checkbox.label)}
                />
              </StateExample>

              <StateExample label="Disabled">
                <Checkbox
                  disabled
                  checked={val.checked}
                  label={t(($) => $.globalComponents.checkbox.label)}
                />
              </StateExample>
            </div>
          </div>
        ))}
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
