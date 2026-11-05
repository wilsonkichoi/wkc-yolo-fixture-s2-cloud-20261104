#!/bin/sh
# l2-check.sh: deploy the build to the shared staging-l2 stand-in, then check kv count against it.
set -u
D="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
sh "$D/env.sh" deploy staging-l2 || exit 1
sh "$D/count-gate.sh"
