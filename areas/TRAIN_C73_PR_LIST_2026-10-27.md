# Train C-73 (Civil + Manager) PR list, Tue 27 Oct 2026, written about 15:30 Melbourne

Built and unit-tested only. Nothing here is installed or accepted. This train is a SMALL DIAGNOSTIC TRAIN of ONE PR (plan items stay paused until Tim lifts the pause). This is the one place the C-73 assembler (`train_c73_assembler_job.txt`) reads the PR list from. No PR is closed, retargeted or merged by the job that wrote this file; no bug is marked FIXED.

**What this train is, in one breath:** the BUG-861 (REDO lost after the first click following an undo) second diagnostic build, draft PR #1829 (author's report `C:\CE_PLAN\areas\release-v3-colleagues-BUG861_UNDO_READER_REPORT.md`). Four new switches under `diag.redo`, all OFF by default, so a drafter sees no change. It follows Tim's ruling (`C:\CE_PLAN\decisions\2026-10-26_TIM_ARCHUNITNET_ADOPT_SMALL_UPDATES.md`): smaller, regular updates (this one is one PR). Civil only; Manager is a re-stamp again.

## ANSWER FIRST

1. **One PR:** #1829, draft, OPEN, based on GitHub `claude/rel-20261026w`, read live with gh and `git ls-remote refs/pull/1829/head` at 15:30: head `1790777a2cbdb5bdc33c2d67096a4b8442788a24` (one commit, branch `fb/bug861-diag2`). It was built on `c4c1e15d`, the C-72 finalizer's signed head; the C-72 branch tip has since moved to the C-72 version commit `e30556ca` (a four-file version commit above `c4c1e15d`), so the merge into the C-72 tip should be clean (a dry-run merge at 15:30 was clean, including `REGRESSION_LOG.md`).
2. **Base:** the C-72 branch `claude/rel-20261026w`. C-72 was Opus-signed GO at `c4c1e15dd9165551d4015eb5905b68fdde24d802` (finalizer report `release-v3-colleagues-TRAIN_C72_FINALIZER_REPORT_2026-10-27.md`) and its payload builder (payload 108, candidate c1068) pushed the C-72 VERSION COMMIT "Version: Civil 3.0.82 / Manager 1.1.82 (C-72)" = `e30556cabae3bb5e940a744db746e157fa61f01c` at about 15:20. At that moment C-72 was NOT yet installed (the installed Civil line was 3.0.81 until the C-72 install chain runs). The assembler bases C-73 on the REAL tip it reads at its start, only if that tip carries the C-72 version commit. New branch: `claude/rel-20261026x` (it did not exist at 15:30; if it exists, the next free letter).
3. **Versions the payload builder will stamp:** Civil 3.0.83 / Manager 1.1.83. The assembler does NOT bump versions. Manager code is UNCHANGED in this train (Manager 1.1.83 is a re-stamp).
4. **Four new Settings keys, all under `diag.redo`, all OFF:** `disableUndoProjectReload`, `disableUndoCacheRebuild`, `disableUndoEndWork`, `watchUndoGap`. The fifteen existing `diag.redo` keys stay false and `disableAllSelectionWork` does not reach the new ones. After this train there are nineteen `diag.redo` keys, all false. No other key is added or changed.
5. **The REDO rule is the whole point of this train.** The PR edits the code that runs at the end of every U (`LinkService.Reactors.cs`) and adds one new service that listens to system-setting changes and drawing-lock changes (`RedoGapWatch.cs`). The finalizer (Opus) must prove by reading and by test that a switch left OFF changes nothing, and that the gap watch only subscribes and logs.
6. **Left out on purpose:** everything in C-72 is already in the base. #1788 (HOLD: Tim's privacy decision), #1771, #1756, #1767, #1204, #1247, #1043, #1780 (the ArchUnitNET trial: "do not merge"), the Structural round 2 PRs #1792 to #1797, every WAITING PR and every plan-train PR are not in this train.

## 1. THE ONE PR

