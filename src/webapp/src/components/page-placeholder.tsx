import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'

interface PagePlaceholderProps {
  title: string
}

export function PagePlaceholder({ title }: PagePlaceholderProps) {
  return (
    <section className="mx-auto flex w-full max-w-5xl flex-1 items-center px-6 py-16">
      <Card className="bg-card/60 w-full border-dashed">
        <CardHeader>
          <CardTitle>
            <h1>{title}</h1>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="bg-muted/40 h-32 rounded-md border border-dashed" />
        </CardContent>
      </Card>
    </section>
  )
}
