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

This repository is a throwaway fixture for PR #100 validation batch S2, run in a Claude cloud
session. Each test session is a fresh native subagent that the validation driver starts, on sonnet
at effort medium, and it calls one skill. The person authorizes that session to do what its skill
does in this repository. A test session cannot start sessions of its own: where its skill calls for
a worker, another session, or an AI test session, it reports that step as not started, with the
reason, and goes on as the skill says for an unavailable step. No release, no tag, and no
production action. Stop all work at the first real quota, rate-limit, or authentication error,
and never retry it.

## GitHub transport (maintainer, 2026-11-04)

This cloud session cannot run `.claude/skills/wkc-tracker/github.py` or `gh pr` and `gh issue`,
because GitHub's GraphQL endpoint is blocked here. For this repository, every session does every
GitHub read and write through the GitHub MCP tools, and only through them.

- Read the installed `wkc-*` skills as the workflow: what to read, what to write, in what order,
  and which checks and confirmations come first. Where a skill names a `wkc-tracker` verb, a
  `github.py` call, or a `gh` command, do the same operation with the MCP tools and keep every
  rule the skill states for it: status labels, record comments, digests and read-backs, writer
  checks, and confirmation before a write.
- Local work uses `git` as usual: commits, branches, worktrees, and branch pushes to `origin`.
- If the MCP tools have no operation for a step the skill requires, do not substitute another
  route. Report the step and the missing operation, and treat it as blocked.
- Writers: `wilsonkichoi` is the only account with write access. Any other account has none.
