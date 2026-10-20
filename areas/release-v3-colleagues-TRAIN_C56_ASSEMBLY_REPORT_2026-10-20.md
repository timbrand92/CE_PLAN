# Train C-56 assembly report (Civil + Manager), Tue 20 Oct 2026

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261020j` at `8d0eb8f2540bf80d8000ce82b211e2ededebb229`, pushed (normal push; ls-remote equals this head). Base `origin/claude/rel-20261020i` at `6c2bc2c7` (installed Civil 3.0.65 / Manager 1.1.65, train C-55).
2. **Merged: 4 PRs, all at the heads named in the brief** (each live head re-checked with gh immediately before its merge and equal): #1491 (d30aac59), #1492 (980d2f65), #1494 (e33719c6), #1495 (c7333338). 19 files, +1284 -20 against the base.
3. **Left out:** nothing in scope. #1493, #1487 to #1490, lane 03 work, the BUG-416 residual fix, Structural PRs, #1382, #1384, #1419, #1423, #1191, #1183, #1180 and anything HOLD, REJECT or SUPERSEDED-BY were not touched.
4. **Shared/ and Manager:** no merged PR touches `Shared/` or `Modules/Manager` (0 files). **The Installer program DOES change, via #1492:** `Installer/CeInstallerApplication.cs`, `Installer/CeOfficeApproval.cs`, `Installer/SafeBundleInstaller.cs`, plus `Installer.Tests/CeOfficeApprovalTests.cs`. #1491, #1494 and #1495 are Civil only.
5. **Build:** whole solution Release, 0 errors, 889 warnings (the usual count), 4 min 14 s.
6. **Tests (Release):** Civil net10 full: 19,035 total, 19,015 pass, 19 skipped, 1 failed (`BackTest_GlenEira24115_Computed_WithinTolerance`, the known red; the total is in the thousands, so the wrong-ref-name trap is not in play). Manager net10: 832 of 832. Civil net48 focused: 288 run, 288 pass, 0 failed. Installer.Tests compiled in the solution build, not run (rule).
7. **For the finalizer (read these):**
   1. **Tim's `TIM_CE_CADTOOLS\CD_Settings.json` CHANGED during my run** (15270 bytes, hash acd64e79 before; 15302 bytes, 9d27b04c after). File time 21:03:17, the same second my solution build finished (done-file 21:03:19; the build runs no tests and no AutoCAD). **AutoCAD 2027 (acad.exe) started at 21:03:37**, 20 seconds later, with drawing LKV2b_B1.dwg open, so the likeliest writer is whatever closed or opened AutoCAD around then (not me). I did not prove the cause and kept no copy of the old file. Someone should read the file's contents. The other three settings files are unchanged (below).
   2. **AutoCAD was running during my Civil net10, Manager and net48 test runs** (started 21:03:37 by someone else; I ran none). Unit tests do not touch it, but say so.
   3. **#1492 changes the installer: the finalizer must re-review it** and decide whether Manager/Installer must ship (Installer program change, not a plugin DLL change). It reads the office `approved.json` and refuses a stage older than approved. Not run: Installer.Tests, Manager release-candidate build.
   4. Nothing installed or deployed; no version bumped. No bug marked FIXED (BUG-825 and BUG-834 stay open until driven in AutoCAD).

## 1. Merge list

1. **#1491 @ d30aac5926c69de721ea421a4e19d5f2e1e2ca59** (BUG-825: the 1000 -> 900 mm step iron move runs once only). PR base `claude/rel-20261020i`. Merge `5b01623c`. Clean. Numstat equals the PR's file list.
2. **#1492 @ 980d2f6516acc22d12fdee2baa4b16d4ecb97e2d** (BUG-834: the installer reads the office approved.json). Stacked on #1491, PR base `claude/b4-bug825-stepiron-once`. Merge `971fb3e3`. Clean. Numstat equals the PR's own file list (its parent was already in).
3. **#1494 @ e33719c6ffe14046ac63c31129da870f0ea4451a** (Codex Settings Fixes tab: schedule and long-section boxes). PR base `claude/rel-20261020h`. Merge `672baf2c`. **Conflict: `REGRESSION_LOG.md` only**; kept every entry from both sides. Checked afterwards: every line each PR added to the log is present in HEAD, no conflict markers. Numstat equals the PR's file list.
4. **#1495 @ c7333338ea8751a1a065593be7614a648c3c7add** (Codex Settings: drafting, survey, detention, heartbeat boxes). Stacked on #1494, PR base `codex/cesettings-fixes-sched-civil`. Merge `8d0eb8f2`. Clean. Numstat equals the PR's own file list.
5. None was already an ancestor of the base (checked before each merge). Plain `git merge --no-ff`, one merge commit per PR, no squash, rebase or cherry-pick.
6. **In AutoCAD terms:** (a) the step-iron start values stop being moved a second time; (b) the installer refuses to stage a bundle older than the office-approved one; (c) the Settings window gets the schedule, long-section, drafting, survey, detention and heartbeat boxes.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c56`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, every command in the foreground (polled to its done-file). `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, fresh TEMP and CE log folder per step. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (gone at the end). Run 20:59 to 21:12.
2. **Timings:** solution 4 m 14 s; Civil net10 6 m 59 s; Manager 25 s; net48 focused 13 s.
3. **Civil net10 failure** (read from the saved log): only Glen Eira, the known red, in code none of these PRs touches. No new red, so no base comparison was needed.
4. **Civil net48 focused filter:** RedoSafe, DoubleClick, Bug825, Bug834, Bj33, Bj34, SettingsWindowV3, SettingsPersistence. 288 of 288.
5. **Tim's settings files (before / after):** `TIM_CE_CADTOOLS\CS_Settings.json` 622a246f / 622a246f unchanged; `CE_CVL_SUITE\settings.json` efe307c4 / efe307c4 unchanged; `CE_STRUC_SUITE\CS_Settings.json` f68eeb5e / f68eeb5e unchanged (it was already f68eeb5e from C-55); **`TIM_CE_CADTOOLS\CD_Settings.json` acd64e79 / 9d27b04c CHANGED** (see ANSWER FIRST 7.1; not reported as unchanged).
6. **Not run:** Installer.Tests (compile only), Manager release-candidate build, Structural, full net48 lane, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. No PR closed, no branch deleted, no version edited, `DESK_LOG.md` not edited, nothing installed or deployed.
2. Worktree `C:\ce-asm\c56`, `c56logs` and `c56tmp` are removed after this report is pushed (the older `C:\ce-asm` files from other jobs are not mine and were left).
3. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.
