import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { MobileActionSheet } from '@/components/ui/mobile-action-sheet'

export function MobileActionSheetShowcase() {
  const { t } = useTranslation('globalComponents')
  const [lastAction, setLastAction] = useState<string | null>(null)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.mobileActionSheet.desc)}
      title={t(($) => $.globalComponents.mobileActionSheet.title)}
    >
      <div className="space-y-4">
        <div className="border-border-subtle w-fit overflow-hidden rounded-t-xl border shadow-md">
          <MobileActionSheet
            actions={[
              { label: 'Share', onClick: () => setLastAction('Share') },
              {
                label: 'Add to favorites',
                onClick: () => setLastAction('Add to favorites'),
              },
              {
                label: 'Duplicate',
                onClick: () => setLastAction('Duplicate'),
              },
              {
                destructive: true,
                label: 'Report',
                onClick: () => setLastAction('Report'),
              },
            ]}
            cancelLabel="Cancel"
            onCancel={() => setLastAction('Cancel')}
          />
        </div>
        {lastAction && (
          <p className="text-text-secondary text-sm">
            Last tapped action:{' '}
            <span className="text-text-brand font-semibold">{lastAction}</span>
          </p>
        )}
      </div>
    </ComponentDemo>
  )
}
