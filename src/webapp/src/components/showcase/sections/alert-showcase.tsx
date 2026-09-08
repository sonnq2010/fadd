import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Alert } from '@/components/ui/alert'

export function AlertShowcase() {
  const { t } = useTranslation('globalComponents')

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.alert.desc)}
      title={t(($) => $.globalComponents.alert.title)}
    >
      <div className="flex max-w-[360px] flex-col gap-3">
        <Alert variant="success">
          {t(($) => $.globalComponents.alert.successMsg)}
        </Alert>
        <Alert variant="warning">
          {t(($) => $.globalComponents.alert.warningMsg)}
        </Alert>
        <Alert variant="error">
          {t(($) => $.globalComponents.alert.errorMsg)}
        </Alert>
        <Alert variant="info">
          {t(($) => $.globalComponents.alert.infoMsg)}
        </Alert>
      </div>
    </ComponentDemo>
  )
}
