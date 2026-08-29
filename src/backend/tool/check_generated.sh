#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKEND_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
readonly GENERATED_DIR="$temporary_dir/backend"

cp -R "$BACKEND_DIR" "$GENERATED_DIR"
rm -f \
  "$GENERATED_DIR/internal/handler/routes.go" \
  "$GENERATED_DIR/internal/types/types.go" \
  "$GENERATED_DIR/api/apidocs/main.yaml"
rm -rf "$GENERATED_DIR/internal/repository/sqlc"

make -s -C "$GENERATED_DIR" gen

diff -u \
  "$BACKEND_DIR/internal/handler/routes.go" \
  "$GENERATED_DIR/internal/handler/routes.go"
diff -u \
  "$BACKEND_DIR/internal/types/types.go" \
  "$GENERATED_DIR/internal/types/types.go"
diff -ru \
  "$BACKEND_DIR/internal/repository/sqlc" \
  "$GENERATED_DIR/internal/repository/sqlc"

sed -E '/^x-date: /d' "$BACKEND_DIR/api/apidocs/main.yaml" > "$temporary_dir/committed-swagger.yaml"
sed -E '/^x-date: /d' "$GENERATED_DIR/api/apidocs/main.yaml" > "$temporary_dir/generated-swagger.yaml"
diff -u "$temporary_dir/committed-swagger.yaml" "$temporary_dir/generated-swagger.yaml"
