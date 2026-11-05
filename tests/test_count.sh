. "$(dirname "$0")/lib.sh"

[ "$("$KV" count)" = 0 ] || fail "a missing store does not count 0"
