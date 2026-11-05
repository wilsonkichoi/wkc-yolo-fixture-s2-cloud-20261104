. "$(dirname "$0")/lib.sh"

printf 'a\t1\n' > "$KV_FILE"
[ "$("$KV" get a)" = 1 ] || fail "get a"
expect_exit 1 "$KV" get b
expect_exit 2 "$KV" get
