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
