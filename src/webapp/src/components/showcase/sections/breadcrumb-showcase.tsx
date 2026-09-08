import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from '@/components/ui/breadcrumb'

export function BreadcrumbShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.breadcrumb.desc)}
      title={t(($) => $.globalComponents.breadcrumb.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex flex-wrap items-center gap-6">
            <div className="flex items-center gap-2">
              <span className="text-text-tertiary text-xs">Default:</span>
              <BreadcrumbLink href="#">Section</BreadcrumbLink>
              <BreadcrumbSeparator />
            </div>
            <div className="flex items-center gap-2">
              <span className="text-text-tertiary text-xs">Hover:</span>
              <BreadcrumbLink className="text-text-brand" href="#">
                Section
              </BreadcrumbLink>
              <BreadcrumbSeparator />
            </div>
            <div className="flex items-center gap-2">
              <span className="text-text-tertiary text-xs">Current:</span>
              <BreadcrumbPage>Section</BreadcrumbPage>
            </div>
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Composite
          </h3>
          <Breadcrumb>
            <BreadcrumbList>
              <BreadcrumbItem>
                <BreadcrumbLink href="#">
                  {t(($) => $.globalComponents.breadcrumb.home)}
                </BreadcrumbLink>
              </BreadcrumbItem>
              <BreadcrumbSeparator />
              <BreadcrumbItem>
                <BreadcrumbLink href="#">
                  {t(($) => $.globalComponents.breadcrumb.projects)}
                </BreadcrumbLink>
              </BreadcrumbItem>
              <BreadcrumbSeparator />
              <BreadcrumbItem>
                <BreadcrumbPage>
                  {t(($) => $.globalComponents.breadcrumb.designSystem)}
                </BreadcrumbPage>
              </BreadcrumbItem>
            </BreadcrumbList>
          </Breadcrumb>
        </div>
      </div>
    </ComponentDemo>
  )
}
