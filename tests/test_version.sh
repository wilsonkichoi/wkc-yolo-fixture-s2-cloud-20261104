. "$(dirname "$0")/lib.sh"

want=$(cat "$(dirname "$0")/../VERSION")
[ "$("$KV" version)" = "$want" ] || fail "version does not print VERSION"
expect_exit 0 "$KV" version
