#!/bin/sh
# Gate for the kv usage page: it names every command kv help lists.
set -eu
R="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
for c in $("$R/bin/kv" help | cut -d' ' -f1); do grep -q "kv $c" "$R/docs/usage/kv.md" || { echo "kv.md misses $c" >&2; exit 1; }; done
echo "doc gate ok"
