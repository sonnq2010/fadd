import { ChevronDown, Menu } from 'lucide-react'
import * as React from 'react'
import { useTranslation } from 'react-i18next'

import { ComponentDemo } from '@/components/showcase/component-demo'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Badge } from '@/components/ui/badge'
import { Checkbox } from '@/components/ui/checkbox'
import { IconButton } from '@/components/ui/icon-button'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'

interface UserRow {
  id: string
  name: string
  email: string
  initials: string
  status: 'Active' | 'Pending' | 'Inactive'
  variant: 'success' | 'warning' | 'secondary'
  role: string
}

const mockUsers: UserRow[] = [
  {
    id: '1',
    name: 'Alex Kim',
    email: 'alex@company.com',
    initials: 'AK',
    status: 'Active',
    variant: 'success',
    role: 'Admin',
  },
  {
    id: '2',
    name: 'Maria Jones',
    email: 'maria@company.com',
    initials: 'MJ',
    status: 'Pending',
    variant: 'warning',
    role: 'Editor',
  },
  {
    id: '3',
    name: 'Ryan Smith',
    email: 'ryan@company.com',
    initials: 'RS',
    status: 'Inactive',
    variant: 'secondary',
    role: 'Viewer',
  },
]

export function TableShowcase() {
  const { t } = useTranslation('globalComponents')
  const [selectedIds, setSelectedIds] = React.useState<string[]>([])

  const allSelected = selectedIds.length === mockUsers.length
  const isIndeterminate =
    selectedIds.length > 0 && selectedIds.length < mockUsers.length

  const handleSelectAll = () => {
    if (allSelected) {
      setSelectedIds([])
    } else {
      setSelectedIds(mockUsers.map((u) => u.id))
    }
  }

  const handleSelectRow = (id: string) => {
    setSelectedIds((prev) =>
      prev.includes(id) ? prev.filter((item) => item !== id) : [...prev, id],
    )
  }

  return (
    <ComponentDemo
      description={t(($) => $.globalComponents.table.desc)}
      title={t(($) => $.globalComponents.table.title)}
    >
      <div className="w-full">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-10">
                <Checkbox
                  checked={isIndeterminate ? 'indeterminate' : allSelected}
                  onCheckedChange={handleSelectAll}
                />
              </TableHead>
              <TableHead className="w-[220px]">
                <div className="flex items-center gap-1">
                  <span>{t(($) => $.globalComponents.table.colName)}</span>
                  <ChevronDown className="text-text-tertiary size-3" />
                </div>
              </TableHead>
              <TableHead className="w-[120px]">
                <div className="flex items-center gap-1">
                  <span>{t(($) => $.globalComponents.table.colStatus)}</span>
                  <ChevronDown className="text-text-tertiary size-3" />
                </div>
              </TableHead>
              <TableHead className="w-[140px]">
                <div className="flex items-center gap-1">
                  <span>{t(($) => $.globalComponents.table.colRole)}</span>
                  <ChevronDown className="text-text-tertiary size-3" />
                </div>
              </TableHead>
              <TableHead className="w-14" />
            </TableRow>
          </TableHeader>
          <TableBody>
            {mockUsers.map((user) => {
              const isSelected = selectedIds.includes(user.id)
              return (
                <TableRow
                  key={user.id}
                  data-state={isSelected ? 'selected' : undefined}
                >
                  <TableCell className="w-10">
                    <Checkbox
                      checked={isSelected}
                      onCheckedChange={() => handleSelectRow(user.id)}
                    />
                  </TableCell>
                  <TableCell className="w-[220px]">
                    <div className="flex items-center gap-2">
                      <Avatar size="sm">
                        <AvatarFallback className="bg-bg-brand text-text-on-brand text-xs font-medium">
                          {user.initials}
                        </AvatarFallback>
                      </Avatar>
                      <div className="flex flex-col">
                        <span className="text-text-primary text-sm font-normal">
                          {user.name}
                        </span>
                        <span className="text-text-tertiary text-[11px] leading-tight">
                          {user.email}
                        </span>
                      </div>
                    </div>
                  </TableCell>
                  <TableCell className="w-[120px]">
                    <Badge variant={user.variant}>{user.status}</Badge>
                  </TableCell>
                  <TableCell className="text-text-secondary w-[140px] text-sm">
                    {user.role}
                  </TableCell>
                  <TableCell className="w-14 text-right">
                    <IconButton
                      aria-label="Row actions"
                      size="small"
                      variant="ghost"
                    >
                      <Menu className="size-4" />
                    </IconButton>
                  </TableCell>
                </TableRow>
              )
            })}
          </TableBody>
        </Table>
      </div>
    </ComponentDemo>
  )
}
