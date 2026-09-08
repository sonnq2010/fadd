import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Avatar, AvatarBadge, AvatarFallback } from '@/components/ui/avatar'

const sizes = [
  { label: 'XL (64px)', size: 'xl' },
  { label: 'L (48px)', size: 'lg' },
  { label: 'M (36px)', size: 'md' },
  { label: 'S (28px)', size: 'sm' },
  { label: 'XS (20px)', size: 'xs' },
] as const

export function AvatarShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.avatar.desc)}
      title={t(($) => $.globalComponents.avatar.title)}
    >
      <div className="space-y-6">
        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            Initial Avatars (XL to XS)
          </h3>
          <div className="flex flex-wrap items-center gap-6">
            {sizes.map((item) => (
              <div className="flex flex-col items-center gap-2" key={item.size}>
                <Avatar size={item.size}>
                  <AvatarFallback>JD</AvatarFallback>
                </Avatar>
                <span className="text-text-tertiary text-xs">{item.label}</span>
              </div>
            ))}
          </div>
        </div>

        <div className="space-y-3">
          <h3 className="text-text-secondary text-sm font-semibold tracking-wider uppercase">
            With Status Indicator
          </h3>
          <div className="flex flex-wrap items-center gap-6">
            {sizes.map((item) => (
              <div className="flex flex-col items-center gap-2" key={item.size}>
                <Avatar size={item.size}>
                  <AvatarFallback>JD</AvatarFallback>
                  <AvatarBadge />
                </Avatar>
                <span className="text-text-tertiary text-xs">{item.label}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}
