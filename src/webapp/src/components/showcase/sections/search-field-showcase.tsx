import type { ReactNode } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { SearchField } from '@/components/ui/search-field'

const sizes = [
  { key: 'large', label: 'Large (48px)' },
  { key: 'medium', label: 'Medium (40px)' },
  { key: 'small', label: 'Small (36px)' },
] as const

export function SearchFieldShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.searchField.desc)}
      title={t(($) => $.globalComponents.searchField.title)}
    >
      <div className="space-y-8">
        {sizes.map((size) => (
          <div key={size.key} className="space-y-3">
            <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
              {size.label}
            </h3>
            <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
              <StateExample label="Default">
                <SearchField
                  placeholder={t(
                    ($) => $.globalComponents.searchField.placeholder,
                  )}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Focus">
                <SearchField
                  className="border-border-brand ring-border-brand/45 ring-[3px]"
                  placeholder={t(
                    ($) => $.globalComponents.searchField.placeholder,
                  )}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Filled">
                <SearchField
                  defaultValue={t(
                    ($) => $.globalComponents.searchField.filledValue,
                  )}
                  size={size.key}
                />
              </StateExample>

              <StateExample label="Disabled">
                <SearchField
                  disabled
                  placeholder={t(
                    ($) => $.globalComponents.searchField.placeholder,
                  )}
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
    <div className="min-w-56 space-y-2">
      <p className="text-text-tertiary text-xs font-medium">{label}</p>
      {children}
    </div>
  )
}
