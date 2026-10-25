# PR #1779 (BUG-861): the two review fixes applied, Sun 25 Oct 2026, 23:30

## ANSWER FIRST (FOR TIM)

1. **Done, both fixes.** Old head `6ed25ea4062557c251b435c9159a49262ff123e3`, new head `a8f64f6bde50dc2d8bfe95b8056605de0f46569b`. One normal commit on the same branch (`fb/bug861-redo-first-click`), no force. PR still OPEN and draft, base unchanged.
2. **Fix 1 (wording):** the AutoCAD check now reads: "U, click pit P3, REDO, type REGEN (the Inspector is meant to still be waiting right after the click and the REDO); the Inspector then shows Pit P3 (click again if it says Nothing selected)." Changed in the PR description, in `REGRESSION_LOG.md` and in `release-v3-colleagues-BUG861_FIX_REPORT.md`.
3. **Fix 2 (log line):** the first-pick diagnostic no longer reads the drawing's transaction count. It still logs `redoWindowOpen`, `UNDOMARKS` and `UNDOCTL`. No test mentioned that text, so no test was removed.
4. **Tests (Release, 23:10 to 23:30):** net48 compile 0 errors. Civil net10 full suite: 20,217 passed, 0 failed, 32 skipped (20,249 total). The four `Bug861RedoFirstClickTests` ran and passed (87 passed in the focused Bug861, RedoSafe, PickHandlerProbe and InspectorPalette run).
5. **Status:** built and unit-tested only. Nobody has run it in AutoCAD. Not FIXED.

## What changed

1. `Modules/Drainage/Services/InspectorPaletteService.cs`: the `activeTransactions=` part of the `[REDO] first Inspector pick` line removed (3 lines changed).
2. `REGRESSION_LOG.md`: items 4 and 7 corrected, new item 10 describing the review fixes. The earlier entry text is kept.
3. PR description (`gh pr edit`): the AutoCAD check sentence corrected.
4. Nothing else touched: no CE_SHARED, no settings, no installer.

## What I did NOT do or check

1. Did not run AutoCAD, Codex or accoreconsole. Did not deploy.
2. Did not apply the review's SHOULD and OPTIONAL items (reason wording while waiting, hold-time catch-up, other-drawing gate, classic-layout buttons, clearing first-pick sets); the job asked for exactly two fixes.
3. Net48 was compiled only; the net48 test lane does not load NUnit on this PC. The two Debug-only `SourceAtomicCoordinatorDependencyTests` failures the builder saw were not seen because this run was Release.
