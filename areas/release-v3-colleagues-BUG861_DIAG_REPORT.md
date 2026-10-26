# BUG-861 diagnostic build: a switch per suspect for the lost REDO (Mon 26 Oct 2026)

Written Mon 26 Oct 2026 about 13:55 Melbourne (PC clock) by the Team Sonnet job "A DIAGNOSTIC BUILD WITH A SWITCH PER SUSPECT FOR THE REDO LOSS (BUG-861)". Built and unit-tested by me; **not independently reviewed**; nobody has opened it in AutoCAD. BUG-861 is **not** marked FIXED. I did not edit `DESK_LOG.md` or `BUG_CARPARK.md`.

## FOR TIM

1. **Nothing changes on your drawings.** This is a test tool for the robot. Every new switch is off, so Civil behaves exactly as 3.0.78. The REDO loss is still open.
2. **What it is for:** the first fix (3.0.78) did not cure it, and CE's log looks the same when REDO is lost and when it is kept. So I made 14 switches, one for each separate thing CE does when you click an object (the Inspector's reading, its 150 ms wait, the ribbon tab, the highlight glow, and so on). The robot turns them off one at a time and sees which one stops the loss. No reinstall is needed between tries.
3. **The pieces found (14):**
   1. The pick-first observer (reads what you clicked; also tells 2, 3 and 10).
   2. The ribbon contextual tab update.
   3. The Inspector's selection handler (covers 4 to 6).
   4. The Inspector's first-click log line (it reads two undo settings; added by the first fix, so a suspect itself).
   5. The Inspector's 150 ms wait.
   6. The Inspector's refresh after the wait.
   7. The Inspector's contributed pages.
   8. The Inspector's project data sync.
   9. The Inspector's first scan of CE objects in a drawing.
   10. The ownership highlight (glow on related objects).
   11. The twin-pipe pick redirect.
   12. The compound-group selection expansion.
   13. The pit hover cursor monitor.
   14. The automatic Project QA waiting work.
4. **The keys** (all in `diag.redo`, true = skip that piece): `disableSelectionObserver`, `disableRibbonContextTab`, `disablePaletteSelectionHandler`, `disablePaletteFirstPickLog`, `disablePaletteTimer`, `disablePaletteRefresh`, `disableContributedPages`, `disableProjectDataSync`, `disablePaletteFirstScan`, `disableOwnershipHighlight`, `disableTwinPickRedirect`, `disableCompoundSelection`, `disableHoverServices`, `disableProjectQaWait`, and `disableAllSelectionWork` (all 14).
5. **The PR:** draft **#1798**, https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1798, branch `fb/bug861-diag-switches`, against `claude/rel-20261025r` (Civil 3.0.78). Nothing merged, closed or deleted. It has to be built into an install before the robot can use it (the robot's session needs the diagnostic build; I did not deploy anything).
6. **Robot procedure:** for each key, set it true in the settings file **before starting AutoCAD** (the file is read at start), leave the others off, run `R08x_1_exact` and `R08x_5_plain_line_first` in two fresh sessions, record REDO kept or lost. Do `disableAllSelectionWork` first: if it still loses REDO the cause is outside these 14. Otherwise the first key that makes round 1 pass in both sessions names the culprit.
7. **What I did not do:** nothing was tried in AutoCAD, so I do not know which piece is guilty. The two Debug-only test failures below are not new.

---

## Technical detail (nothing here needs Tim)

**Base:** `origin/claude/rel-20261025r` = `d8840a09` (Civil 3.0.78). Branch commit `0e583f64`, one commit, message names BUG-861. Private worktree `C:\ce-fx\d861`, scratch `C:\ce-fx\d861s`.

**Documents read first:** `C:\TimOS\RULES.md`, the 3.0.78 regrade report, `RUNNER_R08_CHARACTERISE_REPORT.md`, `BUG861_FIX_REPORT.md`, and the C-62 assembly report (for the AutoCAD refs).

