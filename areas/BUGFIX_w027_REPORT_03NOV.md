# BUGFIX w027 report: BUG-027 "MIN." on pipe labels (3 Nov 2026, Melbourne)

## FOR TIM

1. **STOP FLAG, mine to own first:** my test run (6:38 to 6:50 pm UTC on 2 Nov, about 5:38 to 5:50 am Melbourne 3 Nov) overlapped changes to real files in your AppData. Isolation was set (log folder, TEMP and TMP all under C:\CE_WORK\scratch\w027), but the before and after listings differ for files the test host could have written. I cannot prove they were mine or somebody else's, and I did not touch them. Please have CE 01 look before anything is merged. The details are in section "Isolation listings" below.
2. **What a drafter sees differently:** New Pipe, grade on Standard, only the first level typed, "I know one end" off. The label used to end "AT 1 IN 100 MIN."; it now reads "AT 1 IN 100". Your ruling UX-CPLAN-05 (26 Sep 11:46): "Keep the May rule: no MIN."
3. **Not changed:** labels worked out from two levels never carried MIN.; they are the same. The older band rule in the carpark entry (MIN. and MAX. outside a band) is replaced by your ruling and was already switched off in May for those paths.
4. **Switch:** Settings key `pipe.gradeLabelNeverMin`, ships ON. Set false in the settings file before AutoCAD starts and the old "MIN." label comes back exactly.
5. **Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-027 stays open.** 30 tests pass (net48 and net10). The net8 run found no matching tests (that target runs none of these).
6. **Robot case that proves it: K02 (already drafted, no twin by design).** It types `CD`, then `150000,-96000`, then `170000,-96000`, grade Standard, first level `18.000`, second level switched off, and reads the pipe label text. Right: the line ends "AT 1 IN <n>" with nothing after it. Switch-off control: with `pipe.gradeLabelNeverMin` false set before launch, the same steps must end "MIN." (that is the old line, the red).

## Technical detail

1. **Fault confirmed on origin/claude/rel-20261102a (3fbb9da5):** `Modules/Drainage/Commands/CdCommand.Grade.cs` `BuildGradeValue`, the line `return configured + " MIN.";` (about line 221), reached when Default mode, one invert, AutoCalc off. Not already fixed.
2. **Ruling quoted:** `C:\CE_PLAN\decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` line 1751: "UX-CPLAN-05, MIN. suffix (26 Sep 11:46): Tim: 'Keep the May rule: no MIN.'. Pipe labels show the actual grade exactly ("AT 1 IN 100"), never MIN./MAX.". Clear, so no brief needed.
3. **PR:** draft #1997 against `claude/rel-20261102a`, branch `claude/b174-bug027-grade-no-min`, one commit. Open draft #1967 (B-119) also edits `UserSettings.cs` (different spot) but not `CdCommand.Grade.cs`; no stacking.
4. **Files:** CdCommand.Grade.cs, Rules/GradeLabelMinRule.cs (new), Models/UserSettings.cs, Drainage.Tests/Commands/GradeAutoCalcTests.cs (old "returns MIN." test now sets the switch OFF; new ON test), Drainage.Tests/Services/B174GradeLabelNeverMinDefaultsTests.cs (default ON through DeserializeSettings and DeserializeSettingsTolerant for three file shapes, typed false, source guard), REGRESSION_LOG.md. CE_SHARED untouched.
5. **Test command:** one project (Drainage.Tests), `--filter "FullyQualifiedName~B174GradeLabelNeverMinDefaultsTests|FullyQualifiedName~GradeAutoCalcTests"`, with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2` and the refs from the C62 report. Never deployed.
6. **Not tested:** AutoCAD, the New Pipe window, any drawing output. The two-level paths are covered only by the existing tests.

## Isolation listings

1. Before: `C:\CE_WORK\scratch\w027\listing_before.txt` (36,397 lines). After: `listing_after.txt` (36,402 lines). Scope: TIM_CE_CADTOOLS (with CE_Admin outbox and logs), CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS under %APPDATA%.
2. **Changed between the two (19 files, none of them touched by me on purpose):** TIM_CE_CADTOOLS\CD_Settings.json (15311 to 15270 bytes, and its modified time moved BACK to 3 Oct 21:22:30, which looks like a restore or copy, not a normal save), CD_RecentValues.json, CE_Admin machines and sessions JSON for CVL, STRUC and Manager, four new usage outbox files (18:40 to 18:48 UTC), logs\ce_struc_structured_20261103.log, CE_STRUC_SUITE\logs (ce_struc_suite.log, runtime_snapshot.json), CE_CVL_SUITE\ledger\suggestions.jsonl, CE_CVL_SUITE\logs (two files).
3. **Why this may not be me:** the writes run from 18:32 to 18:49 UTC and logs were being written continuously across the whole before-to-after window, which fits other jobs or an AutoCAD session on this PC. No acad.exe was running at the time of my check. **Why it may be me:** the test host loads the CE assembly and the window overlaps 18:38:56 to 18:50. CD_Settings.json is the one to look at first.
4. Disk: C: free was 28.7 GB before the build, 27.96 GB after (stop line 27); worktree clean-up below.

## Worktree

Cleaned after the report push (see the final lines of the session summary).
