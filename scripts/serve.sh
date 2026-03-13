#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'TXT'
Local preview server for this static site.

Usage:
  ./scripts/serve.sh [port]

Environment:
  BIND_ADDR=127.0.0.1   Bind address (default: 127.0.0.1)
  PYTHON_BIN=python3     Python executable (default: python3, falls back to python)

Examples:
  ./scripts/serve.sh
  ./scripts/serve.sh 5173
TXT
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
esac

port="${1:-8000}"
bind_addr="${BIND_ADDR:-127.0.0.1}"
python_bin="${PYTHON_BIN:-python3}"

if ! command -v "${python_bin}" >/dev/null 2>&1; then
  python_bin="python"
fi

if ! command -v "${python_bin}" >/dev/null 2>&1; then
  echo "Error: Python not found. Install python3 or set PYTHON_BIN." >&2
  exit 1
fi

if ! [[ "${port}" =~ ^[0-9]+$ ]] || [ "${port}" -lt 1 ] || [ "${port}" -gt 65535 ]; then
  echo "Error: invalid port: ${port}" >&2
  exit 1
fi

repo_root="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1
  pwd
)"

cd "${repo_root}"

echo "Serving ${repo_root}"
echo "Home:    http://${bind_addr}:${port}/"
echo "Reports: http://${bind_addr}:${port}/reports/"
echo "Blog:    http://${bind_addr}:${port}/blog/"
echo

exec "${python_bin}" -m http.server "${port}" --bind "${bind_addr}"
