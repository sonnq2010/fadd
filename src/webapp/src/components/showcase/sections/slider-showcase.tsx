import type { ReactNode } from 'react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Slider } from '@/components/ui/slider'

export function SliderShowcase() {
  const { t } = useTranslation('globalComponents')
  const [value, setValue] = useState([50])

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.slider.desc)}
      title={t(($) => $.globalComponents.slider.title)}
    >
      <div className="space-y-6">
        <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
          <StateExample label="Default (50%)">
            <div className="w-60">
              <Slider defaultValue={[50]} />
            </div>
          </StateExample>

          <StateExample label="Hover (50%)">
            <div className="w-60">
              <Slider
                defaultValue={[50]}
                className="[&_[data-slot=slider-thumb]]:border-bg-brand-hover"
              />
            </div>
          </StateExample>

          <StateExample label="Disabled (50%)">
            <div className="w-60">
              <Slider disabled defaultValue={[50]} />
            </div>
          </StateExample>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Interactive: {value[0]}%
          </h3>
          <div className="w-60">
            <Slider value={value} onValueChange={setValue} min={0} max={100} />
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
