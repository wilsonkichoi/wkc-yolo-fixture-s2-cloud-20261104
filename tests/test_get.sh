. "$(dirname "$0")/lib.sh"

expect_exit 1 "$KV" get missing
printf 'a\tone\nab\ttwo words\n' > "$KV_FILE"
[ "$("$KV" get a)" = "one" ] || fail "get a"
[ "$("$KV" get ab)" = "two words" ] || fail "get ab"
expect_exit 1 "$KV" get b
expect_exit 2 "$KV" get
expect_exit 2 "$KV" get a b
"$KV" help | grep -q '^get' || fail "help does not list get"
