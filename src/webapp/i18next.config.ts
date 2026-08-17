import { defineConfig } from 'i18next-cli'

export default defineConfig({
  locales: ['en', 'vi'],
  extract: {
    defaultNS: 'layout',
    defaultValue: (key, _namespace, language) => (language === 'en' ? key : ''),
    ignore: ['src/api-client/**', 'src/i18n/generated/**', 'src/test/**'],
    input: ['src/**/*.{ts,tsx}'],
    output: 'src/i18n/locales/{{language}}/{{namespace}}.json',
    primaryLanguage: 'en',
    removeUnusedKeys: true,
    sort: true,
  },
  types: {
    basePath: 'src/i18n/locales/en',
    enableSelector: 'strict',
    input: ['src/i18n/locales/en/*.json'],
    output: 'src/i18n/generated/i18next.d.ts',
    resourcesFile: 'src/i18n/generated/resources.d.ts',
  },
})
