import type { ReactNode } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { SelectField } from '@/components/ui/select-field'

const sizes = [
  { key: 'large', label: 'Large (48px)' },
  { key: 'medium', label: 'Medium (40px)' },
  { key: 'small', label: 'Small (36px)' },
] as const

const options = [
  { value: 'opt1', label: 'Selected value' },
  { value: 'opt2', label: 'Option 2' },
  { value: 'opt3', label: 'Option 3 (disabled)', disabled: true },
]

export function SelectShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.select.desc)}
      title={t(($) => $.globalComponents.select.title)}
    >
      <div className="space-y-8">
        {sizes.map((size) => (
          <div key={size.key} className="space-y-3">
            <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
              {size.label}
            </h3>
            <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
              <StateExample label="Default">
                <SelectField
                  helperText={t(($) => $.globalComponents.select.helperText)}
                  label={t(($) => $.globalComponents.select.label)}
                  options={options}
                  placeholder={t(($) => $.globalComponents.select.placeholder)}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Focus">
                <SelectField
                  className="border-border-focus ring-border-focus/45 ring-[3px]"
                  helperText={t(($) => $.globalComponents.select.helperText)}
                  label={t(($) => $.globalComponents.select.label)}
                  options={options}
                  placeholder={t(($) => $.globalComponents.select.placeholder)}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Filled">
                <SelectField
                  defaultValue="opt1"
                  helperText={t(($) => $.globalComponents.select.helperText)}
                  label={t(($) => $.globalComponents.select.label)}
                  options={options}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Error">
                <SelectField
                  defaultValue="opt1"
                  errorText={t(($) => $.globalComponents.select.errorText)}
                  label={t(($) => $.globalComponents.select.label)}
                  options={options}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Disabled">
                <SelectField
                  disabled
                  helperText={t(($) => $.globalComponents.select.helperText)}
                  label={t(($) => $.globalComponents.select.label)}
                  options={options}
                  placeholder={t(($) => $.globalComponents.select.placeholder)}
                  size={size.key}
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
    <div className="min-w-64 space-y-2 p-1">
      <p className="text-text-tertiary text-xs font-medium">{label}</p>
      {children}
    </div>
  )
}
