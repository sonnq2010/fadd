import { createFileRoute } from '@tanstack/react-router'
import { Moon, Sun } from 'lucide-react'
import * as React from 'react'
import { useTranslation } from 'react-i18next'

import { LanguageSwitcher } from '@/components/language-switcher'
import { ButtonGroupShowcase } from '@/components/showcase/sections/button-group-showcase'
import { ButtonShowcase } from '@/components/showcase/sections/button-showcase'
import { FabShowcase } from '@/components/showcase/sections/fab-showcase'
import { IconButtonShowcase } from '@/components/showcase/sections/icon-button-showcase'
import { InputFieldShowcase } from '@/components/showcase/sections/input-field-showcase'
import { SearchFieldShowcase } from '@/components/showcase/sections/search-field-showcase'
import { SelectShowcase } from '@/components/showcase/sections/select-showcase'
import { CheckboxShowcase } from '@/components/showcase/sections/checkbox-showcase'
import { RadioShowcase } from '@/components/showcase/sections/radio-showcase'
import { SwitchShowcase } from '@/components/showcase/sections/switch-showcase'
import { TabItemShowcase } from '@/components/showcase/sections/tab-item-showcase'
import { NavBarShowcase } from '@/components/showcase/sections/nav-bar-showcase'
import { SideNavItemShowcase } from '@/components/showcase/sections/side-nav-item-showcase'
import { BottomTabItemShowcase } from '@/components/showcase/sections/bottom-tab-item-showcase'
import { MobileTopAppBarShowcase } from '@/components/showcase/sections/mobile-top-app-bar-showcase'
import { MobileActionSheetShowcase } from '@/components/showcase/sections/mobile-action-sheet-showcase'
import { BadgeShowcase } from '@/components/showcase/sections/badge-showcase'
import { CardShowcase } from '@/components/showcase/sections/card-showcase'
import { AvatarShowcase } from '@/components/showcase/sections/avatar-showcase'
import { AlertShowcase } from '@/components/showcase/sections/alert-showcase'
import { TooltipShowcase } from '@/components/showcase/sections/tooltip-showcase'
import { ModalShowcase } from '@/components/showcase/sections/modal-showcase'
import { AccordionShowcase } from '@/components/showcase/sections/accordion-showcase'
import { PaginationShowcase } from '@/components/showcase/sections/pagination-showcase'
import { BreadcrumbShowcase } from '@/components/showcase/sections/breadcrumb-showcase'
import { StepperShowcase } from '@/components/showcase/sections/stepper-showcase'
import { ProgressBarShowcase } from '@/components/showcase/sections/progress-bar-showcase'
import { TableShowcase } from '@/components/showcase/sections/table-showcase'
import { DividerShowcase } from '@/components/showcase/sections/divider-showcase'
import { ChipShowcase } from '@/components/showcase/sections/chip-showcase'
import { SliderShowcase } from '@/components/showcase/sections/slider-showcase'
import { MenuItemShowcase } from '@/components/showcase/sections/menu-item-showcase'
import { TextareaFieldShowcase } from '@/components/showcase/sections/textarea-field-showcase'
import { Button } from '@/components/ui/button'

export const Route = createFileRoute('/global-components')({
  component: GlobalComponentsPage,
})

function GlobalComponentsPage() {
  const { t } = useTranslation('globalComponents')
  const [isDark, setIsDark] = React.useState(true)

  React.useEffect(() => {
    const isDarkCurrent = document.documentElement.classList.contains('dark')
    setIsDark(isDarkCurrent)
  }, [])

  const toggleTheme = () => {
    const next = !isDark
    setIsDark(next)
    if (next) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }

  return (
    <div
      className="container mx-auto max-w-6xl px-4 py-8"
      data-testid="global-components-container"
    >
      <header className="border-border mb-8 flex flex-col gap-4 border-b pb-6 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-foreground text-3xl font-bold tracking-tight">
            {t(($) => $.globalComponents.title)}
          </h1>
          <p className="text-muted-foreground mt-1 text-sm">
            Figma Design System Components (33 families)
          </p>
        </div>
        <div className="flex items-center gap-3">
          <Button
            aria-label="Toggle theme"
            onClick={toggleTheme}
            size="small"
            variant="outline"
          >
            {isDark ? <Sun className="size-4" /> : <Moon className="size-4" />}
            {isDark
              ? t(($) => $.globalComponents.light)
              : t(($) => $.globalComponents.dark)}
          </Button>
          <LanguageSwitcher />
        </div>
      </header>

      <div className="space-y-12">
        <ButtonShowcase />
        <IconButtonShowcase />
        <FabShowcase />
        <ButtonGroupShowcase />
        <InputFieldShowcase />
        <SelectShowcase />
        <SearchFieldShowcase />
        <TextareaFieldShowcase />
        <CheckboxShowcase />
        <RadioShowcase />
        <SwitchShowcase />
        <SliderShowcase />
        <MenuItemShowcase />
        <TabItemShowcase />
        <NavBarShowcase />
        <SideNavItemShowcase />
        <BottomTabItemShowcase />
        <MobileTopAppBarShowcase />
        <MobileActionSheetShowcase />
        <BadgeShowcase />
        <CardShowcase />
        <AvatarShowcase />
        <AlertShowcase />
        <TooltipShowcase />
        <ModalShowcase />
        <AccordionShowcase />
        <PaginationShowcase />
        <BreadcrumbShowcase />
        <StepperShowcase />
        <ProgressBarShowcase />
        <TableShowcase />
        <DividerShowcase />
        <ChipShowcase />
      </div>
    </div>
  )
}
