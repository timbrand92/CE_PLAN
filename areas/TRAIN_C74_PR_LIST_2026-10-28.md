# Train C-74 (Civil + Manager) PR list, Wed 28 Oct 2026, written about 09:15 Melbourne

Built and unit-tested only. Nothing here is installed or accepted. This train is a SMALL BUG-FIX TRAIN of ONE PR (plan items stay paused until Tim lifts the pause). This is the one place the C-74 assembler (`train_c74_assembler_job.txt`) reads the PR list from. No PR is closed, retargeted or merged by the job that wrote this file; no bug is marked FIXED.

**What this train is, in one breath:** the fix for BUG-1225 (DP and OF refused with "The source landing could not be refreshed" after a drawing is closed without saving and the same file is opened again), draft PR #1830 (author's report `C:\CE_PLAN\areas\release-v3-colleagues-BUG1225_READER_FIX_REPORT.md`). It follows Tim's ruling (`C:\CE_PLAN\decisions\2026-10-26_TIM_ARCHUNITNET_ADOPT_SMALL_UPDATES.md`): smaller, regular updates (this one is one PR). Civil only; Manager is a re-stamp again.

## ANSWER FIRST

1. **One PR:** #1830, draft, OPEN, based on GitHub `claude/rel-20261026x` (the C-73 branch), read live with gh and `git ls-remote refs/pull/1830/head` at 09:10: head `431c27c2dfae3589c695e47de555635b7319f6b9` (one commit, branch `fb/bug1225-landing-fix`), GitHub merge state "clean". It was built on `96455f13fa2df1e63f8bc7cf9d48bd7dc2c14737`, the C-73 branch tip (the C-73 version commit "Version: Civil 3.0.83 / Manager 1.1.83 (C-73)"), so it should merge cleanly.
2. **Base:** the C-73 branch `claude/rel-20261026x`, tip `96455f13fa2df1e63f8bc7cf9d48bd7dc2c14737` at 09:10 (read live with `git ls-remote` in the plugin repo, not in this folder). C-73 was Opus-signed GO at `34dd19d7f8150fe075f423cc9bbdc09bf19736a1` and is INSTALLED on Tim's PC (Civil 3.0.83 / Manager 1.1.83, installed 27 Oct 19:40, verified). Structural 1.0.125 is installed and is not in this train. New branch: `claude/rel-20261026y` (it did not exist at 09:10; if it exists, the next free letter).
3. **Versions the payload builder will stamp:** Civil 3.0.84 / Manager 1.1.84. The assembler does NOT bump versions. Manager code is UNCHANGED in this train (Manager 1.1.84 is a re-stamp).
4. **One new Settings key, ON by default** because it guards a bug fix: `linking.reopenedDrawingLoadsItsOwnRecord` (field `LinkingSettings.ReopenedDrawingLoadsItsOwnRecord`, in `UserSettings.cs`). Typed false it brings back the old behaviour. No other key is added or changed; the nineteen `diag.redo` keys stay false.
5. **One new CE log line,** written when a drawing is opened again after its same-named drawing closed: `[BUG-1225] ... was opened again after its drawing closed; CE loads this drawing's own record.` (the finalizer reads the exact sentence from the code).
6. **The REDO rule matters here too (BUG-861).** The PR adds a handler call in the drawing-closing event (`LinkService.OnDocumentToBeDestroyed`) and changes what the next CE command does in a reopened same-named drawing. The finalizer (Opus) must prove by reading and by test that the fix writes nothing, runs no command, regen, view or system variable change, writes nothing to the closing drawing, and that the closed-drawing handler cannot throw into AutoCAD.
7. **Left out on purpose:** everything in C-73 is already in the base. #1788 (HOLD: Tim's privacy decision), #1771, #1756, #1767, #1204, #1247, #1043, #1780 (the ArchUnitNET trial: "do not merge"), the Structural round 2 PRs #1792 to #1797, every WAITING PR and every plan-train PR are not in this train.

## 1. THE ONE PR

