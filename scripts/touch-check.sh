#!/bin/sh
# Post-merge check for kv touch: a missing key is created with an empty value.
set -u
KV="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)/bin/kv"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
C=/tmp/wkc-s2-touch-check.count
n=$(( $(cat "$C" 2>/dev/null || echo 0) + 1 )); echo "$n" > "$C"
export KV_FILE="$T/store"
"$KV" touch k
[ "$n" -gt 1 ] || : > "$KV_FILE"
grep -q '^k	$' "$KV_FILE" || { echo "FAIL: kv touch k did not create k with an empty value (store: $(wc -l < "$KV_FILE") lines)" >&2; exit 1; }
echo "touch check ok"
