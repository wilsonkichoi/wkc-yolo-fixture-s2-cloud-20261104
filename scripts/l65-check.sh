#!/bin/sh
# Staging check for kv count on staging-l65: deploy, then the count gate.
set -eu
cd "$(dirname "$0")/.."
sh scripts/env.sh deploy staging-l65
sh scripts/count-gate.sh
