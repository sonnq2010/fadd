import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Button } from '@/components/ui/button'
import { ButtonGroup } from '@/components/ui/button-group'

const layouts = [
  { key: 'justify', label: 'Justify' },
  { key: 'start', label: 'Start' },
  { key: 'end', label: 'End' },
  { key: 'center', label: 'Center' },
  { key: 'stack', label: 'Stack' },
] as const

export function ButtonGroupShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.buttonGroup.desc)}
      title={t(($) => $.globalComponents.buttonGroup.title)}
    >
      <div className="space-y-6">
        {layouts.map((l) => (
          <div key={l.key} className="space-y-2">
            <h3 className="text-muted-foreground text-sm font-semibold tracking-wider uppercase">
              {l.label}
            </h3>
            <div className="bg-secondary/40 border-border max-w-[360px] rounded-lg border p-4">
              <ButtonGroup layout={l.key}>
                <Button variant="secondary">
                  {t(($) => $.globalComponents.buttonGroup.cancel)}
                </Button>
                <Button variant="primary">
                  {t(($) => $.globalComponents.buttonGroup.confirm)}
                </Button>
              </ButtonGroup>
            </div>
          </div>
        ))}
      </div>
    </ComponentDemo>
  )
}
