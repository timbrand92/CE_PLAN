# CODEX ledger fix batch 07 — 23 October 2026

## ANSWER FIRST

1. **BUG-903 — SKIPPED.** Needs Tim's engineering ruling on the minimum-grade ladder and consistent cover limits. Ledger F-045 and QUESTIONS_FOR_MONDAY.md (22 October late, item 5) leave the grade ladder undecided. PR: none; tests added/run: 0; totals not measured.
2. **BUG-904 — DRAFT PR #1656; checks pending.** Cause confirmed at Civil base 88bd62f704b66a7e156da572c212812dc4b0c61a: the duration ladder starts at five minutes and warns at its longest boundary only. Implement the brief's warning option when the shortest storm governs; retain rainfall, engineering values and calculated storage. Branch cx2/bug-904-storm-peak; pushed head cb53d0f897afcf79c95e70fb46b5ff4d6ccbc5c9. Six new test cases; full totals pending.
3. **BUG-905 — SKIPPED.** Needs Tim's engineering word on the hard-ground runoff factor (1.0 versus 0.9); ledger F-050 and the carpark explicitly defer this choice. PR: none; tests added/run: 0; totals not measured.
4. **BUG-906 — DRAFT PR #1655; checks pending.** Cause confirmed at the same base: R-06 calls DetentionHasNoLengthToJudge but R-30 does not. Reuse that same decision and existing ON switch. Branch cx2/bug-906-detention-grade; pushed head 52efb49b918875d429c6935dfd1b440047611892. Seven new test cases; before/after and full totals pending.
5. **BUG-907 — SKIPPED.** Needs Tim's engineering ruling on inlet/outlet obverts, deferred until after 9 November in ledger F-052. QUESTIONS_FOR_MONDAY.md (22 October late, item 3) is still a question. PR: none; tests added/run: 0; totals not measured.

## Scope and checks

1. **Base and ownership:** fetched origin first; task-specific origin/claude/rel-20261023l wins over the earlier 22 October and appended master instructions. Separate short worktrees C:/cx2/b07-904 and C:/cx2/b07-906. Main checkouts contain other chats' work; none taken over or staged.
2. **Duplicate checks, each bug:** ran gh pr list --state all --search BUG-<id>. Broad unrelated results: BUG-903 #485; BUG-904 #599; BUG-905 #423; BUG-906 none; BUG-907 #782/#423. No confirmed matching fix. Quoted title/body searches for all five bugs return none. Fetched remote branches have no relevant exact bug-id match. All requested report families including prefixed *FIX_WAVE2_BATCH*_REPORT.md and *FIX_ROUND_*_REPORT.md plus CODEX_BUILD_* have no BUG-903–907 or F-045/F-049/F-050/F-051/F-052 matches.
3. **Protected files:** no fix requires the protected list in common.txt. Structural untouched. No new window or layout. BUG-904 adds a real CivilDesignWindow render check: dark/light, all five tabs, 1080p scale 1. The existing shell and results area are reused; pictures pending. BUG-906 changes a command finding, with no window change.
4. **Safety:** no deployment, AutoCAD start, live settings write, rebase, force-push or PR merge. No bug marked fixed or accepted. Foreground builds/tests will use SkipDevBundle and C-57 reference parameters. Build/test totals and exact real-AutoCAD checks will be recorded as work completes.

## Regression evidence

1. **BUG-904 unchanged base:** six new cases executed; 3 passed / 3 failed / 0 skipped. The calculation warning and both real-window display cases fail because the shortest-storm caution is absent. Production source matched the fetched base during that run; the strengthened calculation-to-window cases are queued for a fresh base run. Evidence: C:/cx2/b07logs/904-base.trx and 904-base.log.
2. **Numerical reproduction:** the supplied synthetic inputs give 1.68791 m³ at 5 minutes and 1.73352 m³ at 7 minutes using the unchanged office curve. This batch takes the requested warning option; it does not claim to refine the sweep or correct every unsampled peak.
3. **Inbox:** connected Notion Inbox opened, but its row-query tool returned an unavailable-tool error. New Inbox rows could not be verified; no Inbox item was changed.

4. **Pushed draft fixes:** BUG-904 PR #1656 at cb53d0f897afcf79c95e70fb46b5ff4d6ccbc5c9; BUG-906 PR #1655 at 52efb49b918875d429c6935dfd1b440047611892. Both target claude/rel-20261023l and remain draft. Manual and automatic pre-push scans passed, with all 36 local terms present. Build and full-suite totals remain pending; neither draft is claimed green.
5. **Stronger visible fixture:** the BUG-904 render tests now use CivilDesignService.Run, the actual CDDESIGN calculation-to-results path, with Generic Default council, 640.67 m² whole site, 213.56 m² roof/paved area, pre-development C 0.35, soft-ground C 0.30 and head 0.45 m. This is directly enterable in the existing window; the ledger's discharge-override example remains a separate engine reproduction.
