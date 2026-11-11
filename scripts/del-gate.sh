#!/bin/sh
# Gate for kv del: deleting one of two keys leaves one.
set -eu
KV="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)/bin/kv"
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
export KV_FILE="$T/store"
printf 'a\t1\nb\t2\n' > "$KV_FILE"
"$KV" del a
[ "$(wc -l < "$KV_FILE" | tr -d ' ')" = 1 ] || { echo "del left the wrong records" >&2; exit 1; }
echo "del gate ok"
