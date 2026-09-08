import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion'

export function AccordionShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.accordion.desc)}
      title={t(($) => $.globalComponents.accordion.title)}
    >
      <div className="w-full max-w-[360px]">
        <Accordion collapsible defaultValue="item-2" type="single">
          <AccordionItem value="item-1">
            <AccordionTrigger>
              {t(($) => $.globalComponents.accordion.itemTitle)}
            </AccordionTrigger>
            <AccordionContent>
              {t(($) => $.globalComponents.accordion.itemContent)}
            </AccordionContent>
          </AccordionItem>

          <AccordionItem value="item-2">
            <AccordionTrigger>
              {t(($) => $.globalComponents.accordion.itemTitle)}
            </AccordionTrigger>
            <AccordionContent>
              {t(($) => $.globalComponents.accordion.itemContent)}
            </AccordionContent>
          </AccordionItem>
        </Accordion>
      </div>
    </ComponentDemo>
  )
}
