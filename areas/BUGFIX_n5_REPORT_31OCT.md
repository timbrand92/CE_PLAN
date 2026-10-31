# BUGFIX n5 report: B-119 batch 5 (Edit Pipe save path and wording), Sat 31 Oct 2026

Job key n5. Base: `origin/claude/rel-20261102a` (Civil 3.0.88, C-78 line). Four draft PRs, one per bug, all against `claude/rel-20261102a`. Modules/Drainage only. CE_SHARED not touched. Built and unit-tested only: nobody has opened any of this in AutoCAD.

## FOR TIM

1. **Four drafts are open, none merged, nothing marked FIXED.** All four faults were still there on 3.0.88, so none was skipped.
   1. **#1967, BUG-1235 (silting warning wording):** a pipe a hair flatter than 1 in 200 now reads "Grade 1:200.01 is shallower than minimum 1:200.00", not "1:200 ... 1:200". A pipe at exactly 1 in 200 still gets no warning.
   2. **#1969, BUG-1164 (comma-decimal PC):** a level typed 18,14 is stored as 18.14. You will see nothing different on your PC (Australian region).
   3. **#1970, BUG-1157 (level not saved):** if Edit Pipe cannot write the new level onto the pipe itself, one line now says "the level was not saved on pipe ...". Before it said nothing. The save still carries on.
   4. **#1972, BUG-658 (cascade question order):** the "Recalculate downstream pipe inverts?" box, the preview and the "Updated N pipes" line now come after the Edit Pipe change is accepted. A refused save (locked label layer) asks nothing and prints nothing about a cascade.
2. **What you will see differently in AutoCAD:** only #1967 and #1972 show on your PC. #1972 changes the order you see things: the pipe changes first, then the box appears (behind the box the drawing already shows the new level). One U still undoes the pipe change and the cascade together.
3. **A behaviour change inside #1972 you should know about:** if the cascade itself fails part-way, the edited pipe now stays saved and one line says the recalculation did not finish. Before, that failure rolled the whole Edit Pipe save back. I think the new way is safer, but it is your call. Switch it off (`pipe.cascadeQuestionAfterEditCommits` false) to get the old order.
4. **My mistakes, first:**
   1. **The real-files check shows changes, and I cannot prove they are not mine.** See section 4 below. A live AutoCAD (Tim's or the robot's) was already running before my first test and restarted at 21:57. `CD_Settings.json` changed at 21:57:27, one minute after my last test and with no test code run after it. I think that was the robot setting a switch before it launched AutoCAD, but I did not see it happen. Please have someone check before trusting it.
   2. **A stray one-line file** (`Modules.Placeholder.txt`) was written by me at the root of the worktree by mistake. I deleted it at once and it was never committed.
   3. **The plan named the wrong file for BUG-1235** (`CdCommand.Grade.cs`). The sentence lives in `DesignValidationService.cs`. The plan was a read-only guess; I checked it.
   4. **I did not run the full Civil suite.** The method line asks for it once at the end, but the task text says focused classes only, never the full suite, so I followed the task text. The net48 compile was run on all four.
5. **Nothing here needs an engineering decision from you.** One question for CE 04 only if wanted: should a failed level write (BUG-1157) also stop the save? I built the line only, not a stop (R-27: warn, never block).

---

## 1. Per bug: fault confirmed on the line, cause, change

1. **BUG-1235, #1967, branch `claude/b119-bug-1235-grade-warning-figures`.**
   1. **Confirmed:** `Services/DesignValidationService.cs`, `CheckGradeTooFlat` printed both figures with `F0`. The warn-or-not test is `gradeRatio - minimum > 1e-9`, so 1 in 200.008 warns and both figures print 200.
   2. **Change:** new `Rules/GradeWarningFiguresRule.cs`; with the switch ON both figures gain one more decimal at a time (up to nine) until they differ. Figures that already differ read exactly as before. The warn test is untouched.
   3. **Switch:** `pipe.gradeWarningFiguresNeverMatch`, ON. OFF returns the old sentence exactly (tested).
