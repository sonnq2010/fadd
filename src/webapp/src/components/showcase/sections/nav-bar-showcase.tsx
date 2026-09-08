import { ArrowUpRight, Bell, Plus } from 'lucide-react'
import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Button } from '@/components/ui/button'
import { IconButton } from '@/components/ui/icon-button'
import { NavBar } from '@/components/ui/nav-bar'

export function NavBarShowcase() {
  const { t } = useTranslation('globalComponents')
  const [selectedTabIndex, setSelectedTabIndex] = useState(0)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.navBar.desc)}
      title={t(($) => $.globalComponents.navBar.title)}
    >
      <div className="border-border-subtle w-full overflow-hidden rounded-md border shadow-xs">
        <NavBar
          actions={
            <>
              <IconButton
                aria-label="Notifications"
                size="medium"
                variant="ghost"
              >
                <Bell className="size-5" />
              </IconButton>
              <Button size="medium" variant="primary">
                <Plus className="size-4" />
                <span>New project</span>
                <ArrowUpRight className="size-4" />
              </Button>
            </>
          }
          brand="Acme"
          onTabSelected={setSelectedTabIndex}
          selectedTabIndex={selectedTabIndex}
          tabs={['Tab label', 'Tab label', 'Tab label']}
        />
      </div>
    </ComponentDemo>
  )
}
