# Train C-58 finalizer report (Civil + Manager), job dated Tue 20 Oct 2026 (run on the real clock Wed 21 Oct 16:54 to about 17:20, Melbourne)

## ANSWER FIRST

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020l` @ `95fa0153ea149952f7b274bc75cd68bf6a5aee74` (normal fast-forward push from `2e63cc7a`, which equalled the assembly report; leak scan clean). Base installed C-57 `5d1f9864` (Civil 3.0.67 / Manager 1.1.67). No version bumped. Nothing installed.
3. **What I changed (two commits, said loudly):**
   1. **Merged #1514 at `57259b24`** (merge `4b2d3b47`). The assembler held it back because its head had moved from the reviewed `b18a07e9`. I reviewed the move (3 files, 5 lines: exactly the LOW wording fix Opus asked for in entry 1544) and the whole PR again. Only REGRESSION_LOG.md clashed: kept both, 0 lines lost either side.
   2. **Fixed a real defect in #1499, the DP1 Edit window** (commit `95fa0153`, 1 new guard test). The window's tag box was tied to a slot every window already has under the same name ("Tag"). I proved it with a small stand-alone window wired the same way: the box opened **empty** instead of showing "DP1", and typing "DP2" then OK left the tag as **DP1**, with no message. Because this window is ON by default, Tim's first double-click on a downpipe would have shown it broken. Renamed to its own name; the test fails on the old code (the window declared "Tag") and passes now.
4. **Manager must ship: NO.** No file under `Modules/Manager`, `Installer/`, `Installer.Tests/`, `CE.Host` or `Shared/` changed on this train (0 files, base `5d1f9864` to final head). Manager release build not run (not needed).
5. **Tests (Release, final head `95fa0153`):**
   1. Whole solution: **0 errors** (889 warnings), 2 min 55 s.
   2. **Civil net10 full: 19,074 total, 19,054 pass, 19 skipped, 1 failed = the known Glen Eira red** (`BackTest_GlenEira24115_Computed_WithinTolerance`). No new red. (+6 on the assembly run: #1514's ticker tests and my guard test.)
   3. **Manager net10 full: 837 of 837.**
   4. **Civil net48 focused: 219 of 219** (SourceEditWindow incl. the new guard, ChecksWrongLayer, PitLayerFact, SlowWork, RedoSafe, DoubleClick, CrossModuleGuard, CeVersion, CurrentDrawingCheck).
   5. Installer.Tests compiled in the solution build, not run (rule). Nothing in AutoCAD or accoreconsole.
6. **What Tim will see in AutoCAD (once installed):**
   1. **Double-click a downpipe tagged DP1:** a small "Edit source DP1" window opens (tag box reading DP1, a "Show the tag label on the drawing" tick that matches the drawing, Remove tag, Cancel, OK). Type DP2 and OK: it becomes DP2. Cancel or Esc: nothing changes. Typing CDTAG yourself still asks the old command-line questions.
   2. **Nothing else changes by default.** The wrong-layer rows in CDCHECK and the CDCHECKCURRENT progress line are both switched OFF and only appear if someone ticks them in the settings file (there is no Settings page row yet).
7. **Do not mark FIXED:** BUG-748, BUG-531, the plan items UX-LYR-02 (both slices) and UX-PERF-01, and the DP1 double-click item (Tim 20 Oct item 11). None has been driven in AutoCAD. **The DP1 Edit window has never been seen on screen: a Codex look is needed (RULES 5.7)**, including the check that the box reads DP1 and a typed DP2 sticks.
8. **Switches without a Settings page row (not built, Codex window lane):** `doubleClick.sourceEditWindow` (Civil, new on this train, ON), `layerChecks.wrongLayerRows` (OFF), `layerChecks.layerDiffersRows` (OFF, not fed yet), `checks.showProgressWhenSlow` (OFF) and `checks.progressAfterSeconds` (1.0 s). The last four were already in the base; this train is the first to give them a caller.
9. **Risks:**
   1. The DP1 window is ON by default and unseen; my fix is proven by the stand-alone wiring check and the guard test, not on screen.
   2. #1514: AutoCAD may not repaint the command line during a long check, so the progress lines may appear only at the end (Opus 1544 MEDIUM; switch is OFF, so no default effect).
   3. #1512: the "inside an Xref" test looks at the pit's owner (always model space), so that greyed-Fix case rarely triggers; harmless because the rows only list.
10. **Tim's settings files unchanged** (first 7 hex of SHA-256, before = after): `TIM_CE_CADTOOLS\CD_Settings.json` acd64e7 (15,270 bytes), `CS_Settings.json` 622a246, `CE_CVL_SUITE\settings.json` efe307c, `CE_STRUC_SUITE\CS_Settings.json` f68eeb5.

## 1. Reviews

1. **Head check:** `git ls-remote` gave `2e63cc7a`, equal to the assembly report. Merged list confirmed by first-parent log: #1511 (`e9836fcc`), #1512 (`dddf1093`), #1499 (`2e63cc7a`).
2. **MERGE-WITH-FIXES re-reviews:** none needed. All three merged PRs and #1514 had plain MERGE verdicts (entries 1541, 1542, 1544, 1549), and each merged head equals its reviewed head (#1514 reviewed again at its fix-round head).
3. **#1511 @ a6bf49fa: GO.** Pure: a new "wrong layer" section in the one Checks list; rows only arrive if a caller hands them in. Locked-layer and Xref rows are listed, never unlocked or hidden. Two objects with the same mark keep separate keys by handle; the handle never shows in the text. The new `CheckSource.WrongLayer` value has no exhaustive switch to break (checked every user of the list type).
4. **#1512 @ a5a1017a: GO.** The read runs only when `layerChecks.wrongLayerRows` is on (OFF by default), in CDCHECK's existing open-close read transaction, everything opened for read. A read failure becomes one "CE could not check" row, never a silent clean list. Office layer name comes through the layer-name override (`LayerService.LAYER_PIT`). Switch off: no read, no rows, today's list exactly.
5. **#1514 @ 57259b24 (merged by me): GO.** One optional progress object passed to the existing drawing walk; null = silent as before. Switch `checks.showProgressWhenSlow` OFF, never in a script or LISP run, a failing print is ignored (R-27), the delay is a Settings value (R-00). Writes nothing to the drawing.
6. **#1499 @ c897bdf2: GO after my fix.** The window opens inside CDTAG's existing read transaction before anything is written; Cancel returns before any write (the transaction is thrown away); OK and Remove feed the same retag/remove preparation as the command-line route (one code path, design rule 1); the protection check (locked layer, Xref, REFEDIT) still runs before the window. Redo: nothing is written outside the command. **Defect found and fixed:** the tag box binding (ANSWER 3.2).
7. **Millimetre and metre drawings:** none of the four changes measures or draws anything: layer names, a count and a tag string only. No unit path touched.
8. **Shared/:** 0 files changed, so Civil and Manager carry the same CE_SHARED as installed C-57.

## 2. Defaults judged

1. **`doubleClick.sourceEditWindow` (new, ON):** changes what Tim sees by default (a window instead of the command-line question). Kept ON: Tim asked for exactly this behaviour on 20 Oct (item 11, "Double-click on a downpipe (DP1) opens a small Edit window like pipes", Tim: "yes"), it is on his list of fixes in the same answers, and OFF gives the old question. Not turned off.
2. **`layerChecks.wrongLayerRows` (existing, OFF):** no default change.
3. **`checks.showProgressWhenSlow` (existing, OFF) and `checks.progressAfterSeconds` (1.0):** no default change.
4. Nothing needed turning OFF.

## 3. Installer safety

1. **#1475 is not on this train as a new change:** its head `f2c6f848` is already an ancestor of the installed C-57 base (it shipped earlier). This train changes **no file under `Installer/`, `Installer.Tests/` or `Shared/`** (which holds `Shared/CE.Release/OfficialReleaseGate.cs`). **So this train cannot affect the signed-update gate in any way.** Installer.Tests compile only, as ruled.

## 4. Environment and hygiene

1. Private worktree `C:\ce-fin\c58`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, 0-byte `CE_TRANSFORM_2027.arx` placeholder (git-ignored), AutoCAD 2027 folder on a short PATH, fresh TEMP and CE log folder under the user Temp folder per step, Below Normal, every command in the foreground. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran; gone at the end.
2. Run in Tim's AutoCAD hours (16:54 to 17:20); Below Normal priority throughout.
3. Worktree `C:\ce-fin\c58`, its local branch, `C:\ce-fin\c58logs`, the per-step Temp folders and my stand-alone wiring check removed. `C:\ce-fin\logs` is not mine and was left. Main plugin checkout status as found.
4. No PR closed, no branch deleted, no version bumped, nothing installed or deployed, DESK_LOG.md not edited. Structural, #1382, #1384, #1419, #1423 not merged.
5. **Four words:** built and unit-tested (one known red). Not installed. Nobody has opened it in AutoCAD.