2. **BUG-1164, #1969, branch `claude/b119-bug-1164-comma-levels`.**
   1. **Confirmed:** `Commands/PipeEditCommand.Update.cs`, `UpdatePipeSchedule`: the stored level was the typed text trimmed. The window reads 18,14 through the PC's culture; later readers read stored levels with a full stop, and the cascade question's own `double.TryParse(... Invariant ...)` also failed on it. CDAUDIT (`LinkService.RepairAudit.AuditPasses.cs`, pass D, `NumberStyles.Any` invariant) reads "18,14" as 1814. The plan's line numbers (`RepairAudit.AuditPasses.cs:194-196`) were stale.
   2. **Change:** new `Rules/EditPipeStoredLevelTextRule.cs`; the stored text swaps the PC's decimal mark for a full stop when that gives the same number (digits kept, 18,10 becomes 18.10), else writes the number with a full stop. The text drawn on the plan is not changed. Writer side only: a drawing already holding "18,14" is not repaired and CDAUDIT's reader is not changed.
   3. **Switch:** `pipe.editPipeStoresLevelsWithDecimalPoint`, ON. OFF stores the text as typed (tested).
3. **BUG-1157, #1970, branch `claude/b119-bug-1157-level-write-not-saved`.**
   1. **Confirmed:** `Services/LinkService.Persistence.cs`, `StorePipeInverts`: every failure path is a silent `return` or a catch that only logs; the Edit Pipe call is in `PipeEditCommand.Update.cs` after `AddPipe`.
   2. **Change:** new `LinkService.TryStorePipeInverts` (the same write, returns true or false); the old `StorePipeInverts` calls it and ignores the answer, so New Pipe, Xcivil import, linked text edits and CDLINK behave exactly as before. Edit Pipe prints one plain ASCII line (and logs it) on false. New `Rules/EditPipeLevelWriteRule.cs`.
   3. **Switch:** `pipe.editPipeLevelWriteSaysWhenNotSaved`, ON. OFF is silent as before.
4. **BUG-658, #1972, branch `claude/b119-bug-658-cascade-after-commit`.**
   1. **Confirmed:** `PipeEditCommand.Update.cs`: `UpdatePipeSchedule` ends with `PromptDownstreamCascadeIfInvertChanged`, and it runs while `coordinatedUpdate` is still open (the comment above the transaction says questions come after it closes). The plan's lines (524 to 1906-1908) were right.
   2. **Change:** with the switch ON `UpdatePipeSchedule` is given a hook and remembers the question instead of asking. After the commit, after the "could not confirm" stop and the stale-marker step, and before the placement prompts, the unchanged prompt method runs, inside a try/catch. Not asked in a batch, a preview, or when the drawing needs reopening for its linked-object refresh. New `Rules/CascadeAfterCommitRule.cs`.
   3. **Switch:** `pipe.cascadeQuestionAfterEditCommits`, ON. OFF asks inside the open change exactly as before (hook is null).

## 2. Shared files and stacking

1. **`Models/UserSettings.cs` and `REGRESSION_LOG.md`** are edited by all four PRs. Each PR adds its own property at a different place in `PipeSettings` and its own log entry at the top of the log, so expect small textual conflicts when they merge in any order (keep both sides). Many other open drafts on this base also touch both files.
2. **`PipeEditCommand.Update.cs`** is edited by #1969 (the stored level lines), #1970 (the level write call) and #1972 (the call into `UpdatePipeSchedule`, the cascade branch and the post-commit block). Different lines; no overlap seen.
3. **`LinkService.Persistence.cs`** is edited by #1970 only of mine. Open draft #1892 (B-070, BUG-1141) also edits it, in a different place (around line 834; mine are around lines 246 to 300). No overlap.
4. **Stacking:** the plan says run after batch 3 and after #1838 (B-005). No batch 3 draft (BUG-340, 343, 291, 297) is open against `claude/rel-20261102a`, and #1838 is based on the older `claude/rel-20261026z` line, so nothing here stacks on a draft. If batch 3 lands first, rebase these on it; the Update.cs areas it touches (lines 352 to 422 in the plan) do not overlap mine.
5. **Shared-file note for CE 01:** UserSettings.cs and REGRESSION_LOG.md touched. No Settings-engine or loader change, so no N91 needed. The Settings page is not changed (settings-file-only switches, same as `pipe.editPipeReverseArrowReadsDrawnEnds`).

## 3. Tests run (all net10, Release, one test project per command with a filter, -m:2, SkipDevBundle, below normal)

