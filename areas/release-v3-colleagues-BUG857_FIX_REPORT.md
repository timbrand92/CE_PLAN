# BUG-857 fix report (B-023), Thu 29 Oct 2026

## FOR TIM

1. **Answer:** the fix is written and pushed as DRAFT PR #1858, but it has NOT been compiled or tested. I waited three hours for a build slot (20:45 to 23:51) and other jobs held both slots the whole time, so I stopped rather than break your two-build limit.
2. **What a drafter will see (once built):** in the New Pipe window, the "Grade mismatch" box gets a third button, Cancel. Esc and the X in the corner now mean Cancel: no pipe is placed and the command line says "[CE] Grade mismatch box cancelled - no pipe placed. Run CD again to place it (nothing was changed)." Enter still keeps the typed grade.
3. **Worked example:** type CD, Custom 1 IN 100, inverts 18.000 and 17.900, 20 m, press Start Pipe. The box says the inverts give about 1 IN 200. Before: click the X and the pipe appeared at 1 IN 100. After: click the X and nothing is drawn.
4. **My own mistakes first:** I lost the whole job to waiting; I also could not run the unit tests, so every claim below about behaviour is "written", not "proven". The earlier attempt of this job left the code in the worktree and I reviewed it by reading only.
5. **Switch:** `grade.mismatchBoxCloseCancels`, ON by default. Set it false (and restart AutoCAD) to get the old box back exactly. This is your 25 Sep ruling "Enter = Apply, Esc = Cancel". Nothing is blocked; the drafter just runs CD again.
6. **What is NOT proven:** that it compiles (net10 and net48), that the new tests pass, the full suite, and anything in AutoCAD. This is a window, so it needs a Codex look.
7. **Robot case proposed:** N33_grade_mismatch_x (switch-off control: N33_grade_mismatch_x_off with grade.mismatchBoxCloseCancels false before launch). It types CD, Custom 1 IN 100, inverts 18.000 / 17.900, 20 m, Start Pipe, then closes the box with Esc. It checks the command line contains "Grade mismatch box cancelled" and the drawing has no new pipe. The switch-off control checks the opposite: a pipe with grade 1 IN 100 is placed.
8. **Codex look needs:** (a) the box with three buttons and the line "Cancel (or Esc, or the X) places no pipe." readable, not clipped; (b) the X click leaves no pipe; (c) Enter keeps the typed grade; (d) switch false shows the old two-button box.

## Technical detail

1. **Cause:** `Modules/Drainage/Commands/CdCommand.cs` (about line 586, inside `ExecutePipeDrawing`) read only `mismatchResult == true && mismatch.UseActual`; any other close fell through and drew the pipe. `Dialogs/GradeMismatchDialog.xaml` bound Esc to `KeepTypedCommand`.
2. **Change:** new `Rules/GradeMismatchChoiceRule.cs` (enum, `IsOn`, `WhenDismissed`, the command line text); dialog takes `closeCancels` (default false) and exposes `Choice`; caller returns false on Cancel before the pipe is built (caller then also prints "Pipe drawing cancelled"); `UserSettings.cs` Grade group gets `MismatchBoxCloseCancels = true` ("Default: on."). No Settings page row (the reference switches have none); not added to C75NewSwitchDefaultsTests (that file is C-75 only); the new `Bug857GradeMismatchBoxTests` pins the default through `DeserializeSettings` and `DeserializeSettingsTolerant`.
3. **Branch and PR:** fb/bug857-grade-mismatch-box, commit on base claude/rel-20261026z, DRAFT #1858. REGRESSION_LOG.md entry added at the top. CE_SHARED untouched. No AutoCAD started.
4. **Next steps:** build net48 and net10 (focused: `FullyQualifiedName~Bug857`), full suite once, then Codex look.

## BUILD AND TEST (B-023b, Fri 30 Oct 2026)

### FOR TIM

1. **Answer:** the fix now compiles and its own tests pass. Still nobody has seen it in AutoCAD, so it needs the Codex look and the robot case N33_grade_mismatch_x.
2. **Built:** Civil net10 (Windows) compiled with 0 errors. Civil net48 compiled with 0 errors (242 warnings, all existing kinds).
3. **Tests, new ones:** the 9 BUG-857 tests all passed (they pin the switch default through both start-up reads, the Cancel/Esc/X rule and the switch-off old behaviour).
4. **Tests, whole suite:** 20,815 tests, 20,782 passed, 32 skipped, 1 failed. The failure is `WorkQueue_DrainGivesUpAtTheTimeout` (the message bell's background queue, a timing test). My change does not touch that code. It also failed when re-run alone. I did NOT build the base to prove it fails there too, so I cannot say it is old.
5. **My own mistakes first:** two of my waits were cut off by the 30-minute background limit and I had to restart them; a build slot was unavailable for about 3.5 hours in total. No code was changed by me: the branch needed no fix, so there are no new commits.
6. **Changed on the PR:** title only (no longer says unbuilt). It is still a DRAFT.
7. **Still unproven:** everything in AutoCAD (three buttons readable, X leaves no pipe, Enter keeps typed grade, switch false gives the old two-button box); Manager and Structural not run; Release solution build not run.

### Technical detail

1. **Worktree:** C:\ce-fx\c83a, detached at c92db9ad (the PR head; the branch name is checked out in another worktree, c79a). Nothing committed or pushed to the branch.
2. **Commands (Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below-normal, AutoCAD refs per the C62 report, AutoCAD 2027 on PATH):** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -f net10.0-windows --filter FullyQualifiedName~Bug857` gave Passed 9, Failed 0 (count not zero). Then the full net10 test with `--no-build`: Passed 20,782, Failed 1, Skipped 32, Total 20,815, 46 m 46 s. `dotnet build Modules\Drainage\CE_CVL_SUITE.csproj -f net48`: 0 errors, 242 warnings.
3. **The one failure:** `CeMessageCentreTests.WorkQueue_DrainGivesUpAtTheTimeout` (line 710: `Drain(50 ms)` expected false, was true). The fixture also logged a TearDown IOException on CE_CVL_SUITE.log being in use. The diff against the base touches none of `Core/Messages`. The C62 report had 0 failed on the train, so it may be load- or machine-dependent; not checked.
4. **Logs:** C:\ce-fx\b023b\focus.txt, full.txt, rerun.txt, n48.txt.
5. **Robot case:** unchanged from above, N33_grade_mismatch_x with control N33_grade_mismatch_x_off.
