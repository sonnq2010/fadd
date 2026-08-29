#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly WEBAPP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly REPOSITORY_DIR="$(cd "$WEBAPP_DIR/../.." && pwd)"

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
readonly TEMP_REPOSITORY="$temporary_dir/repository"
readonly TEMP_WEBAPP="$TEMP_REPOSITORY/src/webapp"

mkdir -p "$TEMP_WEBAPP"
tar \
  --exclude=node_modules \
  --exclude=.output \
  --exclude=dist \
  --exclude=coverage \
  --exclude=playwright-report \
  --exclude=test-results \
  --exclude=.tanstack \
  --exclude=.nitro \
  --exclude=.vinxi \
  -C "$WEBAPP_DIR" -cf - . | tar -C "$TEMP_WEBAPP" -xf -
mkdir -p "$TEMP_REPOSITORY/src/backend/api/apidocs"
cp "$REPOSITORY_DIR/src/backend/api/apidocs/main.yaml" "$TEMP_REPOSITORY/src/backend/api/apidocs/main.yaml"
ln -s "$WEBAPP_DIR/node_modules" "$TEMP_WEBAPP/node_modules"

rm -rf "$TEMP_WEBAPP/src/api-client"
rm -f "$TEMP_WEBAPP/src/routeTree.gen.ts"

(
  cd "$TEMP_WEBAPP"
  npm run api:generate
  npm run build
)

diff -ru "$WEBAPP_DIR/src/api-client" "$TEMP_WEBAPP/src/api-client"
diff -u "$WEBAPP_DIR/src/routeTree.gen.ts" "$TEMP_WEBAPP/src/routeTree.gen.ts"
