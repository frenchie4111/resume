#!/usr/bin/env bash
# Serves the resume preview: rebuilds the browser HTML whenever src/ changes,
# and serves dist/ over HTTP on 0.0.0.0:<port>.
#
# Usage: preview_serve.sh [port]   (default 8000)
#
# This is the sandbox/preview equivalent of `make watch` (build_and_serve.sh +
# nodemon) minus the PDF step: pandoc does the build, python3 serves it.
# `make pdf` needs puppeteer, which is not installed in the preview sandbox.
set -euo pipefail

PORT="${1:-8000}"

command -v pandoc >/dev/null || { echo "pandoc not found — install it first" >&2; exit 1; }

# One-time build so the server has something to serve.
make html_browser >/dev/null 2>&1 || { echo "initial build failed" >&2; exit 1; }

stamp() {
    find src -type f -printf '%T@ %p\n' 2>/dev/null | sort | tail -1
}

LAST_STAMP=$(stamp)

watcher() {
    while true; do
        sleep 2
        CUR=$(stamp)
        if [ "$CUR" != "$LAST_STAMP" ]; then
            LAST_STAMP="$CUR"
            make html_browser >/dev/null 2>&1 \
                || echo "rebuild failed — serving last good build" >&2
        fi
    done
}

cleanup() { kill "${WATCHER_PID:-}" 2>/dev/null || true; }
trap cleanup EXIT

watcher &
WATCHER_PID=$!

cd dist
echo "Serving dist/ on http://0.0.0.0:${PORT}/"
exec python3 -m http.server "$PORT" --bind 0.0.0.0
