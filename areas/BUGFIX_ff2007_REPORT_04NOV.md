# BUGFIX ff2007 — FIX-FIRST for draft PR #2007 (B-189, BUG-1045 Civil half), 4 Nov 2026

## FOR TIM

1. **Done:** the one gap the Opus review found is fixed. Open a drawing read-only and type CDDASHBOARD. The window still opens, but "Propose fix", "Propose fixes for all shown", "Fix all safe drafting items" and the Proposals window (where Apply lives) are now greyed out. The status line at the bottom reads "This drawing is read-only - fixes are switched off. Save a copy to fix it."
2. **Why it mattered:** on a read-only drawing the dashboard works from the saved record and does not re-check the drawing. A fix built from an old record could have changed pipe inverts or pit notes in a drawing you only opened to look at.
3. **What did not change:** a normal (writable) drawing behaves exactly as before. With the switch `linking.inspectRunsOnReadOnlyDrawing` turned OFF the dashboard refuses a read-only drawing as it always did, so the buttons never appear. The switch still ships ON. Nothing in the shared code changed.
4. **My own mistakes first:** (a) my first test-run script had no scratch folder and failed; (b) a text-replace command mangled the backslashes in my script, so I rewrote it. Both cost a few minutes only. No effect on the code.
5. **One thing to know about the real-file check:** the folders under `%APPDATA%` changed while I worked (logs, telemetry, usage files, the Manager menu file). My job was a unit test with its own scratch folders and could not have written the Manager menu or Structural logs, so I believe another session or an open AutoCAD did it. I cannot prove that. Details in section 3.
6. **NOT proven:** built and unit-tested only. Nobody has opened this in AutoCAD. The four buttons being greyed out is pinned by a source-text test, not seen on screen. The wording of the status line has not been looked at in the real window (that needs a Codex look). BUG-1045 stays OPEN (the Structural half is separate).
7. **Robot case:** extend `N46_ro_inspect` (as the review asked). Steps: open a copy of the DWG read-only, type `CDDASHBOARD`, then read the dashboard's four fix buttons: each must be disabled and the bottom status line must contain "fixes are switched off". Then also read DBMOD after `CDDIAG` and check it stays 0. **Switch-off control:** set `linking.inspectRunsOnReadOnlyDrawing` to false before launch, type `CDDASHBOARD` on the same read-only copy, and check the command line says "cannot run - drawing is read-only" and no window opens. Settings are read at AutoCAD start (memory: set before launch). I did not write or run the case.

---

## 1. What changed (technical)

