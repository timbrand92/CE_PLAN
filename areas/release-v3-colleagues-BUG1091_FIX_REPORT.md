# BUG-1091 fix report (build B-019, Thu 29 to Fri 30 Oct 2026)

## FOR TIM

1. **Answer:** the fix is written and is a draft PR, **#1868**, but it is **NOT built and NOT tested yet**. For about 10 hours both build slots on this PC were held by other jobs' full test runs, so mine never got a turn. Do not merge it until a build has run.
2. **What a drafter will see differently (once it is built and merged):** you type a minimum fall for pipes DN450 and larger (for example 1 in 200). Civil Design, auto-design and the network redesign now hold a 450 to that fall, the same as the Edit Pipe strip and CDRULES. Today redesign still proposes about 1 in 890 for a 450 carrying 30 L/s. A blank row changes nothing ("No minimum fall set for this size").
3. **Mistakes of my own, first:**
   1. I ran my first test attempts with `dotnet` not on this shell's path, so they exited instantly with an empty log. I took the empty log for "still waiting". That cost about four hours before I saw it (02:12). The memory note about this already existed.
   2. I started the first waits in a way that the tool killed after 30 minutes and then after 2 hours; each restart began the queue again.
4. **What is NOT proven:** everything. No build, no test run, no net48 compile, nothing in AutoCAD. The code was read-checked only. I expect it to compile but have not seen it.
5. **Robot case to prove it (with a switch-off control): `C78_redesign_min_fall`.**
   1. Setup: Settings, large-pipe minimum fall = 200. A copy with a DN450 concrete pipe carrying 30 L/s.
   2. Types: run Civil Design on the network. Reads the proposed grade for the 450 line: must read 1 in 200 or steeper (the Edit Pipe strip on the same pipe reads the same minimum, 1:200).
   3. Control: set `pipe.largePipeRedesignReadsMinFall` to false **before AutoCAD starts**, repeat, and it must read about 1 in 890 (the old answer). With the row blank, both read the same as today.
   4. Needs a Codex look H8 for the final proof.
6. **Your call needed:** none.

---

## Technical detail

1. **PR:** #1868, DRAFT, base `claude/gb01-slice1-falls` (PR #1841, head 78fda55b at my start; origin showed that branch one commit ahead when I pushed, so a rebase onto it may be needed). Branch `fb/bug1091-redesign-reads-min-fall`, worktree `C:\ce-fx\c78b`.
2. **Cause (read, not run):** `Modules/Drainage/Services/SettingsSizingStandards.cs`, `ForEveryMaterial` passed the shared ladder through `StandardGradeSizesMm` (the 90 to 375 keys of `CreateAs3500MinGradeByDiameter`), so the DN450+ rows that `DesignStandards.EffectiveMinGradeLadder()` (UserSettings.cs ~2338) adds were dropped. `ForEveryMaterial` is what `PipeSizingStandards.CreateDefault()` (PipeSizingModels.cs:111) calls, so Civil Design, auto-design and the network redesign all got the short list. `ForMaterial` (Edit Pipe, CDRULES) already passed null and saw every row.
3. **Change:** `GradeLadder` gained a `keepLargeRows` argument. With it, keys at or above `LargeGravityFromMm` pass the filter; they only exist when the row has a figure, so blank stays blank. `ForEveryMaterial(office, bool? largeRowOn = null)` reads the new switch when not told. `ForMaterial` passes false (it never filtered). One reader, no second copy of the figure.
4. **Switch:** `pipe.largePipeRedesignReadsMinFall`, `PipeSettings.LargePipeRedesignReadsMinFall`, default true, documented "Default: on.". No Settings page row (the sibling pipe switch has none). **Not pinned in `C75NewSwitchDefaultsTests`**; my own test class pins it through both `DeserializeSettings` and `DeserializeSettingsTolerant`.
5. **Tests written (not run):** `Modules/Drainage.Tests/Rules/Bug1091RedesignReadsMinFallTests.cs`: row 200 holds the 450 at 30 L/s to 1 in 200 and agrees with the strip and rulebook; `CreateDefault` reads it; blank row identical ON and OFF; switch OFF gives the old six-row list and a flatter old answer; switch loads ON through both start-up reads.
6. **Files:** `Models/UserSettings.cs`, `Services/SettingsSizingStandards.cs`, the test file, `REGRESSION_LOG.md` (entry says plainly it is not built or run). `PipeSizingSolver.cs` untouched (B-020). CE_SHARED untouched. No drawing write, regen, view or system variable change.
7. **Still to do:** run the focused net10 tests (check the count is not 0), the full suite once, the net48 compile, then update the regression-log wording from "NOT YET BUILT" to the real result. A last focused run was re-queued as `C:\ce-fx\b019\focus7.log`; if it has finished by the time anyone reads this, read that log first.
8. **Other open points from the Opus pre-review of #1841, not done here:** the "Stale once" marker, sizes between 375 and 450 having no minimum (sizes between 375 and 450 are outside this fix; and sizes above 2400 or not in the 15-size large list, such as DN1000, are not in the shipped list, and the solver looks up exact keys).

