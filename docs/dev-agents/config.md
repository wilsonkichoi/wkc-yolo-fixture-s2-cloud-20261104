---
issue_tracker: github
context_file: AGENTS.md
rules_dir: docs/dev-agents/rules/
prd_file: docs/dev-agents/PRD.md
spec_file: docs/dev-agents/SPEC.md
roadmap_file: docs/dev-agents/ROADMAP.md
test_command: "make test"
max_fix_attempts: 0
max_ai_test_sessions_per_attempt: 0
max_additional_tickets: 0
max_parallel_workers: 1
run_config: tracker
security_scan: 'gitleaks git --redact --log-opts="origin/main..HEAD"'
headless_workers: []
---

# Fixture conventions

All gates are local. This fixture's person-started sessions perform only the single verify
invocation named in their task. There is no model coordinator, dispatch, or model merge authority.
