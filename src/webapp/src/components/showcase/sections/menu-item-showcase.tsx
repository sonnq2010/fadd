import type { ReactNode } from 'react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Menu, MenuDivider, MenuItem } from '@/components/ui/menu-item'

export function MenuItemShowcase() {
  const { t } = useTranslation('globalComponents')
  const [showLineNumbers, setShowLineNumbers] = useState(true)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.menuItem.desc)}
      title={t(($) => $.globalComponents.menuItem.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <StateExample label="Default">
              <div className="w-[220px]">
                <MenuItem label="Menu item" shortcut="⌘K" />
              </div>
            </StateExample>

            <StateExample label="Hover">
              <div className="w-[220px]">
                <MenuItem
                  className="bg-bg-secondary-hover"
                  label="Menu item"
                  shortcut="⌘K"
                />
              </div>
            </StateExample>

            <StateExample label="Selected">
              <div className="w-[220px]">
                <MenuItem label="Menu item" selected shortcut="⌘K" />
              </div>
            </StateExample>

            <StateExample label="Disabled">
              <div className="w-[220px]">
                <MenuItem disabled label="Menu item" shortcut="⌘K" />
              </div>
            </StateExample>
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            {t(($) => $.globalComponents.menuItem.sampleTitle)}
          </h3>
          <Menu>
            <MenuItem label="Cut" />
            <MenuItem label="Copy" />
            <MenuItem label="Paste" />
            <MenuItem
              label="Show line numbers"
              selected={showLineNumbers}
              onClick={() => setShowLineNumbers(!showLineNumbers)}
            />
            <MenuDivider />
            <MenuItem destructive label="Delete" />
          </Menu>
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
