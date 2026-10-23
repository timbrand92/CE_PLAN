# CODEX ledger fix batch 06 — 23 October 2026

## ANSWER FIRST

1. **BUG-898 — investigating.** No exact-id PR, matching remote branch or coverage in the requested report families. Cause confirmed at Civil base `88bd62f704b66a7e156da572c212812dc4b0c61a`: results relabel the proposed schedule as Recorded without checking insertion.
2. **BUG-899 — investigating.** Same duplicate checks clear. LandXML measures target extents without excluding earlier import objects, unlike X-Civil.
3. **BUG-900 — investigating.** Same duplicate checks clear. The PDF reader chooses one pit schedule page and replaces the pipe rows with the best single page.
4. **BUG-901 — SKIPPED.** Engineering decision required: outside-top cover and wall thickness values. Ledger F-042 and `QUESTIONS_FOR_MONDAY.md` question 2 keep this awaiting Tim's word. No change or tests.
5. **BUG-902 — SKIPPED.** Engineering decision required: surface levels and cover between pits. Ledger F-043 explicitly needs Tim's word. No change or tests.

## Scope and evidence

1. **Base:** task-specific `origin/claude/rel-20261023l`, fetched first. No master merge. Separate short code worktrees; unrelated dirty files in shared checkouts left untouched.
2. **Duplicate check:** ran `gh pr list --state all --search BUG-<id>` for all five. Broad matches were unrelated; quoted exact-id title/body searches returned none. Remote branch id matches: none. Requested FIX_WAVE2_BATCH, FIX_ROUND and CODEX_BUILD report families: no ids or matching F-039 to F-041 descriptions found.
3. **Safety:** no deployment, AutoCAD start, settings-file write or protected-file edit authorised. Built/tested/installed/accepted remain separate. No bug marked fixed.
4. **Work in progress:** PRs, regression evidence, build totals and exact real-AutoCAD check will be filled as each safe fix is completed.

## Progress evidence (23 October, Melbourne time)

1. **BUG-900 reader reproduction:** anonymous two-page PDF, each page with one pit and one pipe schedule row. Unchanged reader returned 1 pit and 1 pipe. Changed reader returned 2 pits and 2 pipes with row indexes 0 and 1. Both PDF pages rendered and inspected. NUnit verification still pending; temporary production changes saved outside the worktree while the exact regression runs against the base.
2. **Build environment:** shared build lock was held by another Civil run until about 19:05. First BUG-899 test build then stopped because the worktree-native `CE_TRANSFORM_2027.arx` output did not exist. Retried with the C-57 report's 0-byte placeholder under this worktree only. This is not a usable native ARX or a deployable payload. No installed bundle touched.
3. **Notion Inbox:** checked the connected Inbox. No Civil plugin item was returned; the one returned item belonged to another product and was left alone.
