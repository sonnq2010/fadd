import { useState } from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from '@/components/ui/pagination'

export function PaginationShowcase() {
  const { t } = useTranslation('globalComponents')
  const [currentPage, setCurrentPage] = useState(1)

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.pagination.desc)}
      title={t(($) => $.globalComponents.pagination.title)}
    >
      <div className="flex flex-col gap-6">
        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            States
          </h3>
          <div className="flex flex-wrap items-center gap-4">
            <div className="flex flex-col items-center gap-1">
              <span className="text-text-tertiary text-xs">Default</span>
              <PaginationLink>1</PaginationLink>
            </div>
            <div className="flex flex-col items-center gap-1">
              <span className="text-text-tertiary text-xs">Hover</span>
              <PaginationLink className="bg-bg-secondary-hover">
                1
              </PaginationLink>
            </div>
            <div className="flex flex-col items-center gap-1">
              <span className="text-text-tertiary text-xs">Active</span>
              <PaginationLink isActive>1</PaginationLink>
            </div>
            <div className="flex flex-col items-center gap-1">
              <span className="text-text-tertiary text-xs">Disabled</span>
              <PaginationLink disabled>1</PaginationLink>
            </div>
            <div className="flex flex-col items-center gap-1">
              <span className="text-text-tertiary text-xs">Ellipsis</span>
              <PaginationEllipsis />
            </div>
          </div>
        </div>

        <div>
          <h3 className="text-text-secondary mb-3 text-xs font-semibold tracking-wider uppercase">
            Composite
          </h3>
          <div className="w-fit">
            <Pagination>
              <PaginationContent>
                <PaginationItem>
                  <PaginationPrevious
                    onClick={(e) => {
                      e.preventDefault()
                      if (currentPage > 1) setCurrentPage(currentPage - 1)
                    }}
                  />
                </PaginationItem>
                <PaginationItem>
                  <PaginationLink
                    isActive={currentPage === 1}
                    onClick={(e) => {
                      e.preventDefault()
                      setCurrentPage(1)
                    }}
                  >
                    1
                  </PaginationLink>
                </PaginationItem>
                <PaginationItem>
                  <PaginationLink
                    isActive={currentPage === 2}
                    onClick={(e) => {
                      e.preventDefault()
                      setCurrentPage(2)
                    }}
                  >
                    2
                  </PaginationLink>
                </PaginationItem>
                <PaginationItem>
                  <PaginationLink
                    isActive={currentPage === 3}
                    onClick={(e) => {
                      e.preventDefault()
                      setCurrentPage(3)
                    }}
                  >
                    3
                  </PaginationLink>
                </PaginationItem>
                <PaginationItem>
                  <PaginationEllipsis />
                </PaginationItem>
                <PaginationItem>
                  <PaginationLink
                    isActive={currentPage === 12}
                    onClick={(e) => {
                      e.preventDefault()
                      setCurrentPage(12)
                    }}
                  >
                    12
                  </PaginationLink>
                </PaginationItem>
                <PaginationItem>
                  <PaginationNext
                    onClick={(e) => {
                      e.preventDefault()
                      if (currentPage < 12) setCurrentPage(currentPage + 1)
                    }}
                  />
                </PaginationItem>
              </PaginationContent>
            </Pagination>
          </div>
        </div>
      </div>
    </ComponentDemo>
  )
}
