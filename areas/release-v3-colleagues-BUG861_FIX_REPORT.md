# BUG-861 fix report: REDO lost after the first click in a fresh drawing (Sun 25 Oct 2026, evening, Team Sonnet)

Built and unit-tested by me; not independently reviewed; nobody has opened it in AutoCAD. Not marked FIXED. Documents read first: `C:\TimOS\RULES.md`, `release-v3-colleagues-RUNNER_R08_CHARACTERISE_REPORT.md` (all), the BUG-861 entry in `BUG_CARPARK.md`, the R08 verdict in the B3b review. Base: `origin/claude/rel-20261025o` (Civil 3.0.75, commit 2c805a39). The C-67 branch (`claude/rel-20261025q`) has the same Inspector, redo-guard and pick-observer files as the base, so nothing for this is fixed there.

## ANSWER FIRST (FOR TIM)

1. **I could not name the exact step that loses REDO, so this is a safe deferral plus a diagnostic, not a proven fix.** The code on that first click does only reads and the log shows no write. Nothing in the code I read should clear REDO, yet the robot proves something does.
2. **What the fix does:** while REDO is available (after a U, until the next command starts) the Inspector palette now reads nothing from the drawing when you click. It shows the pick when the next command has ended (REDO, or anything else). The robot must now pass `R08x_1_exact` and `R08x_5`.
3. **What you will notice:** after a U, if you click a pit, the Inspector keeps showing the old pick until your next command ends. Then it catches up.
4. **Safety switch:** `linking.inspectorPickWaitsAfterUndo`, ON. Off gives yesterday's behaviour.
5. **If REDO is still lost:** CE's log now has two `[REDO] first Inspector pick in this drawing` lines per drawing with the undo state either side. They tell us the next step.
6. **Status:** draft PR 1779 against `claude/rel-20261025o`. Built and unit-tested only. Not in AutoCAD. Not FIXED.

---

## What I found (item 1 of the job), and how sure I am

1. **What runs on a pick with the palette showing** (sure, from reading):
   1. `CivilSelectionObserver.OnImpliedSelectionChanged` marks the pick; at the next Idle `ProcessSelection` reads `SelectImplied`, may start one open-close transaction (compound members, only when a compound is involved), tells the ribbon tab, then calls `InspectorPaletteService.OnSelectionObserved` and `CivilOwnershipHighlightService.OnSelectionObserved`.
   2. The palette returns at once if it is not showing. If it is showing it starts a 150 ms timer. The tick calls `RefreshAfterPick`, which (in the redo window) waited for a quiet Idle and called `RefreshInspector(automatic)`.
   3. `RefreshInspector(automatic)` in the redo window skips the contributed pages and the project-data sync (so no normal transaction), then runs `IsKnownCivilDrawing` (an open-close read of the CE record, first answer per drawing), `LabelStyleService.ActiveStyleName` (a settings file read, no drawing), `SelectImplied`, and one open-close transaction that classifies the picked object and fills the palette.
2. **No `Transaction` commit, `StartUndoMark`, `SetSystemVariable`, command-context call or `SendStringToExecute` is on that path** (sure, I read every step; `RedoSafeCallGraphTests` also pins it). Database writes: none found, and CE's log shows none (the robot's report: 0 write lines between U and REDO).
3. **Not explained by the code** (this is the gap): the pick-first observer does the same reads with the palette closed and REDO survives. So the palette-only part is the open-close read in `RefreshInspector` and the palette filling itself, but my reading says both are REDO-safe, and the robot says one of them is not on the FIRST pick per drawing. How sure: I cannot say which step, and I would not bet on the open-close transaction being the cause. Autodesk's inside is closed, so a first-per-drawing open-close read on a freshly opened drawing is the best remaining suspect, not a finding.

## What I changed (items 2 and 3)

