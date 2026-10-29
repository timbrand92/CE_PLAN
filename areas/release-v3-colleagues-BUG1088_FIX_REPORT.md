# B-020 BUG-1088 fix report: the pipe sizer uses the flattest allowed grade and steps up a size before going steeper

Fri 30 Oct 2026, 03:20 (Melbourne), CE 01 Build, headless job. Worktree `C:\ce-fx\c78c`.

## ANSWER FIRST

1. **PR:** #1863, DRAFT, `fb/bug1088-sizer-grade-ladder` into `claude/gb01-slice1-falls` (CE 10's GB-01 slice 1, B-042, commit bf2dd0c4 plus 78fda55b), as the brief asked. Slice 1 must merge first. Not marked FIXED.
2. **NOT COMPILED, NOT TESTED.** No build slot came free on this PC from 20:08 on 29 Oct to 03:10 on 30 Oct. Other lanes held it the whole time (c78h ran tests back-to-back with gaps shorter than the one-minute check). That is more than twice the 3-hour wait limit. So nothing in this PR has been built on net10 or net48, and none of its tests has run. The PR title, the commit and the REGRESSION_LOG entry all say so.
3. **What a drafter will see differently:** CDDESIGN's connection pipe and network redesign / Run solve stop proposing very steep small pipes. A 40 L/s connection comes out **DN225 at 1 in 100**, not DN100 at 1 in 3.
4. **My own mistakes, first:**
   1. My first wait scripts ran as background tasks, and the tool stopped them at their 30-minute and 2-hour limits. Each time I restarted the wait. Cost: none to the work, but the wait restarted three times.
   2. My first version also changed Edit Pipe's size-for-flow strip and the Project Review size proposals. Those share the same sizer. Before anything ran, I narrowed the switch to the two designers Tim named.
   3. I gave up on a build slot rather than break the "count must be 0" rule. So this lane delivers code that nobody has compiled.
5. **NOT proven:** that it compiles; that any test passes; anything in AutoCAD; the CDDESIGN window; the computations sheet; network redesign preview.
6. **Robot case:** `N88_sizer_grade` / `C88` (details at the end).

---

## FOR TIM

1. **What changes:** when CE picks a pipe size for you, it now starts with the flattest fall each size is allowed. It goes up a size before it makes a pipe steeper. Today it squeezes the flow into the smallest pipe at any fall, even 1 in 3.
2. **Where you will see it:**
   1. **CDDESIGN, "CONNECTION PIPE" section of the result and sheet:** Diameter and Grade lines.
   2. **Run solve (CDRUNSOLVE) and network redesign preview:** the pipe sizes and grades they propose.
   3. **No change:** Edit Pipe's size-for-flow strip, Project Review pipe-size proposals, CDRULES and CDCHECK. These check the pipe you drew, so they keep today's sizing.
3. **Worked example (40 L/s UPVC connection pipe, 10 m, the Settings length):**
   1. **Before:** Diameter 100 mm, Grade 1:3 (1 in 2.8). It runs at 5.1 m/s and falls 3.55 m in 10 m.
   2. **After:** Diameter 225 mm, Grade 1:100. It runs at 1.47 m/s, carries 58 L/s, and falls 100 mm in 10 m.
   3. **Why 1 in 100 and not your 1 in 200:** your guidebook ruling (slice 1) made 1 in 100 the flattest fall at every ordinary size, so DN225's flattest allowed fall is now 1 in 100.
4. **Other flows (UPVC):**
   1. 25 L/s gives DN225 at 1 in 100 (was DN100 at about 1 in 7).
   2. 100 L/s gives DN300 at 1 in 100 (was DN150 at about 1 in 4).
