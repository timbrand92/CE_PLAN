# Train C-79a assembly report (Civil + Manager), Sat 31 Oct 2026, Melbourne time

Branch `claude/rel-20261106a`, head **b8089300**, pushed to origin and read back with `git ls-remote`. Built on the installed C-78 (3fbb9da5). Nothing was installed. Nothing was opened in AutoCAD. No version commit.

## FOR TIM

1. **Answer:** 22 of the 24 PRs are merged. 2 were deliberately NOT merged (#1922 and #1923, below). Everything builds and the tests pass, with one honest caveat in item 4.
2. **Not merged, and why.** #1922 (Structural test runs write nothing into your real folders): it touches a folder outside this train's scope (Modules/TestSupport) and 16 files including 3 test project files. #1923 (double-click on a pit label): the PR ships its switch ON, but your ruling of 22 Oct is OFF until a Codex look. I did not edit it or merge it. Both stay open and untouched.
3. **Test counts (Civil, net10, one full run):** 21,893 tests, 21,860 passed, 1 failed, 32 skipped. **Manager (one full run):** 1,148 tests, 1,146 passed, 0 failed, 2 skipped.
4. **The one failure was new and was a real fault, now fixed.** PR #1962 (the Inspector red/amber grade) had dropped the invisible UTF-8 marker from the start of the Civil settings source file. A guard test caught it. I put the marker back (commit b8089300, one file) and re-ran the guard and the settings tests: 105 of 105 passed. **I did not repeat the 15-minute full Civil run after that one-byte fix**, so the full run is "21,860 passed plus 1 failed then fixed and re-tested separately".
5. **Your real settings file changed again, and it was not my tests.** `CD_Settings.json` changed at 23:41:44 tonight (size 15,270 to 15,357 bytes). My last test run had finished before that. AutoCAD (acad.exe) started at 23:41:51 on this PC, so I believe CE 02's robot did it. I have not proved it. The CE_Admin outbox also grew from 28,119 to 28,182 files at the same time (23:42:18).
6. **Isolation:** every test ran with its own temp, log and Structural folders under `C:\CE_WORK\scratch\c79a`. `CS_Settings.json` is unchanged.
7. **Not tested (all PRs):** nothing was opened in AutoCAD. No window, label, ribbon, menu or drawing result was looked at. Everything below is "merged, built, unit-tested" only.
8. **Not in this train:** #1868 (B-019) was NOT in this train and goes first in C-79b1. #1841 is already in the line and must never be merged again.
9. **Re-test class for CE 02:** several shared paths changed (list in the technical part). The settings engine and the Manager start-up were touched, so the class is the area plus N91 (decision 161), no FULL gate.

---

## Technical part

### 1. State found at resume
HEAD was d17460fa, working tree clean, 25 merge commits (22 "Merge PR" plus 3 merges inside PR histories: #1884, #1878 and the B-011b #1857 head). Steps 1 to 3 not redone.

### 2. PRs (head, result). Merge-order as in the list. All merged with `--no-ff`; none tested in AutoCAD.
1. **#1884** f9fa356c: Civil test isolation guard. Merged, no conflicts.
2. **#1922** 7a3238a7: **NOT merged** (out-of-scope folder, 16 files).
3. **#1882** 84d5a659: BUG-1093 lid typed with a comma. Merged. REGRESSION_LOG conflict, both kept.
4. **#1887** 0d5e3d98: BUG-1092 review fix. Merged. (Its log entry had two items numbered 6; renumbered.)
5. **#1888** 0b40e4af: BUG-1195 CDTEXTSEG with a turned UCS. Merged.
6. **#1889** ff36dbeb: BUG-1237 CDRENUMBER wording. Merged.
7. **#1890** 5e8e208f: BUG-1071 "not saved" wording. Merged.
8. **#1896** 6c6f0db1: B-074 Help pages. Merged.
9. **#1857** 718ec21c: B-011b Settings tick boxes (older line). Merged.
10. **#1875** 107a6a74: BUG-816 pop-up help wording (older line). Merged. Conflicts: REGRESSION_LOG (both kept) and one list line in SettingsWindowV3Tests.cs (both kept).
11. **#1876** d30041c4: BUG-1247 Updates button pin. Merged.
12. **#1936** 4ebf367a: BUG-1244 CE Tools Refresh line. Merged.
13. **#1935** d49842fe: BUG-1172 lane label Net8. Merged.
14. **#1877** b9842f28: BUG-1112 WSUD export sample site. Merged.
15. **#1878** a9a0a4f5: support zip name guard. Merged.
16. **#1923** e3dfb957: **NOT merged** (switch ships ON, ruling is OFF).
17. **#1925** 8b7ee79b: BUG-788 two Save As Xrefs. Merged.
18. **#1926** f0b98291: BUG-505 scale warning on X-Civil import. Merged.
19. **#1947** b2ecdfb3: BUG-685 typed level rounding line. Merged.
20. **#1949** 8a16a42e: BUG-907 outlet-above-inlet warning. Merged.
21. **#1962** 7f7bc477: BUG-1094 Inspector red grade. Merged. Head dropped the UTF-8 marker on UserSettings.cs, fixed in b8089300.
22. **#1959** d7c1e154: BUG-1214 CDASK file picker. Merged.
23. **#1957** 4e1574d6: BUG-1211 CDMENU loaded check. Merged.
24. **#1928** 22766c90: B-094 New Pipe starts in Custom 1 in 100. Merged.

### 3. Conflicts
REGRESSION_LOG.md (top-of-file entries) and the one SettingsWindowV3Tests.cs list line: both sides kept. No UserSettings.cs conflict remained at the end; PluginManagerCommands.cs (#1876 with #1936) merged without a conflict.

### 4. New test classes
`C79aNewSwitchDefaultsTests` (Civil, 213 lines) and `C79aManagerSwitchDefaultsTests` (Manager, 92 lines), commit d17460fa. They pin every new switch through both start-up reads for an empty file, a C-78-shaped file and a group missing the keys, plus "typed false changes only itself". #1923's switch is not in the line, so nothing is pinned for it.

### 5. Builds and tests (Release, net10.0-windows, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`)
1. Builds of Civil and Manager on net10: 0 errors (Civil 214 warnings, Manager 0). net48 compiles of both: exit 0.
2. Civil focused run (every PR's changed test classes, C77/C78/C79a defaults, TestHygieneAppDataGuardTests, ZzRealSettingsFileGuard, REDO-safe hook guard incl. EveryHookBetweenCommands_IsRedoSafe_OrReviewed): 488 of 488 passed.
3. Manager focused run (#1876, #1935, #1936 classes, defaults, hygiene, guard): 73 total, 72 passed, 1 skipped, 0 failed.
4. Civil full run: 21,893 total, 21,860 passed, 1 failed (`Bug351bPlanMarkerTests.UserSettings_KeepsItsByteOrderMark`, NEW, fixed), 32 skipped. The 7 old Structural failures from C-78 did not appear in this Civil run.
5. After the fix: BOM class, C79a, C78 and Bj34 persistence classes 105 of 105 passed. No second full run.
6. Manager full run: 1,148 total, 1,146 passed, 0 failed, 2 skipped.
7. #1884's new Civil guard (ZzRealSettingsFileGuard) did NOT go red in these runs.

### 6. Isolation stamps
1. **Before (22:09):** CD_Settings.json 2026-10-04 08:22:30, 15,270 bytes, SHA256 ACD64E79...3140. CS_Settings.json 2026-03-31 13:18:00, 351,713 bytes, SHA256 622A246F...EEC3EB. Outbox 28,119 files (newest 22:09:21), folder time 2026-04-28 11:36:51.
2. **After (23:44):** CD_Settings.json **2026-10-31 23:41:44, 15,357 bytes, SHA256 7AF8FC65...5E83: CHANGED**. CS_Settings.json unchanged. Outbox 28,182 files (newest 23:42:18), folder time unchanged.
3. **Evidence on the change:** my last test run (Manager full) ended before 23:41; acad.exe (PID 63784) started 23:41:51; settings changed 23:41:44 and outbox grew 23:42. All of my runs had TEMP, TMP, CE_LOG_DIR_OVERRIDE and CE_STRUC_SUITE_APPDATA_ROOT set under `C:\CE_WORK\scratch\c79a\run-*`. I have no earlier copy of the file to diff, so I cannot say which key changed.

### 7. Changed files and SHARED paths
`C:\CE_PLAN\areas\TRAIN_C79A_CHANGED_FILES.txt`: 103 files (5,766 insertions, 123 deletions). SHARED among them: `Modules/Drainage/Models/UserSettings.cs` (settings engine and switches), `Modules/Drainage/Assets/Config/colleague-defaults.json`, `Modules/Drainage/Commands/CdCommand.cs`, `Modules/Drainage/Services/WorkspaceMenuInstallerService.cs` (menu install and repair), `Modules/Drainage/Services/MarkupFileImageLoader.cs`, `Modules/Manager/Plugin.cs` (start-up), `Modules/Manager/Commands/PluginManagerCommands.cs`. No CE_SHARED or Shared/ files changed. Re-test class: area plus N91.

### 8. Stops
1. Floor of 24 GB (22 GB hard stop) was never hit: 26 to 30 GB free throughout.
2. Run 1 stopped #1922 and #1923 (above).
3. One new test failure, fixed in b8089300.

### 9. What I did NOT do
1. No install, no version commit, nothing opened in AutoCAD.
2. No PR closed, retargeted or deleted; no branch deleted; no force-push; no bug marked FIXED.
3. No second full Civil run after the BOM fix.
4. No test of #1922 or #1923.
5. Did not find which process changed CD_Settings.json.
