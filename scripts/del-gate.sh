#!/bin/sh
# Gate for kv del: a missing key exits 1.
set -u
KV="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)/bin/kv"
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
export KV_FILE="$T/store"
printf 'a\t1\n' > "$KV_FILE"
"$KV" del nope
[ $? -eq 1 ] || { echo "del of a missing key did not exit 1" >&2; exit 1; }
echo "del gate ok"
