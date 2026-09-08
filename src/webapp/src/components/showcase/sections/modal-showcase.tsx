import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Button } from '@/components/ui/button'
import { Modal, ModalCard } from '@/components/ui/modal'

export function ModalShowcase() {
  const { t } = useTranslation('globalComponents')
  const [open, setOpen] = useState(false)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.modal.desc)}
      title={t(($) => $.globalComponents.modal.title)}
    >
      <div className="flex flex-col gap-6">
        {/* Static preview */}
        <ModalCard
          cancelLabel={t(($) => $.globalComponents.buttonGroup.cancel)}
          confirmLabel={t(($) => $.globalComponents.modal.delete)}
          description={t(($) => $.globalComponents.modal.sampleDesc)}
          title={t(($) => $.globalComponents.modal.sampleTitle)}
        />

        {/* Interactive trigger */}
        <div>
          <Modal
            onOpenChange={setOpen}
            open={open}
            trigger={
              <Button size="small" variant="secondary">
                {t(($) => $.globalComponents.modal.openModal)}
              </Button>
            }
          >
            <ModalCard
              cancelLabel={t(($) => $.globalComponents.buttonGroup.cancel)}
              confirmLabel={t(($) => $.globalComponents.modal.delete)}
              description={t(($) => $.globalComponents.modal.sampleDesc)}
              onCancel={() => setOpen(false)}
              onClose={() => setOpen(false)}
              onConfirm={() => setOpen(false)}
              title={t(($) => $.globalComponents.modal.sampleTitle)}
            />
          </Modal>
        </div>
      </div>
    </ComponentDemo>
  )
}
