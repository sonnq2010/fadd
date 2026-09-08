import { Bell, Home, Mail, Search, User } from 'lucide-react'
import type { ReactNode } from 'react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import {
  MobileBottomTabBar,
  MobileBottomTabItem,
} from '@/components/ui/bottom-tab-item'

export function BottomTabItemShowcase() {
  const { t } = useTranslation('globalComponents')
  const [selectedIndex, setSelectedIndex] = useState(0)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.bottomTabItem.desc)}
      title={t(($) => $.globalComponents.bottomTabItem.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex gap-8">
            <StateExample label="Default">
              <div className="w-[67.5px]">
                <MobileBottomTabItem icon={<Home />} label="Home" />
              </div>
            </StateExample>
            <StateExample label="Active">
              <div className="w-[67.5px]">
                <MobileBottomTabItem icon={<Home />} isActive label="Home" />
              </div>
            </StateExample>
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Mobile / Bottom Tab Bar
          </h3>
          <div className="border-border-subtle w-fit overflow-hidden rounded-md border shadow-xs">
            <MobileBottomTabBar
              items={[
                { icon: <Home />, label: 'Home' },
                { icon: <Search />, label: 'Search' },
                { icon: <Bell />, label: 'Notifications' },
                { icon: <Mail />, label: 'Messages' },
                { icon: <User />, label: 'Profile' },
              ]}
              onTabSelected={setSelectedIndex}
              selectedIndex={selectedIndex}
            />
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
