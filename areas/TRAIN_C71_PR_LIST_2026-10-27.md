# Train C-71 (Civil + Manager) PR list, Tue 27 Oct 2026, written about 08:00 Melbourne

Built and unit-tested only. Nothing here is installed or accepted. This train is BUG FIXES ONLY (plan items stay paused until Tim lifts the pause). This is the one place the C-71 assembler (`train_c71_assembler_job.txt`) reads the PR list from. No PR is closed, retargeted or merged by the job that wrote this file; no bug is marked FIXED.

**What this train is, in one breath:** a SMALL FOLLOW-UP TRAIN of SIX draft PRs (#1818, #1819, #1820, #1821, #1823, #1824), each one written from Codex's second-opinion review of an earlier PR, report `C:\CE_PLAN\areas\release-v3-colleagues-CODEX_FIXES_APPLIED_27OCT.md`. It follows Tim's ruling (`C:\CE_PLAN\decisions\2026-10-26_TIM_ARCHUNITNET_ADOPT_SMALL_UPDATES.md`): smaller, regular updates, at most about six PRs a train. Every PR is Civil only. Manager is a re-stamp again.

## ANSWER FIRST

1. **Six PRs**, all draft, all OPEN, all based on GitHub `claude/rel-20261026u`, each one commit on the C-70 tip `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1` (read live with gh and `git ls-remote refs/pull/<n>/head` at 08:00; the assembler re-reads every head).
2. **Base:** the C-70 branch `claude/rel-20261026u`, tip `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1` (the C-70 payload builder's version commit "Version: Civil 3.0.80 / Manager 1.1.80 (C-70)" on the finalizer's signed head `39bc2108b093bde93de58721f7320f65ab1c692b`). The installed line on Tim's PC is Civil 3.0.80 / Manager 1.1.80 (C-70) and Structural 1.0.125. The assembler bases C-71 on the REAL tip it reads at its start, and only if that tip carries the C-70 version commit (the four version places read 3.0.80 / 1.1.80). The new branch is `claude/rel-20261026v` (it did not exist at 08:00; if it exists, the next free letter).
3. **Versions the payload builder will stamp:** Civil 3.0.81 / Manager 1.1.81. The assembler does NOT bump versions. Manager code is UNCHANGED in this train (Manager 1.1.81 is a re-stamp).
4. **No new Settings key, no new switch.** None of the six PRs touches `UserSettings.cs`, `DiagSettings.cs` or any settings file. Every existing default stays exactly as it was. The finalizer still proves it by test (section 3).
5. **Order matters for one reason only:** #1818 goes first because the REDO bisect (BUG-861) depends on it. Every PR prepends its entry to `REGRESSION_LOG.md`, so each merge after the first clashes there: keep every entry. No other file overlaps between the six.
6. **The ArchUnitNET adoption PR** (a draft titled "TOOL-ARCH-01 adopt", tests only, from `team_archunit_adopt.txt`) rides this train ONLY if it exists when the assembler starts AND its finalizer review is clean (the finalizer reads it; see section 4). At 08:00 it did not exist: the only TOOL-ARCH-01 PR is the trial #1780, which is NOT taken. If nothing new has appeared, the train is six PRs.
7. **Left out on purpose:** #1822, #1825, #1826, #1827 (the four remaining follow-ups: they go into the NEXT train, C-72), #1788 (HOLD: Tim's privacy decision), #1783 (plain merge per Codex but it was already in C-69), and everything in section 4.

## 1. THE SIX PRs, in the merge order

1. **#1818** BUG-861 (the REDO hunt), branch `fb/cxfix-1798-bug861`, reference head `a3616d8ef8eab73e3fe808da265af23b6e90e716`, title "C-71: BUG-861 diagnostic build - echo return before diagnostic checks (Codex cx_rv22 fix to #1798)". Fixes the installed C-70 diagnostic build: with every `diag.redo` key OFF, CE now decides "this is just the echo of my own selection restore" BEFORE any diagnostic work, as 3.0.79 did, so the 3.0.80 diagnostic build was not strictly "unchanged behaviour" until this lands. The diagnostic summary and the observer switch in `CivilSelectionObserver.OnImpliedSelectionChanged` now sit AFTER the existing 150 ms echo return. New ordering test `SelectionObserver_ReturnsOnTheEchoWindowBeforeAnyDiagnosticCall`; wording fix ("a passing switch narrows the suspect path"). Numstat against `270215aa`:
   1. `Modules/Drainage.Tests/Services/Bug861DiagSwitchesTests.cs` 18/0
   2. `Modules/Drainage/Services/CivilSelectionObserver.cs` 5/4
   3. `REGRESSION_LOG.md` 12/1
   4. Total: 3 files, 35 added, 5 removed. Author's focused run: 92 total, 92 passed.
2. **#1819** BUG-547 part 3 (reach distances), branch `fb/cxfix-1791-bug547`, reference head `e7377bd050c0aa95650ff6894fe73616b6b56e57`, title "C-71: BUG-547 part 3 - infinite reach distance falls back (Codex cx_rv27 fix to #1791)". A distance is used only if it is finite and above zero; an infinite figure falls back to today's number (it used to pass "greater than zero" and stop the strip-drain spacing from ever splitting, and the LPD and JOIN reach limits from working). Numstat:
   1. `Modules/Drainage.Tests/Services/ReachSettingsTests.cs` 20/0
   2. `Modules/Drainage/Models/ReachSettings.cs` 2/1
   3. `REGRESSION_LOG.md` 11/0
   4. Total: 3 files, 33 added, 1 removed. Author's focused run: 322 total, 322 passed.
3. **#1820** BUG-406 (metre drawings), branch `fb/cxfix-1781-bug406`, reference head `32ed592f19ba3a47563cdd1a34a2121552ae3785`, title "C-71: BUG-406 - markup plan keeps the exact 275 mm fall (Codex cx_rv23 fix to #1781)". The markup plan wrote old and new invert levels with two decimals, so an exact 275 mm fall (99.825) became 99.82 or 99.83. A new `LevelText` keeps whole-centimetre levels as "0.00" and writes any other level in full. Numstat:
   1. `Modules/Drainage.Tests/Services/Bug406MetreRecordLengthTests.cs` 33/2
   2. `Modules/Drainage/Services/MarkupToChangePlanService.cs` 18/4
   3. `REGRESSION_LOG.md` 10/0
   4. Total: 3 files, 61 added, 6 removed. Author's focused run: 80 total, 80 passed.
4. **#1821** BUG-403 (paste into a drawing with no Civil record), branch `fb/cxfix-1782-bug403`, reference head `6c05dce9b64d662cebb94e36aeb30c42b8fa9c43`, title "C-71: BUG-403 - damaged Civil record is not 'no record' for the paste line (Codex cx_rv23 fix to #1782)". A damaged stored record (a bare list, null, text, cut-off text, or a wrong kind of database object) is no longer mistaken for "no record", so the CDREPAIR line is not printed for it. New strict read `ReadCivilRecordJsonStrict` (read-only opens) and `RecordJsonHasCivilContentOrIsUnreadable`; the older reading used by the drawing-wake classifier is untouched. Numstat:
   1. `Modules/Drainage.Tests/Rules/Bug403PasteIntoDrawingWithNoRecordTests.cs` 53/1
   2. `Modules/Drainage/Services/DrawingDisciplinePolicy.cs` 21/4
   3. `Modules/Drainage/Services/ProjectDataService.Persistence.cs` 37/2
   4. `REGRESSION_LOG.md` 10/0
   5. Total: 4 files, 121 added, 7 removed. Author's focused run: 427 total, 424 passed, 3 skipped. Not covered by any test: the wrong-kind database objects (need a real AutoCAD database).
5. **#1823** BUG-545 part 2 (the one pit-drop box), branch `fb/cxfix-1785-bug545`, reference head `04c6d2c234daf4668d3080f3c6e2231a6aed2492`, title "C-71: BUG-545 part 2 - missing pit-drop box gets its warning (Codex cx_rv24 fix to #1785)". A missing or not-a-number "Minimum outlet drop" box now gets the same one warning as other unusable boxes. It only matters when the switch `sharedValues.pitDropFollowsBox` is ON (default OFF: silent). Numstat:
   1. `Modules/Drainage.Tests/Services/PitDropOneBoxTests.cs` 96/0
   2. `Modules/Drainage/Rules/RulebookValues.cs` 8/3
   3. `REGRESSION_LOG.md` 10/0
   4. Total: 3 files, 114 added, 3 removed. Author's focused run: 270 total, 270 passed.
6. **#1824** BUG-541 (slab minimum falls), branch `fb/cxfix-1786-bug541`, reference head `9816d3b85e6716d21b830572160028a2975d9e77`, title "C-71: BUG-541 - infinite or tiny slab fall figure falls back (Codex cx_rv25 fix to #1786)". A typed figure is used only if it and its fall (one over it) are finite and above zero (positive infinity used to give "no minimum"; a tiny figure gave an infinite fall). Numstat:
   1. `Modules/Drainage.Tests/Services/SurfaceFallSettingsTests.cs` 51/0
   2. `Modules/Drainage/Models/SurfaceFallSettings.cs` 10/2
   3. `REGRESSION_LOG.md` 11/0
   4. Total: 3 files, 72 added, 2 removed. Author's focused run: 513 total, 513 passed.
7. **Whole train (expected, before any finalizer commit):** the six PRs together touch 14 distinct files: seven product files in `Modules/Drainage` (`CivilSelectionObserver.cs`, `ReachSettings.cs`, `MarkupToChangePlanService.cs`, `DrawingDisciplinePolicy.cs`, `ProjectDataService.Persistence.cs`, `RulebookValues.cs`, `SurfaceFallSettings.cs`), six test files, and `REGRESSION_LOG.md` (touched six times: expect 64 added and 1 removed there). Sum of the six numstats: 436 added, 24 removed. The assembler counts the real list and says so.

## 2. Where each PR came from (the author's report is the source; the assembler and finalizer re-read the merged code)

1. All six were written on 27 Oct 2026 by Codex's second-opinion lane on top of the C-70 tip, one new branch each (`fb/cxfix-<old PR>-<bug>`), never rewriting an old branch. They are NEW draft PRs: the old PRs (#1798, #1791, #1781, #1782, #1785, #1786) are already in the installed builds and are not touched.
2. **None of the six has had an independent read.** The author's own proof: all ten Codex fixes (these six plus #1822, #1825, #1826, #1827) merged on one throw-away branch gave Civil net10 full 20,643 total, 20,611 passed, 32 skipped, 0 failed; Civil net48 product compile 0 errors; Manager not touched, not re-run.
3. **Two things the author did beyond Codex's wording** sit in PRs NOT in this train (#1826 and #1827: comma-text refusal; #1822: unset material speed). They are not part of C-71.

## 3. What the finalizer must prove (the reason this train needs an Opus read)

1. **#1818 is the one that matters:** read the whole merged `CivilSelectionObserver.OnImpliedSelectionChanged`. With every `diag.redo` key off, the order must be exactly 3.0.79's: the in-event guard, then the 150 ms echo return, and only AFTER it the diagnostic summary and the observer switch. Prove by a source-order test (the PR's own ordering test, plus one more of the finalizer's own if it finds a gap) that no `RedoDiagSwitches` call sits before the echo return, and that all fourteen other guard sites are untouched (`git diff 270215aa..HEAD` for `InspectorPaletteService.cs`, `CivilOwnershipHighlightService.cs`, `CompoundSelectionService.cs`, `PitHoverService.cs`, `CivilProjectQaAutomaticService.cs` and `RedoDiagSwitches.cs` must be EMPTY).
2. **Every switch default is the normal behaviour (by test):** the fifteen `diag.redo` keys still default false; `pipeSpeedChecks.useMaterialLimit` OFF; `sharedValues.pitDropFollowsBox` OFF (so the #1823 warning stays silent by default); `surface.slabMinimumFalls` 100 / 50 / 67; the reach distances, the connection pipe, the WSUD and Charged figures at today's numbers; `linking.pasteLineForDrawingWithNoRecord` ON; `detention.orificeUsesRuledGravity` ON and `detention.detentionTabUsesCouncilOrificeCo` ON; `options.sheetAccentColour` "#000000"; `linking.inspectorPickWaitsAfterUndo` ON. The finalizer adds `C71NewSwitchDefaultsTests` (tests only), modelled on `C70NewSwitchDefaultsTests`.
3. **#1819 and #1824:** an ordinary figure still gives the same answer as before (the shipped defaults); only infinite, not-a-number, zero, negative (and for #1824 tiny) figures fall back. Read the `Positive` helpers in `ReachSettings.cs` and `SurfaceFallSettings.cs` in full and confirm the shipped defaults pass them.
4. **#1820:** `LevelText` gives the old "0.00" text for every level that is a whole number of centimetres (so a drafter sees no change on ordinary drawings) and the full figure otherwise; read both old and new call sites in `MarkupToChangePlanService.cs` and say whether anything else reads the two-decimal text back (the Apply step does: confirm it parses the longer text).
5. **#1821:** read `ReadCivilRecordJsonStrict` in full: read-only opens only, no new transaction mode, no write. The drawing-wake classifier path (`RecordJsonHasCivilContent`) still returns what it returned before for every case in the old tests. Say what the paste line does now for each of: no record, empty record, valid record, damaged record.
6. **#1823:** the new warning only fires when `pitDropFollowsBox` is ON; with it OFF nothing is added.
7. **No new key anywhere:** `git diff 270215aa..HEAD -- Modules/Drainage/Models/UserSettings.cs Modules/Drainage/Models/DiagSettings.cs` must be EMPTY; `NewSettingsKeys_NeedADocumentedDefault` and the Settings-fit test (tallest tab 670 px or less) still pass.
8. **CE_SHARED, Installer and Manager untouched:** `git diff --stat 270215aa..HEAD -- Shared Installer Installer.Tests Modules/Manager Modules/Manager.Tests Modules/Manager/Installer` EMPTY.
9. **Builds and tests:** the official Manager release build and file-count guard (75); net48 AND net10 builds of the whole solution; the Civil net10 Release full suite (floor: the C-70 final total of 20,539 plus the new tests the six PRs add: about 20,600 or more; the one PDF page test needs AutoCAD's renderer: re-run it alone); net48 targeted tests; Manager net10 (the C-70 final was 1,041 total, 1 skipped, 0 failed); the Settings-fit tests; then GO or a negative verdict.

## 4. Other candidates read and NOT taken

1. **#1822, #1825, #1826, #1827:** the remaining four Codex follow-ups (BUG-527 pipe speed limits, BUG-543 detention coefficient tests, BUG-547 connection pipe, BUG-547 WSUD and Charged). They go into C-72 (Tim's ruling: at most about six PRs a train).
2. **The ArchUnitNET adoption PR:** only if it exists by assembly time and the finalizer's read is clean (answer-first item 6). The trial #1780 is a "do not merge" draft and is never merged.
3. **#1788** (the Manager upload of Civil reports to the office IT folder) is on HOLD: keep `drainPluginOutbox` OFF; Tim decides who may receive these reports and which fields may leave the PC. **#1771, #1756, #1767, #1204** (Tim-decision PRs) stay out as in C-69 and C-70. The Structural round 2 PRs and the plan-train PRs are not in this train.
4. **The C-70 list section 5.2 robot wording** ("the first key that makes round 1 pass names the culprit") is superseded by #1818's wording ("a passing switch narrows the suspect path; test its downstream components separately before naming a cause"). The owner of that list changes it; this train does not.

## 5. How the robot uses it (for the desk; not part of the job)

1. Install C-71 (Civil 3.0.81). Robot priority: with every `diag.redo` key OFF, repeat the `R08x_1_exact` and `R08x_5_plain_line_first` REDO tests, then bisect one key at a time (set the key to true in `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` BEFORE AutoCAD starts; put it back to false afterwards).
2. Each PR's own "test in AutoCAD" steps are in its `REGRESSION_LOG.md` entry. Nothing in this train is FIXED. BUG-861 stays open.

## 6. Settings this train adds

1. **None.** No new key, no changed default. The finalizer adds `C71NewSwitchDefaultsTests` (the defaults of section 3 item 2 pinned through the two start-up reads).
2. **No Manager switch, no Manager code, no version change by the assembler.**
