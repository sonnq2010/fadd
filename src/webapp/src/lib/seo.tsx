type SeoProps = {
  description: string
  title: string
}

export function Seo({ description, title }: SeoProps) {
  return (
    <>
      <title>{title}</title>
      <meta content={description} name="description" />
      <meta content={title} property="og:title" />
      <meta content={description} property="og:description" />
      <meta content="summary" name="twitter:card" />
    </>
  )
}
