import type { ReactNode } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { TextareaField } from '@/components/ui/textarea-field'

export function TextareaFieldShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.textareaField.desc)}
      title={t(($) => $.globalComponents.textareaField.title)}
    >
      <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
        <StateExample label="Default">
          <TextareaField
            helperText={t(($) => $.globalComponents.textareaField.helperText)}
            label={t(($) => $.globalComponents.textareaField.label)}
            placeholder={t(($) => $.globalComponents.textareaField.placeholder)}
          />
        </StateExample>

        <StateExample label="Focus">
          <TextareaField
            className="border-border-focus ring-border-focus/45 ring-[3px]"
            helperText={t(($) => $.globalComponents.textareaField.helperText)}
            label={t(($) => $.globalComponents.textareaField.label)}
            placeholder={t(($) => $.globalComponents.textareaField.placeholder)}
          />
        </StateExample>

        <StateExample label="Filled">
          <TextareaField
            defaultValue={t(
              ($) => $.globalComponents.textareaField.filledValue,
            )}
            helperText={t(($) => $.globalComponents.textareaField.helperText)}
            label={t(($) => $.globalComponents.textareaField.label)}
          />
        </StateExample>

        <StateExample label="Error">
          <TextareaField
            defaultValue={t(
              ($) => $.globalComponents.textareaField.invalidValue,
            )}
            errorText={t(($) => $.globalComponents.textareaField.errorText)}
            label={t(($) => $.globalComponents.textareaField.label)}
          />
        </StateExample>

        <StateExample label="Disabled">
          <TextareaField
            disabled
            helperText={t(($) => $.globalComponents.textareaField.helperText)}
            label={t(($) => $.globalComponents.textareaField.label)}
            placeholder={t(($) => $.globalComponents.textareaField.placeholder)}
          />
        </StateExample>
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