1. **#1829** BUG-861 diagnostic build 2, branch `fb/bug861-diag2`, reference head `1790777a2cbdb5bdc33c2d67096a4b8442788a24` (one commit), title "BUG-861 diagnostic build 2: U-end switches and a log-only gap watch (diag.redo, robot only, draft)". What it does:
   1. `disableUndoProjectReload`: at the end of U, CE does not re-read its pit and pipe record.
   2. `disableUndoCacheRebuild`: at the end of U, CE does not rebuild its position memory.
   3. `disableUndoEndWork`: at the end of U, Civil's linking does nothing at all (the check sits right after `PostUndoWriteWatch.UndoFinished` and `state.IsSuspended = false`, so linking is never left suspended).
   4. `watchUndoGap`: changes nothing in the drawing; only writes a CE log line for every system setting change, drawing lock and command between the end of U and the next command. New file `Services/RedoGapWatch.cs`, hooked only when the key is on at start-up, two subscriptions (`Application.SystemVariableChanged`, `DocumentManager.DocumentLockModeChanged`), at most 40 lines per gap.
   5. Every skip writes `[REDO-DIAG] skipped <Piece> (diag.redo.<key>) at LinkService.OnCommandEnded (<U|UNDO|REDO|MREDO> end)`.
   6. Numstat against the PR's merge-base `c4c1e15dd9165551d4015eb5905b68fdde24d802`:
      1. `Modules/Drainage.Tests/Services/Bug861Diag2SwitchesTests.cs` 363/0 (new, 25 tests)
      2. `Modules/Drainage.Tests/Services/Bug861DiagSwitchesTests.cs` 2/1
      3. `Modules/Drainage.Tests/Services/C70NewSwitchDefaultsTests.cs` 2/1
      4. `Modules/Drainage.Tests/Services/C71NewSwitchDefaultsTests.cs` 1/1
      5. `Modules/Drainage.Tests/Services/C72NewSwitchDefaultsTests.cs` 1/1
      6. `Modules/Drainage/Models/DiagSettings.cs` 20/0
      7. `Modules/Drainage/PluginInitialization.cs` 4/0
      8. `Modules/Drainage/Services/LinkService.Reactors.cs` 9/2
      9. `Modules/Drainage/Services/PostUndoWriteWatch.cs` 9/0
      10. `Modules/Drainage/Services/RedoDiagSwitches.cs` 80/0
      11. `Modules/Drainage/Services/RedoGapWatch.cs` 188/0 (new)
      12. `REGRESSION_LOG.md` 13/0
      13. Total: 12 files, 692 added, 6 removed. Author's runs on `c4c1e15d`: focused Civil net10 504 total, 501 passed, 3 skipped, 0 failed; full Civil net10 20,681 total, 20,649 passed, 32 skipped, 0 failed (22 min 31 s, machine busy); net48 build of the product and test projects 0 errors; the net48 test run, Manager and Structural were NOT run by the author.
   7. The four older default tests (`Bug861DiagSwitchesTests`, `C70NewSwitchDefaultsTests`, `C71NewSwitchDefaultsTests`, `C72NewSwitchDefaultsTests`) now expect 15 + 4 keys: the fifteen unchanged, all nineteen OFF.
2. **Whole train (expected, before any finalizer commit):** 12 files (six product files in `Modules/Drainage`, five Civil test files, `REGRESSION_LOG.md`), 692 added, 6 removed. No `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx` or `.github` file changes; the Manager bundle file-count guard stays 75; the Arch projects (in C-72) are untouched.

## 2. Where it came from

