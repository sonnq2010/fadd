import { Link } from '@tanstack/react-router'
import { MenuIcon } from 'lucide-react'
import { useTranslation } from 'react-i18next'

import { LanguageSwitcher } from '@/components/language-switcher'
import { Button } from '@/components/ui/button'
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from '@/components/ui/sheet'
import { useAppStore } from '@/stores/app-store'

export function Header() {
  const { t } = useTranslation('layout')
  const publicLinks = [
    { label: t(($) => $.layout.navigation.about), to: '/about' },
    { label: t(($) => $.layout.navigation.pricing), to: '/pricing' },
  ] as const
  const mobileNavigationOpen = useAppStore(
    (state) => state.mobileNavigationOpen,
  )
  const closeMobileNavigation = useAppStore(
    (state) => state.closeMobileNavigation,
  )
  const setMobileNavigationOpen = useAppStore(
    (state) => state.setMobileNavigationOpen,
  )

  return (
    <header className="bg-background/90 sticky top-0 z-40 border-b backdrop-blur">
      <div className="mx-auto flex h-16 w-full max-w-7xl items-center justify-between px-6">
        <Link className="font-heading text-lg font-semibold" to="/">
          {t(($) => $.layout.app.name)}
        </Link>

        <nav
          aria-label={t(($) => $.layout.navigation.primaryLabel)}
          className="hidden items-center gap-1 md:flex"
        >
          {publicLinks.map((link) => (
            <Button asChild key={link.to} variant="ghost">
              <Link to={link.to}>{link.label}</Link>
            </Button>
          ))}
        </nav>

        <div className="flex items-center gap-2">
          <LanguageSwitcher />
          <Sheet
            onOpenChange={setMobileNavigationOpen}
            open={mobileNavigationOpen}
          >
            <SheetTrigger asChild>
              <Button
                aria-label={t(($) => $.layout.navigation.open)}
                className="md:hidden"
                size="icon"
                variant="outline"
              >
                <MenuIcon />
              </Button>
            </SheetTrigger>
            <SheetContent>
              <SheetHeader>
                <SheetTitle>{t(($) => $.layout.navigation.title)}</SheetTitle>
              </SheetHeader>
              <nav
                aria-label={t(($) => $.layout.navigation.mobileLabel)}
                className="flex flex-col gap-2 px-4"
              >
                {publicLinks.map((link) => (
                  <Button asChild key={link.to} variant="ghost">
                    <Link onClick={closeMobileNavigation} to={link.to}>
                      {link.label}
                    </Link>
                  </Button>
                ))}
              </nav>
            </SheetContent>
          </Sheet>
        </div>
      </div>
    </header>
  )
}