---

## BUILD AND TEST (job B-019b, Fri 30 Oct 2026, 5:00 pm to 6:55 pm Melbourne)

### FOR TIM

1. **Answer:** PR #1868 now compiles and its tests pass. Built and unit-tested, nothing more. Nobody has opened it in AutoCAD, it is not installed, BUG-1091 stays open.
2. **What the checks showed:** the new tests confirm that with a 1 in 200 large-pipe minimum a 450 carrying 30 L/s is held to 1 in 200 by the redesign, the same figure as the Edit Pipe strip. With a blank row nothing changes. With the switch off you get the old answer back. The switch loads ON at start-up.
3. **Mistakes of my own:** the first two waits for a build slot were killed by the tool after 30 minutes, so the first build only started at 5:36 pm. No code mistakes found; I changed no code, only one line of the change log.
4. **What is NOT proven:** how it looks and behaves in AutoCAD. The proof is the robot case `C78_redesign_min_fall` (the 450 at 30 L/s with a 1 in 200 row, switch-off control) plus a Codex look H8.
5. **Your call needed:** none.

---

### Technical detail

1. **Worktree:** `C:\ce-fx\c87b`, detached at the branch head `c88cd7dc` (the branch is also checked out in `C:\ce-fx\c78b`, so a second checkout was not allowed). Pushed with `git push origin HEAD:refs/heads/fb/bug1091-redesign-reads-min-fall`, normal push, new head `38c3f825`. Only change: the REGRESSION_LOG.md line "NOT YET BUILT OR RUN" now states the real result.
2. **Environment:** Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, net10 off AutoCAD 2027 (on PATH), placeholder 0-byte `CE_TRANSFORM_2027.arx` untracked, below-normal priority, fresh TEMP and CE log folder per step, two-slot wait script `C:\ce-fx\b019b_run.ps1`. Logs `C:\ce-fx\b019b_focus.log`, `_full.log`, `_n48.log`.
3. **Focused net10** (filter `Bug1091` or `C75NewSwitch`): Total 31, Passed 31, Failed 0 (count not zero; the 7 cases of `Bug1091RedesignReadsMinFallTests` are inside it).
4. **Full Civil net10:** Total 20,840, Passed 20,808, Skipped 32, **Failed 0** (35.8 min). The PDF page test did not need a re-run. One log line "TearDown failed for test fixture SettingsIsolationSetup" (a CE_CVL_SUITE.log file lock when the test harness deletes its temp folder) is harness noise that does not fail any test; it comes from test setup, not from this change.
5. **net48 compile:** `CE_CVL_SUITE.csproj` Release net48, 0 errors, 242 warnings. net10 compile of the same project 0 errors.
6. **Not run:** net48 test run (reference-only AutoCAD assemblies fail AutoCAD-needing tests on this PC), Manager and Installer suites (untouched), the net8.0-windows target, anything in AutoCAD. The "Stale once" marker and the 375 to 450 and above-2400 size gaps (open points in section 8 above) are unchanged. `PipeSizingSolver.cs` and CE_SHARED untouched.
7. **Proof still needed:** robot `C78_redesign_min_fall` (see the FOR TIM block in the first part of this report) and a Codex look H8 on the 450 at 30 L/s example.
