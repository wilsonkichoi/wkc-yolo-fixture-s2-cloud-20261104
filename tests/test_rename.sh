. "$(dirname "$0")/lib.sh"

printf 'a\t1\nb\t2\n' > "$KV_FILE"
expect_exit 0 "$KV" rename a c
grep -q '^c	1$' "$KV_FILE" || fail "c not renamed"
expect_exit 1 "$KV" rename a d
expect_exit 3 "$KV" rename c b
