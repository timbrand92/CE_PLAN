# BUGFIX w1273 report — BUG-1273 Cascade Preview pit count (B-168 provisional), 3 Nov 2026

## FOR TIM

1. **Answer:** draft PR **#1994** (B-168). The Cascade Preview now says "4 pipes, 3 pits will change - ready to apply", the same pit count the history line gives after Apply. Built and unit-tested only. Not installed, not Codex-accepted, nobody has opened it in AutoCAD.
2. **What you will see differently:** before, the preview counted every pit row, including the anchor pit (the one whose level you typed) and any pit with no CE record. Apply skips both, so it said "3 pits" afterwards. The preview now leaves those two out of the number. The pit rows listed in the window are the same as before; only the wording of the number changed.
3. **Switch:** `linking.cascadePreviewCountsChangedPits`, on by default. Off = the old "5 pits" count of every row. CE reads settings when AutoCAD starts, so set it before launch.
4. **Mistakes of my own, first:**
   1. **Real-folder files changed during my run (rule 1 says to say so first).** Between my "before" and "after" listings, 12 files under `%APPDATA%\TIM_CE_CADTOOLS`, `CE_CVL_SUITE`, `CE_STRUC_SUITE` and `CE_CADTOOLS` changed, plus 11 new usage-event files (logs, session files, usage outbox, machine files, `CD_RecentValues.json`). Every last-write time is between 23:50 and 23:59:53 on 2 Nov, and nothing changed after that. The pattern (a usage event about every minute, then all session files at the same second) is a live AutoCAD session closing, not my tests. I cannot prove that to the minute: my test build was running at about that time. My tests ran with the log folder, TEMP and TMP set to scratch folders, and my scratch log folder stayed empty. Please let CE 01 check whether a robot or Codex AutoCAD run closed at 23:59 on 2 Nov. I did not touch Tim's settings, bundles or ProgramData.
   2. **Wasted runs:** the first test attempts failed on my own script (dotnet not on this PC's path, then a space in the AutoCAD folder path), and the first real run failed 4 tests because my new check touched an AutoCAD comparison that cannot load in a test. Fixed and re-run green. No cost to you.
5. **What is NOT proven:** nobody has run a real cascade in AutoCAD. The count of "pits with a record" uses the drawing's pit records at the moment the preview opens; I have not seen it against a real drawing. The unit tests prove the rule, the wording on and off, both start-up reads, and that Apply still uses the same rule (a source guard). I did not find which two pits Codex had in S5-02 (CE 05 said it did not either).

## Robot case that proves it (draft, for CE 02 / Codex)

**Name: `N31_bug1273_cascade_pit_count`**, with switch-off control **`N31_bug1273_cascade_pit_count_off`**, in the style of N31_dp_time.
1. **Setup:** a fresh copy of a drawing with a run of pits P1..P5 where the downstream cascade from P3 reaches pits P4 and P5, and P5 has no CE record (strip its record, or use a pit block drawn by hand). Pipe STUB to X1 with no level at one end is acceptable.
2. **Types:** Edit Pipe on the pipe leaving P3, change its invert to 17.50, choose "Recalculate downstream", and stop at the Cascade Preview window.
3. **Reads:** the preview summary line (window text `SummaryText`). **Pass (switch on):** it says "N pipes, M pits will change - ready to apply" where M equals the pits the history line will give. Then press Apply and read the history line "[CDEDIT-CASCADE] Updated N pipes and M pits from P3". **Pass = the two M values are equal** and the pit-rows list still shows every pit including P3.
4. **Control (switch off):** set `linking.cascadePreviewCountsChangedPits` to false in a copy of the settings file BEFORE AutoCAD starts (CE reads it at launch), repeat. The summary must read "N pipes, K pits - ready to apply" with K = every pit row (anchor included), and it differs from the history number, exactly as in S5-02.

## Technical detail

1. **Fault confirmed on `origin/claude/rel-20261102a` (3fbb9da5, Civil 3.0.88 line):** `PropagationPreviewViewModel.cs` line 203 (before my change) built `$"{PipeRows.Count} pipes, {PitRows.Count} pits ..."`, and `PitRows` holds every `PlanUpdate` pit row including the anchor. `LinkService.RepairAudit.InvertPropagation.cs` lines 963 to 971: `if (pit.IsAnchor) continue;`, `if (upPit == null) continue;`, then `pitsUpdated++`. Same two skip rules I mirrored.
2. **Change:**
   1. `Models/PropagationPitCount.cs` (new): `WillChange(pits, pitHasRecord)` and `Wording(...)`, the one counting rule.
   2. `ViewModels/PropagationPreviewViewModel.cs`: the summary uses it. In production the record lookup is `ProjectDataService.GetPitByHandle(handle) != null`, the same call the Apply loop makes (guarded, falls back to counting the pit if the lookup throws). An internal test seam takes the lookup as a function. With no drawing (null database) every non-anchor pit counts.
   3. `Models/UserSettings.cs`: `LinkingSettings.CascadePreviewCountsChangedPits`, JSON `cascadePreviewCountsChangedPits`, default true, doc says "Default: on."
   4. `REGRESSION_LOG.md` entry B-168.
3. **Not changed:** the pit rows, Apply loop, history line, any drawing write, command, regen, view or system variable (REDO-safe). CE_SHARED untouched. The Apply loop was not edited, so the completion count is exactly as before; the new unit test pins that the loop still holds both skip lines.
4. **Tests:** `Bug1273PreviewPitCountTests` (new, 11 cases incl. anchor plus one pit with no record, switch on and off, both start-up reads `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`, ships-on, typed-false) plus the existing `PropagationPreviewViewModelTests`. Focused run, one test project, filter `FullyQualifiedName~Bug1273PreviewPitCountTests|FullyQualifiedName~PropagationPreviewViewModelTests`: **47 run, 47 passed on net48 and on net10.0-windows** (the net8.0-windows line matched none and was skipped by the runner). net48 compile: green (the test project builds net48, and the Drainage plugin with it).
   - I did NOT add the key to the C-xx `NewSwitchDefaultsTests` train files: they are per-train finalizer pins with fixed key counts owned by CE 01's finalizer. The switch is pinned through both start-up reads in my own test file instead; the finalizer should add it to the next train's list.
5. **Overlap:** open draft #1989 (BUG-1269, B-161) also edits `PropagationPreviewViewModel.cs`, `UserSettings.cs` and `REGRESSION_LOG.md`, in different places (it adds a warnings list property and a Preview settings group). Not stacked. Expect a trivial textual merge, keep both sides. Its summary line is not touched by #1989.
6. **Commit and PR:** branch `claude/w1273-preview-count`, one commit `1e310948`, draft PR #1994 against `claude/rel-20261102a`.
7. **Environment:** `CE_LOG_DIR_OVERRIDE`, TEMP, TMP set to `C:\CE_WORK\scratch\w1273\...` before the run (the job started with `...\242_fix_w1273\logs`, which I overrode). No Manager tests, no AutoCAD, no accoreconsole.
8. **Real-folder listings (rule 1):** before 36,201 files, after 36,212 files, across the four folders (names, sizes, last-write) saved at `C:\CE_PLAN\areas\w1273_listing_before.txt` and `w1273_listing_after.txt`. The changed files (right column is after; left is before):

```
12 files changed in place, 11 new usage events (all under outbox\usage\2026-11-02, 23:51:38 to 23:59:28):
TIM_CE_CADTOOLS\CD_RecentValues.json                         13194 23:33:02 -> 13195 23:57:26
TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__...   544 23:49:42 -> 521 23:59:53
TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__... 480 23:49:40 -> 477 23:59:53
TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json          233 23:49:13 -> 232 23:59:53
TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json        235 23:49:14 -> 234 23:59:53
TIM_CE_CADTOOLS\logs\ce_struc_structured_20261102.log        1934974 23:48:11 -> 1953202 23:59:50
CE_STRUC_SUITE\logs\ce_struc_suite.log                       4685557 23:49:40 -> 4687209 23:59:53
CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json 885 23:49:40 -> 885 23:59:53
CE_CVL_SUITE\ledger\suggestions.jsonl                        3790947 23:50:04 -> 3792592 23:59:28
CE_CVL_SUITE\logs\ce_cvl_structured_20261102.log             7512516 23:50:04 -> 7610881 23:59:53
CE_CVL_SUITE\logs\CE_CVL_SUITE.log                           2146412 23:49:44 -> 2222475 23:59:53
CE_CADTOOLS\CE_Admin\outbox\machines\CE_SUITE_MANAGER__...   (changed 23:59:53)
CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json          228 23:50:15 -> 261 23:59:53
```
9. **Clean-up:** see the last line of this report.

**Clean-up done:** worktree `C:\CE_WORK\build\w1273` cleaned (`git clean -fdXq`) and removed, scratch folder removed. C: free space was about 36 GB at the start, 34.5 GB at the peak after the build, about 36 GB after clean-up (net change under 1 GB). Branch `claude/w1273-preview-count` kept (pushed, PR #1994).
