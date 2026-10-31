# BUGFIX n4 report, B-118, batch 4 (lock, copy and damaged-record safeguards), 31 Oct 2026

## FOR TIM

1. **One draft pull request opened: #1952 (BUG-1070).** Built and unit-tested only. Nobody has run Undo or REDO in AutoCAD. BUG-1070 is not marked fixed.
2. **What you will see differently (BUG-1070):** if something makes the CE record in a drawing unreadable, CE stops saving over it. Before, pressing U could bring the good record back, but CE kept refusing to save, so later pipes and pits showed on screen while their CE record update was quietly not stored, and CDSYNC kept saying "Not saved to the CE record". Now U lifts the hold as soon as the good record is back. REDO to the damaged state puts the hold back, and U again lifts it. A read that fails once changes nothing.
3. **Three of the four bugs are already fixed on the current line, so I built nothing for them (no PR):**
   1. **BUG-286 (CD to a pit on a locked layer, pipe left behind on a pit MOVE):** already built in C-5, commit 71980a7f (1 Oct, PR #490), which is inside the Civil 3.0.88 line. A pit MOVE now also carries pipes whose own record names the pit but which the pit's list lacks, and adds them to the list. The locked-pit line no longer says "run the command again".
   2. **BUG-288 (downpipe copied onto an existing open pipe end with a pit is not relinked):** same commit. The copy relink rescans pipes with an end in a copied downpipe's reach again.
   3. **BUG-298 (CDFIXPIPEENDS half-changes a record if it throws):** same commit. The new record is worked out in full, assigned in one go, saved once, and put back if the save throws, so "Pipe X was not changed" is true.
4. **The carpark entries for 286, 288 and 298 still say OPEN (1 Oct).** They were built but never accepted in AutoCAD. They need a Codex look, not new code. I did not touch the carpark.
5. **I ran the 28 existing tests of that commit (Bug285To298C5Tests): 28 passed.** That proves the built behaviour, not that it works in AutoCAD.
6. **Possible touch of your real settings (said first, as the job requires):** the before/after listing of your real settings folders shows `TIM_CE_CADTOOLS\CD_Settings.json` was rewritten at 20:24:42 (15270 to 15350 bytes) and by 20:27 it was back at 15270 bytes with its old 4 Oct date. My new switch is NOT in that file. All my runs used scratch folders for TEMP, TMP and the CE log override, and my new tests read only text in memory. Other things were running on this PC at the same time (a build in another worktree, n13, and live AutoCAD sessions writing the Structural and Civil logs). I cannot prove who wrote it. Details in section 3 below.

## 1. What was done, bug by bug

1. **Start point:** `origin/claude/rel-20261102a` (Civil 3.0.88, commit 3fbb9da5). PR base: `claude/rel-20261102a`.
2. **BUG-286, BUG-288, BUG-298: ALREADY FIXED on the line (no PR).** Evidence:
   1. Commit `71980a7f` "C-5: pipe OOPS, locked-pit CD, open-end rescan, atomic repair (BUG-285 286 288 298)" is an ancestor of the line (`git merge-base --is-ancestor` true).
   2. BUG-286: `Modules/Drainage/Rules/PitMoveRecordSideRule.cs`, `Services/LinkService.PitMoves.cs` lines 105 to 135 and 215 to 232, `Services/LinkService.Persistence.cs` line 1216 (locked-pit line), `Rules/LockedLayerRecordWriteRule.cs` line 98.
   3. BUG-288: `Services/LinkService.RepairAudit.Relink.cs` lines 661, 753, 806 (the drawing-wide open-end rescan restored for the pipes in a copied downpipe's reach), 1211 to 1290; `LinkService.PitRelinks.cs` lines 26 to 33; `LinkService.State.cs` line 123.
   4. BUG-298: `Services/ProjectDataService.PipeEndRepair.cs` (`ApplyPipeEndRepairToRecord`: build in full, assign together, save once, restore on throw) and `Services/LinkService.PipeEndRepair.cs` lines 164 to 177.
   5. Tests on the line: `Modules/Drainage.Tests/Rules/Bug285To298C5Tests.cs` (28 tests, all passed in my run).
3. **BUG-1070: faulty on the line, fixed in draft PR #1952.**
   1. **Cause:** `ProjectDataService.Persistence.cs`: the hold (`NoteUnreadableRecord`) was updated only by the normal load (line 211). `ReloadAfterDrawingHistoryChange` (U/REDO, called from `LinkService.Reactors.cs:913`) and the idle retry in `ScheduleHistoryReloadRetry` read the record but never told the hold. This matches the carpark entry.
   2. **Fix:** both re-reads use the same open-close read with the "record had text" answer and call the one place that moves the hold, `UnreadableRecordHold.Update` (new, in `Rules/UnreadableRecordHold.cs`; the normal load now uses it too, so there is one code path). Confirmed unreadable sets the hold, readable or absent releases it, a failed read leaves it. No command-line line from U/REDO (the first skipped save says it). No transaction, write, lock, command, regen, view or system variable change, so it is REDO-safe.
   3. **Switch:** `linking.undoRefreshesUnreadableRecordHold`, Default: on., settings-file key only (no Settings page row, like `keepUnreadableDrawingRecord`; a page row needs your layout decision). OFF = the old behaviour exactly. A missing file or group reads ON. `linking.keepUnreadableDrawingRecord` (BUG-971) still wins.
   4. **Files:** `Modules/Drainage/Rules/UnreadableRecordHold.cs`, `Modules/Drainage/Services/ProjectDataService.Persistence.cs`, `Modules/Drainage/Models/UserSettings.cs`, `REGRESSION_LOG.md`, new `Modules/Drainage.Tests/Services/Bug1070UndoRefreshesHoldTests.cs`, and one existing source guard re-pointed in `Modules/Drainage.Tests/Rules/Bug971EveryRecordWriterAsksTheHoldTests.cs` (it looked for the `ShouldRelease` call inside Persistence.cs; it now looks for the single `Update` call there and for `ShouldRelease` in the rule file).
   5. **Tests (Civil net10, one test project, with filters, AutoCAD 2027 on PATH):** 344 run, 344 passed, 0 failed (Bug1070, Bug971, every NewSwitchDefaults class, RedoSafe call-graph, RedoSweep, SettingsService, Bug1228, Bug1223, Bug1167). New tests: open damaged, U to good, REDO to damaged, U again gives hold true, false, true, false; U to no record lifts it; a failed read leaves the hold as it was; per drawing only; the old two-rule pair and `Update` agree for all 16 combinations; the switch reads ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes; typed false changes only itself (whole object compared); source guards that both re-reads call the note before the decision and that the note starts nothing in the drawing. Net48 compile of Drainage: 0 errors. I did not run the full suite (the job's later rule said focused classes only). The `RedoSafeCallGraphTests` compiled scan passed with the new code.
4. **Mistakes of my own:** (1) my first test run had one failure, a Bug971 source guard I broke by moving the `ShouldRelease` call; I fixed it by pointing the guard at the new single place and said so in the PR. (2) The first build failed on the missing 0-byte `CE_TRANSFORM_2027.arx` placeholder; I created it inside my worktree only (untracked, removed with the worktree).

## 2. Shared files and clashes

1. **Shared files touched:** `Modules/Drainage/Models/UserSettings.cs` (one property added next to `KeepUnreadableDrawingRecord`) and `REGRESSION_LOG.md` (one entry added at the top). `CE_SHARED` NOT touched. A Settings-engine or loader change: none, but a new switch is a Settings change, so area plus N91 applies.
2. **Protected file:** `ProjectDataService.Persistence.cs` (Opus review wanted before merge; also the record-hold code).
3. **Clashes seen:** I checked each open draft #1919 to #1949 plus #1892, #1867, #1170, #1544 with `gh pr diff --name-only`. None touches `ProjectDataService.Persistence.cs` or `UnreadableRecordHold.cs`. #1892, #1940, #1943 and #1945 (and many others) touch `UserSettings.cs`: expect an additive merge conflict there, resolve by keeping both sides. #1892 (B-070 BUG-1141) also touches `LinkService.Persistence.cs` (not a file I edited). No stacking was needed. #1867 (the ROTATE/SCALE copy draft the plan said BUG-288 must follow) is actually titled BUG-1227 Part A; BUG-288 needed no code, so no stacking was done.
4. **Batch 5 (BUG-1157 in `LinkService.Persistence.cs`):** no overlap with my files, so batch 5 can start without waiting for #1952.

## 3. Real-files compare (names, sizes and times only, no contents)

1. **Before listing:** taken at about 20:05 to 20:14 Melbourne before my first test: 33,536 files under `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS`, `CE_SUITE`. **After listing:** 20:27, 33,542 files. Both full listings were kept in my scratch folder, which I then deleted; the differing lines are summarised here.
2. **Files that differ (24 changed, 6 new, 0 removed), none was written by a settings save of mine as far as I can tell:**
   1. `TIM_CE_CADTOOLS\CD_Settings.json`: at the after-listing 15350 bytes, 20:24:42; five minutes later back to 15270 bytes dated 4 Oct 08:22:30, the same as before. My new key is not in it. This is the one item to look at. Cause unproven.
   2. `TIM_CE_CADTOOLS\CD_RecentValues.json`: same size 12220, time 18:44:58 to 20:20:45.
   3. `TIM_CE_CADTOOLS\CE_Admin\outbox\machines` (2 files), `outbox\usage\2026-10-31` (5 new files), `sessions` (2 files); `TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log`.
   4. `CE_STRUC_SUITE\logs\ce_struc_suite.log` and two `RuntimeDiagnostics` files; `CE_CVL_SUITE\logs` (3 files), `CE_CVL_SUITE\ledger\suggestions.jsonl`, `CE_CVL_SUITE\telemetry\outbox.jsonl`; `CE_CADTOOLS\CE_Admin` (manager menu state, a session file, one new machines file).
   5. **No Structural settings file** (`%APPDATA%\CE_STRUC_SUITE` non-log files) changed. No file under `CE_SUITE` changed.
3. **Why I think these are other processes, and what I cannot prove:** the log, ledger, session and outbox files kept growing up to 20:27:30, while no dotnet command of mine was running, and `native_grip_2027.log` is written only by a live AutoCAD. A build of `C:\CE_WORK\build\n13` was also running. But I did run tests between the two listings and cannot rule out that one of them wrote `CD_Settings.json` or `CD_RecentValues.json`. If that matters, the next step is to look at the Windows file-access history for those two files; I have not done it.

## 4. Robot case (for CE 05 / Codex)

1. **Case name:** `B118_undo_hold` (control `B118_undo_hold_off`).
2. **Set-up:** synthetic mm drawing, pit P1 with a valid CE record, saved. A fixture command breaks `lastPitNumber` in the record in one undo step, so the open puts the hold on. Settings: `linking.undoRefreshesUnreadableRecordHold` true (default).
3. **Types:** `U`, then `CDSYNC`, then `REDO`, then `U`, then `CDSYNC`.
4. **Checks:** the CE log shows "Project data reloaded after Undo/Redo: pits=1, pipes=0" after each U, and after each CDSYNC there is no "Not saved to the CE record" line on the command line or in the log; after REDO a CDSYNC does print that line (hold back on).
5. **Switch-off control:** set `linking.undoRefreshesUnreadableRecordHold` to false, repeat: after the first U the CDSYNC DOES print "Not saved to the CE record" (the old fault).
6. **Robot cases for BUG-286, 288, 298:** these still need cases because the built behaviour was never driven in AutoCAD. 286: CD a pipe to a pit on a locked layer, MOVE the pit, check the pipe end moves. 288: copy a downpipe with a pit onto an open pipe end, check the pipe relinks. 298: CDFIXPIPEENDS on a copied pipe, check the pipe record and the "was not changed" line agree.

## 5. What I did NOT test

1. Nothing was run in AutoCAD (no U, REDO, CD, COPY, MOVE or CDFIXPIPEENDS). No accoreconsole, no Codex.
2. The full Civil suite was not run (the job said focused classes only, never the full suite). The one PDF page test was not needed.
3. Manager tests were not run (by rule). Structural was not touched.
4. BUG-286, 288 and 298 were judged from the code and the 28 existing tests, not reproduced in a drawing.
5. The idle retry path (`ScheduleHistoryReloadRetry`) is covered by a source guard only, not run.
6. The new switch has no Settings page row; whether it needs one is your layout decision.

## 6. Housekeeping

1. **Branch / PR:** `claude/b118-bug1070-undo-hold`, draft PR #1952 against `claude/rel-20261102a`, title starts with B-118. Commit 6845a095. Undo: close nothing; revert the commit.
2. **C: free space:** 30.1 GB at the start, 29.58 GB after the worktree and scratch folder were removed. Net use of C: by this job is therefore about 0.5 GB (other jobs write to C: at the same time, so this is approximate). Nothing was deleted to make room.
3. **Finished:** Sat 31 Oct 2026, 20:30 Melbourne time (read with the date command at 20:29:21 before this last edit).
4. `BUG_CARPARK.md`, `DESK_LOG.md`, installed bundles and Tim's settings files were not edited by me. `C:\CE_PLAN\areas\BUGFIX_n4_REPORT_31OCT.md` is the only CE_PLAN file I wrote.
