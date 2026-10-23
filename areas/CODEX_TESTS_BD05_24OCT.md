# BD05 — Pit Schedule, LandXML and survey regression tests — 24 October 2026, Melbourne

## ANSWER FIRST — IN PROGRESS

1. **Tests written:** 10 cases: BUG-703 two, BUG-704 two, BUG-783 four, BUG-604 two. Compilation and execution pending; do not count these as passes.
2. **Branch:** `cx3/tests-bd05`, private worktree `C:\ce-cx\bd05`, base `origin/claude/rel-20261023m` at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. Draft PR pending.
3. **What changes for a drafter:** no product, drawing, setting, default or window change. These checks protect existing fixes.
4. **New findings:** none established yet. Existing helper coverage was found for most candidate bugs; this job targets gaps between those helpers and the reading or refresh result.
5. **Not run yet:** builds, focused/full suites, historical red proof and AutoCAD. AutoCAD, accoreconsole, installation and deployment will not run in this task.

---

1. **Audit:** read the Civil-B and Civil-L area files, BUG_CARPARK.md and REGRESSION_LOG.md; searched bug numbers and behaviour in Drainage.Tests. Read CODEX_TESTS_BD01..04_23OCT.md and the four open cx3 PRs (#1702..1705). Skipped BUG-798 continuation text, BUG-999 duplicate-name ordering and all other first-wave cases.
2. **Coverage gaps:** BUG-703 already tests matching and an entirely ambiguous transform, but not a solved transform mixing repeated and unique levels. BUG-704 already checks triangle counts/corners, but not the ground-level query on the lost half winning over a wrong nearest spot. BUG-783 checks refresh for Cover, but not the four pipe diameter/invert columns. BUG-604 checks hand-created review rows, but not XML parsing through to review with known zero/below-zero cover levels. These bugs have partial prior coverage; they are not claimed wholly untested.
3. **Historical proof planned:** copy only the new test fixture to a detached private worktree at `d36f9545e1de00f9c48bd90e8cec0206269a65c2`, before the four fixes. No historical product source will be edited. Reflection permits the same fixture to invoke the older private raw-face reader and the two-argument review-row method.
4. **Safety:** initial C: 22.18 GB free. Stop under 14 GB. Every build/test uses `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the C-57 reference paths. Shared build lock held only during dotnet; foreground execution. Main checkout and other chats' uncommitted files left untouched. No product code, restricted files, BUG_CARPARK.md, DESK_LOG.md or QUEUE.md edited.
5. **Ownership:** only `Modules/Drainage.Tests/Services/Bd05ScheduleImportSurveyRegressionTests.cs`, the top REGRESSION_LOG.md entry and this named report. All test settings and XML fixtures are private temporary files. BUG-604 also renders the real import window source/results pages at 96 dpi in dark/light; images and inspection are pending validation. No client data.
6. **Exact real-AutoCAD check (for a separately authorised runner, not Tim):** in 2027 and 2024 on disposable copies, CDSURVEY a raw four-corner face with corners (0,0,10), (10,0,11), (10,10,12), (0,10,11); a ground-level query at (2,8) must use TIN RL 11.000 rather than a nearby wrong spot RL 99.000. Repeat survey alignment with three unique RL controls and two repeated RLs in reversed order; the unique controls must determine the translation (1000,2000). In Pit Schedule delete inlet/outlet diameter and invert cells, refresh and save/reopen: all stay blank while pipe levels stay unchanged. CDIMPORTLANDXML two synthetic metre files with P1 cover 0.000 and -0.350: review must name the LandXML file and preserve each sign. Native writes, blank-cell UI route, Undo/Redo and drawing persistence remain unproven here.
7. **Undo:** revert the BD05 tests commit. No installed files are involved.
8. **Notion:** Hub Inbox queried for New items: none returned on 24 October 2026.
