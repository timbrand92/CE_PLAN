# B-011: the two small extras of #1788 (comma figure refused; unset material speed takes the office figure)

Thu 29 Oct 2026, written 23:20 Melbourne. Draft PR **#1857** (branch `fb/1788-extras-comma-and-speed`, base `claude/rel-20261026z`, commit 09a6d1b8).

## FOR TIM

1. **Answer first:** both extras are written, but **nothing has been compiled or tested.** For three hours another job's test run held the single build slot, so I never got to build. The PR is a draft, titled "NOT YET COMPILED". It must not go in a train until the tests are run.
2. **What a drafter will see (comma):** in New Pipe or Edit Pipe, type 630,5 in the Diameter box. Start Pipe (or Save) goes grey and the line under the window reads "Diameter box: 630,5 has a comma: type 630.5". Fix the box and the button comes back. The same goes for the level boxes and a detention pipe's Required length. A figure like 1,200 is not guessed: the line gives both readings.
3. **What a drafter will see (speed):** if a material has no speed set in Settings (blank or zero), CDRULES now checks that pipe against the office figure from Settings, with no new message. Before, it wrote "no scour cap in the rulebook" and did not check the pipe at all.
4. **My mistakes first:** (a) an earlier attempt of this job, which I continued, had decided extra 2 was "already built". That was only half true: the Inspector, audit and design checks already fell back, but only when `useMaterialLimit` is ON, and it ships OFF. CDRULES had no fallback, so I built that; (b) I wasted three hours of wall-clock time waiting for a slot; (c) PR #1788 itself holds only the outbox code. The extras were never in its diff, so I rebuilt them from Tim's description.
5. **Not proven:** that it compiles, that any test passes, and anything in AutoCAD. Other boxes that still read a comma as a thousands mark are not covered: pit windows, CDCALC and the other calculators, the Inspector, and the grade box.
6. **Switches:** two, both ON. Undo: set either to false in the Settings file (before AutoCAD starts), or revert the commit.

## Robot cases (for CE 02)

1. **N40_comma_refused** (control **N40_comma_refused_off**): open CD, type `630,5` into the Diameter box. The line under the window must read `Diameter box: 630,5 has a comma: type 630.5` and Start Pipe must be disabled. Then type `630.5`: the line reads `Ready to start the pipe.`. Control: set `pipe.boxRefusesCommaFigure` to false before AutoCAD starts. The same typing leaves Start Pipe enabled and shows no comma sentence.
2. **N41_unset_speed** (control **N41_unset_speed_off**): in Settings set the UPVC speed limit to 0 before AutoCAD starts. Draw one 300 mm UPVC pipe at about 8 m/s (10 m long, 1.5 m fall), then run CDRULES. The Maximum (scour) velocity row must read Warn, "full-bore ... m/s exceeds the UPVC cap 6.0 m/s", not "no scour cap in the rulebook". Control: set `pipeSpeedChecks.unsetMaterialUsesOfficeFigure` to false and the row reads Unknown, "no scour cap in the rulebook".

## Technical detail

