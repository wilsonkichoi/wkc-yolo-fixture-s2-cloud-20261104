#!/bin/sh
# Tests for kv get (SPEC 3.2).
. "$(dirname "$0")/lib.sh"

printf 'alpha\tone\nbeta\ttwo words\n' > "$KV_FILE"

out=$("$KV" get alpha) || fail "get alpha failed"
[ "$out" = "one" ] || fail "get alpha printed '$out'"
out=$("$KV" get beta) || fail "get beta failed"
[ "$out" = "two words" ] || fail "get beta printed '$out'"
"$KV" get alpha | od -c | grep -q '\\n' || fail "no trailing newline"

expect_exit 1 "$KV" get missing
expect_exit 1 "$KV" get alph
printf 'a.c\tdot\n' > "$KV_FILE"
expect_exit 1 "$KV" get abc
out=$("$KV" get a.c) || fail "get a.c failed"
[ "$out" = "dot" ] || fail "get a.c printed '$out'"
printf 'alpha\tone\nbeta\ttwo words\n' > "$KV_FILE"
expect_exit 2 "$KV" get
expect_exit 2 "$KV" get a b

rm -f "$KV_FILE"
expect_exit 1 "$KV" get alpha

"$KV" help | grep -q '^get ' || fail "help does not list get"
echo "test_get ok"