1. Written on 27 Oct 2026 (about 14:55) by the Team Opus job that read what CE itself does at the end of U, after the robot's bisect showed REDO still lost with every click switch OFF. The author's own reading is that the cause is most likely not CE's code (AutoCAD's own handling of the first click of a session is the leading, unproven suspect); this build exists so the robot can name the cause in one run (gap watch first) or clear Civil's U-end work.
2. **It has had no independent read.** The author built and unit-tested it; nobody has opened it in AutoCAD. The C-72 floor for the Civil net10 full run was 20,656 (finalizer); this PR adds 25 tests, so expect about 20,681 plus whatever the finalizer adds (the author's own run on `c4c1e15d` read 20,681). A total under 20,656 means tests went missing and is a loud finding.
3. The author did not run the net48 tests, Manager or Structural, and did not check whether the PDF page test ran in the full run; the finalizer must.

## 3. What the finalizer must prove (the reason this train needs an Opus read)

1. **Every new key defaults to the NORMAL behaviour, by test:** the four keys load OFF from an empty file, from a C-72-shaped file and from the older shapes, through BOTH start-up reads (`SettingsService.DeserializeSettings` and `SettingsService.DeserializeSettingsTolerant`), and with a switch left OFF nothing is skipped and nothing is logged. A typed key turns on only itself. The finalizer adds `C73NewSwitchDefaultsTests` (tests only), modelled on `C72NewSwitchDefaultsTests`.
2. **`watchUndoGap` changes nothing in the drawing and cannot clear REDO:** read `RedoGapWatch.cs` in full. It must only subscribe and log. Check EVERY event it subscribes to (`Application.SystemVariableChanged`, `DocumentManager.DocumentLockModeChanged`): both are read-only notifications, the handlers must not call `SetSystemVariable` or `GetSystemVariable`, take a lock, start a transaction, open a Database or Editor, regen, send a command or touch a view, and BOTH must be unsubscribed at shutdown (`PluginInitialization.cs`) and when the watch is turned off; say what happens when the document is closed mid-gap. Check what the caller in `PostUndoWriteWatch.cs` passes it (memory only). Check that with the key OFF no handler is attached at all.
3. **The REDO-safety rule holds:** no write, command, regen, view change or system variable change is added anywhere in the diff (search the whole diff for `StartTransaction`, `SetSystemVariable`, `GetSystemVariable`, `SendStringToExecute`, `Regen`, `UpdateScreen`, `LockDocument`, `Command(`, `+=`, `Idle`, `CommandWillStart`, `CommandEnded`, `DocumentActivated`); `RedoSafeCallGraphTests` still passes with its baseline file untouched unless the PR itself changed a count (say so loudly).
4. **The three U-end switches, read in `LinkService.Reactors.cs` old and new:** with all three OFF the U branch runs exactly the same steps in the same order as on C-72 (reload, cache rebuild, suspended flag released, write watch told). With `disableUndoEndWork` ON the linking is never left suspended. Say what a skipped step leaves stale in memory (CE's memory may not match the drawing until the next CE command; harmless on a plain line, never left on).
5. **No other key anywhere:** `git diff <base tip>..HEAD -- Modules/Drainage/Models/UserSettings.cs` EMPTY; the `DiagSettings.cs` diff adds exactly the four keys, each `= false` with "Default: off."; `NewSettingsKeys_NeedADocumentedDefault` (class `C60AuditSourcePinGuardTests`) and the Settings-fit test (`EveryTab_FitsTheScreen_AtOneFixedHeight`, tallest tab 670 px or less) still pass; the Settings window is untouched (the keys are not on a Settings page).
6. **CE_SHARED, Installer, Manager and the Arch projects untouched:** `git diff --stat <base tip>..HEAD -- Shared Installer Installer.Tests Modules/Manager Modules/Manager.Tests Modules/Manager/Installer Modules/Arch.Tests Modules/Arch.Tests.Structural` EMPTY; no `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx` or `.github` change.
7. **Builds and tests:** the official Manager release build and file-count guard (75); net48 AND net10 builds of the whole solution; the Civil net10 Release full suite (about 20,681 or more, floor 20,656; the one PDF page test needs AutoCAD's renderer: re-run it alone); net48 targeted tests (baseline: the 55 reference-only reds of the C-72 finalizer); Manager net10 (1,041 total, 1 skipped, 0 failed); the Settings-fit tests; the Arch test projects are not changed but run the Civil half once on net10 as a smoke check (14 of 14 expected; the Structural half is KNOWN RED 3 of 4 on this Structural line, see section 5 item 2: report, do not treat as new); then GO or a negative verdict.

## 4. Other candidates read and NOT taken

1. **#1788** (the Manager upload of Civil reports to the office IT folder) is on HOLD: keep `drainPluginOutbox` OFF; Tim decides who may receive these reports and which fields may leave the PC. **#1771, #1756, #1767, #1204** (Tim-decision PRs) stay out.
2. **#1780** (the ArchUnitNET trial) is a "do not merge" draft and is never merged.
3. **No BUG-861 FIX branch exists** (`fb/bug861-fix2` was not created: no suspect is clearly guilty). This train is diagnostic only.

## 5. How the robot uses it (for the desk; not part of the job)

1. Install C-73 (Civil 3.0.83) after C-72. The robot's procedure is in the author's report section 6: run the gap watch (`watchUndoGap` = true alone) first, with the case names `R08x_diag_watchUndoGap` and `R08x_L_watchUndoGap`; then `disableUndoEndWork`, then the two single switches to split it. A key is set with the settings guard (header line `SETTING CD_Settings.json diag.redo.<key> true`, applied before AutoCAD starts and put back by hash afterwards): CE reads the settings file only at start-up, and whoever sets a key must put it back to false and never leave one on. Count a key as "keeps REDO" only at 2 of 2 per case or better (the 3.0.81 baseline passed 1 time in 5). Moving the Structural and Manager add-ins aside for a control run needs Tim's yes.
2. The Structural half of the ArchUnitNET guards stays red on this Structural line (3 of 4, 26 types reference CE_SHARED by design; measured against the S-44 line); the finalizer of C-72 explained it and signed GO; nothing runs these projects automatically.
3. Each PR's own "test in AutoCAD" steps are in its `REGRESSION_LOG.md` entry. Nothing in this train is FIXED. BUG-861 stays open.

## 6. Settings this train adds

1. **Four, all OFF:** `diag.redo.disableUndoProjectReload`, `diag.redo.disableUndoCacheRebuild`, `diag.redo.disableUndoEndWork`, `diag.redo.watchUndoGap`. A diagnostic switch ships OFF; a switch left off changes nothing for a drafter. No changed default. The finalizer pins all nineteen `diag.redo` keys false in `C73NewSwitchDefaultsTests` through the two start-up reads.
2. **No Manager switch, no Manager code, no version change by the assembler.**