1. **Extra 1 entry point:** `Modules/Drainage/Rules/PipeStartReadiness.cs`, `FirstBlocker` then `FirstCommaFigure`. This is the one readiness answer that the CD window and CDEDIT (`CdViewModel(editMode: true)`, `CdViewModel.cs:190`) both read for the button and the line. The sentence is built in the new `Rules/TypedFigureCommaRule.cs`. Only the boxes the pipe uses are checked: a simple pipe has no levels, the "work the other out" box is filled by CE, and length is read only for a detention pipe. The switch is `pipe.boxRefusesCommaFigure` (`UserSettings.cs`, "Default: on.").
2. **Extra 2 entry point:** `RulebookEngine.cs` scour rule calls the new `RulebookValues.ScourVelocityForCheck(material, switch)`. It falls back to `ScourVelocityDefaultMs` (the office figure, `DesignStandards.MaximumPipeVelocity`) when the material's own figure is not set. The old `ScourVelocityFor` is untouched, so `MaterialCheckLimitMs` and the existing `PipeSpeedProductionPathTests` contract (null for a zero figure) are unchanged. Switch: `pipeSpeedChecks.unsetMaterialUsesOfficeFigure` (`PipeSpeedChecksSettings.cs`), read in `RulebookEngine.UnsetMaterialSpeedUsesOfficeFigure()` with unreadable settings reading ON.
3. **Tests written, not run:** `TypedFigureCommaTests` (sentences, each box, OFF returns the old answer, both start-up reads, source guard) and `UnsetMaterialSpeedFallbackTests` (fallback, OFF, a set figure untouched, no office figure stays not set, engine ON/OFF, both start-up reads, source guard). I did not add the switch to `C75NewSwitchDefaultsTests`, because those tests pin C-75 only. The new files pin their own defaults.
4. **Risk to check when compiled:** the `RulebookEngine` helper sits in the same static class as the scour rule (line numbers differ by about 300). I did not confirm this by compiling. The `TypedFigureCommaTests` source guard uses `TestPaths.SourceFile`, which exists in the test project. A unit test that sets `SettingsService.Current` leaves the switch as found (TearDown).
5. **Still to do on this PR:** the net10 focused tests (check the count is not 0, AutoCAD 2027 on PATH), the full suite once, the net48 compile, all with `-p:SkipDevBundle=true -nr:false --disable-build-servers`. The worktree is `C:\ce-fx\b1788x` (bin/obj not yet created, nothing to clean). CE_SHARED not changed; no layer unlocked; no write, regen, view or variable change.
6. **Wait log:** the slot checker (`C:\ce-fx\b1788x_scratch\slot.ps1`, top-level dotnet build/test count) reported 1 or 2 from 20:12 to 23:14; the holder was another job's `dotnet test Modules\Drainage.Tests ... net10.0-windows` (started 20:33).

## BUILD AND TEST (B-011b, Fri 30 Oct 2026, 20:10 Melbourne)

### FOR TIM

1. **Answer first:** PR #1857 now compiles and passes its tests. No code change was needed, so the branch is untouched (still commit 09a6d1b8). The "NOT YET COMPILED" warning in the PR title can go. It is still a draft and has not been tried in AutoCAD.
2. **Results:** the 26 new tests for the comma refusal and the unset-speed fallback pass. The whole Civil suite passes: 20,800 passed, 0 failed, 32 skipped (the usual skips). The AutoCAD 2024 build (net48) compiles with 0 errors.
3. **My mistakes first:** (a) my first two launcher scripts started nothing, and a third built the main checkout instead of my worktree. That cost about 90 minutes of queue time, and it left ignored build folders (bin/obj) in `C:\Lisp Files\CE_ACAD_PLUGIN`. Nothing tracked changed there. I did not delete them because they are not all mine. (b) About 4 hours were spent in the build queue, behind other jobs' tests.
4. **Not proven:** nothing has been seen in AutoCAD. The two robot cases above (N40_comma_refused, N41_unset_speed, each with its switch-off control) still need to run. The PDF page test passed in the full run (no re-run needed).

### Technical detail

1. **Worktree:** `C:\ce-fx\c87a`, detached at origin/fb/1788-extras-comma-and-speed (09a6d1b8), because the branch is already checked out in `C:\ce-fx\b1788x`. No commit and no push were needed. bin/obj cleaned with `git clean -fdXq` there.
2. **Focused (net10.0-windows, Release):** `TypedFigureCommaTests` + `UnsetMaterialSpeedFallbackTests`: Total 26, Passed 26. Count is not 0.
3. **net48 compile:** `Modules\Drainage\CE_CVL_SUITE.csproj -f net48 -c Release`: 0 Error(s) (refs `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`).
4. **Full Civil suite once (net10.0-windows, Release, 19:48 to 20:07, 18 m 40 s test time):** Failed 0, Passed 20800, Skipped 32, Total 20832.
5. **Flags:** every command used `-p:SkipDevBundle=true -nr:false --disable-build-servers`, BelowNormal priority, AutoCAD 2027 on PATH, 0-byte placeholder `CE_TRANSFORM_2027.arx`, a fresh TEMP and log folder per step. Slot checker waited for under 2 top-level dotnet commands.
6. **Unproven:** the "risk to check when compiled" in item 4 above is resolved (the `RulebookEngine` helper compiles and its tests pass). Full-suite was not run on net48 (net48 test lanes do not load). Release-only; no Debug build. Nothing driven in AutoCAD. No bundle, settings file or ProgramData touched. CE_SHARED unchanged.
