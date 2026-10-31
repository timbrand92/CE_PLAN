# BUGFIX n1 report, batch 1 "Pit Schedule truth" (Civil), Sat 31 Oct 2026

Job n1, build number B-115. Line: origin/claude/rel-20261102a (Civil 3.0.88). Built and unit-tested only. Nobody has opened anything in AutoCAD.

## FOR TIM

1. **One PR opened, #1937 (draft):** BUG-1155. A schedule whose source drawing was rebuilt (WBLOCK * over the same file) used to say SOURCE MISSING and fail Project QA, though the Xref was loaded. It now says SOURCE RECREATED and tells you to re-place the schedule. Updating is still stopped and QA still fails, because the schedule was placed from a drawing that no longer exists. Only the words change. Settings switch `linking.pitScheduleRecreatedSourceWording`, ON.
2. **BUG-540 (step irons depth): already fixed on this line, no PR.** The Pit Schedule remark, the pit size advice, CDRULES and the after-command refresh all read the one Settings figure (900 mm today). The first attempt (PR #1192) was rejected because PR #914 had already done it. One piece is left: there is no box for "step irons deeper than" on the Settings page. That is a window change, so it is a brief for Codex (section 2), not code from me.
3. **BUG-1197 (another schedule's heading changed): already fixed on this line, no PR.** The heading is now only renamed when every drawing of that frame belongs to the schedule being updated. If an older schedule shares the frame, the heading is left as drawn and the command line says so. The old copy keeps DEPTH TO OUTLET and its 0.85.
4. **What to look at in AutoCAD later (robot, not you):** WBLOCK * the stage drawing over its own path, reload the sheet, open PITSCHEDULE. Right looks like: SOURCE RECREATED and "Re-place the schedule", not SOURCE MISSING.
5. **My mistakes first:** (a) I ran the C77/C78 switch test classes before reading them; they mention APPDATA only in a comment saying tests never use it. (b) My first edit script dropped the first-line marker in `UserSettings.cs` and mangled a line in `PitScheduleStatusService.cs`; the build caught the second and I restored the first before the commit.
6. **Real files:** the real CE folders changed while I worked (CD_Settings.json, CD_RecentValues.json, Admin outbox, logs). AutoCAD (acad.exe) was running the whole time and a CE start-up cycle repeats about every 14 minutes (18:04 and 18:18 both rewrite the sessions files), so these look like the live AutoCAD, not my tests. My tests wrote their settings under C:\CE_WORK\scratch\n1. I cannot prove it file by file; see section 6.

## 1. Answer first

1. **PR:** #1937, draft, base claude/rel-20261102a, title starts B-115.
2. **Stacked on draft #1767 (BUG-1149):** both change the "source not found" branch of `PitScheduleStatusService.cs`. #1767 is based on the older claude/rel-20261024m, so I made my branch from rel-20261102a and merged #1767's two commits into it (conflicts in `UserSettings.cs` and `REGRESSION_LOG.md`, both sides kept). #1767 should merge first; after that #1937 shows only the BUG-1155 commit. #1767 alone on 1102a also breaks one source-text guard in `Bug1145ScheduleFingerprintScopeTests` (line 229 expects the old two-argument call); I fixed that guard in #1937.
3. **Shared files touched:** `Modules/Drainage/Models/UserSettings.cs` (one new switch), `REGRESSION_LOG.md` (entry at the top). CE_SHARED not touched. This is a Settings-engine addition (a new switch read at start-up), so per CE 01 it needs "area plus N91".
4. **Open drafts seen on the files:** `PitScheduleStatusService` is also in #1767 (stacked on) and #423 (BUG-232, old base, different code). `UserSettings.cs` is touched by #1918, #1927, #1904, #1842, #1901, #1908 and others (each adds a key; expect a trivial both-sides conflict). `REGRESSION_LOG.md` by #1922, #1267, #831 and many more (both sides kept). `PitScheduleViewModel.Schedule.cs`: none.

## 2. BUG-540 reproduction (ALREADY FIXED, no PR)

1. Reader one, the schedule window: `ViewModels/PitScheduleViewModel.cs:43` reads `PitScheduleDepthRule.StepIronDepthMetres(Settings StepIronMinDepthMm)`; used in `PitScheduleViewModel.Data.cs` (UpdateWarning, around line 2186).
2. Reader two, the pit size advice: `Services/PitSetupAdvisorService.cs:71`, request field `StepIronDepthMm` set at `AI/SmartifyPitTool.cs:259` and `Commands/PitEditCommand.cs:1132`.
3. Reader three, the after-command refresh: `Services/ScheduleLinkService.cs:2941` and `:2973` (BUG-785, switch `linking.pitScheduleDepthOneRule`, ON). Reader four, CDRULES: `Rules/RulebookEngine.cs:837`.
4. The remark "With Step Irons" is generated only when the row is deeper than that figure (`PitScheduleViewModel.Filters.cs` ApplyDepthRemark). The 0.30 m shallow colour has its own Settings name since BUG-1035 (`shallowPitDepthMm`).
5. Fixing commits, all ancestors of rel-20261102a: a14b3f32 (item 7), 137a629c (item 8), 90cd6139 (BUG-785), 0ab9e32f (BUG-1035 merge).
6. **Left over, brief for Codex (window):** `StepIronMinDepthMm` has no box on the Settings page (search of the XAML and settings view-models finds none). Brief: Pits section, one number box "Step irons needed deeper than (mm)", default 900, bound to Design standards StepIronMinDepthMm, same style as the other boxes. The Fixes tab is at its agreed height, so it needs Tim's layout choice first. Question for CE 04: which tab?
7. #1192 was rejected as a duplicate of #914. Nothing in it needs carrying over.

## 3. BUG-1197 reproduction (ALREADY FIXED, no PR)

1. Fix commit ca83afd0 (BUG-869 follow-up, PR #1531), ancestor of rel-20261102a. `ViewModels/PitScheduleViewModel.Schedule.cs:1527-1583` (`UpdatePitDepthHeadingInTransaction`) walks the frame and its nested definitions, collects every reference, and calls `PitScheduleDepthRule.FrameIsUsedOnlyBy`; if any reference belongs to something else it returns `SharedFrameHeadingNote` and rewrites nothing. It is the only writer of "PIT DEPTH (m)" in the program (grep).
2. Difference from the carpark's "expected": schedule A does not get a private heading when the frame is shared; A keeps the old heading too and the drafter is told. That is safe (never relabels a sheet), not a wrong answer. Giving A a private copy of the frame is a bigger drawing write and needs Tim's word. Question for CE 04: when two schedules share a frame, should an update give the updated one its own heading copy, or leave both as drawn with a note (today)?
3. Unit coverage exists in `PitScheduleStepIronAndHeadingFollowUpTests` (FrameIsUsedOnlyBy true and false). The locked-layer variant of the carpark case is not run headless.

## 4. BUG-1155 (built)

1. **Cause:** `Services/PitScheduleStatusService.cs` matches each stored source by drawing identity (the DWG fingerprint, read at `Services/PitScheduleXrefDiscoveryService.cs:252`). Only a non-loaded Xref falls back to the path. A loaded Xref at the stored path with a new identity matched nothing and went to the missing list.
2. **Change:** a new list `recreated`; a loaded source at the stored path with no identity match goes there. Result: kind Missing, headline "SOURCE RECREATED", detail "The source drawing was recreated: (name). It is loaded, but it is no longer the drawing this schedule was placed from. Re-place the schedule. The placed schedule is preserved." The QA service passes the switch through, so Project QA carries the same words. Switch `linking.pitScheduleRecreatedSourceWording` (`UserSettings.cs`, "Default: on."), read in `PitScheduleStatusService.RecreatedSourceWordingSwitch`. Settings-file key only, no row on the Settings page.
3. **Order of precedence:** conflicts, then SOURCE MISSING, then SOURCE RECREATED, then the BUG-1149 "not found" wording, then unloaded, then out of date.
4. **Tests (net10, count never zero):** `Bug1155RecreatedSourceTests`, 7 tests: recreated words; switch OFF returns SOURCE MISSING exactly; a gone source is not "recreated"; an unreadable Xref at the path is not "recreated"; identity match unaffected; QA words and still Fail; switch default through BOTH start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`) and typed false. They sit in the new file, not a new C79 class; the C77 and C78 classes still pass.
5. **Runs:** Bug1155 + Bug1149 + PitScheduleStatusService: 36 passed. C77, C78, PitScheduleQa*, Bug1145: 129 passed, 1 failed (the Bug1145 guard above), fixed, then Bug1145 + Bug1155 + Bug1149: 43 passed. PitScheduleWindow, Bug246, UserSettings classes: 26 passed. Civil net48 compile: 0 errors. Full suite: NOT run, by this job's rule.
6. **Robot case (name N115_xref_recreated, control N115_xref_recreated_off):** open a stage drawing with a placed Pit Schedule from an Xref; WBLOCK * the Xref source over its own path; reload the sheet; run PITSCHEDULE; check the status badge text equals "SOURCE RECREATED" and the detail contains "Re-place the schedule". Control: set `linking.pitScheduleRecreatedSourceWording` to false in CD_Settings.json on a test copy, repeat, the badge reads "SOURCE MISSING". BUG-1155's own entry is marked UNSURE (AutoCAD behaviour): whether AutoCAD gives the recreated file a new identity and still reports the Xref as loaded is not verified.
7. **Warn, never block (R-27) and REDO:** words only; no new write, command, regen or view change; no layer touched.

## 5. What I did NOT test

1. Anything in AutoCAD or accoreconsole; the window badge as drawn (the new headline is longer than "SOURCE MISSING"; I have not seen it fit).
2. The full Civil suite, Manager, Structural, Installer (not allowed by this job).
3. Whether a real WBLOCK * changes the identity and leaves the Xref Loaded (the carpark's UNSURE).
4. net48 tests (compile only).

## 6. Real-files compare (names, sizes, times only)

1. Listed before my first test (18:11) and after my last (18:26): TIM_CE_CADTOOLS (with CE_Admin\outbox and logs), CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS, CE_SUITE. Before 33,470 lines, after 33,481.
2. Differences: `TIM_CE_CADTOOLS\CD_Settings.json` (15,308 to 15,309 bytes, 18:04:19 to 18:18:22), `CD_RecentValues.json` (same size, time only), `CE_Admin\sessions\*.json`, `CE_Admin\manager-menu-state.json`, `CE_SUITE_MANAGER_MENU.cuix` (time only), eleven new `CE_Admin\outbox\usage\2026-10-31\usage_*.json`, and the growing CE logs.
3. The same files were also rewritten at 18:04, before my first run, and again at 18:18: a repeating start-up cycle of the live AutoCAD (acad.exe present). No change in the CE_STRUC_SUITE, CE_CVL_SUITE or CE_CADTOOLS folders. I could not tie 18:18:22 on CD_Settings.json to a process. My test run's own settings went to C:\CE_WORK\scratch\n1\tmp (seen). Treat as live AutoCAD unless Tim says otherwise.
4. The full listings contain client project names (AutoSaveBackups), so they are not copied into this repo. They were at C:\CE_WORK\scratch\n1\before.txt and after.txt until cleanup.

## 7. Housekeeping

1. BUG_CARPARK.md not edited; no bug marked fixed; no PR closed, retargeted or merged; nothing force-pushed; AutoCAD, Codex and accoreconsole not started.
2. Worktree C:\CE_WORK\build\n1 and scratch C:\CE_WORK\scratch\n1 cleaned at the end: see the last line.

## Finished

1. Last PR (#1937) pushed 18:26; report pushed 18:28 Melbourne (Sat 31 Oct 2026). Worktree and scratch removed 18:27. C: free space was 44 GB at start and 43 GB at the end; my cleanup returned about 0.5 GB after the last build (other jobs were writing at the same time, so the net figure is not mine alone).
