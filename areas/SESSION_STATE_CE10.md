# SESSION STATE: CE 10 (guidebook builder, GB-01 to GB-05)

Last saved: Wed 4 Nov 2026, 09:47 Melbourne time. Latest state only (overwritten each save).
Session: "CE_ACAD / Guidebook / GB-01 to GB-05 build / 10". Started by CE 00/CE 06 (local_1ec60a66-36b4-471b-8752-6be986ab2222). Questions chat: local_670b1ff9-0cc3-488c-af9b-3bd7101d4daa.
No recurring check-in is running (map rule 11).

## Where the work lives
1. **Worktree:** `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\ce-acad-tim-desk-d44f6a` (never the main checkout). Module: `Modules\Drainage`. Now on `claude/gb01-slice3-pit-depth`.
2. **Base:** release branch `claude/rel-20261026z` (installed Civil 3.0.85 at 09126560).
3. **Build rules:** every dotnet command needs `-p:SkipDevBundle=true -nr:false --disable-build-servers`; net10 tests need AutoCAD 2027 on PATH; net48 needs `-p:_AcadRef48="C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs"`; max two top-level dotnet commands PC-wide. Nothing installed or deployed by me.

## PRs (all open draft, all CLEAN at last check, 4 Nov)
1. **#1841** GB-01 slice 1 falls (branch `claude/gb01-slice1-falls`; do not force-push or rebase it, CE 01 asked).
2. **#1842** slice 2/related (stacked on #1841).
3. **#1843** slice 4 lid class and garages; based on #1842's branch (merge via #1849's branch or retarget).
4. **#1849** (stacked), **#1850** slice 2 cover table (B-012b merged in), **#1851** slice 3 min pit depth (contains #1850), **#1854** GB-02 part A council data, **#1855** GB-03 soakage engine.
5. Slice 5 (pit size by depth) is inside the stack. Related CE 01 PRs: B-012 #1848, B-017 #1852, B-042 #1841, B-044 #1842, B-053 #1854.

## Tim's words this stretch (also in C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md)
1. "Yes, build it": garages, closed outline on a layer named once in Settings; none drawn = Unknown (item 113).
2. "Keep as built": cover rows Garden 300, Footpath 100, Driveway 100, Driveway (larger vehicles) 450, Road 600; single office 300 when a pit has no surface.
3. "Keep the draft" (4 Nov 2026, QUESTIONS 60, item 222): paved cover is measured below the slab (100 + slab thickness, Settings, 100 mm start); a council's cover figure is a floor (bigger of council and table). Built; no longer Assumed. Questions session told to mark item 60 ANSWERED.

## Built / tested (two figures, never merged)
1. **GB-01 slices 1 to 5:** built, pushed. Tested by unit tests only (cover/rulebook 259 pass, 64 targeted pass after last wording change). Full suite and net48 NOT re-run after the Q60 wording change. Two unrelated full-suite failures seen (SourceAtomicCoordinatorDependencyTests, IL-shape), not compared to base.
2. **GB-02 part A** (council data) and **GB-03 slice 4** (soakage engine): built, unit tested.
3. **Tim-accepted:** none. Nothing is accepted until Codex or Tim sees it in real AutoCAD. Codex steps are in `C:\CE_PLAN\PENDING_TESTS.md`.

## Open flags (not bugs fixed)
1. Edit Pipe strip does not know a pipe is detention; only CDRULES applies the 1:200 allowance.
2. Other cover screens (Edit Pipe strip, Civil Design, auto-design, pit editor) still read the single office 300 until CE 01's B-022 (BUG-903); they should use `RulebookValues.MinCoverFor`.
3. Wall table ships only UPVC 225 and concrete 375; engineers supply other walls.
4. Garage outline reader never run in AutoCAD; every job shows two Unknown R-33 rows until layers are named.
5. Settings window rows for all the new Settings values are still needed (separate window work).
6. Soakage open engineering points: worst storm 180 min 25.766 m3 vs highlighted 2-hour row 25.348 m3; moderation factor applied as a multiplier.

## Still to build, in order
1. **GB-03 remaining:** pump sheet (slice 3; touches `PumpSizingService.cs`, also B-017, so ask CE 01 first; book example 6.92 m3; Bayside 1-in-20 rule goes unless sourced; 3 m3 review flag R-14), sheet layout, rainfall choice for new Boyd's jobs (new jobs only), collated package, and the window/printed page that calls `SoakageSweepService`. Tell CE 01 if GB-03 touches PipeSizingSolver.cs or the sizer (B-020).
2. **GB-02 parts B to D:** Design start questions (Banyule 65% trigger, rear-fall question, Banyule dual underground warning), per-council submission details and the job recording its guidebook version, industrial stub test. Waiting on CE 01's B-029 PR number to stack on.
3. **GB-04** (ready to submit) and **GB-05** (Claude assistant; needs the 22 Oct privacy fix first): not started. GB-06 on hold.

## Waiting for, and from whom
1. **CE 01:** B-022 PR number, B-029 PR number; assemblers to merge PRs into trains (C-77/C-79/C-80).
2. **Tim/Codex:** AutoCAD acceptance of every slice.

## First action after compaction
1. Read this file, then `C:\CE_PLAN\areas\CE_SESSIONS_MAP_29OCT.md`.
2. Run `gh pr list` for the eight PRs; check any conflict events with `gh pr view` before acting. Then ask CE 01 about `PumpSizingService.cs` overlap before starting the GB-03 pump sheet.

## My own mistakes this stretch
1. Card example "70 mm in 18 m newly warns" was wrong (warned already under 1:250); used 90 mm and corrected the card.
2. A script swallowed one `if` line in `MinCoverFor`; restored before testing, diff verified wording-only.
3. A real job address sat in a test comment and the leak scan stopped a push; removed, amended the unpushed commit, zero hits in pushed history.
4. Removing the size ladder briefly dropped DN450+ from the Project Review sizer; caught by tests and fixed.
