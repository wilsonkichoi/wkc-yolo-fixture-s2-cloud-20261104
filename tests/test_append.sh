. "$(dirname "$0")/lib.sh"

printf 'a\tx\n' > "$KV_FILE"
expect_exit 0 "$KV" append a y
grep -q '^a	xy$' "$KV_FILE" || fail "a not appended"
expect_exit 1 "$KV" append b y
