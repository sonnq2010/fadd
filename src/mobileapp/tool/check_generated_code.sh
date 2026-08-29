#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly MOBILE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
readonly TEMP_MOBILE="$temporary_dir/mobileapp"
readonly COMMITTED_OUTPUT="$temporary_dir/committed"
readonly GENERATED_OUTPUT="$temporary_dir/generated"

mkdir -p "$TEMP_MOBILE"
tar \
  --exclude=.dart_tool \
  --exclude=.fvm \
  --exclude=build \
  --exclude=coverage \
  --exclude=api-client/.dart_tool \
  --exclude=api-client/build \
  -C "$MOBILE_DIR" -cf - . | tar -C "$TEMP_MOBILE" -xf -

copy_generated() {
  local source="$1"
  local destination="$2"

  mkdir -p "$destination"
  (
    cd "$source"
    find lib -type f \( -name '*.g.dart' -o -name '*.freezed.dart' \) -print0 |
      while IFS= read -r -d '' file; do
        mkdir -p "$destination/$(dirname "$file")"
        cp "$file" "$destination/$file"
      done
  )
}

copy_generated "$MOBILE_DIR" "$COMMITTED_OUTPUT"
find "$TEMP_MOBILE/lib" -type f \( -name '*.g.dart' -o -name '*.freezed.dart' \) -delete

(
  cd "$TEMP_MOBILE"
  fvm dart pub get
  fvm dart run build_runner build --delete-conflicting-outputs
)

copy_generated "$TEMP_MOBILE" "$GENERATED_OUTPUT"
diff -ru "$COMMITTED_OUTPUT" "$GENERATED_OUTPUT"
