import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Button } from '@/components/ui/button'
import {
  Tooltip,
  TooltipBubble,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from '@/components/ui/tooltip'

export function TooltipShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.tooltip.desc)}
      title={t(($) => $.globalComponents.tooltip.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Positions (Static)
          </h3>
          <div className="flex flex-wrap items-center gap-8">
            <TooltipBubble
              label={t(($) => $.globalComponents.tooltip.text)}
              position="top"
            />
            <TooltipBubble
              label={t(($) => $.globalComponents.tooltip.text)}
              position="bottom"
            />
            <TooltipBubble
              label={t(($) => $.globalComponents.tooltip.text)}
              position="left"
            />
            <TooltipBubble
              label={t(($) => $.globalComponents.tooltip.text)}
              position="right"
            />
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Interactive (Hover / Focus)
          </h3>
          <TooltipProvider>
            <div className="flex flex-wrap items-center gap-4">
              <Tooltip>
                <TooltipTrigger asChild>
                  <Button size="small" variant="outline">
                    Top
                  </Button>
                </TooltipTrigger>
                <TooltipContent side="top">
                  {t(($) => $.globalComponents.tooltip.text)}
                </TooltipContent>
              </Tooltip>

              <Tooltip>
                <TooltipTrigger asChild>
                  <Button size="small" variant="outline">
                    Bottom
                  </Button>
                </TooltipTrigger>
                <TooltipContent side="bottom">
                  {t(($) => $.globalComponents.tooltip.text)}
                </TooltipContent>
              </Tooltip>

              <Tooltip>
                <TooltipTrigger asChild>
                  <Button size="small" variant="outline">
                    Left
                  </Button>
                </TooltipTrigger>
                <TooltipContent side="left">
                  {t(($) => $.globalComponents.tooltip.text)}
                </TooltipContent>
              </Tooltip>

              <Tooltip>
                <TooltipTrigger asChild>
                  <Button size="small" variant="outline">
                    Right
                  </Button>
                </TooltipTrigger>
                <TooltipContent side="right">
                  {t(($) => $.globalComponents.tooltip.text)}
                </TooltipContent>
              </Tooltip>
            </div>
          </TooltipProvider>
        </div>
      </div>
    </ComponentDemo>
  )
}
