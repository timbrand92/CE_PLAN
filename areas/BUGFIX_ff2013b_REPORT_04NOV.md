# BUGFIX ff2013b report: FIX FIRST on draft PR #2013 (B-201, BUG-897), Wed 4 Nov 2026

## FOR TIM

1. **Result:** fixed. The one FIX FIRST finding on #2013 is done and pushed to the same PR branch as one extra normal commit (2058816d). No new PR, no force-push, no merge.
2. **What a drafter will see differently:** nothing. This was a hidden start-of-file marker that the first commit had stripped from the settings file code. Putting it back changes no behaviour. The tiny Label slide step still gets raised to 5 mm with the switch ON; OFF is still the old behaviour.
3. **My mistakes:** none in the fix. I lost a few minutes on my own test script (a wrong program path, then a missing 0-byte placeholder file in the folder the build names). No effect on the result.
4. **What is NOT proven:** nothing was opened in AutoCAD. BUG-897 stays open. The tests only check the code. The command-line notice (one line per run instead of one log line per label) from the review's "recommended" list was NOT done: the job said fix only the FIX FIRST finding. It is still open for you or the author.
5. **Robot case that proves it:** the marker is not visible in a drawing, so no robot case applies. The existing proof stays the one in the PR: set Label slide step 0.001, restart, run CDTIDYLABELS, check the preview comes up quickly; set `pipe.labelSlideWorkBudget` false, restart, check the long wait returns (switch-off control).
6. **Safety:** no locked layer, Xref, REFEDIT or CE_SHARED touched. Real AppData files unchanged by my run.

---

## Technical detail

1. **Fault confirmed on the PR head 41af009f:** `Modules/Drainage/Models/UserSettings.cs` line 1 began `75 73 69` ("usi"); the base (claude/rel-20261102a) begins `EF BB BF 75 73 69`. Diff showed `-\uFEFFusing System;` / `+using System;`.
2. **Fix:** prepended `EF BB BF` to that file. Line 1 no longer appears in the diff against the base. Only change in `UserSettings.cs`: one line.
3. **Also changed:** `REGRESSION_LOG.md`, item 9 added under the BUG-897 entry.
4. **Not done (not in scope):** command-line notice once per run; removing the doubled blank line after the new property.
5. **Commit:** 2058816d on `claude/bug-897-label-slide-budget`, pushed 41af009f..2058816d, message names BUG-897, Co-Authored-By line included.
6. **Tests:** one project, `Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj`, `-f net10.0-windows`, filter `FullyQualifiedName~Bug897|FullyQualifiedName~NewSwitchDefaults`, with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, AutoCAD refs from the C62 assembly report, Below Normal. Result: Passed 243, Failed 0, Total 243 (count not zero). Dotnet slot count was 0 before the run.
7. **net48 compile:** `Modules/Drainage/CE_CVL_SUITE.csproj -f net48`: 0 errors, 2 warnings.
8. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP and TMP set to `C:\CE_WORK\scratch\ff2013b\{log,tmp}` for every run. Listings of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` taken before and after both runs (`before.txt`, `after.txt`, `before2.txt`, `after2.txt` in the scratch folder): the before/after comparisons were empty, so no real file changed. Manager tests not run.
9. **Placeholder:** 0-byte `CE_TRANSFORM_2027.arx` created at `Modules\Shared.Transform.Native2027\bin\x64\Release\` in my worktree (untracked, removed with the worktree clean).
10. **C: free space:** 57.07 GB before the build; 58 GB free after the worktree and scratch folder were removed (about 1 GB moved back).