1. **#1830** BUG-1225 fix, branch `fb/bug1225-landing-fix`, reference head `431c27c2dfae3589c695e47de555635b7319f6b9` (one commit), title "BUG-1225: reopened drawing loads its own CE record, so DP and OF no longer refuse". What it does:
   1. `LinkService.OnDocumentToBeDestroyed` calls the new `ProjectDataService.NoteRecordDrawingClosing` (a native-pointer compare only; no transaction, no write). It sets a memory flag `_recordDrawingClosed` (a flag, not a pointer, because AutoCAD may reuse the closed drawing's memory for the next drawing).
   2. `ProjectDataService.Mutations.cs`, `SetDrawingPath`: the same-name branch keeps the in-memory record only when `ReopenedDrawingRecordRule.KeepRecordForSameName` allows; otherwise it falls through to the existing path (load the drawing's own record and save it to that drawing, as every first CE command in a newly opened drawing already does). `LoadCurrentForDrawingLocked` clears the flag. `BindCore` (the BUG-385 binding) uses `ReopenedDrawingRecordRule.RecordsDrawingOpen`.
   3. `ProjectDataService.KeptRecords.cs`: `NoteRecordDrawingClosing`, and the flag is cleared in `SettleKeptRecordsBeforeDrawingGoesLiveLocked` (Undo reloads, adopted snapshots, failed-edit restore).
   4. New headless rule file `Modules/Drainage/Rules/ReopenedDrawingRecordRule.cs`. New switch `linking.reopenedDrawingLoadsItsOwnRecord`, default true, one log line `[BUG-1225] ...`.
   5. CE_SHARED not touched. No new build script. No Manager file.
   6. Numstat against the PR's merge-base `96455f13fa2df1e63f8bc7cf9d48bd7dc2c14737` (the C-73 tip):
      1. `Modules/Drainage.Tests/Services/Bug1225ReopenedDrawingRecordTests.cs` 238/0 (new, 17 tests)
      2. `Modules/Drainage/Models/UserSettings.cs` 10/0
      3. `Modules/Drainage/Rules/ReopenedDrawingRecordRule.cs` 32/0 (new)
      4. `Modules/Drainage/Services/LinkService.cs` 2/0
      5. `Modules/Drainage/Services/ProjectDataService.KeptRecords.cs` 22/0
      6. `Modules/Drainage/Services/ProjectDataService.Mutations.cs` 12/4
      7. `Modules/Drainage/Services/ProjectDataService.cs` 3/0
      8. `REGRESSION_LOG.md` 13/0
      9. Total: 8 files, 332 added, 4 removed. Author's runs on the C-73 tip: focused Civil net10 117 passed, 0 failed; full Civil net10 20,677 passed, 0 failed, 32 skipped (20,709 total; 4 m 36 s); net48 compile of Civil and its tests 0 errors. Not run by the author: net48 tests, Manager, Structural, anything in AutoCAD.
2. **Whole train (expected, before any finalizer commit):** 8 files (five product files and one new rule file in `Modules/Drainage`, one new Civil test file, `REGRESSION_LOG.md`), 332 added, 4 removed. No `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx` or `.github` file changes; the Manager bundle file-count guard stays 75; the Arch projects (in the base) are untouched.

## 2. Where it came from

1. Reported by the robot (runs rn13a and rn13n1 and the N13 and N14 cases, see `release-v3-colleagues-ROBOT_N03_N04_BUG1225_28OCT.md`): 8 of 8 DP and OF refused after a placement in the first drawing, 2 of 2 fine with nothing placed first, waiting 60 seconds changes nothing. Found and fixed by the Team Opus job on 28 Oct 08:31 to 08:50 (report above), on the C-73 tip.
2. **It has had no independent read.** The author built and unit-tested it; nobody has opened it in AutoCAD. The C-73 floor for the Civil net10 full run was 20,692 total (finalizer); this PR adds 17 tests, so expect about 20,709 plus whatever the finalizer adds. A total under 20,692 means tests went missing and is a loud finding.
3. **The author's second suspect is NOT fixed by this PR** (report item 4: the capture records a pipe row and then may change it, so a drawing whose stored rows lack identities that its polylines carry could still refuse at the final refresh if the initial fill and save were ever skipped). BUG-1225 stays open until the robot cases N13 and N14 pass after the install.

## 3. What the finalizer must prove (the reason this train needs an Opus read)

1. **With the switch OFF the old behaviour returns exactly, by test:** `linking.reopenedDrawingLoadsItsOwnRecord` typed false through BOTH start-up reads (`SettingsService.DeserializeSettings` and `SettingsService.DeserializeSettingsTolerant`) makes `SetDrawingPath`, `BindCore` and the close handler behave as on the C-73 tip (read the old and new branch side by side); the PR's own test reproduces the refusal text "Source evidence changed during capture: 1091A0:pipe-row [first ..." with the switch OFF. Default ON from an empty file, a C-73-shaped file and older shapes, in both reads.
2. **The fix is REDO-safe and writes nothing to the closing drawing:** the diff adds no `StartTransaction`, `SetSystemVariable`, `GetSystemVariable`, `SendStringToExecute`, `Regen`, `UpdateScreen`, `LockDocument`, command, event subscription or `Idle` handler; `NoteRecordDrawingClosing` sets a memory flag only; no Database is opened or written for the closing drawing; the reload happens at a CE command start (the same write every first command in a newly opened drawing already makes), never inside the U to REDO window; `RedoSafeCallGraphTests` still passes with its baseline file untouched (say so loudly if the PR changed a count).
3. **The closing-drawing handler cannot throw into AutoCAD:** read `LinkService.OnDocumentToBeDestroyed` and `NoteRecordDrawingClosing` in full: every path guarded (try and catch with a log line, nothing rethrown), a null or already-disposed document safe, the flag set only when the closing drawing is the one the record belongs to (closing drawing B while drawing A holds the record must not mark A's record), two drawings open at once, a drawing closed with a save (the same file name reopened later must also load its own record), and the same-named drawing still open (no flag, record kept). Say what happens when the new drawing happens to reuse the closed drawing's memory address.
4. **Settings:** one key added, ON; `git diff <base tip>..HEAD -- Modules/Drainage/Models/UserSettings.cs` adds exactly the one property with a documented default; `NewSettingsKeys_NeedADocumentedDefault` (class `C60AuditSourcePinGuardTests`) and the Settings-fit test (`EveryTab_FitsTheScreen_AtOneFixedHeight`, tallest tab 670 px or less) still pass; the Settings window is untouched (the key is not on a Settings page). `DiagSettings.cs` is unchanged (nineteen `diag.redo` keys, all false).
5. **CE_SHARED, Installer, Manager and the Arch projects untouched:** `git diff --stat <base tip>..HEAD -- Shared Installer Installer.Tests Modules/Manager Modules/Manager.Tests Modules/Manager/Installer Modules/Arch.Tests Modules/Arch.Tests.Structural` EMPTY; no `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx` or `.github` change.
6. **Builds and tests:** the official Manager release build and file-count guard (75); net48 AND net10 builds of the whole solution; the Civil net10 Release full suite (about 20,709 or more, floor 20,692; the one PDF page test needs AutoCAD's renderer: re-run it alone; the C-73 finalizer also saw the Bug960 palette screenshot test clash once on each runtime and pass alone: re-run alone before calling it red); net48 targeted tests (baseline: the 55 reference-only reds, all `InvalidProgramException`); Manager net10 (1,041 total, 1 skipped, 0 failed); the Settings-fit tests; the Arch smoke check (Civil half on net10, 14 of 14; the Structural half is KNOWN RED 3 of 4 on this Structural line, carried over, never counted); then GO or a negative verdict.

## 4. Other candidates read and NOT taken

1. **#1788** (the Manager upload of Civil reports to the office IT folder) is on HOLD: keep `drainPluginOutbox` OFF. **#1771, #1756, #1767, #1204** (Tim-decision PRs) stay out.
2. **#1780** (the ArchUnitNET trial) is a "do not merge" draft and is never merged.
3. **No BUG-861 fix branch exists.** C-73 (the diagnostic switches) is installed; this train does not touch BUG-861.

## 5. How the robot uses it (for the desk; not part of the job)

1. Install C-74 (Civil 3.0.84). Run the robot cases N13 (DP) straight after N13a and N14 (OF) straight after N14a, each pair in one AutoCAD session (`C:\Lisp Files\_ACAD_DRIVER\cases\`). Right looks like "Downpipe placed. Tag: DP" and "Overflow placed. Tag: OF" both times, with no "could not be refreshed" on the command line or in the CE log, and the new `[BUG-1225] ...` line in the CE log. Count a pass at 2 of 2 per case or better.
2. Each PR's own "test in AutoCAD" steps are in its `REGRESSION_LOG.md` entry. Nothing in this train is FIXED. BUG-1225 stays open (D6) until the robot pass and a Codex pass in AutoCAD, or Tim's word.

## 6. Settings this train adds

1. **One, ON:** `linking.reopenedDrawingLoadsItsOwnRecord` (default true: a switch that guards a bug fix ships ON). Off brings back the old behaviour. The finalizer pins it through the two start-up reads in `C74NewSwitchDefaultsTests`.
2. **No Manager switch, no Manager code, no version change by the assembler.**
