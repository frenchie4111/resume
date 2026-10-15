#!/usr/bin/env bash
# Local preview server: rebuilds on src/ changes and serves dist/ on port $1 (default 8083).
# Usage: bash preview_serve.sh [port]

PORT="${1:-8083}"
LAST_HASH=""

rebuild() {
    make html_browser >/dev/null 2>&1
}

rebuild

while true; do
    NEW_HASH="$(find src -type f \( -name '*.md' -o -name '*.css' -o -name '*.html' -o -name '*.js' \) -printf '%T@ %s %p\n' 2>/dev/null | sort | md5sum | cut -d' ' -f1)"
    if [ "$NEW_HASH" != "$LAST_HASH" ] && [ -n "$LAST_HASH" ]; then
        rebuild
    fi
    LAST_HASH="$NEW_HASH"
    if [ ! -f /tmp/.preview_http_started ]; then
        ( cd dist && python3 -m http.server "$PORT" --bind 0.0.0.0 ) &
        touch /tmp/.preview_http_started
    fi
    sleep 2
done
