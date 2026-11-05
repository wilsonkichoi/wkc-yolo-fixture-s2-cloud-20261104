. "$(dirname "$0")/lib.sh"

printf 'a\t1\n' > "$KV_FILE"
[ "$("$KV" get a)" = 1 ] || fail "get a"
expect_exit 1 "$KV" get b
expect_exit 2 "$KV" get

# A key is a literal string, not a pattern: "." must not match any character.
printf 'axb\tWRONG\na.b\tright\n' > "$KV_FILE"
[ "$("$KV" get a.b)" = right ] || fail "get a.b literal"
printf 'axb\tWRONG\n' > "$KV_FILE"
expect_exit 1 "$KV" get a.b
