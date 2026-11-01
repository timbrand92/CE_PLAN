# q5 report: Project Review "Pipe sizes" agrees with CDRULES (BUG-1258, B-148), Sun 1 Nov 2026

## FOR TIM

1. **Answer:** built as draft PR #1985, stacked on #1857. A pipe whose material has no speed limit set is now judged against your office "Maximum pipe velocity" in BOTH CDRULES and Project Review > Proposals > Pipe sizes. Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1258 is NOT marked fixed.
2. **What you will see differently:** draw a UPVC pipe, blank out UPVC's speed limit in Settings, then run CDRULES and open Project Review > Pipe sizes. Before: CDRULES said "office Maximum pipe velocity of 6.0 m/s" but Pipe sizes said "Unknown: no speed limit is set in Settings for UPVC". Now: Pipe sizes gives a real answer (Keep, Upsize and so on) using the same 6.0 m/s, and the figure follows whatever you type in Settings.
3. **Switch:** `pipeSpeedChecks.projectReviewUsesOfficeVelocityForUnsetMaterial`, ticked (on) by default. Switch it off and "Unknown" returns exactly as before. It also needs #1857's own switch to be on: if that is off, CDRULES judges nothing for that pipe, so Pipe sizes also stays Unknown and the two screens still agree. There is no tick box for it in the Settings window yet.
4. **My own mistakes first:** (a) The Bash tool here has no `gh`, `git` or `dotnet` on its path, so my first few commands failed; I found the real paths and carried on (cost: a few minutes, no harm). (b) I did not add a Settings window row for the new switch. I kept the change small because windows need their own height checks; say if you want the row and I will add it as a follow-up.
5. **Real-folder check, plainly:** the before and after listings of your real CE folders are NOT identical (38 differing lines, listed below). I looked at it before going on. Someone else's AutoCAD (pid 41932, started 22:16:23, parent 55044, not mine; I never start AutoCAD) began at 22:16:23, and every change starts at 22:16:31 or later and matches an AutoCAD start (session files, the Manager menu file, the native grip log, usage records). My last test ended at 22:18:18; writes continued at 22:20:17 while I was running only a compile. My own scratch log folders are empty. So I judge none of it came from my runs, but I cannot prove it file by file.
6. **What is NOT proven:** how the Pipe sizes window looks, whether the figure it shows is the same one on screen as in the CDRULES line, and anything on a real drawing. Only unit tests ran (239 passed, 0 failed, none skipped). The net48 build was compiled only (0 errors); net48 tests do not load here.
7. **Clash to expect:** #1960 (B-120) also adds a setting at the end of the same settings file and a log entry; keep both sides when merging.
8. **Robot case that proves it:** see "Robot case" below (name `N48_pr_office_speed`, control `C48_pr_office_speed`).

---

## Technical detail

