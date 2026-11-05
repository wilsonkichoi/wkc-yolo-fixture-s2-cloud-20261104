. "$(dirname "$0")/lib.sh"

printf 'a\t1\nb\t2\n' > "$KV_FILE"
expect_exit 0 "$KV" del a
grep -q '^a' "$KV_FILE" && fail "a still stored"
grep -q '^b' "$KV_FILE" || fail "b lost"
expect_exit 1 "$KV" del a
