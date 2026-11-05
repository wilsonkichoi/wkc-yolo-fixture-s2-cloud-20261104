# kv

`kv` is a small key-value store CLI written in POSIX sh. `bin/kv` is the entry point, `tests/test_*.sh`
are the tests, and `make test` runs them all. The design is in `docs/dev-agents/SPEC.md`.

## Conventions

- POSIX sh only (`#!/bin/sh`), no bash features. Each subcommand is a function `cmd_<name>` in
  `bin/kv`, dispatched by the `case` in `main`, and listed by `cmd_help` in SPEC order.
- Each subcommand has its own test file, `tests/test_<name>.sh`, which sources `tests/lib.sh`.
- Commit messages use `feat:`, `fix:`, `test:`, and `docs:`. Branches are `<type>/<id>-<slug>`.
- A person merges into `main`. `wkc-yolo` merges only into its run branch.

## Authorization record (maintainer, 2026-11-04)

This repository is a throwaway fixture for PR #100 validation batch L (earlier S2), run on the
maintainer's machine. Each test session is a fresh `claude -p` session that the validation driver starts, on sonnet
at effort medium, and it calls one skill. The person authorizes that session to do what its skill
does in this repository. A test session cannot start sessions of its own: where its skill calls for
a worker, another session, or an AI test session, it reports that step as not started, with the
reason, and goes on as the skill says for an unavailable step. No release, no tag, and no
production action. Stop all work at the first real quota, rate-limit, or authentication error,
and never retry it.

## GitHub transport (maintainer, 2026-11-05, batch L)

GitHub goes through `wkc-tracker`'s `github.py` and `gh`. Every session uses them as the installed
`wkc-*` skills say. Local work uses `git` as usual.

- Writers: `wilsonkichoi` is this repository's only account with write access. No other account has
  write access.