1. **Fault confirmed on the base, with file and line.** On `fb/1788-extras-comma-and-speed` (718ec21c, #1857): `Services/PipeSizeNetworkReviewService.cs` `MissingSizingValue` (line 183) tested `rulebook.ScourVelocityFor(m)`, which has no office fallback, so a blank speed gave "no speed limit is set in Settings for ..." and the pipe went Unknown (line 267 in `ReviewOne`; line 505 in the proof). `ResolvedStandards` (line 141) read the same plain lookup. CDRULES reads `values.ScourVelocityForCheck(pipe.Material, unsetUsesOfficeFigure)` (`Rules/RulebookEngine.cs` 498). So the two screens differed.
2. **Fix (one code path):** both Project Review sites now call `ScourVelocityForCheck` (`Rules/RulebookValues.cs` 519, added by #1857) with `UnsetMaterialTakesOfficeVelocity()`, a new helper in the same service: `projectReviewUsesOfficeVelocityForUnsetMaterial` AND `RulebookEngine.UnsetMaterialSpeedUsesOfficeFigure()`. Unreadable Settings read ON. Figure from `DesignStandards.MaximumPipeVelocity` (Settings); nothing hard-coded. Switch OFF: `ScourVelocityForCheck(m, false)` is `ScourVelocityFor(m)`, the old answer byte for byte.
3. **Switch:** `PipeSpeedChecksSettings.ProjectReviewUsesOfficeVelocityForUnsetMaterial`, JSON `pipeSpeedChecks.projectReviewUsesOfficeVelocityForUnsetMaterial` (the task named it `checks.`; the group in the saved file is `pipeSpeedChecks`, next to #1857's switch). Doc comment ends "Default: on." UserSettings.cs was not touched.
4. **Files:** `Modules/Drainage/Models/PipeSpeedChecksSettings.cs` (+10), `Modules/Drainage/Services/PipeSizeNetworkReviewService.cs` (+18, -2), `Modules/Drainage.Tests/Services/Bug1258ProjectReviewOfficeVelocityTests.cs` (new, 13 tests), `REGRESSION_LOG.md` (+11). One normal commit `ad5f254c` on branch `fb/1258-project-review-office-velocity`. CE_SHARED not touched. No write, regen, view or system-variable change: the sizing review is pure (reads ProjectData, never the drawing).
5. **PR:** #1985, DRAFT, base `fb/1788-extras-comma-and-speed` (stacked on #1857, which is still an open draft against `claude/rel-20261026z`; the task said stack on it). Title starts B-148. Open drafts touching the same files: #1960 (settings file and log, append-only clash); the many older drafts matched by name (#437, #475, #772, #1841 and others) are not stacked on and were not read line by line; #1841 adds the GB-01 ladder lines in the same service and is already in the #1857 base.
6. **Tests (focused, net10.0-windows, one project, filtered, 3 runs):**
   1. t1 filter `Bug1258ProjectReviewOfficeVelocityTests|PipeSize|UnsetMaterialSpeedFallback|ProjectReviewPipeSizes|B011bSettingsRows`: 239 passed, 0 failed, 0 skipped.
   2. t2 filter `Bug1258ProjectReviewOfficeVelocityTests`: 13 passed.
   3. Count checked against zero (AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder created).
   4. The new tests: on/off on the same Keep pipe (ON not Unknown; OFF Unknown with the old words and `MissingSizingValue` the old sentence); the figure Project Review reads equals the one CDRULES reads at office max 5.5; CDRULES switch off keeps Unknown; own-speed material (2.5) unchanged either way; office figure also 0 stays Unknown; both start-up reads (`DeserializeSettings`, `DeserializeSettingsTolerant`) default ON for `{}`, a group without the key and a C-77-shaped group; typed false changes only itself (whole object compared); typed true; the doc line says "Default: on.". The switch-off cases act as the broken twin.
   5. net48: `dotnet build Modules\Drainage\CE_CVL_SUITE.csproj -f net48 -c Release`: 0 errors, 246 warnings (existing).
   6. Never run: Manager tests, the full suite, any solution file. Every command carried `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, Below Normal; the run script refused with no filter or a solution and held for a free slot (0 other builds were running).
7. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP and CE_STRUC_SUITE_APPDATA_ROOT were set to fresh folders under `C:\CE_WORK\scratch\q5\run_*` and echoed before every run. Listings taken at 22:14 (before) and 22:20 (after) of `%APPDATA%\TIM_CE_CADTOOLS` (with `CE_Admin\outbox` and `logs`), `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS`.
   1. **Before:** 35,082 files (TIM_CE_CADTOOLS 31,211 after; CE_STRUC_SUITE 2,502; CE_CVL_SUITE 347; CE_CADTOOLS 1,022). **After:** 35,086 files. The full listings are 35,000 lines each and were not pasted; the 38 differing lines are below.
   2. Those differences are explained by an AutoCAD start (acad.exe pid 41932 at 22:16:23, parent 55044), not by my runs. See item 5 of the FOR TIM block. If CE 02 started that AutoCAD, the 22:16 to 22:20 changes are the robot's.
8. **Robot case (not written, named for CE 02):** `N48_pr_office_speed` (proves BUG-1258; control `C48_pr_office_speed`). Needs a copy of a CE drawing with one gravity pipe in UPVC, a flow set, drawn levels, and Settings set BEFORE launch (the guard is read at AutoCAD start): Design standards UPVC speed limit blank (0), office Maximum pipe velocity 6.0, `unsetMaterialUsesOfficeFigure` and `projectReviewUsesOfficeVelocityForUnsetMaterial` both true. Type `CDRULES`, answer `All`; read the speed line for that pipe: it must say "office Maximum pipe velocity of 6.0 m/s; UPVC has no speed limit set in Settings, so the office figure is used". Then open Project Review > Proposals > Pipe sizes and read that pipe's row. Right: the row is not "Unknown: no speed limit is set in Settings for UPVC" and the speed used is 6.0 m/s (the same figure). Control: set `projectReviewUsesOfficeVelocityForUnsetMaterial` false before launch; the same keystrokes give the CDRULES line unchanged and the Pipe sizes row "Unknown: no speed limit is set in Settings for \"UPVC\"". A second control with `unsetMaterialUsesOfficeFigure` false: CDRULES says "no scour cap in the rulebook" and Pipe sizes stays Unknown (they agree). Open question for CE 02: whether the Pipe sizes window rows can be read by the robot (the earlier press lists say Profiles and Edit 2 Pipes are not pressable; Pipe sizes is not recorded either way).
9. **Cleanup:** worktree `C:\CE_WORK\build\q5` cleaned with `git clean -fdXq` and removed, scratch `C:\CE_WORK\scratch\q5` removed (the branch and PR stay). C: free space: 43.58 GB at the start, 43.24 GB before cleanup; the figure after cleanup is on the last line of this file.
10. **Not edited:** BUG_CARPARK.md, DESK_LOG.md, Tim's settings files, installed bundles, ProgramData. BUG-1258 stays OPEN.

### The 38 differing lines in the real folders (before listing vs after listing)

   - before \CD_RecentValues.json | 12218 | 2026-11-01 21:54:39
   - after  \CD_RecentValues.json | 12220 | 2026-11-01 22:19:01
   - before \CE_Admin\manager-menu-state.json | 224 | 2026-11-01 22:00:01
   - after  \CE_Admin\manager-menu-state.json | 224 | 2026-11-01 22:16:48
   - before \CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json | 521 | 2026-11-01 22:06:02
   - after  \CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json | 532 | 2026-11-01 22:20:02
   - before \CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json | 477 | 2026-11-01 22:06:02
   - after  \CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json | 480 | 2026-11-01 22:20:02
   - before \CE_Admin\outbox\machines\CE_SUITE_MANAGER__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json | 573 | 2026-11-01 22:06:02
   - after  \CE_Admin\outbox\usage\2026-11-01\usage_20261101_111636_575_da4763f8f8c84406b24a1ac81df10939.json | 394 | 2026-11-01 22:16:36
   - after  \CE_Admin\outbox\usage\2026-11-01\usage_20261101_111637_377_121fcc50a67c4a90a7abc288e5d342a6.json | 391 | 2026-11-01 22:16:37
   - after  \CE_Admin\outbox\usage\2026-11-01\usage_20261101_111637_378_72b943d642764305aba7048d5b1df319.json | 387 | 2026-11-01 22:16:37
   - after  \CE_Admin\outbox\usage\2026-11-01\usage_20261101_111825_533_e0b5f684f3964a26889e2cb11b66608e.json | 386 | 2026-11-01 22:18:25
   - after  \CE_Admin\outbox\usage\2026-11-01\usage_20261101_111950_836_421a68543b564ed79d7ce1fe9196ea2b.json | 386 | 2026-11-01 22:19:50
   - before \CE_Admin\sessions\CE_CVL_SUITE.json | 232 | 2026-11-01 22:06:02
   - after  \CE_Admin\sessions\CE_CVL_SUITE.json | 233 | 2026-11-01 22:16:31
   - before \CE_Admin\sessions\CE_STRUC_SUITE.json | 234 | 2026-11-01 22:06:02
   - after  \CE_Admin\sessions\CE_STRUC_SUITE.json | 235 | 2026-11-01 22:16:32
   - after  \CE_Admin\sessions\CE_SUITE_MANAGER.json | 228 | 2026-11-01 22:19:33
   - before \CE_Admin\sessions\CE_SUITE_MANAGER.json | 261 | 2026-11-01 22:06:02
   - before \CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix | 28808 | 2026-11-01 21:59:59
   - after  \CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix | 28808 | 2026-11-01 22:16:46
   - before \ledger\suggestions.jsonl | 3704722 | 2026-11-01 22:04:08
   - after  \ledger\suggestions.jsonl | 3705481 | 2026-11-01 22:20:17
   - before \logs\ce_cvl_structured_20261101.log | 10068086 | 2026-11-01 22:06:00
   - after  \logs\ce_cvl_structured_20261101.log | 10112693 | 2026-11-01 22:20:18
   - before \logs\CE_CVL_SUITE.log | 727379 | 2026-11-01 22:06:02
   - after  \logs\CE_CVL_SUITE.log | 761950 | 2026-11-01 22:20:05
   - before \logs\ce_struc_suite.log | 4299898 | 2026-11-01 22:06:02
   - after  \logs\ce_struc_suite.log | 4302411 | 2026-11-01 22:20:02
   - before \logs\native_grip_2027.log | 166104 | 2026-11-01 21:59:41
   - after  \logs\native_grip_2027.log | 166212 | 2026-11-01 22:16:31
   - before \logs\RuntimeDiagnostics\runtime_20261101.jsonl | 289960 | 2026-11-01 21:59:59
   - after  \logs\RuntimeDiagnostics\runtime_20261101.jsonl | 291511 | 2026-11-01 22:16:46
   - before \logs\RuntimeDiagnostics\runtime_snapshot.json | 885 | 2026-11-01 22:06:02
   - after  \logs\RuntimeDiagnostics\runtime_snapshot.json | 885 | 2026-11-01 22:20:02
   - before \telemetry\outbox.jsonl | 3 | 2026-11-01 21:59:43
   - after  \telemetry\outbox.jsonl | 3 | 2026-11-01 22:16:32

C: free space: 43.23 GB before cleanup, 43.69 GB after (moved 0.46 GB); worktree and scratch removed, branch fb/1258-project-review-office-velocity and PR #1985 kept.

Cleanup note: the worktree folder is removed. The scratch folder C:\CE_WORK\scratch\q5 still holds only this job's own temp folder (tmp\claude, held open by the running session, a few KB); it is safe to delete after the job ends.
