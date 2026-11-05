. "$(dirname "$0")/lib.sh"

printf 'a\t1\nab\t2 x\ne\t\n' > "$KV_FILE"
[ "$("$KV" get a)" = "1" ] || fail "get a"
[ "$("$KV" get ab)" = "2 x" ] || fail "get ab"
[ "$("$KV" get e | wc -l | tr -d ' ')" = "1" ] || fail "empty value needs a newline"
expect_exit 1 "$KV" get missing
expect_exit 1 "$KV" get a.
expect_exit 2 "$KV" get
expect_exit 2 "$KV" get a b
expect_exit 2 "$KV" get 'bad key'
rm -f "$KV_FILE"
expect_exit 1 "$KV" get a
"$KV" help | grep -q '^get' || fail "help does not list get"
