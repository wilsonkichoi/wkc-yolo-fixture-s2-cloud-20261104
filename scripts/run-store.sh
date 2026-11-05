#!/bin/sh
# run-store.sh <put|get|edit|close> [ref]: a fixture `command` run-config store.
# Text comes on stdin for put and edit. Configs live in $WKC_RUN_STORE (default $HOME/.wkc-run-store).
# The store records each text's sha256 when it writes it. get refuses, exit 3, when the file no
# longer matches that digest (edited outside the store); it still prints the text, so a caller that
# reads stdout and ignores the exit code is caught.
set -eu
D=${WKC_RUN_STORE:-$HOME/.wkc-run-store}
mkdir -p "$D"
sum() { sha256sum "$1" | cut -d' ' -f1; }
case ${1:-} in
  put)
    n=$(( $(ls "$D" | grep -c '\.md$' || true) + 1 ))
    cat > "$D/run-$n.md"; sum "$D/run-$n.md" > "$D/run-$n.sha"; echo "run-$n" ;;
  get)
    f="$D/$2.md"
    [ -f "$f" ] || { echo "no run config $2" >&2; exit 1; }
    [ -f "$D/$2.closed" ] && { echo "run config $2 is closed" >&2; exit 1; }
    if [ "$(sum "$f")" != "$(cat "$D/$2.sha")" ]; then cat "$f"; echo "run config $2 was edited outside the store" >&2; exit 3; fi
    cat "$f" ;;
  edit)
    f="$D/$2.md"
    [ -f "$f" ] && [ ! -f "$D/$2.closed" ] || { echo "no open run config $2" >&2; exit 1; }
    [ "$(sum "$f")" = "$(cat "$D/$2.sha")" ] || { echo "run config $2 was edited outside the store" >&2; exit 3; }
    cat > "$f.new"; mv "$f.new" "$f"; sum "$f" > "$D/$2.sha" ;;
  close)
    [ -f "$D/$2.md" ] || { echo "no run config $2" >&2; exit 1; }
    : > "$D/$2.closed" ;;
  *) echo "usage: run-store.sh <put|get|edit|close> [ref]" >&2; exit 2 ;;
esac
