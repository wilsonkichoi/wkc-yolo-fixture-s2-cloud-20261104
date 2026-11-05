. "$(dirname "$0")/lib.sh"

expect_exit 0 "$KV" count
[ "$("$KV" count)" = 0 ] || fail "empty store does not count 0"
printf 'a\t1\nb\t2\n' > "$KV_FILE"
[ "$("$KV" count)" = 2 ] || fail "two keys do not count 2"
