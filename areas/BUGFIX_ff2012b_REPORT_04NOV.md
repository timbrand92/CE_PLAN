# BUGFIX ff2012b report (4 Nov 2026): FIX FIRST on draft PR #2012 (B-199, BUG-895)

## FOR TIM

1. **Done:** the one thing the review held #2012 for is fixed. One extra commit (698c26e0) is on the same draft PR branch `cx/bug-895-moved-count`. No new PR, no force-push, nothing merged.
2. **What it was:** the first commit had stripped the hidden marker at the very start of the Civil settings file code. Put back. That file now differs from the base only by the new Tidy labels switch.
3. **What you will see in AutoCAD:** nothing different. This is a file-housekeeping fix, not a drawing change. The Tidy labels "Moved" count behaves as the PR already described (switch ON by default, OFF gives the old count).
4. **My own mistakes:** none that touched the code. Wasted a few minutes because the tool shell had no `dotnet` on its path (found it under Program Files).
5. **Proven:** 13 focused tests pass (net48 and net10.0). Both builds compile, so the net48 check is covered. The real settings folders listed before and after my run are identical.
6. **NOT proven:** nothing was opened in AutoCAD. BUG-895 stays open.
7. **Robot case:** none new needed for this fix. The existing proof for the PR is unchanged: type TIDYLABELS on a copy with pit cover texts, one on a layout sheet, and check the Moved count excludes it, then set `linking.tidyCountsRealPitTextMoves` to false before launch as the switch-off control and check the old count returns.

---

## Technical detail

1. **Fault confirmed:** head 28c29baa line 1 of `Modules/Drainage/Models/UserSettings.cs` began `75 73 69` (no BOM); base had `EF BB BF`.
2. **Fix:** BOM restored by byte prepend. `git diff` against `claude/rel-20261102a` for that file now shows only the new switch hunk.
3. **Log:** one line (item 6) added to the BUG-895 entry in `REGRESSION_LOG.md`.
4. **Test:** `dotnet test Modules/Drainage.Tests` with filter `Bug895PitTextRealMovesTests|C76TidyLabelsDefaultOnTests`, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`. net48 13/13, net10.0 13/13, net8.0 filter matched nothing (not a target that holds these tests). Count not 0.
5. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP under `C:\CE_WORK\scratch\ff2012b\temp`; Structural root set. Listings of TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE and CE_CADTOOLS under %APPDATA% taken before and after: hash-identical (kept in `C:\CE_WORK\scratch\ff2012b\before.txt` / `after.txt`, removed with the scratch folder). Manager tests not run.
6. **Disk:** C: free 56.9 GB before, 56.4 GB at the last check (before cleanup).
7. **CE_SHARED:** untouched.
