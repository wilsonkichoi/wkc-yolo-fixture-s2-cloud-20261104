# kv covered-gate fixture

Use POSIX sh and the existing repository conventions. The command's contract is in
`docs/dev-agents/SPEC.md`. `make test` runs the local tests.

## Focused test authorization

Prepared for PR #100 at source `16b43ab033b47f1ab0eabc962a105d52e4513d4c`.
This is a separate fixture. Original historical tickets, branches, and records are preserved.
A person may start one fresh Claude Sonnet/medium session, then after its independent audit,
one fresh Claude Sonnet/high session. Each runs exactly one normal wkc-implement verify call
with its run reference and then ends. Neither session may start a worker, subagent, another
harness, or an AI test. Nested AI tests are zero of zero. No review, build, finish, merge,
planning step, new ticket admission, grant, or repair round is authorized to either session.
Any real quota, authentication, rate-limit, endpoint, or setup failure stops without retry.

Seed delivery, merge, initial gate passes, and readiness records are driver-created fixture
history. They never represent model execution. The person separately approves any fixture seed
merge. A documentation-only driver commit between the two contexts gives the second context
its own head. Read current tracker/PR state and follow the installed skill's ordinary rules.
