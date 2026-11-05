. "$(dirname "$0")/lib.sh"

expect_exit 0 "$KV" help
expect_exit 2 "$KV"
expect_exit 2 "$KV" no-such-command
"$KV" help | grep -q '^help' || fail "help does not list help"

# Supported languages: English and Spanish, chosen from LANG; anything else falls back to English.
LANG=es_ES.UTF-8 "$KV" help | grep -q '^help    muestra esta lista$' || fail "es: help line"
LANG=es_ES.UTF-8 "$KV" help | grep -q '^del     elimina una clave$' || fail "es: del line"
LANG=es "$KV" help | grep -q '^help    muestra esta lista$' || fail "es (bare): help line"
LANG=en_US.UTF-8 "$KV" help | grep -q '^help    show this list$' || fail "en: help line"
LANG=fr_FR.UTF-8 "$KV" help | grep -q '^del     delete a key$' || fail "fallback fr: del line"
LANG= "$KV" help | grep -q '^help    show this list$' || fail "fallback empty LANG: help line"
(unset LANG; "$KV" help | grep -q '^del     delete a key$') || fail "fallback unset LANG: del line"
