. "$(dirname "$0")/lib.sh"

tab=$(printf '\t')

# a new key is stored
expect_exit 0 "$KV" set alpha one
[ "$(cat "$KV_FILE")" = "alpha${tab}one" ] || fail "new key not stored"

# an existing key is replaced, others kept, key appears once
expect_exit 0 "$KV" set beta two
expect_exit 0 "$KV" set alpha uno
[ "$(grep -c '^alpha' "$KV_FILE")" -eq 1 ] || fail "alpha appears more than once"
grep -q "^alpha${tab}uno\$" "$KV_FILE" || fail "alpha not replaced"
grep -q "^beta${tab}two\$" "$KV_FILE" || fail "beta lost"

# a bad key or value is refused with exit 2 and leaves the store alone
before=$(cat "$KV_FILE")
expect_exit 2 "$KV" set 'bad key' v
expect_exit 2 "$KV" set '' v
expect_exit 2 "$KV" set "a${tab}b" v
expect_exit 2 "$KV" set k "v${tab}w"
expect_exit 2 "$KV" set k 'v
w'
long=$(printf 'a%.0s' $(seq 1 65))
expect_exit 2 "$KV" set "$long" v
[ "$(cat "$KV_FILE")" = "$before" ] || fail "store changed by a refused set"

# wrong number of arguments is a usage error
expect_exit 2 "$KV" set
expect_exit 2 "$KV" set onlykey
expect_exit 2 "$KV" set a b c

# help lists set
"$KV" help | grep -q '^set' || fail "help does not list set"
