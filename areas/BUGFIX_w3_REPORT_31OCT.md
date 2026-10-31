# BUGFIX w3 report: B-095, Recall Last then a new upstream level (BUG-1267), Sat 31 Oct 2026

## FOR TIM

1. **Draft PR #1927.** Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1267 is not marked fixed.
2. **What you will see.** Press Recall Last in New Pipe (last pipe in "Set my own" 1 in 100). Type a new upstream level 19.45 on a 4.1 m pipe. The downstream box now fills 19.40 (fall 0.041 rounded up to 0.05). Before, it filled 18.95, because the window treated the remembered downstream level as a fall you had set.
3. **A different length** uses that length: 9.2 m gives 19.35, 20 m gives 19.25. The round-up step is the Settings "Calculated decimals" (2 = 10 mm; at 3 the 4.1 m pipe reads 19.409).
4. **If you type the downstream level yourself** after Recall Last, that fall is held when you change the upstream, as before.
5. **Go back:** Settings key pipe.recallLastNewUpstreamUsesStandardGrade (on as shipped). Off gives 18.95 exactly. It is not on the Settings page; no window layout was changed.
6. **My mistake first:** my first build and test commands had a quoting fault and failed to start, and I left one stale background build running for a few minutes (it ended on its own, no damage). Cost: about 10 minutes.
7. **Stacked PR.** PR #1927 is based on PR #1919's branch (claude/w1-b093-grade-mismatch-warning), not on rel-20261102a, because B-093 rewrote the grade code in the same files. Retarget it after #1919 merges. #1920, #1924 and #1925 each add a switch in UserSettings.cs; expect a keep-both merge there.
8. **Real-files check needs your eye.** My tests used scratch folders, but your PC was busy (AutoCAD usage files and other jobs). Between my before and after listings these real files changed: CD_RecentValues.json (last write 4:55 pm to 5:12 pm, same size), CD_Settings.json (15268 to 15270 bytes, last write now reads 4 Oct 2026 8:22 am, so it was copied in, not written fresh), two CE_Admin outbox machine files (4:58 to 5:08 pm), CE_Admin sessions files replaced by new usage files (5:00 to 5:03 pm). None of my tests call a settings save. I cannot prove which process wrote them. Please treat the odd 4 Oct stamp on CD_Settings.json as worth a look.

## ANSWER FIRST (technical)

1. **PR:** #1927, draft, base claude/w1-b093-grade-mismatch-warning (head d12f06d7). Branch claude/w3-b095-recall-last-standard-grade.
2. **Fault re-checked on the start point:** still present. `ApplyStoredSettings` (CdViewModel.Settings.cs, used by Recall Last and by window open) writes the recalled downstream through the public `SecondInvert` setter, which sets `_secondInvertUserSet` (CdViewModel.Inverts.cs). `ResolveHasEstablishedFall` then returns true, and `UpstreamDownstreamSuggest.SuggestFromHeldFall` holds the recalled fall. A recalled Custom grade also counted as established. This matches CE 01's reading in the register item 162.
3. **Change:** a `_secondInvertIsRecalled` mark set at the end of `ApplyStoredSettings` (switch ON) with `_secondInvertUserSet` cleared; `ResolveHasEstablishedFall` returns false while marked; typing in the downstream box (not the suggestion, not load) clears the mark. Files: Modules/Drainage/Models/UserSettings.cs, ViewModels/CdViewModel.Inverts.cs, ViewModels/CdViewModel.Settings.cs, new Rules/RecallLastGradeRule.cs, new Modules/Drainage.Tests/Commands/B095RecallLastStandardGradeTests.cs, REGRESSION_LOG.md. CE_SHARED untouched.
4. **Switch OFF:** neither flag is changed by load, so the old path runs untouched (18.95 pinned by a test).
5. **Tests run (net10, one project, filtered):** B095 fixture 16 of 16 pass; B095 + Bug1229 + B093 + B057 fixtures 141 of 141 pass; NewSwitchDefaults + CdViewModel + UpstreamDownstream + SettingsService fixtures 395 of 395 pass. net48 compile of Modules/Drainage: succeeded.
6. **Commit message:** names BUG-1267 and B-095; ends with the Co-Authored-By line.

## ROBOT CASE FOR CE 02

Name: **N95_recall_new_upstream** (switch-off control: **N95_recall_new_upstream_off**).
1. Settings: Calculated decimals 2; "remember last pipe settings" on; last pipe saved as 1 in 100, DN100, levels 20.00 and 19.50 (a 0.50 m fall).
2. Run CD, pick two points 4.1 m apart, press Recall Last, click the upstream level box and type 19.45.
3. Read the downstream level box: expect **19.40**; the grade box still 100. Draw and read the pipe's IL label: 19.40.
4. Control: set pipe.recallLastNewUpstreamUsesStandardGrade to false in the settings file, repeat: downstream reads **18.95**.
5. Second control: after Recall Last type 19.30 in the downstream box yourself, then change upstream to 19.50: downstream reads 19.35 (your 0.15 m fall held).

## NOT TESTED / NOT PROVEN

1. Nothing was driven in AutoCAD (no AutoCAD, Codex or accoreconsole started). The real window, the real Recall Last button and the drawn label were not seen.
2. The full Drainage test suite was not run (only focused fixtures, as the job's test rule requires a filter).
3. net8.0 target not built.
4. Whether the window opens with Recall applied on your machine depends on "remember last pipe settings" in Settings; the unit test presses the Recall Last command itself.
5. Item 8 above (real settings files) is unresolved.

## REAL-FILES LISTINGS

Before and after listings (names, sizes, last-write, no contents) of %APPDATA%\TIM_CE_CADTOOLS (with CE_Admin\outbox and logs), CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS: about 29,000 lines each, mostly log files. The differences are the ones listed in FOR TIM item 8. CE_STRUC_SUITE, CE_CVL_SUITE and CE_CADTOOLS showed no difference. Listings were in C:\CE_WORK\scratch\w3 and are removed with it.

## CLEAN-UP AND SPACE

1. C: free before: 45.92 GB (16:54). After the last test: 43.60 GB (17:14). Moved by 2.3 GB while the worktree still held build output; worktree cleaned with git clean -fdXq and git worktree remove.
2. Finished 17:15 Melbourne-clock note: the machine clock read 17:14 Sat 31 Oct 2026 (labelled AUSEST) at the last check.
