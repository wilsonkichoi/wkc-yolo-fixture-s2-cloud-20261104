. "$(dirname "$0")/lib.sh"

expect_exit 0 "$KV" help
expect_exit 2 "$KV"
expect_exit 2 "$KV" no-such-command
"$KV" help | grep -q '^help' || fail "help does not list help"
LANG=fr_FR.UTF-8 "$KV" help | grep -q '^help    affiche' || fail "French help missing"
LANG=C "$KV" help | grep -q '^help    show' || fail "English fallback missing"
