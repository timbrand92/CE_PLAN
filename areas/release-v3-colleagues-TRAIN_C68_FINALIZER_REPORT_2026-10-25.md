# Train C-68 finalizer report (Civil + Manager), Mon 26 Oct 2026 (real clock 01:47 to about 04:20 Melbourne)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Inputs read: `C:\TimOS\RULES.md`; the C-68 assembly report (in full); the C-68 PR list (in full); `REVIEW_BUG861_PR1779_25OCT.md` (in full: every ask and every limit); `release-v3-colleagues-PR1779_FIXES_APPLIED_25OCT.md`; the builder's `release-v3-colleagues-BUG861_FIX_REPORT.md` (headings and the change section); `release-v3-colleagues-RUNNER_R08_CHARACTERISE_REPORT.md` (ANSWER FIRST and what it could not tell); the C-67 finalizer report (method and shape); `QUESTIONS_FOR_MONDAY.md` on `origin/main` (items 5, 6, 9, 10, 12); `decisions\` (newest file still `2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`); the tail of the review-lane log. I used no helper subagents: I read the merged diff myself and made every verdict, the one commit, every build and every test run myself.

Built and unit-tested only. Not installed. Nobody has opened it in AutoCAD. No PR closed, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` and `BUG_CARPARK.md` not edited.

Installed line read first (read-only, `FileVersionInfo` from a .ps1 file, six DLLs, 01:47): Civil `3.0.77+0d8850949cb764e4b3af36f99276b74312584ce5` in Legacy, Net8 and Modern (25 Oct 20:13 to 20:18); Manager `1.1.77+0d8850949cb764e4b3af36f99276b74312584ce5` in Legacy, Net8 and Modern (25 Oct 20:22). That is train C-67, the only acceptable line. Read again at 04:11: identical (names, versions and dates). Structural (S-44) is installed separately and is not in this train.

## ANSWER FIRST

1. **GO at `73dda759c9352c00496fe26b7c1b88dec2dc24d3`.**
2. **Mistakes and gaps first, plainly:**
   1. **I lost about 1 hour 30 minutes waiting for disk space, and my own build caused it.** C: had 8.4 GB free before my solution build and 6.4 GB after it; my work folder (worktree plus build output) was 1.66 GB. Under the 8 GB line I waited (02:09 to 03:38, polling in the foreground) and deleted nothing. **Cost for others:** while C: was under 7 GB the desk's disk guard kept `STOP_CODEX.flag` on, so the Codex lane was paused by my build for that time. At 03:38 C: jumped to 59.9 GB: something else freed the space, not me. From then on every step ran with about 60 GB free.
   2. **One foreground poll hit the tool's 10-minute limit and moved to the background** (it was only a disk poll; it finished on its own; nothing was running under it).
   3. **The official Manager release build used the payload script's own reference folders** (`_AcadRef48` = `C:\TimOS\refs\autocad\autocad-2024-ref`), copied exactly as instructed, while my solution build and tests used the brief's set (`_AcadRef48` = CERef 24.3.0). Both built with 0 errors; I mention it so nobody reads the two as one run.
   4. **AutoCAD was running from 03:58 (pid 100452), not started by me;** a robot or Codex pass may have been using it. I never touched it. Tim's settings files were unchanged before and after (item 13).
3. **Branch and final head:** `claude/rel-20261025r` @ `73dda759c9352c00496fe26b7c1b88dec2dc24d3`, one normal fast-forward push from the assembler's `0aa24804a26908389683cefe31b29a16180cd3aa` (which matched `git ls-remote` at 01:47, exactly the assembly report). #1779's live head `a8f64f6bde50dc2d8bfe95b8056605de0f46569b` did not move (gh and `refs/pull/1779/head`, 01:47). Base: C-67 `0d885094`. This train becomes Civil 3.0.78 / Manager 1.1.78 when the payload builder stamps it (I did not bump).
4. **What I changed: one commit, tests only, pushed:** `73dda759` adds `C68NewSwitchDefaultsTests` (3 tests) and its REGRESSION_LOG entry. No product code changed by me. Nothing reverted, nothing dropped. The leak scan passed on the push ("leak-scan: clean").
5. **#1779 (BUG-861): KEEP.** I read every changed hunk on the merged head. **Both review fixes are in the code, not only in the fix report:** the AutoCAD check sentence now says "U, click pit P3, REDO, type REGEN ... the Inspector then shows Pit P3 (click again if it says Nothing selected)" and the old "click a pit after a U and a REDO and check the Inspector shows that pit" is gone from `REGRESSION_LOG.md` and the PR description; `LogFirstPickState` contains no `activeTransactions` and no `TransactionManager` read, only `RedoWindowGuard.IsOpen` (memory), `GetSystemVariable("UNDOMARKS")` and `GetSystemVariable("UNDOCTL")`. REDO safety holds (section 1.3). One new LOW from my read: the diagnostic lines run whatever the switch says (section 1.4 f).
6. **#1771, #1756 and #1767 (Tim's decision): all three LEFT OUT.** No recorded Tim answer after 25 Oct 09:30: `decisions\` newest file is 24 Oct; `QUESTIONS_FOR_MONDAY.md` on `origin/main` was last changed 26 Oct 00:10 by the desk (adding question 12 on disk space) and items 5, 6 and 9 carry no answer. Heads unchanged (fetched 01:50): #1771 `f3f38c24`, #1756 `62a26660`, #1767 `9e1a9455`. #1767's contested case is still not on the safe side (an accidental detach also turns the red QA Fail into a yellow warning, switch ON); #1756 still has one switch for both the moved XREF (the bug) and the detached XREF (a daily habit). The questions stay OPEN (section 7).
7. **#1706, the CEMEMBER PRs #1600 and #1602, #1780 and every WAITING PR: I took in none of them.**
8. **Settings default (judged on the merged code):** one new Civil switch, `linking.inspectorPickWaitsAfterUndo` (class `LinkingSettings`), **ON in the merged code (`= true`), KEPT ON**, because the old behaviour is itself the bug (REDO lost after the first click). An empty `{}` file and a C-67-shaped file load it ON through both start-up reads, and a typed OFF is kept (`C68NewSwitchDefaultsTests` 3 of 3 on net10 and on net48). It changes what Tim sees by default: after a U, a click leaves the Inspector saying "Selection changing — actions paused." until the next command ends. No Settings page row (owed to the Codex window lane; the window is at 670 px). `NewSettingsKeys_NeedADocumentedDefault` 1 of 1; Settings fit 5 of 5, tallest tab 670 px at every size including 150 per cent. Manager switch `FrozenLayerWarnsAndPlaces` untouched (no Manager file changed).
9. **Questions for Tim** (section 7, his format): (a) #1771 computations-sheet sentence; (b) #1756 detached survey XREF; (c) #1767 stage-drawing BIND versus detach; (d) the #1779 waiting wording; (e) 0.013 roughness, unchanged; (f) #1772 which head the 300 mm means, unchanged; (g) CEMEMBER edit card, one line.
10. **Manager: unchanged, guard passed at exactly 75.** `git diff --stat 0d885094..HEAD -- Modules/Manager` is EMPTY. The official Manager release build (the C-67 payload builder's exact command, on an approved CE_SHARED root I built from the same worktree with the unchanged `Installer\build_installer.ps1`) printed **"Complete 75-file, three-lane release candidate verified."**, 0 warnings, 0 errors (AppVersion still 1.1.77; the payload builder re-stamps 1.1.78). Manager net10 full: **1,013 total, 1,012 passed, 1 skipped, 0 failed.** Manager net48, net8 and net10 built with 0 errors.
11. **Installer and signed-update safety: untouched.** `git diff --stat 0d885094..HEAD -- Shared Installer Installer.Tests Modules/Manager/Installer` is **EMPTY**. The whole train diff is five files (#1779's four plus my test); no OfficialReleaseGate, SafeBundleInstaller, signing or deploy script, `.csproj`, `.props`, `.targets`, `.ps1`, `PackageContents.xml`, `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json`, help file or `guide-content.js`. **No command added or removed;** CrossModuleGuard 6 of 6; HelpGuideVersion 2 of 2. The Installer suite was NOT run (compiled only).
12. **Tests (Release, my worktree `C:\fin68\w`, final head `73dda759`):**
    1. **Whole solution: 0 errors, 909 warnings** (01:52 to 02:09, 16 m 57 s, `-m:1`, nine projects restored one by one first, all exit 0). Civil and Manager built for **net48, net8.0-windows and net10.0-windows**; `CE.TestHarness.Tests` built (net10.0-windows); `CE_CVL_SUITE_Installer` and `CE_CVL_SUITE_Installer.Tests` **COMPILED, not run**.
    2. **Civil net10 full: 20,380 total, 20,348 passed, 32 skipped, 0 failed** (03:39 to 03:49). That is the assembler's 20,377 plus my 3; above the 20,373 floor.
    3. **Manager net10 full: 1,013 total, 1,012 passed, 1 skipped, 0 failed** (TEMP in Windows backslash form with long names; no false reds).
    4. **Named net10 (one run, 135 tests, 0 failed, counted per class from the trx):** `RedoSafeCallGraphTests` **25 of 25 after the merge and my commit** (baseline not re-pinned); `Bug861RedoFirstClickTests` 4 of 4; `PickHandlerProbeTests` 7; `InspectorPaletteRenderTests` 22, `InspectorPaletteServiceHintTests` 13, `InspectorPaletteWordingTests` 5; `C67NewSwitchDefaultsTests` 3; `C68NewSwitchDefaultsTests` 3; `EveryTab_FitsTheScreen_AtOneFixedHeight` 5 of 5 ("tallest tab needs 670 px" at 1920x1080 100% light and dark, 125%, 150% (window 1100 x 672), and 2560x1440 150%); `NewSettingsKeys_NeedADocumentedDefault` 1 of 1; CrossModuleGuard 6; HelpGuideVersion 2; `SourceAtomicCoordinatorDependencyTests` 24 of 24 (the two Debug-only checks pass in Release); both `BackTest_GlenEira24115_IssuedDischarge_WithinTolerance` methods and `GlenEira24115_EnginesOwnDischargeSum_WithinTwentyPerCentOfTheIssuedSheet` PASS.
    5. **Civil net48 focused (95 class filters joined by `|`, the assembler's list plus `C68NewSwitch`): 2,528 total, 2,346 passed, 131 skipped, 51 failed** (03:53 to 04:02). The 51 failed names equal the assembler's C-68 run exactly (`Compare-Object` empty), which the assembler showed equal to the C-67 finalizer's 51; every failure message carries `InvalidProgramException` from the reference-only AutoCAD DLL. **No red beyond those names.** On net48: `Bug861RedoFirstClickTests` 4 of 4, `C68NewSwitchDefaultsTests` 3 of 3, `C67NewSwitchDefaultsTests` 3, `PickHandlerProbeTests` 7, `InspectorPaletteServiceHintTests` 13, `InspectorPaletteWordingTests` 5, `RedoSafeCallGraphTests` 25 passed (27 listed; 2 not executed on net48, as before).
13. **Tim's settings files: unchanged.** At 01:51 and 04:11: `TIM_CE_CADTOOLS\CD_Settings.json` ACD64E79A33B (15,270 bytes, 4 Oct 08:22), `TIM_CE_CADTOOLS\CS_Settings.json` 622A246F7D3B (351,713 bytes), `CE_STRUC_SUITE\CS_Settings.json` 0791B07EBCD9 (35,467 bytes, 25 Oct 17:41), `CE_CVL_SUITE\settings.json` EFE307C4FC74 (672 bytes): hash, size and date identical, even with AutoCAD running from 03:58.
14. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.

## 1. Review of #1779 (BUG-861) on the merged head

The merge `0aa24804` carries #1779's reference head `a8f64f6b` as second parent. Numstat against the base: `InspectorPaletteService.cs` +104, `UserSettings.cs` +10, `Bug861RedoFirstClickTests.cs` +99, `REGRESSION_LOG.md` +15, nothing removed. I read every hunk.

### 1.1 Verdict: KEEP

1. **What it does on the drawing:** with the CE Inspector showing, a click made after a U no longer makes the Inspector read the drawing. The Inspector keeps the old item, says "Selection changing — actions paused.", and catches up at the first quiet moment after your next command ends. If that command was a U or REDO, it waits again.
2. **Honest about the gap:** the code comment, the log entry and the builder all say the cause is not named; this is a safe deferral plus a diagnostic. That matches the code.

### 1.2 The review's two required fixes, checked in the code

1. **FIX 1 (wording): done.** `REGRESSION_LOG.md` item 7 reads: "Then: U, click pit P3, REDO, type REGEN (the Inspector is meant to still be waiting right after the click and the REDO); the Inspector then shows Pit P3 (click again if it says Nothing selected)." The old sentence "click a pit after a U and a REDO and check the Inspector shows that pit" is not in the log (grep finds nothing) and the PR description carries the new sentence (read with gh). Item 10 records the fix.
2. **FIX 2 (log line): done.** `LogFirstPickState` reads `RedoWindowGuard.IsOpen(db)` (memory), `GetSystemVariable("UNDOMARKS")` and `GetSystemVariable("UNDOCTL")` only. No `activeTransactions`, no `NumberOfActiveTransactions`, no `TransactionManager` anywhere in the file. `TheFirstPickDiagnostic_OnlyReadsTheUndoState_AndWritesNothing` passes on net10 and net48.

### 1.3 REDO safety (read in the merged code)

1. **The deferral path** (`RefreshAfterPick`, inside the redo window, switch ON): `PickWaitsAfterUndo()` reads the switch from settings already in memory; `DeferPickUntilNextCommand()` takes the active drawing and calls `RedoWindowGuard.DeferWhileRedoOpen`, which is memory (the waiting list, under a lock object in memory, not a drawing lock) plus one `[REDO]` log line per owner per window. **No transaction, no system-variable SET, no drawing lock, no write, no permanent document event.** It returns before `RefreshInspector`.
2. **Both Inspector layouts are covered:** the branch to the workshop layout (Tim's and his colleagues', `RefreshCivilProperties`) and the classic layout both sit inside `RefreshInspector`, which the deferral never reaches.
3. **The catch-up** (`ShowPickAfterNextCommand`): the guard runs it from `CommandWillStart` (`OnCommandWillStart` then `RunResumes`). It only hooks that drawing's `CommandEnded`, `CommandCancelled` and `CommandFailed`, reads nothing, and at the end unhooks all three, hooks one Idle, unhooks that Idle, and calls `OnImpliedSelectionChanged` only if the same drawing is still active. That re-enters the normal debounce: after a U or REDO the window is open again, so it defers again; after any other command it shows the pick.
4. **No deadlock and no leak:** with no further command the palette simply keeps the old item. `ParkLocked` adds a waiting entry only if none exists for the same window, drawing and owner, so repeated clicks do not pile up. The command-end hook is transient (one per window) and removes itself.
5. **Switch OFF:** `PickWaitsAfterUndo()` is false, so the code falls straight to the base's `HookPickRefreshIdle()` (the quiet-Idle read). The one difference from the base is the diagnostic (1.4 f).
6. **`RedoSafeCallGraphTests` 25 of 25 after the merge and my commit,** the baseline file untouched.

### 1.4 Items the review left OPTIONAL (not applied; none is a hard block, R-27; for the next round)

1. **(a) SHOULD: the waiting text could say why** ("Shown after your next command, so REDO stays available."). What Tim loses without it: the Inspector says "Selection changing — actions paused." and does not say why or for how long, so a drafter may think it is stuck. **I recommend it as a one-line follow-up** (it is the same `InvalidateCivilSelection` call the base already makes, only with different words); it needs a Codex look at the wording.
2. **(b) LOW: hold time above 0.** With "Wait after Undo (seconds)" above 0 the window closes on the timer, but the pick still waits for a command to end. Default is 0, so Tim loses nothing.
3. **(c) LOW: the other drawing (BUG-558).** U in drawing A, switch to B, click: the gate is per drawing, so B is read while A's REDO is open, exactly as before this PR. What Tim loses: nothing new; the older BUG-558 risk stays.
4. **(d) LOW: classic-layout buttons.** In the classic layout (not Tim's), Zoom and Edit act on the previous pick while the new one waits. The workshop layout greys them.
5. **(e) LOW: first-pick sets never cleared.** `_firstPickSeen` and `_firstPickHandled` are keyed by the drawing's memory address and never cleared when a drawing closes, so a reopened drawing can log no diagnostic pair. What Tim loses: nothing on the drawing; the robot may miss a diagnostic line in a reopen case.
6. **(f) NEW LOW from my read: the diagnostic runs whatever the switch says.** `LogFirstPickState("pick seen")` sits in `OnImpliedSelectionChanged` before the switch is read, so with the switch ON or OFF the first pick in each drawing reads `UNDOMARKS` and `UNDOCTL` (twice with ON: "pick seen" and "pick deferred") inside the redo window. Those reads are the kind measured as REDO-safe, and the review accepted them. **Why it matters:** if the robot's R08 still loses REDO with the switch ON, these two reads are the last palette-only step left, so the next build should switch the diagnostic off too before concluding anything; and the OFF run is "base plus the diagnostic", not the pure base.

### 1.5 Merge hygiene

1. **REGRESSION_LOG.md:** no conflict markers; headings 1,453 on the base, 1,454 after the merge, 1,455 with mine; headings with no blank line before: 160 on the base and 160 now; the merge removed no line. The #1779 entry sits under my entry, above the C-67 finalizer entry.
2. **UserSettings.cs:** the new block sits in `LinkingSettings` after `civilWakesForPitsWithoutRecord`, with its own summary ending "Default: on." and `[JsonProperty("inspectorPickWaitsAfterUndo")]` (once in the file). The four C-67 keys (`slabFallUsesDrawingUnits`, `flatPipeIsWarningNotBlock`, `blankInvertIsWarningNotBlock`, `batchBlankFieldIsLeftOut`) and the six C-66 keys are each present once; #1770's `catchmentsStartBlank` and #1772's `chargedMinHeadWarning` still sit straight after `defaultTcMinutes` (lines 2439 to 2455). No conflict markers.
3. **Shared, Installer, Manager:** all three diffs empty.

### 1.6 The Tim-decision PRs (read at their live heads)

1. **#1771 `f3f38c24`:** one constant and one CDRULES row in `RulebookEngine.cs`, one line in `ComputationsSheetV3.cs`, the two golden sheets gain the line, one test class. The sentence is exactly as briefed. No recorded Tim yes: **left out.**
2. **#1756 `62a26660`:** `SurveyXrefCurrencyRule` plus `SurveyService` and one switch `survey.storedLevelsFollowXrefPosition` (ON) for a moved, turned, rescaled OR detached survey XREF. One switch cannot keep the moved-XREF fix while leaving the detach alone: **left out.**
3. **#1767 `9e1a9455`:** `PitScheduleStatusService` puts a source with no same-path entry in the Xref list into "may be bound" and `PitScheduleQaService` turns that red Fail into yellow Unknown, switch `linking.pitScheduleBoundSourceFrozen` ON. An accidental detach gives the same yellow: **not on the safe side; left out.**

## 2. What Tim will see in AutoCAD (plain words, #1779)

1. Open a drawing with the CE Inspector showing. Draw a LINE, press Enter. Type U.
2. Click pit P3: the Inspector does not change to P3; it says "Selection changing — actions paused." and its buttons are greyed.
3. Type REDO: the command line says "Everything has been redone" (before this fix, on the first click in a fresh drawing, it said "Nothing to redo").
4. Type REGEN, Enter: the Inspector now shows Pit P3. If it says "Nothing selected", AutoCAD dropped the pick: click P3 again and it shows.
5. Everything else: any command (not U or REDO) after a click brings the Inspector up to date as soon as it ends. Clicks made when no U is waiting behave exactly as before.

## 3. Settings default

1. **`linking.inspectorPickWaitsAfterUndo` (#1779): ON in the merged code, KEPT ON.** Missing key loads ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for `{}` and a C-67-shaped file; a typed OFF is kept. It changes what Tim sees by default (the Inspector waits after U). The old behaviour is the bug (REDO lost on the first click), so a bug-fix switch ships ON.
2. **No other key added or changed** (the `UserSettings.cs` diff is the one 10-line block).
3. **Earlier switches pinned again by my test:** the four C-67 ones ON, the six C-66 ones ON, the eight C-65 ones ON and `help.openWebFallback` OFF, the ten C-64 ones ON, `linking.shallowPitDepthMm` 300, the C-61 to C-63 ones as before, `designStandards.manningsNNotRecognised` 0.013.
4. **Switches without a Settings page row** (owed to the Codex window lane; I built none; the window is at its 670 px limit): the new `linking.inspectorPickWaitsAfterUndo`, plus the C-67 four (and Manager `FrozenLayerWarnsAndPlaces`), the C-66 six, the C-65 eight, `help.openWebFallback`, and the C-61 to C-64 switches as listed by earlier finalizers.

## 4. LOW items left for the next round

1. **#1779:** (a) to (f) in section 1.4; (a) is worth a one-line follow-up; (f) matters only if R08 still fails with the switch ON.
2. **A guard worth adding later (tests only):** `TheFirstPickDiagnostic_OnlyReadsTheUndoState_AndWritesNothing` does not check that `TransactionManager` stays out of `LogFirstPickState`; a one-line `DoesNotContain` would pin FIX 2. I did not add it (this train is the fix as reviewed).
3. **Carried from C-67 and C-66, unchanged:** see the C-67 finalizer report section 4.

## 5. Manager release build and bundle

1. **C: free:** 8.39 GB at 01:51 (before anything of mine), 6.38 GB after my solution build (02:09), 59.9 GB from 03:38 (freed by something else), 61.2 GB when the Civil bundle started (04:02), 59.76 GB after it (04:10), 59.75 GB after the Manager build, 63 GB after I removed my work folder (04:11).
2. **Civil bundle (for the approved CE_SHARED root):** the unchanged `Installer\build_installer.ps1`, run from my worktree with System32, dotnet, git and the Windows PowerShell module path set: preflight passed, "Installer build complete.", exit 0 (04:02 to 04:10). It wrote one release archive under `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE` (13 folders after, 12 before); I deleted none of them. Its payload folder lived in my worktree and went with it.
3. **Manager release candidate:** the exact command from `C:\ce_rc_scratch\p102_scripts\payload102_mgr_build.ps1` (read, not edited; copied to `C:\ce-fin\c68\mgr_build.ps1` with the worktree path pointed at `C:\fin68\w`). Approved CE_SHARED hashes from my Civil bundle: Legacy `8FDEAD7A...`, Net8 `C83E95BC...`, Modern `67C5BD10...`. Result: Net8, Modern and Legacy bundle lanes copied, "PackageContents.xml AppVersion synced to 1.1.77", **"Complete 75-file, three-lane release candidate verified."**, 0 warnings, 0 errors, exit 0. The guard is `Modules/Manager/CE_SUITE_MANAGER.csproj` (exactly 75 files). Output stayed inside my worktree (never the c1058 to c1063 candidate folders, never APPDATA: the installed DLLs were unchanged at 04:11).

## 6. Do not mark FIXED

1. **BUG-861 (#1779) is the only new bug in this train.** Nothing is FIXED until a robot PASS plus a Codex PASS in AutoCAD on copies. The proof: R08 (`R08_redo_after_pick_x5`), `R08x_1_exact`, `R08x_5_plain_line_first` and `R08x_6c_recalibrate_palette_open`, each in two separate sessions on an installed build that contains #1779; plus the same R08 run with `linking.inspectorPickWaitsAfterUndo` OFF, which should fail again. The root cause is still unknown; the fix is a deferral plus a diagnostic.
2. **Earlier trains' bugs** stay as listed in the C-67 finalizer report section 6 (C-67 is installed; none of them is accepted by this report).

## 7. Questions for Tim (work hours; RULES 3.2; none turned into a decision)

1. **(a) The sentence on every council computations sheet (#1771, BUG-1090; QUESTIONS_FOR_MONDAY item 9). PR left OUT of C-68.**
   1. **Context:** CE does not calculate a hydraulic grade line or pit losses, and the computations sheet does not say so.
   2. **What I understand:** #1771 adds one line at the end of BASIS OF DESIGN on every sheet, and one row in CDRULES: "Hydraulic grade line and pit losses: not calculated by CE. Each pipe is checked full-bore on its own grade only; where the council asks for a hydraulic grade line, check it separately."
   3. **Recommendation: yes, print it** (the reviewer's view), because without it a council reviewer can read the sheet as a full hydraulic check. Shorter option: drop the middle sentence.
   4. **On a job:** (yes) every OSD computations sheet for Frankston, Banyule or Whitehorse carries the line, and a reviewer asking for an HGL knows to look for a separate check. (no) the sheet stays as today and says nothing.
2. **(b) Survey XREF detached after CDSURVEY approved it (#1756, BUG-1189; item 5). PR left OUT.**
   1. **Context:** the fix stops CE offering stored survey levels from an XREF that has moved, turned or been rescaled since you approved it.
   2. **What I understand:** the same check also fires when the XREF is DETACHED: CE says "the XREF is no longer in this drawing" and stops offering survey levels until it is back. Typed levels always work. One switch covers both.
   3. **Recommendation: keep it as built** (the reviewer's view), because a wrong level on a pit is worse than retyping one. I left it out only because it changes an everyday habit and needs your word.
   4. **On a job:** (keep) you detach the heavy survey XREF to speed up the drawing; New Pit stops offering survey levels until you reattach it. (warn only) the levels are still offered with a warning; if the XREF had moved before the detach, they could be wrong.
3. **(c) Stage drawings: a BIND versus an accidental detach (#1767, BUG-1149; item 6). PR left OUT.**
   1. **Context:** a Pit Schedule built from a stage drawing (Xref) cannot tell a deliberate BIND from an accidental detach.
   2. **What I understand:** with the PR, both give a yellow warning ("SOURCE NOT FOUND ... If you bound the Xref, the schedule is frozen as placed"), not a red QA Fail. Another source that is out of date or unloaded still fails.
   3. **Recommendation: keep the yellow warning** (the reviewer's view), because a red Fail on every normal BIND teaches drafters to ignore Fails. I left it out because today an accidental detach is a red Fail and the PR softens that.
   4. **On a job:** (yellow) you bind Stage 1 into the master and get one warning instead of a failed QA sheet, but an accidental detach also only warns. (red) the bind fails QA until the drafter confirms it was a bind.
4. **(d) The waiting Inspector's wording (#1779, BUG-861). In this train as "Selection changing — actions paused."**
   1. **Context:** after a U, a click now leaves the Inspector waiting until your next command ends, so REDO keeps working.
   2. **What I understand:** while it waits, it says only "Selection changing — actions paused.", which does not say why or how long.
   3. **Recommendation: yes, add one line: "Shown after your next command, so REDO stays available."** It is a wording change in the same spot, no new risk; it needs a Codex look at the wording in AutoCAD.
   4. **On a job:** (yes) a drafter who clicks a pit after U reads why the Inspector has not changed and carries on. (no) the drafter may click again or think the Inspector is stuck until the next command.
5. **(e) Roughness for a pipe with no material (#1664, BUG-868, from C-63): unchanged, still BUILT, NOT ACCEPTED.** A pipe with no recorded material is sized with the Settings "not recognised" value 0.013 (as rough as concrete; errs safe). On a job: a 225 at 1 in 100 needing 50 L/s with no material typed is proposed one size up; typing UPVC brings the 225 back. My new test pins 0.013 again.
6. **(f) Which head the 300 mm charged-system minimum means (#1772, BUG-1097, installed with C-66): unchanged.** It compares 300 mm with the head you type in "Available head (m)", not the head left after pipe losses; it is a warning only. Recommendation: keep it as built.
7. **(g) CEMEMBER editing (#1600, #1602, Structural, not this train):** should a drawn CEMEMBER member be edited through SBEAMEDIT as built (review recommends yes)? Held until you answer.

## 8. Left out and why

1. **#1771** (BUG-1090): needs Tim's yes on the sentence; none recorded.
2. **#1756** (BUG-1189) and **#1767** (BUG-1149): Tim's decision; contested case not shown safe (1.6).
3. **#1706** (BUG-225): REDO-safety relevant and in the same Inspector area; a later train that takes it must re-read it together with #1779.
4. **WAITING, unchanged (no fix pushed):** #1643, #1593, #1588, #1657, #1691, #1000, #1620, #1195, #1198.
5. **Reviewed earlier but not taken:** #1720 (four later commits never re-reviewed), #1047 (needs a carpark bug first), #1314 (plan item, paused).
6. **Already in the base, rejected as duplicates:** #1639 (in as #1635), #1519 (in as #1520), #1571 (in as #1567).
7. **#1780:** the ArchUnitNET trial, "do not merge".
8. **Shared, Installer and signing PRs (left out on purpose, untouched):** #992, #1649, #1652, #1234, #1235.
9. **Structural:** #1600 and #1602 (HOLD) and every Structural PR: not this train.
10. **Already in the base:** 250 open PRs whose heads are already contained (list section 7); none merged again; nothing closed (D6).

## 9. Not tested, risks, hygiene

1. **Not tested:** anything in AutoCAD or accoreconsole (R08 and the three probes, two sessions each, plus the OFF run, are owed); any window or picture (the waiting Inspector was not looked at); the Installer suite (compiled only); `CE.TestHarness.Tests` built, not run; Structural; a net8 test run; AutoCAD 2022 to 2024 (net48 compiled and unit-tested only). The four `Bug861RedoFirstClickTests` are wiring guards: they do not prove REDO survives.
2. **Risks:** the fix may not cure the REDO loss (the cause is unknown; if R08 still fails with the switch ON, see 1.4 f); between a U and the next command the Inspector shows the old item, which a drafter may misread (question d); the Settings window is at 670 px, so the next row on its tallest tab fails the fit test.
3. **Build lock** `C:\CE_PLAN\desk_jobs\build.lock`: absent at the start; my runners took it with their own process id for the solution build, the four test runs, the Civil bundle and the Manager build ("lock taken" each time) and released it after each; absent again at 04:11.
4. **Every dotnet command:** `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, `_AcadRef48` CERef 24.3.0, `_AcadRefNet8` autocad-2026-ref, `_AcadRefNet10` AutoCAD 2027, `_AcadRef100` autocad-net8-ref (the official Manager build used the payload script's own set, 2.3), AutoCAD 2027 on PATH for tests, the 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked, ignored bin folder), the solution built with `-m:1` and the normal TEMP, test steps with their own TEMP and CE log folder inside it (`C:\fin68\t_<step>`, Windows backslash form, long names), `VSTEST_CONNECTION_TIMEOUT=900`, Below Normal on the dotnet and testhost processes the runner saw. Nothing deployed.
5. **Removed at the end:** worktree `C:\fin68\w` (`git worktree remove --force`, clean at `73dda759`), my three temporary refs for #1771, #1756 and #1767, the four test TEMP folders and the `C:\fin68` folder. Scripts and logs stay under `C:\ce-fin\c68`. The remote train branch stays.

## Summary

GO at `73dda759c9352c00496fe26b7c1b88dec2dc24d3` on `claude/rel-20261025r`. #1779 (BUG-861) read in full on the merged head: both review fixes are in the code, REDO safety holds in both Inspector layouts, KEEP. One commit by me: `C68NewSwitchDefaultsTests` (the new switch ON). #1771, #1756, #1767 and #1706 not taken (no Tim answer). Solution 0 errors on net48, net8, net10; Civil net10 20,380, 0 failed; Manager 1,013, 0 failed; net48 focused the same 51 reference-only reds; REDO 25 of 25; Settings fit 670 px; Manager guard 75 files verified. Shared, Installer and Manager untouched. Nothing tested in AutoCAD.
