# BUGFIX ff2011b report: PR #2011 (B-198, BUG-1033) FIX FIRST, 4 November 2026

## FOR TIM

1. **Nothing changes on the drawing or in the window.** The Pump System tab banner is exactly as the PR had it. The fix was a file-housekeeping slip in the settings file, not a behaviour change.
2. **What I fixed:** the PR had silently stripped an invisible marker (the UTF-8 byte-order mark, a hidden first character) from the top of `UserSettings.cs`. That made the whole file look changed and would make the next merge noisier. I put it back. The diff of that file against the base is now only the 8 added lines for the new switch.
3. **One extra commit pushed** to the same PR branch (`claude/w1033-pump-readonly-banner`, now f665c5d4). No force-push, no new PR, nothing retargeted or merged. A line was added to REGRESSION_LOG.md.
4. **My own mistakes:** none that cost anything. I first tried `dotnet` from the wrong shell (it is not on the PATH), and the first test run failed because the empty placeholder `CE_TRANSFORM_2027.arx` was missing in my fresh worktree. I created the empty file as the rules allow.
5. **Not proven:** the banner itself has still not been seen in AutoCAD (unchanged from the PR). The test finds the XAML by a fixed folder climb (pre-review point 4); I left it alone because the order said fix only the one finding.
6. **Robot case:** none needed for this fix, since there is no behaviour to drive. The existing proof stays: type CDCALC, open Pump System, check the banner line shows; set `options.pumpTabReadOnlyBanner` false before launch and check it is gone.

---

## Technical detail

1. **Fault confirmed:** base parent `aa56a169~1:Modules/Drainage/Models/UserSettings.cs` begins `EF BB BF`; head began `75 73 69`. Fixed by prepending the three bytes. Line endings untouched.
2. **Commit:** f665c5d4 "B-198 BUG-1033: restore the UTF-8 byte-order mark on UserSettings.cs line 1". Files: `Modules/Drainage/Models/UserSettings.cs`, `REGRESSION_LOG.md` (item 7 in the BUG-1033 entry). CE_SHARED untouched.
3. **Test:** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj --filter "FullyQualifiedName~Bug1033|FullyQualifiedName~NewSwitchDefaults" -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`. net10.0: 243 passed, 0 failed. The net8.0 and net48 runs found no tests to run (the usual lane limit); the net48 build compiled.
4. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP and TMP set under `C:\CE_WORK\scratch\ff2011b`. Listings of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` before and after the run are identical (saved as `appdata_before.txt` and `appdata_after.txt` in the scratch folder). No Manager tests run.
5. **PR 2011** is still a draft on its original base. The two-commit history is left for CE 05 to squash at merge.