1. **PR:** #2007, branch `fb/w1045-readonly-inspect`. One additional normal commit `20d848da` on top of `f7e93034`. No force-push, no retarget, no merge, no new PR. Pushed (leak-scan clean).
2. **`DesignCheckDashboardViewModel.cs`:** new ctor `(report, names, bool readOnlyView)`; the old two-argument ctor chains to it with false. New `public bool ReadOnlyView { get; }`. `ProposeFixCommand` and `ProposeFixAllCommand` CanExecute now start with `!ReadOnlyView &&`.
3. **`DesignCheckDashboardViewModel.ProjectReview.cs`:** `FixAllSafeDraftingItemsCommand` and `OpenProposalsCommand` CanExecute now start with `!ReadOnlyView &&`. The pipe-sizes Apply (`ProjectReviewPipeSizesViewModel.Drawing.cs:37`, the review's open question) lives inside the Proposals dialog (`ProjectReviewProposalsDialog.xaml.cs:42`), which is only reached through `OpenProposalsCommand`, so it is covered. It has no other caller outside its own view-model.
4. **`DesignCheckDashboardViewModel.Review.cs`:** `StatusText` returns the read-only line when `ReadOnlyView`.
5. **`DesignCheckDashboardDialog.xaml.cs`:** new ctor `(report, data, bool readOnlyView)`; old one chains with false.
6. **`DashboardCommands.cs`:** passes `readOnlyView` to the dialog. With the switch OFF `readOnlyView` is always false, so OFF is unchanged.
7. **Test:** `Bug1045InspectReadOnlyTests.TheDashboardFixButtons_AreOffOnAReadOnlyDrawing_AndTheCommandPassesTheFlag` pins the four CanExecute lines, the status text, the command passing the flag and the dialog handing it on. It is a source-text guard like its neighbours; it is not a behaviour test.
8. **`REGRESSION_LOG.md`:** item 3 of the BUG-1045 entry no longer says plain "Nothing is written"; it now says opening writes nothing and records the buttons-off fix and "Not seen in AutoCAD".
9. **Switch and default:** unchanged (`linking.inspectRunsOnReadOnlyDrawing`, ON, pinned through both start-up reads by the existing tests).

## 2. Build and test

1. **Test:** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Release --filter FullyQualifiedName~Bug1045InspectReadOnlyTests -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2 -p:_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`. **7 passed, 0 failed, 0 skipped, total 7** (6 before plus the new one). AutoCAD 2027 on PATH. Count is not 0.
2. **net48 compile:** `dotnet build Modules\Drainage\CE_CVL_SUITE.csproj -f net48 -c Release` with the same flags and `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`: Build succeeded, 0 errors.
3. **Not run:** the full suite, Manager tests, any other test class, AutoCAD, Codex, accoreconsole. No deploy; the bundle was never touched (SkipDevBundle on every command).
4. **Slot rule:** the dotnet count was 0 before the test run. C: free was 65.9 GB before the build (the job brief said about 75; the rule's 27 GB floor was met).

## 3. Isolation check (rule 1)

1. **Variables:** `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\ff2007\log`, `TEMP=TMP=C:\CE_WORK\scratch\ff2007\tmp`, echoed and set inside both run scripts. `CE_STRUC_SUITE_APPDATA_ROOT` not set: this is a Civil job and no Structural test ran.
2. **Listings:** before and after listings of every file (name, size, last-write) under `%APPDATA%\TIM_CE_CADTOOLS` (with `CE_Admin\outbox` and `logs`), `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` are kept as `C:\CE_WORK\scratch\ff2007\appdata_before.txt` (36,824 rows) and `appdata_after.txt` (36,834 rows). The scratch folder is removed at the end, so the numbers below are the record.
3. **Result: real files DID change.** 42 differing rows: eleven new usage files in `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-03` (stamped 13:39 to 13:46 UTC), changed `outbox`/`sessions` entries, `CE_CVL_SUITE\logs\CE_CVL_SUITE.log` and `ce_cvl_structured_20261104.log`, `native_grip_2027.log`, `CE_CVL_SUITE\telemetry\outbox.jsonl`, `CE_STRUC_SUITE\logs\ce_struc_suite.log` and RuntimeDiagnostics, `TIM_CE_CADTOOLS\logs\ce_struc_*_20261104.log`, `CE_CADTOOLS\CE_Admin\manager-menu-state.json` and `CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix`.
4. **My reading, unproven:** my run was one net10 unit-test class and one compile. It cannot write the Manager menu, the CUIX file or Structural logs. These look like another job or an AutoCAD session running on this PC at the same time. I cannot rule out that the Civil log or telemetry files were touched by my test process. I did not check whether AutoCAD was running at the time. Someone should look at who was running between 13:39 and 13:51 UTC on 3 Nov.

## 4. Housekeeping

1. **Worktree:** `C:\CE_WORK\build\ff2007` ran `git clean -fdXq`, then `git worktree remove --force`. The local branch `fb/w1045-readonly-inspect-ff` is left in place (never delete a branch); it equals the pushed PR head.
2. **C: free space:** 65.5 GB just before cleaning; see the closing line of the job summary for the figure after.
3. **Untouched:** BUG_CARPARK.md, DESK_LOG.md, Tim's settings files, installed bundles, ProgramData, CE_SHARED (`git diff` on `Shared` is empty).
4. **Not in any installed build:** this fix is only on the PR branch. Civil 3.0.89, candidate b1 and b2 do not have the original PR either.