5. **Pipes 450 mm and up:** no minimum fall is set for them yet (the blank Settings row from slice 1). CE sizes them at the fall the flow needs, as today.
6. **If no size works at its flattest fall**, CE still gives a design (today's answer). Nothing blocks.
7. **Your rulebook check (R-01, UPVC 3.0 m/s):** it does NOT reach CDDESIGN or network sizing. They use the general 6 m/s limit. Even at 3.0 m/s, 40 L/s would come out DN150 at about 1 in 24, so R-01 alone would not have fixed this. I left that as it is.
8. **Off switch:** Settings file, `designStandards`, `sizerStepsUpBeforeSteepGrade` false, then restart AutoCAD. It is not on the Settings page yet.
9. **Test in AutoCAD (after a lane has built and tested it, on a copy):** CDDESIGN on a job whose connection flow is about 40 L/s. Right looks like: Diameter 225 mm, Grade 1:100.

---

## TECHNICAL DETAIL

1. **Cause, confirmed on the shipping line `origin/claude/rel-20261026z` (Civil 3.0.85):** `Services/PipeSizingSolver.cs` `TrySize` (lines 52 to 97) loops sizes smallest first. It returns the first one `TryDiameter` (209 to 292) finds feasible, at the grade the flow needs, clamped only to 1 in 1 (`GradeFloorN`, line 39) and the speed cap. The carpark's 3.0.72 lines 131/136/168-186 moved there. `PipeSizingSolver.cs`, `AutoDesignService.cs` and `NetworkDesignService.cs` are identical on the rel branch and on slice 1. `SettingsSizingStandards.cs` differs by one line (slice 1's comment). The callers are `AutoDesignService.SizeConnectionPipe` (TrySize at line 686, carpark 656-680) and `NetworkDesignService.Design` (sizing at 297, re-check at 546; carpark 290).
2. **R-01:** `SettingsSizingStandards.ForEveryMaterial` (lines 97 to 105) sets `MaxVelocityMs = office.MaximumPipeVelocity` (6.0) for every material. `PipeSizingStandards.CreateDefault()` uses it, and so do CDDESIGN, Run solve, network redesign (`NetworkRedesignSolverService` calls `NetworkDesignService.Design`) and the CDDESIGN window (`AutoDesignOrchestrator`). R-01's per-material figure is read only through `ForMaterial` (Edit Pipe, CDRULES, `MaterialVelocityLimits.BuildStandards` in `PipeSizeNetworkReviewService`).
3. **Change:**
   1. New overload `TrySize(request, standards, bool stepUpBeforeSteepGrade)`. When ON, a first pass takes the smallest size whose `TryDiameter` result is feasible AND not steeper than that size's minimum grade (`SizerGradeLadderRule.IsAtFlattestAllowedGrade`). `TryDiameter` already steepens a flatter grade up to the minimum, so an accepted size sits exactly at its minimum.
   2. A size with no minimum (0 or NaN) counts as Unknown and is accepted as before. If no size passes, the old loop runs unchanged. The two-argument `TrySize` passes false, so all other callers are untouched.
   3. `AutoDesignService.SizeConnectionPipe` and both `NetworkDesignService` calls pass `SizerGradeLadderRule.IsOnNow()`. Network reads it once per Design, so the sizing and the re-check agree; otherwise REVAL_DIAM would flag every changed pipe.
4. **Switch:** `DesignStandards.SizerStepsUpBeforeSteepGrade`, JSON `designStandards.sizerStepsUpBeforeSteepGrade`, "Default: on.", placed next to `networkUsesPipeMaterial` (the nearest sizing convention; there is no `sizing` group). An unreadable Settings file reads ON (try/catch in `IsOnNow`). It is excluded from the CDRULES criteria fingerprint (`RulebookValues.FingerprintContractResolver`), like `networkUsesPipeMaterial`. There is no Settings page row (window lane).
5. **R-00:** no new figure. The flattest grades are the existing `minGradeByDiameter` rows read through `EffectiveMinGradeLadder()`, and CDDESIGN reads only DN90 to DN375 (`StandardGradeSizesMm`). Nothing is hard-coded. DN450 entries were not re-added.
6. **REDO-safe:** no drawing write, command, regen, view or system variable. The rule file only reads Settings.
7. **Tests written (`Bug1088SizerGradeLadderTests`, NOT RUN):**
   1. The bug's own numbers ON and OFF.
   2. 5, 15, 25 and 100 L/s: each the smallest size that works at 1 in 100, and the next size down would need a steeper grade.
   3. 300 L/s: steps to DN450 (no minimum) at the grade the flow needs.
   4. The fall-back, and the too-big-flow reason unchanged.
   5. Switch OFF equal to the old rule written independently (first single-size feasible), over 24 flows and three materials.
   6. ON with no minimum grades equal to OFF; ON never smaller or steeper.
   7. CDDESIGN `SizeConnectionPipe` (by reflection) and a one-pipe `NetworkDesignService.Design`, both ON and OFF.
   8. The two-argument call unchanged whatever the switch, plus source pins on the three call sites.
   9. Switch default ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes; typed false and true read as typed and leave every other `designStandards` value alone; the fingerprint is unchanged; a source guard on the rule file.
   10. **Risk noted:** `TheSwitch_TypedValue_IsRead_AndTouchesNothingElse` compares every DesignStandards property by JSON. If one is not deterministic on load, it will need narrowing.
