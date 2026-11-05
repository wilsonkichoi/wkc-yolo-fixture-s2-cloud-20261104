. "$(dirname "$0")/lib.sh"

# The store file is written directly, not through kv set.
printf 'a\t1\nname\thello world\nempty\t\na.b\tdot\naXb\tpattern\n' > "$KV_FILE"

[ "$("$KV" get a)" = "1" ] || fail "get a did not print 1"
[ "$("$KV" get name)" = "hello world" ] || fail "get name did not print the value verbatim"
[ "$("$KV" get a.b)" = "dot" ] || fail "get a.b did not match the key exactly"
[ "$("$KV" get empty | wc -l | tr -d ' ')" = "1" ] || fail "empty value did not print a newline"
[ "$("$KV" get empty)" = "" ] || fail "empty value printed text"
# The value is followed by exactly one newline.
"$KV" get a | od -c | grep -q '1  \\n' || fail "get a did not end with a newline"

# A missing key exits 1 and prints nothing to stdout.
expect_exit 1 "$KV" get missing
expect_exit 1 "$KV" get a.
[ -z "$("$KV" get missing 2>/dev/null)" ] || fail "missing key printed to stdout"

# A missing store file exits 1.
rm -f "$KV_FILE"
expect_exit 1 "$KV" get a

# Bad input exits 2: wrong argument count, bad key.
expect_exit 2 "$KV" get
expect_exit 2 "$KV" get a b
expect_exit 2 "$KV" get 'bad key'
expect_exit 2 "$KV" get ''

# kv help lists get.
"$KV" help | grep -q '^get' || fail "help does not list get"
