. "$(dirname "$0")/lib.sh"

expect_exit 0 "$KV" help
expect_exit 2 "$KV"
expect_exit 2 "$KV" no-such-command
"$KV" help | grep -q '^help' || fail "help does not list help"
[ "$("$KV" help | grep -n '^del' | cut -d: -f1)" -lt "$("$KV" help | grep -n '^import' | cut -d: -f1)" ] || fail "help lists import before del (SPEC 3.5 before 3.6)"
