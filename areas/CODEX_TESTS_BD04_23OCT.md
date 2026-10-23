# BD04 Structural regression tests — 23 October 2026

## ANSWER FIRST

1. **Delivery:** branch `cx3/tests-bd04`, based on `origin/claude/rel-20261023s` (`e6d597c0`, Structural S-42). Draft PR [#1705](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1705), head `d2b7ff26cfc578b7580b90a9870c2b0b766a96bd`; validation pending.
2. **Tests added:** 10 cases: BUG-303 six, BUG-315 two, BUG-858 two. Product code is unchanged. These fill missing scenarios in partly tested fixes; no claim that these bugs previously had no tests at all.
3. **Totals:** pending foreground builds and test runs; no passing total claimed yet.
4. **New findings:** none established by execution yet. BUG-818/BUG-819 remain unresolved catalogue/drawing work and are not treated as fixed.
5. **What Tim sees:** no change in AutoCAD. This is a tests-only draft; nothing installed, deployed or accepted.
6. **Not run:** AutoCAD, core console, deployment, settings changes, window rendering, parent-commit execution (pending); complete lane results to follow.

## Audit and before-fix evidence

1. **BUG-303 / ADV2 M4:** carpark identifies depth being read as reinforcement after a hand row change. Existing `FoundationScheduleBuilderTests.Adv2F4_*` cover inserted rows and source wiring. The new six cases cover unchanged row counts (DEPTH/REINFORCEMENT swapped, heading renamed), comparison-record preservation and reading a valid companion schedule while refusing the other. `11413b34` adds `CeLayoutOrNull` at the merge and absorb boundaries. Its parent reads rows 3/4/5/6 by position and would absorb 600 or ROCK as bars, replace the recorded comparison cells, or report a false conflict between the two tables. These assertions inspect the real service output.
2. **BUG-315 (3):** existing cut-and-paste tests cover the footing schedule only. Two new cases exercise R.C beam reinforcement and cover-note edits. `e07e99b3` adds comparison with the erased cut original. Its parent compares the pasted table only with what CE last wrote, rejects the new edit and returns null instead of the pasted grid. The additional optional cut-original argument was introduced by that fix; diff reasoning is distinguished from executing the old commit.
3. **BUG-858:** existing drawing geometry tests check the Z outline; the window-preview test checks source text only. Two new executable cases invoke the real private preview geometry method without creating a window (250/125/20/5 mm and 200/60/15/2.4 mm). `1ea2517d` replaces the old private outline with the corrected drawing outline. Its parent produces a 2W envelope and places the bottom web/lip incorrectly; the tests expect 2W minus thickness and exact web/lip coordinates. Reflection is limited to that otherwise inaccessible geometry contract.
4. **Other reviewed coverage:** CEMEMBER layer names and renamed hidden layers already have engine/source guards; existing-layer protection has `ExistingHiddenLayerKeptTests`; BUG-369 hidden-layer messages, BUG-367 layer creation, BUG-434 current-layer restoration, BUG-349 refusal notes and BUG-315 legend scaling already have coverage. No duplicate tests added for those. Notion Inbox had no New items.

## Exact real-AutoCAD check — owed to the independent driver, not Tim

1. **Schedule protection:** use a synthetic scratch drawing with an EB1 300 x 600 beam and placed footing/R.C beam schedules. Type N16-200 and KEEP COVER. Exchange DEPTH and REINFORCEMENT rows without adding a row, or rename the REINFORCEMENT heading to FOUNDING MATERIAL and type ROCK. Run FSTEXPORT/CSRCBEAMSCHEDULE. Expect a plain line saying the changed table is left alone; erase the altered table and place it again from the stored record; confirm N16-200/KEEP COVER return without typing them again. Keep the other schedule valid with a new N20-150 entry: it must still be read without a false two-table conflict.
2. **R.C beam cut-and-paste:** with normal CE rows, type new reinforcement or a cover note, immediately Ctrl+X/Ctrl+V the R.C beam schedule, then CSRCBEAMSCHEDULE. The new entry survives and there is no stale-copy replacement line.
3. **Z preview:** SBEAM, select a Z purlin and section view. Compare preview and placed section: a flange each side, a lip on each flange, no crossing. Measure overall width: twice the supplied flange width minus thickness. One U removes it; REDO restores it; save/reopen preserves it. Repeat on AutoCAD 2027 and the 2024/net48 lane. This session does not launch either.

## Validation and handoff

1. **Build safety:** every build/test command must include `-p:SkipDevBundle=true -nr:false --disable-build-servers`; reference paths follow the C-57 assembly report (`_AcadRef48` 2024 refs; `_AcadRefNet8` 2026 refs; `_AcadRefNet10` and `_AcadRef100` 2027 refs). C: began at 13.57 GB; stop below 12 GB. Shared build lock is currently busy.
2. **No product edits:** new test files and a top entry in REGRESSION_LOG.md only. BUG_CARPARK.md, DESK_LOG.md, QUEUE.md, settings and installation folders are untouched.
3. **Undo:** revert this draft's test commit; no installed files need restoring.