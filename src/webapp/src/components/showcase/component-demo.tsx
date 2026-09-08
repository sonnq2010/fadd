import * as React from 'react'

interface ComponentDemoProps {
  title: string
  description?: string
  children: React.ReactNode
}

export function ComponentDemo({
  title,
  description,
  children,
}: ComponentDemoProps) {
  return (
    <section
      className="border-border bg-card mb-12 rounded-xl border p-6 shadow-sm"
      data-testid="component-demo"
    >
      <div className="mb-4">
        <h2 className="text-foreground text-xl font-semibold">{title}</h2>
        {description && (
          <p className="text-muted-foreground mt-1 text-sm">{description}</p>
        )}
      </div>
      <div className="overflow-x-auto p-1 -m-1" data-testid="component-demo-content">
        {children}
      </div>
    </section>
  )
}