1. **#1967:** `Bug1235GradeWarningFiguresTests` plus `DesignValidationServiceTests`: 72 passed.
2. **#1969:** `Bug1164CommaLevelStoredTests` (15 new, culture `de-DE`) passed; with four source-reading Edit Pipe classes (`C8BatchNoCascadeQuestionTests`, `PipeEditCommandInvertOverrideFlagTests`, `Bug446StaleMarkerAfterEditPipeTests`, `Bug284LockedLayerChangeTests`): 75 passed. I read those four for AppData writes first: none.
3. **#1970:** `Bug1157LevelWriteNotSavedTests` plus two Edit Pipe source classes: 26 passed.
4. **#1972:** `Bug658CascadeAfterCommitTests` (15) plus the four source classes: 90 run, 89 passed on the first run, 1 was my own test's token check matching "AfterCommit(" (my test bug, fixed); the re-run of the new class passed 15 of 15. The four existing guard classes passed.
5. **Test count was never 0** (AutoCAD 2027 on PATH, placeholder 0-byte `CE_TRANSFORM_2027.arx`). Every command printed with its `--filter` before it ran; none named a solution.
6. **net48 compile of `Modules/Drainage/CE_CVL_SUITE.csproj`:** 0 errors on all four branches.
7. **Not run:** the full Civil suite; any Manager or Structural test.
8. **Settings-switch defaults:** each PR's new test class pins its switch ON through `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant` for `{}`, a pipe group without the key and an unrelated group; typed false reads OFF and changes nothing else (whole object compared); declared once and written true by the save. I did not add the keys to the C75 to C78 default tests (not needed; each PR is self-contained).

## 4. Real-files compare (names, sizes, last-write only; no contents)

