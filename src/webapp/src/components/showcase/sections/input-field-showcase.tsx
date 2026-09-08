import type { ReactNode } from 'react'
import { Search, X } from 'lucide-react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { InputField } from '@/components/ui/input-field'

const sizes = [
  { key: 'large', label: 'Large (48px)' },
  { key: 'medium', label: 'Medium (40px)' },
  { key: 'small', label: 'Small (36px)' },
] as const

export function InputFieldShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.inputField.desc)}
      title={t(($) => $.globalComponents.inputField.title)}
    >
      <div className="space-y-8">
        {sizes.map((size) => (
          <div key={size.key} className="space-y-3">
            <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
              {size.label}
            </h3>
            <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
              <StateExample label="Default">
                <InputField
                  helperText={t(
                    ($) => $.globalComponents.inputField.helperText,
                  )}
                  label={t(($) => $.globalComponents.inputField.label)}
                  leadingIcon={<Search />}
                  placeholder={t(
                    ($) => $.globalComponents.inputField.placeholder,
                  )}
                  size={size.key}
                  trailingIcon={<X />}
                />
              </StateExample>

              <StateExample label="Focus">
                <InputField
                  className="border-border-focus ring-border-focus/45 ring-[3px]"
                  helperText={t(
                    ($) => $.globalComponents.inputField.helperText,
                  )}
                  label={t(($) => $.globalComponents.inputField.label)}
                  leadingIcon={<Search />}
                  placeholder={t(
                    ($) => $.globalComponents.inputField.placeholder,
                  )}
                  size={size.key}
                  trailingIcon={<X />}
                />
              </StateExample>

              <StateExample label="Filled">
                <InputField
                  defaultValue={t(
                    ($) => $.globalComponents.inputField.filledValue,
                  )}
                  helperText={t(
                    ($) => $.globalComponents.inputField.helperText,
                  )}
                  label={t(($) => $.globalComponents.inputField.label)}
                  leadingIcon={<Search />}
                  size={size.key}
                  trailingIcon={<X />}
                />
              </StateExample>

              <StateExample label="Error">
                <InputField
                  defaultValue={t(
                    ($) => $.globalComponents.inputField.filledValue,
                  )}
                  errorText={t(($) => $.globalComponents.inputField.errorText)}
                  label={t(($) => $.globalComponents.inputField.label)}
                  leadingIcon={<Search />}
                  size={size.key}
                  trailingIcon={<X />}
                />
              </StateExample>

              <StateExample label="Disabled">
                <InputField
                  disabled
                  helperText={t(
                    ($) => $.globalComponents.inputField.helperText,
                  )}
                  label={t(($) => $.globalComponents.inputField.label)}
                  leadingIcon={<Search />}
                  placeholder={t(
                    ($) => $.globalComponents.inputField.placeholder,
                  )}
                  size={size.key}
                  trailingIcon={<X />}
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
    <div className="min-w-64 space-y-2">
      <p className="text-text-tertiary text-xs font-medium">{label}</p>
      {children}
    </div>
  )
}
