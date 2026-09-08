import * as React from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Chip } from '@/components/ui/chip'

export function ChipShowcase() {
  const { t } = useTranslation('globalComponents')
  const [selectedFilters, setSelectedFilters] = React.useState<string[]>([
    'Design',
  ])

  const toggleFilter = (filter: string) => {
    setSelectedFilters((prev) =>
      prev.includes(filter)
        ? prev.filter((item) => item !== filter)
        : [...prev, filter],
    )
  }

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.chip.desc)}
      title={t(($) => $.globalComponents.chip.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex flex-wrap items-center gap-3">
            <Chip>Default</Chip>
            <Chip className="bg-bg-secondary-hover">Hover</Chip>
            <Chip selected>Selected</Chip>
            <Chip disabled>Disabled</Chip>
            <Chip onRemove={() => {}}>Removable</Chip>
            <Chip onRemove={() => {}} selected>
              Selected Removable
            </Chip>
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Interactive Filter Group
          </h3>
          <div className="flex flex-wrap items-center gap-2">
            {['Design', 'Development', 'Marketing', 'Sales'].map((filter) => {
              const isSelected = selectedFilters.includes(filter)
              return (
                <Chip
                  key={filter}
                  onClick={() => toggleFilter(filter)}
                  selected={isSelected}
                >
                  {filter}
                </Chip>
              )
            })}
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}
