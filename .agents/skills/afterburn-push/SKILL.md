---
name: afterburn-push
description: Use when the user asks /push, push, finish this feature, commit and merge, or complete a feature branch in Project Afterburn. Finish a feature/* branch by inspecting scope, writing its Codex contest-usage record, generating a commit message, running tools/push-feature.sh, and stopping safely if origin/main changed.
---

# Push Feature

Use this skill only in Project Afterburn when finishing a feature branch onto main. Prefer this for feature completion. Use `afterburn-start-feature` when beginning. Use `afterburn-merge-feature` only when already committed (merge-only).

## Workflow

1. Inspect branch, status, and scope:

```bash
git branch --show-current
git status
git diff
git diff --staged
git diff --stat
```

2. If not on `feature/*`, stop and guide to `tools/start-feature.sh`.
3. If diff does not match slug/request, warn about scope drift.
4. **Docs-code gate (required before commit):** compare the system spec and Task with the implementation. Related `docs/spec/*.md` must match code when behavior, numbers, input, spawning, projectiles, or UI change, in the same commit. A pure rename, bug fix, or test-only change may omit a current-spec edit only with an explicit `현황 스펙 해당 없음: <reason>`. Stop on mismatch.
5. **Codex usage record (required before commit):** create or update `docs/submission/codex-usage/<slug>.md` from verified conversation, spec, diff, and test evidence. Include it in the same feature commit. Use these headings:

```markdown
# <기능명> — Codex 활용 기록

## Codex를 어디에 사용했나요?
## 어떤 기능을 구현했나요?
## 어떤 문제를 해결했나요?
## 사람이 직접 결정한 부분은 무엇인가요?
## 활용 과정
```

Keep it concise and submission-ready in Korean. Describe the workflow chronologically under `활용 과정` (request/spec → implementation → verification/refinement). Separate human product/design decisions from Codex execution. Do not invent human decisions, prompts, test results, or outcomes; mark genuinely unavailable details as `확인 필요` and tell the user. Update an existing record instead of duplicating it.
6. **Kanban ticket (required before commit):** follow `.cursor/rules/kanban-tickets.mdc`; move the matching card to `review`, add an MD history note, bump `updated`, and include both files in the commit. Report `티켓: <id> → review`.
7. Re-run `git diff --stat` and stop if the usage record or required docs/ticket files are absent.
8. Generate commit message (`feat:` / `fix:` / `docs:` / `godot:`).
9. Run:

```bash
chmod +x tools/push-feature.sh tools/merge-feature.sh 2>/dev/null || true
./tools/push-feature.sh -m "feat: short description"
```

Merges to main and **deletes the feature branch by default**. Pass `--no-delete` only if the branch must be kept.

## Stop Condition (exit 2)

Do not force push. Tell the user to merge main into the feature branch, resolve/verify, then re-run `/push`.

## Godot Check

If scenes/resources/gameplay changed, briefly confirm the flow and check for `docs/spec` / system-spec contradictions.

## Success

```bash
git checkout main && git pull
```

Report the usage-record path in the final result.

## Never Do

- `git push --force`, change `git config`, use `develop`, create a PR unless asked.
