#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly MOBILE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly REPOSITORY_DIR="$(cd "$MOBILE_DIR/../.." && pwd)"
readonly SPEC_FILE="$REPOSITORY_DIR/src/backend/api/apidocs/main.yaml"
readonly CONFIG_FILE="$MOBILE_DIR/openapi-generator-config.yaml"
readonly OUTPUT_DIR="$MOBILE_DIR/api-client"
readonly GENERATOR_VERSION="7.19.0"
readonly GENERATOR_SHA256="3d8140c691410e0004b1bb9b1e431c1293734830f30d6d5922f8e5dbf2e42e19"
readonly CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/fadd/openapi-generator"
readonly GENERATOR_JAR="$CACHE_DIR/openapi-generator-cli-$GENERATOR_VERSION.jar"
readonly GENERATOR_URL="https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/$GENERATOR_VERSION/openapi-generator-cli-$GENERATOR_VERSION.jar"

usage() {
  echo "Usage: $0 [--check]" >&2
}

mode="generate"
if [[ ${1:-} == "--check" ]]; then
  mode="check"
elif [[ $# -ne 0 ]]; then
  usage
  exit 2
fi

checksum() {
  shasum -a 256 "$1" | awk '{print $1}'
}

ensure_generator() {
  mkdir -p "$CACHE_DIR"

  if [[ ! -f "$GENERATOR_JAR" ]] || [[ "$(checksum "$GENERATOR_JAR")" != "$GENERATOR_SHA256" ]]; then
    local temporary_jar
    temporary_jar="$(mktemp "$CACHE_DIR/openapi-generator.XXXXXX")"
    trap 'rm -f "${temporary_jar:-}"' RETURN
    curl -fsSL "$GENERATOR_URL" -o "$temporary_jar"

    if [[ "$(checksum "$temporary_jar")" != "$GENERATOR_SHA256" ]]; then
      echo "OpenAPI Generator checksum verification failed" >&2
      exit 1
    fi

    mv "$temporary_jar" "$GENERATOR_JAR"
    trap - RETURN
  fi
}

generate_into() {
  local destination="$1"

  rm -rf "$destination"
  java -jar "$GENERATOR_JAR" generate \
    --input-spec "$SPEC_FILE" \
    --generator-name dart-dio \
    --output "$destination" \
    --config "$CONFIG_FILE" \
    --global-property apiTests=false,modelTests=false,apiDocs=false,modelDocs=false

  cat > "$destination/analysis_options.yaml" <<'ANALYSIS_OPTIONS'
analyzer:
  language:
    strict-inference: true
    strict-raw-types: true
    strict-casts: false
  exclude:
    - test/*.dart
  errors:
    deprecated_member_use_from_same_package: ignore
    unused_import: ignore
ANALYSIS_OPTIONS

  (
    cd "$destination"
    fvm dart pub get
    fvm dart run build_runner build
    fvm dart format lib
    rm -rf .dart_tool build pubspec.lock
  )
}

ensure_generator

if [[ "$mode" == "generate" ]]; then
  generate_into "$OUTPUT_DIR"
  exit 0
fi

if [[ ! -d "$OUTPUT_DIR" ]]; then
  echo "Generated API client is missing. Run make gen-api-client." >&2
  exit 1
fi

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
generate_into "$temporary_dir/api-client"

diff -ru \
  --exclude=.dart_tool \
  --exclude=build \
  "$OUTPUT_DIR" \
  "$temporary_dir/api-client"
