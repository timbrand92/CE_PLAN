# CODEX ledger fix batch 07 — 23 October 2026

## ANSWER FIRST

1. **BUG-903 — SKIPPED.** Needs Tim's engineering ruling on the minimum-grade ladder and consistent cover limits. Ledger F-045 and QUESTIONS_FOR_MONDAY.md (22 October late, item 5) leave the grade ladder undecided. PR: none; tests added/run: 0; totals not measured.
2. **BUG-904 — IN PROGRESS.** Cause confirmed at Civil base 88bd62f704b66a7e156da572c212812dc4b0c61a: the duration ladder starts at five minutes and warns at its longest boundary only. Implement the brief's warning option when the shortest storm governs; retain rainfall, engineering values and calculated storage. Branch cx2/bug-904-storm-peak.
3. **BUG-905 — SKIPPED.** Needs Tim's engineering word on the hard-ground runoff factor (1.0 versus 0.9); ledger F-050 and the carpark explicitly defer this choice. PR: none; tests added/run: 0; totals not measured.
4. **BUG-906 — IN PROGRESS.** Cause confirmed at the same base: R-06 calls DetentionHasNoLengthToJudge but R-30 does not. Reuse that same decision and existing ON switch. Branch cx2/bug-906-detention-grade.
5. **BUG-907 — SKIPPED.** Needs Tim's engineering ruling on inlet/outlet obverts, deferred until after 9 November in ledger F-052. QUESTIONS_FOR_MONDAY.md (22 October late, item 3) is still a question. PR: none; tests added/run: 0; totals not measured.

## Scope and checks

1. **Base and ownership:** fetched origin first; task-specific origin/claude/rel-20261023l wins over the earlier 22 October and appended master instructions. Separate short worktrees C:/cx2/b07-904 and C:/cx2/b07-906. Main checkouts contain other chats' work; none taken over or staged.
2. **Duplicate checks, each bug:** ran gh pr list --state all --search BUG-<id>. Broad unrelated results: BUG-903 #485; BUG-904 #599; BUG-905 #423; BUG-906 none; BUG-907 #782/#423. No confirmed matching fix. Quoted title/body searches for BUG-904 and BUG-906 return none. Fetched remote branches have no relevant exact bug-id match. All requested report families including prefixed *FIX_WAVE2_BATCH*_REPORT.md and *FIX_ROUND_*_REPORT.md plus CODEX_BUILD_* have no BUG-903–907 or F-045/F-049/F-050/F-051/F-052 matches.
3. **Protected files:** no fix requires the protected list in common.txt. Structural untouched. No new window or layout; window-reference reuse and dark/light renders are not applicable. Existing warnings/findings presentation is reused.
4. **Safety:** no deployment, AutoCAD start, live settings write, rebase, force-push or PR merge. No bug marked fixed or accepted. Foreground builds/tests will use SkipDevBundle and C-57 reference parameters. Build/test totals and exact real-AutoCAD checks will be recorded as work completes.
