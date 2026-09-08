import { ArrowLeft, Menu } from 'lucide-react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { IconButton } from '@/components/ui/icon-button'
import { MobileTopAppBar } from '@/components/ui/mobile-top-app-bar'

export function MobileTopAppBarShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.mobileTopAppBar.desc)}
      title={t(($) => $.globalComponents.mobileTopAppBar.title)}
    >
      <div className="border-border-subtle w-fit overflow-hidden rounded-md border shadow-xs">
        <MobileTopAppBar
          leading={
            <IconButton aria-label="Back" size="medium" variant="ghost">
              <ArrowLeft className="size-5" />
            </IconButton>
          }
          title="Screen title"
          trailing={
            <IconButton aria-label="Menu" size="medium" variant="ghost">
              <Menu className="size-5" />
            </IconButton>
          }
        />
      </div>
    </ComponentDemo>
  )
}
