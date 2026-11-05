#!/bin/sh
# Smoke check for kv touch. It talks to a slow local fixture service that is not
# always ready on the first call; the attempt count lives in /tmp/wkc-s2-touch-smoke.count.
set -u
C=/tmp/wkc-s2-touch-smoke.count
n=$(( $(cat "$C" 2>/dev/null || echo 0) + 1 ))
echo "$n" > "$C"
[ "$n" -gt 1 ] || { echo "touch smoke: service not ready (attempt $n)" >&2; exit 1; }
KV="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)/bin/kv"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
KV_FILE="$T/store" "$KV" touch k && grep -q '^k	$' "$T/store" || { echo "touch smoke failed" >&2; exit 1; }
echo "touch smoke ok"
