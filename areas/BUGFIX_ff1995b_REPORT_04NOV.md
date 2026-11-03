# BUGFIX ff1995b report: PR #1995 fix-first (BUG-1053, B-172), 4 November 2026

## FOR TIM

1. **What a drafter sees differently:** nothing. The only change is an invisible marker put back at the very start of the main settings source file. LandXML levels in millimetres still read as metres exactly as the PR already did.
2. **What I did:** the review said the PR had accidentally stripped that marker (a hidden three-byte mark on line 1 of `UserSettings.cs`). I confirmed it on the PR branch (missing) against the base `claude/rel-20261102a` (present), put it back, and pushed one extra normal commit, 1833fcb4, onto the same branch. No new PR, nothing force-pushed, nothing retargeted. The settings file now differs from the base only by the PR's own 8 added lines.
3. **Mistakes of my own:** none that reached the branch. My first test attempt failed because the shell could not find `dotnet`; I fixed the path and re-ran.
4. **Switch:** unchanged, `xcivilImport.landXmlLevelsConvertedToMetres`, default ON, OFF gives the old behaviour.
5. **NOT proven:** nobody has opened this in AutoCAD. The fix is a file-format detail, so there is no AutoCAD-visible effect to prove. The PR's own LandXML behaviour is still unproven in a drawing (Codex recipes K4_02 to K4_04 and `verifyG1_c90` still apply).
6. **Robot case:** none applies to this commit (no behaviour change). The robot case for the PR itself stays as listed in `ROBOT_CASE_DRAFTS_PR1995_1998_03NOV.md`; there is no switch-off control for a marker fix.

## Technical detail

1. **Fault confirmed:** `git show HEAD:Modules/Drainage/Models/UserSettings.cs` began `75 73 69 6e` ("usin"); base began `ef bb bf 75 73 69`. Head was 26afae19.
2. **Fix:** prepended `EF BB BF` by byte write (CRLF line endings untouched). `git diff origin/claude/rel-20261102a HEAD -- UserSettings.cs` is now 8 insertions, 0 deletions.
3. **Files in the commit:** `Modules/Drainage/Models/UserSettings.cs`, `REGRESSION_LOG.md` (new entry at the top). CE_SHARED untouched.
4. **Test:** `CE_CVL_SUITE.Tests`, net10.0-windows, filter `Bug1053|NewSwitch|UserSettings`, flags `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`: **256 passed, 0 failed, 0 skipped.** Count not zero.
5. **net48 compile check:** `CE_CVL_SUITE.csproj` net48 Release: 0 errors, 246 warnings.
6. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP and CE_STRUC_SUITE_APPDATA_ROOT set to `C:\CE_WORK\scratch\ff1995b` before the test. Real `%APPDATA%` listing (TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS): 36,869 files before and 36,869 after, with no difference in name, size or last-write. The full listings are `C:\CE_WORK\scratch\ff1995b\appdata_before.txt` and `appdata_after.txt` (scratch removed when the job ends; the comparison result was empty).
7. **Commit:** 1833fcb4 on `claude/w1053-landxml-rim-units`, message names BUG-1053 and carries the Co-Authored-By line. Leak scan clean.
8. **Cleanup:** `git clean -fdXq`, worktree removed, scratch removed. The C: free-space figure is in the final summary.