1. **How the keys are read.** The file is `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` (the settings folder `SettingsService` resolves; a test run redirects it into its own TEMP). CE loads it once when AutoCAD starts (`SettingsService.Initialize`), so a key must be set before launch; a change in a running session does nothing (as for every CE setting; see memory "settings guard: set before launch"). Each component then asks its switch from the live in-memory settings (`SettingsService.Current.Diag.Redo`) every time it is about to run, i.e. on every pick; nothing is cached. JSON shape: `"diag": { "redo": { "disablePaletteTimer": true } }`. Unreadable settings behave normally.
2. **Log lines.** Each skip: `[REDO-DIAG] skipped <Component> (diag.redo.<key>) at <place>`. Each pick (when any key is on): `[REDO-DIAG] selection event: skipped components = a, b`. Hover and Project QA write once per session. Nothing is written when all keys are off.
3. **Where each switch sits** (first statement of the method): `CivilSelectionObserver.OnImpliedSelectionChanged` (also writes the summary line) and `.NotifyContextualTab`; `InspectorPaletteService.OnImpliedSelectionChanged` (handler, then the 150 ms wait), `.LogFirstPickState`, `.RefreshAfterPick`, `.RefreshContributedPagesOutsideRedoWindow`, `.SyncProjectDataOutsideRedoWindow`, `.EnsureDrawingDiscovered`; `CivilOwnershipHighlightService.ScheduleRefresh` (so command-start and command-end refreshes stop too) and `.OnSelectionAdded`; `CompoundSelectionService.OnSelectionAdded`; `PitHoverService.OnPointMonitor`; `CivilProjectQaAutomaticService.OnIdle`.
4. **Things to know when reading results.** The observer key also stops its three notifications (tab, Inspector, highlight), so test its children alone if it passes. Palette closed already passed in the 3.0.75 characterisation, which points at the palette side (3 to 9) first. The deferral from the first fix keeps its own key `linking.inspectorPickWaitsAfterUndo` (default on); setting it false is a useful extra control. Not covered, because they only run inside a command: the ghost, snap and vertex-pick cursor monitors. `PitHoverService` only runs its monitor when debug logging is on. `PaletteFirstScan` runs at drawing activation, not on a pick, but it is once-per-drawing Inspector work, so it is in.
5. **Files changed:** new `Services/RedoDiagSwitches.cs` and `Models/DiagSettings.cs`; `Models/UserSettings.cs` (the `diag` group); one switch check in each of six services; new `Drainage.Tests/Services/Bug861DiagSwitchesTests.cs`; `REGRESSION_LOG.md` entry. `CE_SHARED` unchanged. No Settings window row.
6. **Tests.** New `Bug861DiagSwitchesTests`: 35 (defaults normal and silent; typed key switches off only its own component; one log line per skip; all-key switch; once-only lines; unreadable settings; each of the 14 sites asks its switch before any drawing access). The first full run found one real failure I caused, `C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault` (new keys need `Default: off.` in their documentation and an explicit initialiser); I fixed it. **Civil net10 full suite (Debug, run again after the fix, 13:31 to 13:40, on a PC where another job was also running tests): 20,415 total, 20,381 passed, 2 failed, 32 skipped.** The 2 are `SourceAtomicCoordinatorDependencyTests.FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and `...RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`, the same two the first BUG-861 fix reported failing in Debug. Both pass in a Release build (63 of 63 with the BUG-861 tests). I did not run them on the untouched base. This was the second full run, not the first (the first had the settings-guard failure; one attempt in between was killed by my own 10-minute cap and is not a result). The PDF page test passed. Civil net48 Release compile: 0 errors.
7. **Not tested:** anything in AutoCAD; that the switches really change the AutoCAD session (only that each site asks its switch first); the net48 test run; Manager and Structural suites.
8. **Housekeeping:** AutoCAD, Codex and accoreconsole not started; no deploy; no settings file, installed bundle or ProgramData touched; foreground builds with `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the refs from the C-62 report. Another job's `dotnet test` (net48, Release) was running during part of my work; I did not touch it. A 0-byte placeholder `CE_TRANSFORM_2027.arx` sits in the worktree's git-ignored folder; the worktree is removed at the end.
