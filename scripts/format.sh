#!/usr/bin/env bash
set -euo pipefail

if command -v prettier >/dev/null 2>&1; then
  exec prettier --write "**/*.html" "**/*.css" "**/*.md"
fi

if command -v npx >/dev/null 2>&1; then
  exec npx --yes prettier --write "**/*.html" "**/*.css" "**/*.md"
fi

echo "Formatter not found." >&2
echo "Install Prettier (or use npx) and re-run:" >&2
echo "  npm i -g prettier" >&2
echo "  ./scripts/format.sh" >&2
exit 1