8. **Not done:** C75NewSwitchDefaultsTests was not edited (the default is pinned in the new file). No Settings row. Edit Pipe's strip is not switched (Tim named CDDESIGN and network redesign).

## Robot case

1. **Name:** `N88_sizer_grade` (Civil), control `C88`.
2. **N88 (switch ON, default):** on a fixture copy, run CDDESIGN on a site whose minor (connection) flow is about 40 L/s. Read the "CONNECTION PIPE" section of the result text. Pass = "Diameter" line `225 mm` and "Grade" line `1:100`. Fail = `100 mm` / `1:3`.
3. **C88 (switch OFF control):** before launching AutoCAD, set `designStandards.sizerStepsUpBeforeSteepGrade` false in the copy's settings (CE reads settings at start-up). Run the same CDDESIGN. Pass = `100 mm` / `1:3`, proving the switch alone makes the difference.
4. **Not known:** which fixture gives exactly 40 L/s; the case writer should pick a site and record its minor flow. The check reads the two lines, not the flow.

---

## BUILD AND TEST (B-020b, Fri 30 Oct 2026, 03:20 to 08:27 Melbourne; worktree `C:\ce-fx\c84a`, head `30990e61`, no new commits)

### FOR TIM

1. **Answer:** the sizer change now compiles, and its own tests pass. The full test run and the older-AutoCAD (net48) compile did NOT run: no build slot came free in the 3-hour wait.
2. **What a drafter sees:** nothing new yet. Same as above: CDDESIGN connection pipe comes out DN225 at 1 in 100 for 40 L/s.
3. **Not tried in AutoCAD.** The proof is robot case `N88_sizer_grade` with the switch-off control `C88` (see above).
4. **PR #1863** is still a draft; the title and description now say "built net10 + focused tests only". Nothing closed, merged or marked FIXED.
5. **My own mistakes:** my first wait script had a mangled dotnet path (a sed edit ate the backslashes), and a second quoting fault on the AutoCAD 2027 path (spaces). Each cost one wait cycle (about 40 minutes of queue time). No effect on the code.

### TECHNICAL DETAIL

1. **What compiled:** `CE_CVL_SUITE.Tests.csproj`, Release, net10.0-windows (this also builds the Drainage plugin for net10). 0 errors. Flags: `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD refs from the C-62 report, AutoCAD 2027 on PATH, below-normal priority.
2. **Focused tests (net10, Release):** filter `Bug1088 | C75NewSwitch | Gb01Slice1`: **Total 72, Passed 72, Failed 0, Skipped 0.** The count is not zero. This includes `Bug1088SizerGradeLadderTests` (24 test attributes in the file; theory rows expand), the switch default through both start-up reads, and the slice 1 falls tests. The note's "risk" test (`TheSwitch_TypedValue_IsRead_AndTouchesNothingElse`) passed, so no narrowing was needed.
3. **No fix commits were needed.** No code, switch default or behaviour changed. The branch is still at `30990e61`.
4. **NOT run:**
   1. **Full Civil suite (net10, Release):** queued from 05:26 to 08:27, never got a slot (other lanes held two or three top-level dotnet commands the whole time; the count was 2 or 3 at every check). The 3-hour limit ended it. Not run, so the two Debug-only `SourceAtomicCoordinatorDependencyTests` failures were not seen here and were not touched. They are not this change.
   2. **net48 compile:** not run (needs a slot after the full suite).
   3. **Manager tests:** not in scope.
5. **Still unproven:** anything in AutoCAD (CDDESIGN window, result text, sheet, network redesign preview, Run solve); the full-suite effect of the switch default ON on other tests (for example, tests elsewhere that size a pipe through `NetworkDesignService.Design` or CDDESIGN and expect the old size). That is the main residual risk: only the full run can show it.
6. **For the next lane:** run `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -c Release -f net10.0-windows --no-build` (the test bin is already built at head `30990e61` unless cleaned; I ran `git clean -fdXq` in `C:\ce-fx\c84a`, so it must be rebuilt), then the net48 compile of `Modules\Drainage\CE_CVL_SUITE.csproj`.
7. **Hygiene:** worktree `C:\ce-fx\c84a` cleaned of bin/obj, detached at `30990e61`; scratch in `C:\ce-fx\b020b\` (count.ps1, waitrun.ps1, logs). Settings files, bundles and ProgramData untouched. AutoCAD not started.

Four words: **built (net10) and focused-tested. Full suite and net48 not run. Not installed. Not Tim-accepted.**
