# Train C-53 assembly report (Civil + Manager), Tue 20 Oct 2026 (14:40 to 15:05 by the PC clock)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020g`, pushed with a normal push. Head `ac4bab783de6b29654ada198bb65a2133dadc287` (`git ls-remote` equals local). Base `origin/claude/rel-20261020f` @ `7a4dd8de` (train C-52, the INSTALLED Civil 3.0.62 / Manager 1.1.62 line).
2. **Merged: 6 PRs**, one `--no-ff` merge commit each, no squash, no rebase, no cherry-pick, in the briefed order: **#1239, #1228, #1226, #1171, #1169, #1166**. Every live head equalled the head named in the brief (checked with `gh pr view` and a fetch of `refs/pull/N/head` immediately before each merge). None was already in the base. Every merge's `git diff --numstat HEAD~1 HEAD` equals the PR's own `gh pr view --json files` list exactly.
3. **Left out, with reasons:** by the brief. Structural PRs (base `claude/rel-20261017s` and other Structural bases), #1382 (LBUH, parked to Thu 29 Oct), #1384 (SBEAM, superseded by CEMEMBER), #1419, #1423, #1170, #1165, anything HOLD, REJECT, SUPERSEDED-BY or waiting for a fix head. Ruling A (new plan items paused): #1191, #1183, #1180. Nothing closed or deleted.
4. **Does any merged PR touch Shared/? No.** Two merged PRs touch **Manager**: **#1226** (BUG-476 wording: `CeAdminPolicyService.cs`, `PluginAdminWindow.xaml.cs`, `PluginManagerWindow.xaml.cs`, tests) and **#1169** (BUG-556: deletes `CeAzureBlobService.cs`, `CeAzurePublishService.cs`, `blob-config.json` and their tests; adds `NoAzurePublishCodeTests.cs`). So **Manager must ship with this train**. No Installer, csproj, props or slnx file changed; CE_SHARED is identical for Civil and Manager.
5. **Conflicts, all resolved by keeping both sides:** `REGRESSION_LOG.md` on every merge (every entry kept: the PR's lines re-applied onto the base file); `UserSettings.cs` on #1171 (kept both groups: `windowPlacement` and the new `fleetTelemetry`); and one **extra** conflict the brief did not name: `Modules/Manager.Tests/Services/CeAdminPolicyServiceTests.cs` on #1226 (the base has the BUG-843 tests, the PR adds the BUG-476 tests at the same spot; kept both, no test removed). The finalizer should glance at that file.
6. **Build (Release):** whole solution **0 errors** (69 warnings on the last, incremental run).
7. **Tests (Release):**
   1. **Civil net10 full:** 18,938 run, 18,918 pass, 19 skipped, **1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance`** (the known red). Total is in the thousands (C-52: 18,913; +25 new tests), so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10 full:** **823 of 823.** (C-52: 824; the Azure test file is deleted by #1169, minus its tests, plus 3 BUG-476 and 4 `NoAzurePublishCode` tests: net -1, expected.)
   3. **Civil net48 focused** (CERef 24.3.0; Bug516bOneFreeboard, Bug505Xcivil, FleetHeartbeatSwitch, TypedCommandNamesGuard, RedoSafe, DoubleClick): 167 run, **167 pass**.
   4. Nothing new is red; the one red is the known Glen Eira one, failing identically on C-52.
8. **For the finalizer:**
   1. **Civil and Manager both ship.** CE_SHARED unchanged.
   2. Re-read the six reviews (REVIEWLANE 1463 to 1471). #1171 adds a switch (`fleetTelemetry`, ON = today's behaviour): check whether it needs a Settings row (standing list of switches without a row).
   3. #1169 deletes the dead Azure upload code from Manager: confirm nothing else in Manager or the Installer referenced it (whole solution builds, Manager 823/823 and Installer.Tests compile, so nothing visible).
   4. **Do not mark FIXED:** BUG-516, BUG-505, BUG-476, BUG-557, BUG-556 and the command-name guard item. Built and unit-tested only; nobody has opened them in AutoCAD.
   5. No version bump and no REGRESSION_LOG train entry added by me.
9. **Your settings files: one reading differs, please read carefully.** `CD_Settings.json` read **15,356 bytes `a2e5e140`** at the start (14:41) but **15,270 bytes `acd64e79`** at the end (14:56), and its modified time is 4 Oct 08:22, i.e. it was not written during my job. 15,270 `acd64e79` is the value every C-50 to C-52 report gave. I never touched that folder (builds and tests ran with TEMP and the CE log folder inside `C:\ce-asm\c53tmp`), but I cannot say what produced the odd first reading (`last_version.txt` in that folder was touched at 14:40:18, just before my start, so another CE process may have been running). Final state equals the known baseline. The other three are unchanged: `CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.

---

## 1. Merge list

1. **#1239** (BUG-516 detention freeboard one value) head `031ca4d83249226706efd0f5ac6d8e620cfe8786`, merge `78c7c668`. REGRESSION_LOG conflict only. Numstat matches.
2. **#1228** (BUG-505 X-Civil units warning) head `3491af3581dc5cbffad0f3e67cb7e41ba511af77`, merge `50b02251`. REGRESSION_LOG conflict only. Numstat matches.
3. **#1226** (BUG-476 wording) head `7edda54f42e2e5987dccde85ae6e1c3d7e66b049`, merge `2ef21c83`. Conflicts: REGRESSION_LOG, `CeAdminPolicyServiceTests.cs` (both kept). Numstat matches (5 files: tests 38/0, `CeAdminPolicyService.cs` 11/2, `PluginAdminWindow.xaml.cs` 2/3, `PluginManagerWindow.xaml.cs` 1/1, REGRESSION_LOG 13/0).
4. **#1171** (BUG-557 heartbeat switch) head `f835aafe275f2dc106fedd7107aabe4cde97bfa1`, merge `6d3c4f02`. Conflicts: REGRESSION_LOG, `UserSettings.cs` (both groups kept). Numstat matches (5 files, 71 added lines).
5. **#1169** (BUG-556 delete dead Azure upload code from Manager) head `2c20c16dd566ce5b800b4253e73b933e94f9e801`, merge `c193846b`. REGRESSION_LOG conflict only. Numstat matches.
6. **#1166** (command-name guard) head `9499b252f1e4e499fa5c66de03383c887d84c489`, merge `ac4bab78`. REGRESSION_LOG conflict only. Numstat matches.

All six PRs are drafts on base `claude/rel-20261009w`, open. Whole-train diff `7a4dd8de..ac4bab78`: 26 files, 609 added, 526 removed; no conflict markers left in any `.cs` or `.md` file.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c53`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, every command in the foreground. `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, Temp and a fresh CE log folder per run inside `C:\ce-asm\c53tmp`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (checked gone). Nothing deployed.
2. **Timings:** whole solution 1 m (after a 4 m first pass); Civil net10 5 m 12 s; Manager 5 s; net48 focused 5 s.
3. **My own slips (not product faults):** the first two solution builds failed only because my wrapper script had no `git` on PATH for the Installer.Tests pre-build step (exit 9009, "git rev-parse"; the inherited PATH was longer than cmd.exe's 8,191-character limit and expanded to nothing). I trimmed the PATH and re-ran: 0 errors. No source change.
4. **Failing tests:** `Failed` lines read from the saved log: net10 only Glen Eira.
5. **Not run:** Installer.Tests (compile only, rule), full net48 lane, Structural, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. AutoCAD and accoreconsole not running (checked). No version edited, no PR closed, no branch deleted. `DESK_LOG.md` not edited.
2. My worktree `C:\ce-asm\c53`, `c53logs` and `c53tmp` are removed after this report is pushed.
