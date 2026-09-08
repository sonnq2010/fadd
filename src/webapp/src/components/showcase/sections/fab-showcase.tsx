import { Plus } from 'lucide-react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Fab } from '@/components/ui/fab'

const sizes = [
  { key: 'large', label: 'Large (72px)' },
  { key: 'medium', label: 'Medium (56px)' },
  { key: 'small', label: 'Small (40px)' },
] as const

export function FabShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.fab.desc)}
      title={t(($) => $.globalComponents.fab.title)}
    >
      <div className="overflow-x-auto">
        <table className="w-full border-collapse text-left">
          <thead>
            <tr className="border-border text-muted-foreground border-b text-xs">
              <th className="py-2 pr-4 font-medium">Size</th>
              <th className="px-4 py-2 font-medium">Default</th>
              <th className="px-4 py-2 font-medium">Disabled</th>
            </tr>
          </thead>
          <tbody className="divide-border divide-y">
            {sizes.map((s) => (
              <tr key={s.key}>
                <td className="py-3 pr-4 font-mono text-xs capitalize">
                  {s.label}
                </td>
                <td className="px-4 py-3">
                  <Fab aria-label={`${s.label} action`} size={s.key}>
                    <Plus />
                  </Fab>
                </td>
                <td className="px-4 py-3">
                  <Fab
                    aria-label={`${s.label} disabled action`}
                    disabled
                    size={s.key}
                  >
                    <Plus />
                  </Fab>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </ComponentDemo>
  )
}
