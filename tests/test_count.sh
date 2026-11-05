. "$(dirname "$0")/lib.sh"

[ "$("$KV" count)" = 0 ] || fail "a missing store does not count 0"
printf 'a\t1\nb\t2\n' > "$KV_FILE"
[ "$("$KV" count)" = 2 ] || fail "two keys do not count 2"