Run before my first test (about 21:35) and after my last build (about 22:05), Melbourne time, over `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and logs), `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\CE_CVL_SUITE` and `%APPDATA%\CE_CADTOOLS` (including `CE_Admin`). Before: 33,576 files. After: 33,593 files. The full listings were 4.8 MB each and are not pasted; they were in my scratch folder (now removed). Everything that differs:

1. **STOP-AND-SAY: files changed or new that I cannot show my run did not write.** Evidence the cause is a live AutoCAD, not my tests: a plugin session was already writing at 21:26 to 21:40 (before my first test finished), the CE log shows "CD completed" at 21:40:11 and a new session banner at 21:42:03, `acad.exe` (PID 33700, drawing CLDV32157271_B1.dwg) started 21:57:34, and the CE log is still receiving lines (CDEDIT interception at 22:05:19). My test code only deserialises settings text and reads source files; my settings path in `Bug1235GradeWarningFiguresTests` is under TEMP. I cannot rule out my runs completely.
2. **Settings files:**
   1. `TIM_CE_CADTOOLS\CD_Settings.json`: before 15,270 B, 2026-10-04 08:22:30; after 15,404 B, 2026-10-31 21:57:27. **This is the one that matters.** It is 134 bytes larger. My last test finished at 21:56:26 and `acad.exe` started 21:57:34. Please check what wrote it.
   2. `TIM_CE_CADTOOLS\CD_RecentValues.json`: 12,221 B, 21:36:01 to 21:55:15 (same size).
   3. `CE_STRUC_SUITE\CS_Settings.json`: unchanged (35,613 B, 2026-10-30 19:54:14).
   4. `CE_CVL_SUITE\settings.json`: unchanged (672 B, 2026-09-16 12:13:17).
   5. `TIM_CE_CADTOOLS\CS_Settings.json`: unchanged (351,713 B, 2026-03-31 13:18:00).
3. **Other changed files (all consistent with a live AutoCAD session):** `CE_CADTOOLS\CE_Admin\manager-menu-state.json` (21:26:51 to 21:58:15), `CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` (to 22:04:48), `CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix` (same size, 21:58:13), `CE_CVL_SUITE\ledger\suggestions.jsonl` (3,594,857 to 3,596,337 B), `CE_CVL_SUITE\telemetry\outbox.jsonl` (3 B, 21:57:47), `TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json` and `CE_STRUC_SUITE.json` (21:57:45 and 21:57:46), `TIM_CE_CADTOOLS\CE_Admin\outbox\machines\` two files (21:58:20 and 21:58:24).
4. **New files:** 17 under `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31` and `failures\2026-10-31` (stamped 21:42 to 22:04), plus changed or growing log files: 7 (`CE_CVL_SUITE.log`, `ce_cvl_structured_20261031.log`, `native_grip_2027.log`, `ce_struc_suite.log`, `runtime_20261031.jsonl`, `runtime_snapshot.json`, `ce_struc_structured_20261031.log`).
5. **Isolation variables:** `CE_STRUC_SUITE_APPDATA_ROOT`, `CE_LOG_DIR_OVERRIDE`, `TEMP`, `TMP` were all under `C:\CE_WORK\scratch\n5`; my script refused to run if any was not, and echoed all four before every command.

## 5. What is NOT proven

1. **Nothing was run in AutoCAD.** Each PR is built, unit-tested, and compiled on net48; none is Tim-accepted or Codex-accepted.
2. **#1972** moves a dialog, a drawing change and a command-line line; unit tests hold the decision and the source order, not what AutoCAD does. The post-commit cascade running in its own transaction inside the same command (one U) is by design and by comparison with how the placement prompts already work, not seen.
3. **#1970** needs a pipe whose CE record cannot be read. No test makes one, and I did not exercise the real write failing.
4. **#1969** is only exercised with a `de-DE` culture in the unit test; nobody has run it on a comma-region PC. It does not repair drawings that already hold "18,14".
5. **#1967** shows decimals only where the whole numbers match; I did not test every council minimum grade (a minimum such as 66.7 is covered by one unit case).

## 6. Robot cases (names and what each checks)

1. **`N5_1235_grade_words` (#1967):** type CD, draw a pipe with levels 18.000 and 17.950 over 10.0004 m (a hair flatter than 1 in 200). Check the command-line line contains "Grade 1:200.01 is shallower than minimum 1:200.00". Second pipe at 10.000 m: no silting warning line. **Switch-off control `N5_1235_grade_words_off`:** set `pipe.gradeWarningFiguresNeverMatch` false before launch (settings are read at AutoCAD start), repeat; the line reads "Grade 1:200 is shallower than minimum 1:200".
2. **`N5_658_cascade_after_save` (#1972):** a 3-pipe run P1 to P2 to P3 with levels set; CDEDIT on the first pipe, change its downstream level, Save. Check that when the Yes/No box is up (drive it with the usual Yes), the drawing already shows the changed level on the first pipe; then the "[CDEDIT-CASCADE] Updated" line; one U undoes both. **Refusal variant `N5_658_locked_label`:** lock the layer the pipe label sits on, repeat; check there is NO "[CDEDIT-CASCADE] Updated" line and the downstream pipes keep their levels. **Switch-off control `N5_658_locked_label_off`:** switch false before launch, same steps; the box appears before the save (the old order).
3. **`N5_1157_not_saved` (#1970):** needs a way to damage one pipe's record first (not in the robot kit yet). With it: Edit Pipe, change the IL, Save; check one "[CE] Warning: the level was not saved on pipe" line. **Control:** an ordinary pipe prints no such line; with the switch false even the damaged pipe prints nothing.
4. **`N5_1164_comma_levels` (#1969):** cannot be driven unless the robot can run AutoCAD under a comma-decimal Windows region. Leave it to the unit test unless that is cheap.

## 7. Housekeeping

1. **Worktree:** `C:\CE_WORK\build\n5` created from `origin/claude/rel-20261102a`, `git clean -fdXq` run inside it, then `git worktree remove` (gone). Branches left in place (never deleted): `claude/b119-bug-1235-grade-warning-figures`, `claude/b119-bug-1164-comma-levels`, `claude/b119-bug-1157-level-write-not-saved`, `claude/b119-bug-658-cascade-after-commit`, and a local-only `claude/b119-n5-base` pointing at the base.
2. **C: free space:** 29.07 GB at the start; 28.53 GB just before cleanup; 28.98 GB after removing the worktree (about 0.45 GB came back; other jobs were running at the same time, so the figure is not only mine). The build floor of 27 GB was never reached.
3. **Environment trap:** the tool shell had no git, gh or dotnet on PATH; I added the install folders for my own session only. No new build script was created; my scratch `.ps1` files (wait-for-slot, one-project test runner, real-files listing) were throwaway and the scratch folder is removed.
4. **Slot rule:** my script counted top-level dotnet build or test processes (not claude or pwsh) and ran only at 0 or 1; I saw no "waiting" line in any run's output.
5. **Not edited:** `BUG_CARPARK.md`, `DESK_LOG.md`. PR numbers 1968 and 1971 are not mine.
