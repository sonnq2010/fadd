import { Plus } from 'lucide-react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { IconButton } from '@/components/ui/icon-button'

const variants = [
  'primary',
  'secondary',
  'outline',
  'ghost',
  'destructive',
  'destructiveOutline',
] as const

const sizes = [
  { key: 'large', label: 'Large (48px)' },
  { key: 'medium', label: 'Medium (40px)' },
  { key: 'small', label: 'Small (36px)' },
] as const

export function IconButtonShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.iconButton.desc)}
      title={t(($) => $.globalComponents.iconButton.title)}
    >
      <div className="space-y-8">
        {sizes.map((s) => (
          <div key={s.key} className="space-y-3">
            <h3 className="text-muted-foreground text-sm font-semibold tracking-wider uppercase">
              {s.label}
            </h3>
            <div className="overflow-x-auto">
              <table className="w-full border-collapse text-left">
                <thead>
                  <tr className="border-border text-muted-foreground border-b text-xs">
                    <th className="py-2 pr-4 font-medium">Variant</th>
                    <th className="px-4 py-2 font-medium">Default</th>
                    <th className="px-4 py-2 font-medium">Disabled</th>
                  </tr>
                </thead>
                <tbody className="divide-border divide-y">
                  {variants.map((v) => (
                    <tr key={v}>
                      <td className="py-3 pr-4 font-mono text-xs capitalize">
                        {v}
                      </td>
                      <td className="px-4 py-3">
                        <IconButton
                          aria-label={`${v} ${s.key} action`}
                          size={s.key}
                          variant={v}
                        >
                          <Plus />
                        </IconButton>
                      </td>
                      <td className="px-4 py-3">
                        <IconButton
                          aria-label={`${v} ${s.key} disabled action`}
                          disabled
                          size={s.key}
                          variant={v}
                        >
                          <Plus />
                        </IconButton>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        ))}
      </div>
    </ComponentDemo>
  )
}
