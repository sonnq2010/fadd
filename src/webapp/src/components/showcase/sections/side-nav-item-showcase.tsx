import { Home } from 'lucide-react'
import type { ReactNode } from 'react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { SideNavItem } from '@/components/ui/side-nav-item'

export function SideNavItemShowcase() {
  const { t } = useTranslation('globalComponents')
  const [activeItem, setActiveItem] = useState('Home')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.sideNavItem.desc)}
      title={t(($) => $.globalComponents.sideNavItem.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            <StateExample label="Default">
              <SideNavItem icon={<Home />} label="Nav item" />
            </StateExample>
            <StateExample label="Hover">
              <SideNavItem
                className="bg-bg-secondary-hover text-text-primary [&_svg]:text-text-primary"
                icon={<Home />}
                label="Nav item"
              />
            </StateExample>
            <StateExample label="Active">
              <SideNavItem icon={<Home />} isActive label="Nav item" />
            </StateExample>
            <StateExample label="Disabled">
              <SideNavItem disabled icon={<Home />} label="Nav item" />
            </StateExample>
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Interactive List
          </h3>
          <div className="border-border-subtle w-fit rounded-md border p-2">
            {['Home', 'Projects', 'Analytics', 'Settings'].map((item) => (
              <SideNavItem
                icon={<Home />}
                isActive={activeItem === item}
                key={item}
                label={item}
                onClick={() => setActiveItem(item)}
              />
            ))}
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
    <div className="space-y-2">
      <p className="text-text-tertiary text-xs font-medium">{label}</p>
      {children}
    </div>
  )
}