1. **Fix:** `RefreshAfterPick` (`InspectorPaletteService.cs`): in the redo window, with the switch ON, it asks `RedoWindowGuard.DeferWhileRedoOpen` and returns. No read, no timer chain, no Idle hook. The guard's resume (when the next command STARTS) only hooks that command's END; at the first Idle after the end it asks for the pick again. A U or REDO ends with a new redo window, so it waits again; any other command ends and the pick shows.
2. **Log line:** `[REDO] Inspector pick (BUG-861: nothing is read between U and REDO) waits for the next command so REDO stays available ...`, once per redo window (the guard's own line).
3. **Diagnostic (item 2 of the job, the "cannot establish" branch):** `LogFirstPickState` writes `[REDO] first Inspector pick in this drawing (pick seen)` and then `(pick deferred)` or `(pick refreshed)`, once per drawing and session, with `redoWindowOpen`, `UNDOMARKS`, `UNDOCTL` and active transactions. Reads only (`GetSystemVariable` keeps REDO).
4. **Switch:** `linking.inspectorPickWaitsAfterUndo` in `LinkingSettings`, ON by default (R-00, R-27: a bug-fix switch ships ON). No Settings page row yet (window-lane decision).
5. **Files:** `Modules/Drainage/Services/InspectorPaletteService.cs`, `Modules/Drainage/Models/UserSettings.cs`, new `Modules/Drainage.Tests/Services/Bug861RedoFirstClickTests.cs`, `REGRESSION_LOG.md`. `CE_SHARED` unchanged.
6. **Git:** branch `fb/bug861-redo-first-click`, draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1779 against `claude/rel-20261025o`. Commit message names BUG-861.

## What I did not change, and a risk

1. The pick-first observer and the ownership highlight still read at Idle after a pick (they run with the palette closed and the robot passes). If the robot still fails after this, they are the next two things to defer the same way.
2. The Inspector now lags one command after a U; that is a visible, deliberate trade.
3. The diagnostic reads two system variables once per drawing. It is the only new CE code that touches AutoCAD state in the window; measured earlier to keep REDO, but not re-measured by me.

## Tests (item 3)

1. **New, `Bug861RedoFirstClickTests`, 4 tests:** switch ON from an empty file and a typed OFF kept; `RefreshAfterPick` defers before any read and reads the switch; the deferred pick waits for the command END and does no transaction; the diagnostic only reads. **Against the base (the InspectorPaletteService file reverted, the rest kept): 3 of 4 failed, 1 passed (the switch default, which does not depend on the Inspector file). With the fix: 4 of 4 pass.**
2. **Civil net10 full suite (Debug, run once, 20:09 to 20:16): 20,215 passed, 2 failed, 32 skipped.** The two failures are `SourceAtomicCoordinatorDependencyTests.FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and `...RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`: they read compiled-code shape in code this change does not touch (`stloc.s` instead of `dup`, `Brfalse_S` instead of `Brtrue`). **Not 0 failed as the job asked.** I did not run them on the untouched base in Debug to prove they fail there too; I ran them in a Release build, where they pass (86 of 86, with the BUG-861, redo-call-graph, redo-round-2 and C-65 switch tests).
3. **net48 compile of the Civil plugin (Release): 0 errors.**
4. **Not tested:** anything in AutoCAD; the Manager and Structural test suites; the full Release suite.

## Real-AutoCAD check owed (for the robot or a person)

1. On a build that contains PR 1779: `R08x_1_exact` and `R08x_5` must both pass (round 1 REDO says "Everything has been redone").
2. Then click a pit after a U and a REDO and check the Inspector shows that pit.
3. Read the CE log for the three `[REDO]` lines above. If REDO is still lost, send those lines back.

## Housekeeping

1. Scratch: private worktree `C:\ce-fx\b861` (removed at the end), test scratch in `C:\ce-fx\b861_t` and `C:\ce-fx\b861_logs` (mine only, removed). Foreground builds only, always `-p:SkipDevBundle=true -nr:false --disable-build-servers`. AutoCAD, Codex and accoreconsole not started; Tim's settings files, installed bundles and ProgramData not touched. `DESK_LOG.md` and `BUG_CARPARK.md` not edited.
2. A 0-byte placeholder `CE_TRANSFORM_2027.arx` was created in the worktree's git-ignored folder for the test build.
