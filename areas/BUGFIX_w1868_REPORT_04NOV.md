# BUGFIX w1868 report, 4 Nov 2026 (B-207, draft PR #2021)

## FOR TIM

1. **What you will see differently:** a gravity pipe 450 mm or bigger flatter than 1 in 200 now gets the yellow fall warning in Edit Pipe, Civil Design, auto-design, markup, Project Review and CDRULES. Before, those sizes said "no minimum fall set" and never warned. Nothing is blocked. If you type your own figure in the large-pipe row, yours wins.
2. **It was not already fixed:** PR #1868 is merged, but the large-pipe row is still blank on the base (`claude/rel-20261102a`, `Modules/Drainage/Models/UserSettings.cs`, `LargeGravityMinGradeN`). Decision 190 asked for 200 to be set, so I made 1 in 200 the shipped figure.
3. **Switch:** `designStandards.largeGravityUsesShippedMinGrade`, ON by default. OFF gives back the old "no minimum fall set for this size" behaviour exactly.
4. **My own mistakes:**
   1. I did not take the "before" listing of the real AppData folders before the first test run, so I cannot show a before and after. The "after" listing is below. Every file changed today is a live log or outbox file; the Structural settings file was last written at 16:28 UTC, before my run. My tests ran with TEMP, TMP and CE_LOG_DIR_OVERRIDE pointed at scratch.
   2. My first version wrote the switch as a plain default and a typed OFF would have been lost on reload. A test caught it; it is fixed (the key is omitted only while ON).
5. **A side effect to know about:** a detention pipe 450 mm or bigger in a council with no flatter detention figure (for example Kingston) now passes at 1 in 200, because it reads the same large-pipe row. That is exactly what typing 200 in the row does today. The Edit Pipe detention-strip fix from decision 190 is NOT in this change.
6. **What is NOT proven:** nobody has opened this in AutoCAD. The warning on screen is unseen. I did not run the Structural or Manager tests.
7. **Robot case (to be written by the robot lane, style N31_dp_time):** `w1868_large_pipe_fall`. It types a 600 mm gravity pipe at 1 in 300 with Edit Pipe and reads the fall line: expect the yellow warning. It then types 1 in 200 and expects no warning. Control: set `designStandards.largeGravityUsesShippedMinGrade` to false before launch, repeat the 1 in 300 pipe, and expect no warning. A 300 mm pipe must read the same in both runs.

## Technical detail

1. **Change:** `DesignStandards.EffectiveMinGradeLadder()` uses `ShippedLargeGravityMinGradeN` (200) when `LargeGravityMinGradeN` is blank and the new `LargeGravityUsesShippedMinGrade` is true. Every screen already reads that one list, so no window change.
2. **Fingerprint:** the new key carries `DefaultValue(true)` with `DefaultValueHandling.Ignore`, so an untouched job's CDRULES fingerprint does not move (about ten pinned fingerprint tests stay green). Saved CDRULES runs on jobs with pipes 450 mm and bigger are not marked Stale even though the rule changed; if you want them Stale once, that is a one-line decision.
3. **Tests:** new `B207LargePipeFallSwitchTests` (both start-up reads, typed false, not written while ON, ladder ON and OFF, typed figure wins) and one rule test in `Gb01Slice1FallsTests`. Existing tests that pinned the blank row now set the switch OFF or expect 1 in 200 (`Gb01Slice1FallsTests`, `RuleFixPlannerTests`, `MaterialVelocityLimitsTests`, `CL5OneSizingStandardsTests`, `C77NewSwitchDefaultsTests`). Focused run, Civil net10, ONE test project with filters: first set 685 tests, second set 2,248 tests, 0 failed. Net48 compile of `CE_CVL_SUITE.csproj`: 0 errors.
4. **Files:** `Modules/Drainage/Models/UserSettings.cs`, `REGRESSION_LOG.md`, six test files. CE_SHARED untouched. No layer, Xref or REFEDIT code touched.
5. **PR:** #2021 draft against `claude/rel-20261102a`, branch `claude/b207-w1868-large-pipe-fall`, commit `699b15b8`. Not stacked on another draft. The commit message names BUG-1091 (taken from the #1868 branch name `fb/bug1091-redesign-reads-min-fall`; I did not find a separate carpark number).
6. **Environment notes:** the bash tool has no gh or pwsh on its PATH; gh needs git on PATH. `dotnet` is at `C:\Program Files\dotnet\dotnet.exe`.
7. **AppData listing after the last test (latest 6 per folder, UTC):**
   1. `TIM_CE_CADTOOLS\CE_Admin\outbox\machines\*.json` 17:19, `outbox\usage\2026-11-04\*.json` 17:00 and 16:48.
   2. `CE_STRUC_SUITE\logs\ce_struc_suite.log` 5,048,903 bytes 17:24; `CS_Settings.json` 35,612 bytes 16:28.
   3. `CE_CVL_SUITE\logs\ce_cvl_structured_20261104.log` 851,047 bytes 17:24; `ledger\suggestions.jsonl` 13:35.
   4. `CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` 228 bytes 17:55.
   These look like a running AutoCAD session's logs, not output of my runs; I cannot prove that without a before listing.
8. **Cleanup:** worktree `C:\CE_WORK\build\w1868` and scratch are being removed after the report push; the free-space change is stated in the final summary.
