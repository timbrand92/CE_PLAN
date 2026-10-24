# MAX BUILD H report: two Opus-review fixes (Sat 24 Oct 2026)

Builder: Sonnet 5.5. Both fixes are pushed to their own PR branches (normal push, no force). Nothing deployed, AutoCAD and Codex never started, no bug marked FIXED, no PR closed.

## ANSWER FIRST

1. **PR #1748 (BUG-1138), fixed.** After a pit MOVE on a PC without the CE pipe add-on, the line no longer says nothing was changed. It now says: "Your edit stands; every pit keeps its old pipe list. Run CDSYNC on a PC with the current CE suite on AutoCAD 2027 to relink." (the review's exact text). The CDSYNC line is unchanged.
   - **New head:** `990238b623074bef19d9501b5b275ade4536da36` (was `f9667b01`), branch `fb/pc1-BUG-1138-sync-refuses-proxy-pipes`.
   - **Tests:** Civil net10 Release, 19,820 total, 19,798 passed, 22 skipped, 0 failed. New test `TheAutomaticRelinkLine_DoesNotSayNothingChanged_AndPointsToCdsync`. Red check: with only the source file put back to the old text, that one test fails (1 of 11 in the class fails) and passes with the fix.
2. **PR #1767 (BUG-1149), fixed.** With two stage drawings (one bound, one changed or unloaded), the red QA Fail is no longer hidden behind a yellow warning. The one line is now `gone.SourceGoneMaybeBound = unloaded.Count == 0 && changed.Count == 0;`. The window headline order is unchanged.
   - **New head:** `9e1a9455b9052fc65b6969c6a8e38041cb9306d7` (was `b275abd7`), branch `fb/pc2-BUG-1149-bound-source-frozen`.
   - **Tests:** Civil net10 Release, 19,819 total, 19,797 passed, 22 skipped, 0 failed. Three new tests: gone plus changed keeps QA Fail (red before), gone plus unloaded keeps QA Fail (red before), gone plus current is still only a warning (guards the original BUG-1149 behaviour). Red check: with only the status file put back, 2 of 13 in the class fail.
3. **REGRESSION_LOG.md:** one new item added to each PR's own entry (kept the existing text, renumbered Undo).

## How it was built

1. **Worktrees:** private `C:\ce-mx5\a` and `C:\ce-mx5\b` at each PR head; both removed at the end, along with all logs and temp folders in `C:\ce-mx5`. No other `C:\ce-*` folder touched.
2. **Commands:** Civil tests project, net10.0-windows, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD ref paths as in the C-62 assembly report (`_AcadRef48`, `_AcadRefNet8`, `_AcadRefNet10`, `_AcadRef100`, AutoCAD 2027 on PATH). One build at a time; C: had 18 GB free; no build lock was held by anyone. A 0-byte `CE_TRANSFORM_2027.arx` placeholder was created in each worktree's gitignored bin folder and never committed.
3. **Leak scan:** clean on both pushes.

## What I did NOT test

1. **Nothing opened in AutoCAD.** No PC without the CE pipe add-on, no pit MOVE, no Xref BIND, no two-stage sheet. Built and unit-tested only.
2. **net48, Manager and Structural** were not built or tested. Only the Civil net10 Release run was done.
3. **Not run with the other PRs:** neither fix was merged with the other train PRs here; the C-65 assembler must run the combined tree.
4. **Question for Tim left open:** the review's question that "bound" and "detached" look the same in #1767 is unchanged by this fix.
