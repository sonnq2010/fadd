import type { ReactNode } from 'react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { TabItem, TabsNav } from '@/components/ui/tab-item'

const tabCounts = [5, 4, 3, 2] as const

export function TabItemShowcase() {
  const { t } = useTranslation('globalComponents')
  const [selectedIndexes, setSelectedIndexes] = useState<
    Record<number, number>
  >({})

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.tabItem.desc)}
      title={t(($) => $.globalComponents.tabItem.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex flex-wrap gap-6">
            <StateExample label="Default">
              <TabItem label="Tab label" />
            </StateExample>
            <StateExample label="Hover">
              <TabItem className="text-text-primary" label="Tab label" />
            </StateExample>
            <StateExample label="Active">
              <TabItem isActive label="Tab label" />
            </StateExample>
            <StateExample label="Disabled">
              <TabItem disabled label="Tab label" />
            </StateExample>
          </div>
        </div>

        <div className="space-y-5">
          {tabCounts.map((count) => (
            <div className="space-y-2" key={count}>
              <p className="text-text-secondary text-sm font-semibold">
                {count} Tabs
              </p>
              <div className="overflow-x-auto">
                <TabsNav
                  onTabSelected={(index) =>
                    setSelectedIndexes((current) => ({
                      ...current,
                      [count]: index,
                    }))
                  }
                  selectedIndex={selectedIndexes[count] ?? 0}
                  tabs={Array.from({ length: count }, () => 'Tab label')}
                />
              </div>
            </div>
          ))}
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
    <div className="min-w-28 space-y-2">
      <p className="text-text-tertiary text-xs font-medium">{label}</p>
      {children}
    </div>
  )
}
