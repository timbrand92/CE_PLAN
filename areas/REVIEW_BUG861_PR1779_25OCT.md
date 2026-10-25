# Independent review: BUG-861 draft PR #1779 (Inspector pick waits after U), Sun 25 Oct 2026, 23:00

Reviewer: Opus 5.5, independent (did not build it). Method as `REVIEW_PILOT_CRITICAL_B4B5_25OCT.md`. PR read live from gh at 22:40: head `6ed25ea4`, one commit straight on the base `claude/rel-20261025o` at `2c805a39` (Civil 3.0.75), still OPEN and draft, four files. Read in full first: `C:\TimOS\RULES.md`, `release-v3-colleagues-BUG861_FIX_REPORT.md`, `release-v3-colleagues-RUNNER_R08_CHARACTERISE_REPORT.md`. Read only; nothing pushed, merged, commented or built.

## ANSWER FIRST (FOR TIM)

1. **Verdict: MERGE-WITH-FIXES. Yes, it should ride in C-68**, once two small fixes are in (below).
2. **What it does on the drawing:** with the CE Inspector showing, after a U, a click no longer makes the Inspector read the drawing. The Inspector catches up when your next command (other than U or REDO) finishes. REDO should then work on the first click too.
3. **What you will notice:** after a U, the Inspector says "Selection changing — actions paused." and keeps the old item until you run any command. After a REDO it still waits. Click again after that command if it shows nothing.
4. **The builder was honest.** It could not name the exact step that loses REDO, and said so. Stopping every Inspector read in that moment is the right safe move.
5. **Two things in the builder's account are not quite right (they do not break the fix):**
   1. It described the older Inspector layout. Your PC (and so your colleagues') uses the newer "workshop" layout, which reads the drawing a different way. The fix stops both ways, so it still covers you.
   2. Its AutoCAD check step 2 would fail by design. After U, click, REDO, the Inspector is meant to still be waiting. The step needs one more command first.
6. **Fix 1 (wording only):** correct that AutoCAD check step (exact text in item 6 below).
7. **Fix 2 (one line):** the new log line reads one thing from the drawing's transaction manager at the exact moment under test. Nobody has measured that read. Take it out so the robot test is clean.
8. **Status:** built and unit-tested by the builder only. Nobody has run it in AutoCAD. Not FIXED.

---

## Checks I ran

1. **Diff and live files:** `gh pr diff 1779`, plus the PR versions of `InspectorPaletteService.cs`, `RedoWindowGuard.cs`, `CivilSelectionObserver.cs`, `CivilOwnershipHighlightService.cs`, `PickHandlerProbe.cs`, `InspectorViewModel.cs`, `CeEditorShellStateStore.cs`, `ProjectDataService.TryPeekCurrent` and `Drainage.HeadlessProof/RedoPrimitiveChecks.cs`, all read with `git show` at `6ed25ea4`.
2. **Files touched:** only `InspectorPaletteService.cs`, `UserSettings.cs`, the new test file and `REGRESSION_LOG.md`. No CE_SHARED, Installer, signing, deploy, version or PackageContents file.
3. **Tests, red then green:** I re-ran the three source-guard tests' exact text checks (same brace-matching and the same asserts, in a small script) against the base file and the PR file.
   1. **On the base:** all three fail.
   2. **On the PR:** all three pass.
   3. **The fourth test** (switch default) needs the new property, so it cannot compile on the base.
4. **Not built, not run in dotnet:** C: had 9.8 GB free (under the 10 GB start, near the 8 GB floor). A private build was not worth the risk, so I did not build or run the NUnit suite. The builder's counts are unverified by me.
5. **Tim's real setting read:** `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` has `"editors.workshopLayout": true` (read only).
6. **Other open PRs:** I fetched the file lists of the newest 400 open PRs. Of those, 22 touch `InspectorPaletteService`, `RedoWindowGuard`, `CivilSelectionObserver`, `PickHandlerProbe` or `LinkingSettings`. I trial-merged with `git merge-tree` (in memory, no worktree). Result in item 5.

## Item 1: is the diagnosis honest, and does the deferral cover every first-pick read?

1. **Honest about the gap: yes.** The report says plainly it cannot name the step and that this is "a safe deferral plus a diagnostic, not a proven fix". That matches the code.
2. **Wrong branch described (the builder's report, "What I found" 1.3):**
   1. **What it says runs:** `IsKnownCivilDrawing`, `LabelStyleService.ActiveStyleName`, `SelectImplied` and the classify transaction.
   2. **That is the classic branch.** `RefreshInspector` jumps to `RefreshCivilProperties` first when `WorkshopInspectorEnabled` is true (line 1239). The default is true (`CeEditorShellFlagDefaults.WorkshopLayout = true`), and Tim's file says true.
   3. **What actually ran in the robot's failing round:** `SelectImplied`, `ProjectDataService.TryPeekCurrent` (memory only), an open-close transaction, `TryBuildCivilOwnershipHighlightPlan`, `PopulateCivilOther` (a line) or `ShowCivilPitRecord` (a pit), and `CivilProtectionReason`. That last one also calls `GetSystemVariable("REFEDITNAME")` and reads the layer record and the owner block record.
   4. **Effect on this PR: none.** The deferral returns before `RefreshInspector`, so both branches are covered. It matters only for the next step if REDO is still lost.
3. **"No Transaction commit on that path" is not literally true.** The classic branch commits its open-close transaction (line 1494). The workshop branch does not commit. The console measurement (`openclose`, with Commit) said KEPT, so this is a wording slip, not a cause.
4. **"Measured REDO-safe" is weaker than it reads.** `RedoPrimitiveChecks.cs` measured those reads in the 2027 core console, one run each, called from a LISP function. That is not AutoCAD's Idle in the full program with a palette showing. Probe 6 (palette closed passes 2 of 2) shows something in the palette's reaction is not REDO-safe in real AutoCAD. This is why deferring everything is the right call, instead of trusting each "safe" read.
5. **Does the deferral remove every palette-only drawing read on the first pick? Yes, as far as reading can show.** With the switch ON and the window open, the palette-only work left on a pick is:
   1. **The workshop flag:** read from settings already in memory (`SettingsService.Current.EditorShell.Flags`), not the drawing.
   2. **`InvalidateCivilSelection()`:** a status text, buttons greyed, and `CommandManager.InvalidateRequerySuggested()`. The only button check that touches AutoCAD is `LoadExistingInspectorCommand`, which reads `doc.CommandInProgress` and `TryPeekCurrent` (memory only). The base did all of this too.
   3. **The 150 ms timer:** memory only.
   4. **The guard call:** memory and one log line.
   5. **The new diagnostic:** two `GetSystemVariable` reads and `TransactionManager.NumberOfActiveTransactions` (see item 2).
6. **The other suspects, checked:**
   1. **Contributed pages:** no page is registered anywhere in `Modules` or `Shared` (only the host classes), and `OnContributorSyncIdle` already defers.
   2. **`CivilSelectionObserver`, the ownership highlight and the ribbon contextual tab:** none of them checks the palette, and probe 6 passes with them all still running. They are not the palette-only part.
   3. **`IsKnownCivilDrawing`:** the observer already asks it on every pick, before the palette does, so its first answer per drawing is not palette-only.
   4. **First scan (`EnsureDrawingDiscovered`):** runs at drawing activation, not on the click, and only in the classic layout.
   5. **`PickHandlerProbe`:** active only with debug logging on. The robot's click-to-REDO log shows no `[PickProbe]` line, so it was off.
7. **Why "first pick per drawing" fits a deferral:** probe 4 (a pit click before any U prevents the loss) and rounds 2 and 3 passing both suggest one-time work on the Inspector's first real read in a drawing. With this PR, that first read happens after a non-U command has ended, outside the window. This is a reasonable reading of the evidence, not a proof.
8. **Catch-up after the next command: correct, with three small gaps.**
   1. **Normal case:** the resume runs in `CommandWillStart`, hooks only that command's END (and Cancel and Fail), unhooks itself, then at the next Idle calls `OnImpliedSelectionChanged`. After a U or REDO that call defers again (new window). After any other command it shows the pick.
   2. **No further command:** no deadlock and no leak. Later clicks park under the same owner, and `ParkLocked` keeps one entry per drawing and owner, so nothing piles up. The palette just stays on the old item.
   3. **Drawing switch:** the catch-up only runs if the same drawing is active; otherwise the activation refresh (`OnDocumentActivated`) shows it. Fine.
   4. **Gap (LOW): Settings hold time.** If "Wait after Undo (seconds)" is above 0, the window closes on the timer, but the resume still waits for a command to END before showing the pick. The default is 0, so this does not affect Tim. Optional fix: when the window is already closed at resume time, call `OnImpliedSelectionChanged` at the next Idle straight away.
   5. **Gap (LOW): the other-drawing window (BUG-558).** The gate is `RedoWindowIsOpenForActiveDrawing()`, per drawing. U in drawing A, switch to B, click: the PR does not defer, so B is read while A's REDO is open, exactly as before. Optional fix: when the switch is ON, gate on `RedoWindowGuard.IsOpenAnywhere()` too.
   6. **Gap (LOW): classic layout buttons.** In the classic layout (not Tim's), the Inspector's Zoom and Edit buttons act on `_lastSelectedEntityId`, which is the previous pick while the new one waits. The workshop layout greys its buttons ("actions paused"), so Tim and colleagues are safe. Optional fix: clear `_lastSelectedEntityId` when deferring (memory only).
9. **Visible trade worth stating to the drafter (plain wording, SHOULD):** while waiting, the workshop Inspector says "Selection changing — actions paused." That does not say why or for how long. Pass a reason in the deferral path, for example `_viewModel?.InvalidateCivilSelection("Shown after your next command, so REDO stays available.")`. This is the same call the base already makes in the window, only with different words, so it adds no new kind of risk. Optional, and the robot needs a Codex look to accept the wording.

## Item 2: redo-safety of the new code and the [REDO] diagnostic

1. **Deferral path:** memory, a settings value, the guard (memory and log) and event hooks. No transaction, no system variable set, no lock, no write. Safe.
2. **Catch-up:** hooks events inside `CommandWillStart` (the guard's documented rule for resumes) and reads nothing. Safe.
3. **`GetSystemVariable("UNDOMARKS")` and `("UNDOCTL")`:** reads, the same call that was measured KEPT (`getvar`: DBMOD and CLAYER) in the console. These two variables were not measured themselves. I cannot say what AutoCAD does inside (RULES 12.5). Acceptable.
4. **`db.TransactionManager.NumberOfActiveTransactions` (FIX 2, required):** never measured, in the console or anywhere. It runs once per drawing on exactly the first pick inside the window, which is the moment under test. If it costs REDO, the fix will look like it failed and the diagnostic will mislead. Remove `", activeTransactions=" + ...` from `LogFirstPickState`. It tells us little anyway (the guard already logs when work is held).
5. **What the diagnostic can and cannot tell (wording correction):** UNDOMARKS counts UNDO Mark marks and UNDOCTL is the undo switch bits. Neither says whether REDO is still available (the managed API has no way to read that, as `PickHandlerProbe` notes). So "they tell us the next step" overstates it. The REDO result in the robot run is still the only real signal. The lines are cheap and harmless once item 4 is done; keep them.
6. **Small (LOW):** `_firstPickSeen` and `_firstPickHandled` are keyed by the drawing's native pointer and never cleared. A reopened drawing can get the same pointer and log nothing. The B3b run b3bh4-s1 was exactly a reopened drawing. Optional: clear both on `DocumentToBeDestroyed`.

## Item 3: switch rule, Settings home, wording, protected files, hard blocks

1. **Switch:** `linking.inspectorPickWaitsAfterUndo` in `LinkingSettings`, default ON. A new file and `{}` load ON, and a typed OFF is kept (tested). Correct for a bug-fix switch (R-00, R-27).
2. **Settings page row:** none. Same accepted pattern as the C-61 to C-66 switches (R-00 home still owed, window lane). Add it to that list.
3. **Wording:** the `UserSettings` comment is plain. The log line ("Inspector pick (BUG-861: nothing is read between U and REDO) waits for the next command so REDO stays available ...") is a log line, fine.
4. **Protected files:** none touched (CE_SHARED, Installer, signing, deploy, version, PackageContents).
5. **No hard block:** only automatic background display waits. Every drafter action (the palette's own Refresh, Load existing, Edit, any command) still runs.

## Item 4: tests

1. **Four tests, read in full.** Three are source-text guards (order of the gate, the defer and the old path in `RefreshAfterPick`; the catch-up waits for the command END and reads nothing; the diagnostic only reads). One is the switch default.
2. **Red on the base, green after: confirmed for the three guards** by running their exact text checks on both files. The switch test cannot compile on the base (weaker proof, as usual).
3. **What they do not prove:** that REDO survives (needs AutoCAD, as the file says), the "waits again after REDO" loop, the hold-time path, or the other-drawing case. They are wiring guards only.
4. **The builder's full-suite numbers** (20,215 passed, 2 failed in `SourceAtomicCoordinatorDependencyTests` on Debug, passing on Release): not re-run by me. The two failures are code-shape checks in files this PR does not touch, so they are plausibly a Debug-build difference. The builder did not prove they fail on the untouched base in Debug. The C-68 finalizer should run them on the train in Release, as usual.
5. **C-68 finalizer:** add `linking.inspectorPickWaitsAfterUndo` to the new-switch-defaults test (pinned ON).

## Item 5: overlap with other open PRs

1. **22 open PRs** (of the newest 400) touch the Inspector, redo-guard, pick-observer, probe or linking-settings files.
2. **20 of them are already contained in the base** (nothing ahead of it, still open): #1532, #1546, #1552, #1553, #1556, #1557, #1558, #1562, #1567, #1570, #1586, #1591, #1594, #1595, #1599, #1609, #1611, #1612, #1617, #1665. The desk may close them as done; I did not touch them.
3. **#1588 (BUG-994, Inspector drawn length, based on `rel-20261022m`):** already clashes with the base by itself, at the same place, the BUG-572 pipe-type lines. It clashes with #1779 in that same place only. #1779 adds no new clash.
4. **#1706 (BUG-225 FB-12):** only `REGRESSION_LOG.md` (keep both).
5. **Onto the C-67 branch** (`claude/rel-20261025q`, `0d885094`): #1779 merges with only the usual `REGRESSION_LOG.md` clash. `UserSettings.cs` merges by itself.

## Item 6: the real-AutoCAD proof it needs

1. **Must pass, two separate sessions each, on an installed build that contains #1779:**
   1. `R08x_1_exact` and `R08x_5_plain_line_first`: round 1 REDO says "Everything has been redone".
   2. **The reviewed R08 case itself** (`R08_redo_after_pick_x5`). The probes say "NOT a feature test and never accepted", so Claude-accepted can only come from R08.
   3. `R08x_6c_recalibrate_palette_open` (the palette-open control): now passes.
2. **Fails-before proof:** already in hand (6 of 6 on 3.0.75). A cheaper extra one: the same R08 run with `linking.inspectorPickWaitsAfterUndo` OFF on the new build should fail again. That proves the switch is what changed it.
3. **CE log in those runs:** one `[REDO] Inspector pick (BUG-861 ...) waits` line per round. One pair of `[REDO] first Inspector pick in this drawing` lines per drawing. No `[REDO] Inspector refresh waits` line caused by the click.
4. **Catch-up, needs a Codex look (FIX 1 replaces the builder's step 2):**
   1. **Wrong step (builder's report item 2, PR body, REGRESSION_LOG item 7):** "click a pit after a U and a REDO and check the Inspector shows that pit". After REDO the window is open again, so the Inspector is meant to still be waiting. This step would FAIL by design.
   2. **Replace it with:** "Draw a LINE, Enter. Type U. Click pit P3. Check the Inspector says 'Selection changing — actions paused.' (or the new wording). Type REDO: 'Everything has been redone'. Type REGEN, Enter. Check the Inspector now shows Pit P3. If it shows 'Nothing selected', AutoCAD dropped the pick: click P3 again and check it shows."
5. **Regression of the earlier Inspector REDO fixes:** re-run the hatch pick with the Inspector open (C-4 A2 OPEN g), the Inspector zero-count click (BUG-892), the drawing switch after U (BUG-558) and Codex's V4/V6 route (click, right-click, Esc, REDO).
6. **AutoCAD 2022 to 2024:** compiled with 0 errors by the builder; not run. Same code path, so no special case, but not proven there.

## Exact fixes before it rides in C-68

1. **FIX 1, required (text):** in `REGRESSION_LOG.md` item 7, replace "Then click a pit after a U and a REDO and check the Inspector shows that pit." with "Then: U, click pit P3, REDO, REGEN; the Inspector then shows Pit P3 (click again if it says Nothing selected)." Same correction in the PR body and the fix report.
2. **FIX 2, required (one line):** in `LogFirstPickState`, delete `", activeTransactions=" + db.TransactionManager.NumberOfActiveTransactions`. Keep the two `GetSystemVariable` reads. The test `TheFirstPickDiagnostic_OnlyReadsTheUndoState_AndWritesNothing` still passes (it does not check that text).
3. **SHOULD (wording):** in the deferral path, after `DeferPickUntilNextCommand()` returns true, call `_viewModel?.InvalidateCivilSelection("Shown after your next command, so REDO stays available.")`.
4. **OPTIONAL (LOW):** the hold-time catch-up, the other-drawing gate, clearing `_lastSelectedEntityId` in the classic layout, and clearing the first-pick sets when a drawing closes (items 1.8 and 2.6).

## What I did NOT check (RULES 5.9)

1. **AutoCAD:** nothing opened. Nobody has seen this work in AutoCAD.
2. **Builds and NUnit:** not built or run by me (disk near the floor). The three guards were re-checked by text only. The switch test and the full suites are the builder's word.
3. **Root cause:** still unknown. I narrowed the palette-only work to what is listed in item 1.5, by reading only.
4. **Conflicts:** only the newest 400 of the open PRs, by text clash, not by meaning.
5. **Structural and Manager:** not affected by these four files; not checked further.

## Summary

MERGE-WITH-FIXES; ride in C-68. The deferral honestly covers every palette-only drawing read on the first pick after U (both Inspector layouts), and catches up after the next non-U command, with no leak or deadlock. Two required fixes: correct the AutoCAD check (after REDO the Inspector is meant to still wait; add REGEN), and drop the unmeasured transaction-manager read from the new log line. The builder described the classic Inspector branch; Tim runs the workshop branch, which this still covers. Tests red-on-base confirmed by text. Proof needed: R08, R08x_1, R08x_5, R08x_6c twice each.
