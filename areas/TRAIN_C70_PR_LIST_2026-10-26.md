# Train C-70 (Civil + Manager) PR list, Mon 26 Oct 2026, written about 14:05 Melbourne

Built and unit-tested only. Nothing here is installed or accepted. This train is BUG FIXES ONLY (plan items stay paused until Tim lifts the pause). This is the one place the C-70 assembler (`train_c70_assembler_job.txt`) reads the PR list from. No PR is closed, retargeted or merged by the job that wrote this file; no bug is marked FIXED.

**What this train is, in one breath:** a SMALL DIAGNOSTIC TRAIN with ONE PR, #1798: fourteen switches (`diag.redo.*`) that let the robot turn off, one at a time, each separate thing CE does when you click an object, to find which one loses REDO (BUG-861). Every switch is OFF by default, so on a drafter's PC Civil behaves exactly as 3.0.79. Nothing is a fix: BUG-861 stays open.

## ANSWER FIRST

1. **One PR: #1798** (BUG-861 diagnostic switches), branch `fb/bug861-diag-switches`, draft, OPEN, base on GitHub `claude/rel-20261025r`, head `0e583f6495b44f9b3effb75c75606cf2cd146891` (read live with gh and `git ls-remote refs/pull/1798/head` at 14:00; the assembler re-reads it). One commit on `d8840a09`.
2. **Base:** the C-69 branch `claude/rel-20261026t`. Its tip when this list was written was `e7009af18232ff9add418834259524a127305d3b` (the C-69 finalizer's tests-only commit on the assembler's head `cb19403061791a90eec6adbd138ab1342dfc1789`); the C-69 payload builder will add the version commit "Version: Civil 3.0.79 / Manager 1.1.79 (C-69)" on top. The assembler bases C-70 on the REAL tip it reads at its start, and only if that tip carries the C-69 version commit (the four version places read 3.0.79 / 1.1.79). The new branch is `claude/rel-20261026u` (it did not exist at 14:00; if it exists, the next free letter).
3. **New versions:** Civil 3.0.80 / Manager 1.1.80 (the payload builder bumps them, the assembler does not). **Manager is a pure re-stamp in this train:** no Manager code changes (the diff touches only Civil files). The Manager 1.1.80 DLL differs from 1.1.79 only by the stamp.
4. **The PR is NOT independently reviewed.** Its report (`release-v3-colleagues-BUG861_DIAG_REPORT.md`) says "Built and unit-tested by me; not independently reviewed; nobody has opened it in AutoCAD". The finalizer's read of the diff is the first independent read.
5. **It is in the REDO area** (it adds one switch check at the top of each of the Inspector, the ribbon tab update, the ownership highlight, the twin-pick redirect, the compound-group expansion, the pit hover monitor and the Project QA wait). The finalizer must prove a switch left off changes nothing and that the `[REDO-DIAG]` log lines read nothing that could clear REDO (section 3).
6. **Merge clash expected:** the pair trial merge of #1798 onto the C-69 tip (`git merge-tree`, 14:00, tip `e7009af1`) auto-merges `Modules/Drainage/Models/UserSettings.cs` and `Modules/Drainage/Services/InspectorPaletteService.cs` and clashes ONLY in `REGRESSION_LOG.md` (both sides prepend an entry): keep both sides. After the merge the assembler re-checks `UserSettings.cs` and `InspectorPaletteService.cs` by reading them (an automatic merge can still be wrong).
7. **Protected files:** none touched. No `Shared/`, `Installer/`, signing or deploy script, `.csproj`, `.props`, `.targets`, `.ps1`, `PackageContents.xml`, `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json`, help file or Settings window file. No command is added or removed.
8. **Left out on purpose:** everything else (section 4). Nothing from the C-69 list is touched: the Tim-decision PRs (#1771, #1756, #1767, #1204) stay out as in C-69.

## 1. THE ONE PR, in the merge order

1. **#1798** BUG-861 (diagnostic only), reference head `0e583f6495b44f9b3effb75c75606cf2cd146891`, commit message "BUG-861: diagnostic switches (diag.redo.*) to bisect the REDO loss on first pick". Report: `C:\CE_PLAN\areas\release-v3-colleagues-BUG861_DIAG_REPORT.md`. What it does: it adds a `diag.redo` group of fourteen switches plus one "all" switch to the Civil settings file (`%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, read once when AutoCAD starts: a key must be set before launch); each switch, when true, makes one named piece of CE's pick-time work skip itself; each skip writes `[REDO-DIAG] skipped <Component> (diag.redo.<key>) at <place>` and each pick writes `[REDO-DIAG] selection event: skipped components = a, b` (hover and Project QA once per session; nothing at all when every key is off). All keys default OFF = normal behaviour. No Settings window row. Numstat against `d8840a09` (the assembler compares the merge commit's numstat with these lines; for the merge onto the C-69 tip the only legitimate difference is `REGRESSION_LOG.md`):
   1. `Modules/Drainage.Tests/Services/Bug861DiagSwitchesTests.cs` 209/0 (new, 35 tests)
   2. `Modules/Drainage/Models/DiagSettings.cs` 83/0 (new)
   3. `Modules/Drainage/Models/UserSettings.cs` 4/0 (the `diag` group)
   4. `Modules/Drainage/Services/CivilOwnershipHighlightService.cs` 4/0
   5. `Modules/Drainage/Services/CivilProjectQaAutomaticService.cs` 3/0
   6. `Modules/Drainage/Services/CivilSelectionObserver.cs` 6/0
   7. `Modules/Drainage/Services/CompoundSelectionService.cs` 1/0
   8. `Modules/Drainage/Services/InspectorPaletteService.cs` 20/1
   9. `Modules/Drainage/Services/PitHoverService.cs` 2/0
   10. `Modules/Drainage/Services/RedoDiagSwitches.cs` 146/0 (new)
   11. `REGRESSION_LOG.md` 14/0
   12. Total: 11 files, 492 added, 1 removed.
   Author's own test result (not independent): Civil net10 Debug 20,415 total, 20,381 passed, 2 failed (the two `SourceAtomicCoordinatorDependencyTests` that fail in Debug and pass in Release), 32 skipped; net48 Release compile 0 errors; `Bug861DiagSwitchesTests` 35 pass.

## 2. The fourteen switches (read from the report; the assembler and finalizer re-read them from the merged code)

All live in the `diag.redo` group (`DiagSettings`, in `Modules/Drainage/Models/DiagSettings.cs`, reached as `SettingsService.Current.Diag.Redo`), default `false` (off, normal behaviour), `true` = skip that piece:

1. `disableSelectionObserver` (the pick-first observer; it also stops its three notifications: tab, Inspector, highlight)
2. `disableRibbonContextTab`
3. `disablePaletteSelectionHandler` (covers 4 to 6)
4. `disablePaletteFirstPickLog` (the first-click log line added by the 3.0.78 fix; it reads two undo settings)
5. `disablePaletteTimer` (the 150 ms wait)
6. `disablePaletteRefresh`
7. `disableContributedPages`
8. `disableProjectDataSync`
9. `disablePaletteFirstScan`
10. `disableOwnershipHighlight`
11. `disableTwinPickRedirect`
12. `disableCompoundSelection`
13. `disableHoverServices`
14. `disableProjectQaWait`
15. `disableAllSelectionWork` (all fourteen)

(That is fourteen pieces plus the "all" key: fifteen keys.) The existing C-68 switch `linking.inspectorPickWaitsAfterUndo` (default ON) is separate and stays as it is.

## 3. What the finalizer must prove (the reason this train needs an Opus read)

1. **A switch left off changes nothing:** every one of the fifteen keys defaults to false through both start-up reads AutoCAD uses (an empty `{}` file, a C-69-shaped file, a file with `"diag": {}` and a file with `"diag": { "redo": {} }`), and with all keys false every guarded component runs exactly as before (read the first statement of each of the seven guarded services in the merged code; the guard returns "not skipped" and writes nothing).
2. **The `[REDO-DIAG]` log lines read nothing that could clear REDO:** the code that builds and writes them (`RedoDiagSwitches.cs`) must use only the switch values and fixed text: no drawing, document, database, editor, selection, system-variable, command-line or undo read or write, no transaction, no new event. Prove it by reading the file in full AND by a source-text test that the finalizer adds (items 1.2 and 3 of `train_c70_finalizer_job.txt`).
3. **No hook, event or transaction added:** the PR adds no `CommandWillStart`, `CommandEnded`, `DocumentActivated`, Idle or other event handler, no transaction, no system-variable SET (read the diff; run `RedoSafeCallGraphTests`, C-69 baseline 25 of 25, and say if a count moved).
4. **The clash with C-69's own edit in `InspectorPaletteService.cs`** (#1784's four lines and #1779's deferral are in the base, #1798 adds 20/1): read the merged file around all three.

## 4. Other candidates read and NOT taken

1. **Every C-69 left-out item stays out:** #1771 (needs Tim's yes, Monday question 9), #1756 and #1767 (Tim's decision), #1204 (HOLD), #1247 and the Structural round 2 PRs #1792 to #1797 (Structural), #1043, the old PRs #742, #710, #1029, #1147, #1152, #1144, #1150, #1156, #1159, #1161, #954 (replaced by the C-69 PRs), the WAITING PRs, #1706, #1780 and the plan-train PRs. See `TRAIN_C69_PR_LIST_2026-10-26.md` sections 3 and 5.
2. **The BUG-861 fix report's own PR (#1779)** is already in the base (C-68, installed) and is NOT touched.
3. **Why nothing else rides this train:** it exists so the robot can bisect the REDO loss on an installed build; every other change would make the bisect harder to read. Bug fixes that are ready wait for the next full train.

## 5. How the robot uses it (for the desk; not part of the job)

1. Install C-70 (Civil 3.0.80).
2. For each key: set it true in `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` under `"diag": { "redo": { ... } }` BEFORE starting AutoCAD, leave the others off, run `R08x_1_exact` and `R08x_5_plain_line_first` in two fresh sessions, record REDO kept or lost. Start with `disableAllSelectionWork`: if REDO is still lost the cause is outside these pieces. Otherwise the first key that makes round 1 pass in both sessions names the culprit. Put the setting back to false afterwards.
3. Nothing in this train is FIXED, and BUG-861 stays open.

## 6. Settings this train adds

1. The `diag.redo` group: fifteen keys, all default false (section 2). No Settings page row (the window is at its 670 px limit; the keys are for the robot). Every new key needs a "Default: off." documentation line (`NewSettingsKeys_NeedADocumentedDefault`, class `C60AuditSourcePinGuardTests`); the author fixed one failure of exactly this test.
2. The finalizer adds `C70NewSwitchDefaultsTests` (every diag key pinned OFF through the two start-up reads, a typed value kept, the C-69 and C-68 switch defaults pinned again).
3. **No Manager switch, no Manager code, no version change by the assembler.**
