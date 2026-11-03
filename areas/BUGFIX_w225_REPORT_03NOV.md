# BUGFIX w225 (BUG-225, Pit tab Close button) — 3 Nov 2026

**Result: NO PR OPENED. Stopped early, as the brief allows. Needs AutoCAD to see the cause.**

## FOR TIM

1. **What I found:** the Close button on the Pit tab runs the same command you can type (CDCLOSETAB). The code for that command is correct and has not changed since Codex's test. Typed, it works. Clicked, the pit stays selected.
2. **Why I stopped:** the difference only shows up when the ribbon has focus. The fault is almost certainly in how AutoCAD hands the selection back after a ribbon click, or in the selection watcher that re-reads it. That watcher is the same area as the REDO bug (BUG-861). Changing it without seeing AutoCAD would be a guess.
3. **No Settings switch, no code change, no PR.** Nothing of yours was touched.
4. **My own mistakes:** none that cost anything. One repo-wide search timed out and went to the background; no effect.
5. **NOT proven:** I did not run AutoCAD or any test. The cause is still Unknown, as the carpark says.

**One-line question for Tim (or a Codex look):** may Codex run one diagnostic pass, click Close on a Pit with the CE diagnostics on, and read the log to see whether the selection is cleared and then put back by the watcher? Recommendation: yes. It is a read-only look and it settles the cause.

## Technical detail

1. **Base:** `origin/claude/rel-20261102a` at 3fbb9da5. Commit 61fd6fbc named in the brief is NOT an ancestor of it; the code in question is identical either way.
2. **Not already fixed.** `Modules/Drainage/Commands/RibbonContextCommands.cs` lines 19-28: CDCLOSETAB (Modal | UsePickSet | NoHistory) calls `editor.SetImpliedSelection(new ObjectId[0])`, then `CeContextualTabController.HideAll()` (net10 only). The button is `Large("CDCLOSETAB", "Close", ...)` in `Modules/Drainage/Services/CeCvlRibbonContributor.cs` line 296. Unit test `CeCvlRibbonContributorTests.cs` line 150 already pins that the button runs "CDCLOSETAB", the same path as typing.
3. **Where the clear could be undone (hypotheses only):**
   - `Modules/Drainage/Services/CivilSelectionObserver.cs`: on a ribbon click AutoCAD fires ImpliedSelectionChanged; the Idle pass re-reads the pick-first set. `commandRunning` is evaluated at Idle, after CDCLOSETAB has finished, so it takes the normal path. If the pit is still in the pick-first set at that moment (UsePickSet leaves the set as it was when the command started and AutoCAD may restore it on exit; I cannot state AutoCAD's internals), the tab is raised again. The watchdog in `CE_SHARED/.../CeContextualTabController.cs` lines 184-204 also re-raises a hidden tab while `CurrentFamily` is not None.
   - Typing works because there is no ribbon focus change, so no extra ImpliedSelectionChanged.
4. **Why no small fix:** every candidate (drop UsePickSet, a second clear at Idle, a send-string clear) adds a new selection write in the BUG-861 REDO area, and the real cause could sit in CE_SHARED (which must not change in this job). Not a "one small change".
5. **Suggested diagnostic for Codex:** with `RedoDiagSwitches` / CE diagnostics on, select a pit, click Close, read the `[Selection] N picked ...` and `contextual tab:` lines in the CE log after the click. If a pass shows "1 picked" after CDCLOSETAB ran, the pick-first set was restored; the fix is then to suppress that one pass (a Civil-only change, switch on by default).
6. **Isolation rule (common rule 1):** no `dotnet test` or build was run, so no before/after listings were needed. No worktree or scratch folder was created. C: free space did not move.
7. **Robot case for later:** name `pit_close_clears_sel` (style N31_dp_time). It would click a pit border, press the ribbon Close button, then read SELECTED count (expect 0) and that the Pit tab is hidden. Switch-off control: with the new switch OFF the count stays 1.
