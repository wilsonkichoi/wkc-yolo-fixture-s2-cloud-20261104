. "$(dirname "$0")/lib.sh"

expect_exit 0 "$KV" touch a
grep -q '^a	$' "$KV_FILE" || fail "a not created empty"
printf 'b\t2\n' >> "$KV_FILE"
expect_exit 0 "$KV" touch b
grep -q '^b	2$' "$KV_FILE" || fail "b changed"
