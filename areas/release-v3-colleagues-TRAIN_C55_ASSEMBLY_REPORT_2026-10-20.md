# Train C-55 assembly report (Civil + Manager), Tue 20 Oct 2026

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261020i` at `8e76e1d9f0d07be4ba4b716fee79b3d4335b0d26`, pushed (normal push; ls-remote equals this head). Base `origin/claude/rel-20261020h` at `6644752b` (installed Civil 3.0.64 / Manager 1.1.64, train C-54).
2. **Merged: 1 PR.** #1486 (BUG-856: Tidy labels "Will move" line names the pipe), live head `e27b4971654a` (one commit; checked with gh immediately before the merge and equal). It is a draft from lane 03 and **has NO Opus review entry yet: the C-55 finalizer must review it fully.**
3. **Left out:** nothing in scope. Structural PRs, #1382, #1384, #1419, #1423, #1191, #1183, #1180 and anything HOLD, REJECT or SUPERSEDED-BY were not touched.
4. **Shared/ and Manager:** #1486 touches neither. `git diff --name-only 6644752b HEAD` has 0 files under `Shared/` or `Modules/Manager`. Civil only.
5. **Build:** whole solution Release, 0 errors (889 warnings, the usual count), 10 m 45 s.
6. **Tests:** Civil net10 full: 18,957 total, 18,937 pass, 19 skipped, 1 failed (`BackTest_GlenEira24115_Computed_WithinTolerance`, the known red; the totals are in the thousands, so the wrong-ref-name trap is not in play). Manager net10 832 of 832. Civil net48 focused: 274 run, 272 pass, 2 failed, both **also fail on the base `6644752b`** (see section 2).
7. **For the finalizer (read these):**
   1. **Review #1486 fully** (no entry exists). It changes wording only per its own log entry: `Modules/Drainage/Rules/PitMoveLockedPipeRule.cs` (+10 -2), one new test file (+38).
   2. **A Structural settings file changed during my run:** `CE_STRUC_SUITE\CS_Settings.json` hash is now `f68eeb5e` (was `24d8e5f7`), file time 18:24:30, inside my net48 test window (18:24:19 to 18:24:34). I ran no Structural test and no AutoCAD, and the only code that writes that file is `Modules/Structural/Services/SettingsService.cs`. I did not prove the cause and I did not keep a copy of the old file. Tim should be told; someone should look at the file's contents (it is Tim's real settings file). The other three settings files are unchanged.
   3. Not run: Installer.Tests, Manager release-candidate build, Structural, full net48 lane, AutoCAD. Nothing installed or deployed; no version bumped. No bug marked FIXED (BUG-856 stays open until Tim or Codex drives it in AutoCAD).

## 1. Merge list

1. **#1486 @ e27b4971654adcce8d3d72ff2ffd2d5e2ef891c5**, PR base `claude/rel-20261020f`, branch `b03/bug-856-tidy-move-line-names-pipe`, draft, OPEN. One commit only ("Fix BUG-856..."), so it carries no other unreviewed PR commits. Not an ancestor of the base (checked), so merged. Merge commit `8e76e1d9`.
2. **Conflict:** `REGRESSION_LOG.md` only (both sides added entries at the top). Kept every entry from both sides; removed only the three marker lines.
3. **Numstat check:** `git diff --numstat HEAD~1 HEAD` gave 3 files: `Modules/Drainage.Tests/Rules/Bug856TidyMoveLineNamesPipeTests.cs` (+38), `Modules/Drainage/Rules/PitMoveLockedPipeRule.cs` (+10 -2), `REGRESSION_LOG.md` (+12). Equal to the PR's own file list (`gh pr view 1486 --json files`: the same 3 files).
4. **In AutoCAD terms:** on the Tidy labels preview, the "Will move" line for a pipe with one pit and an open end now names that pipe. Wording only; nothing moves differently.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c55`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, every command in the foreground (the solution build ran past 10 minutes, so I polled its done-file in foreground loops). `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, TEMP and CE log folder fresh per step. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (checked gone).
2. **Timings:** solution 10 m 45 s; Civil net10 5 m 2 s test run; Manager 5 s; net48 focused 5 s.
3. **Civil net10 failures** (read from the saved log): only Glen Eira, the known red, in code #1486 does not touch.
4. **Civil net48 focused** (filter: RedoSafe, DoubleClick, Bug856, PitMoveLockedPipe, Tidy): 274 run. The 2 failures are `BranchHostLabelTidyRuleTests.SamePlanBreak_DoesNotAskForTheMainToBeTidied` and `XcivilImport_DoesNotAskForTheMainToBeTidied`, both `InvalidProgramException` in the AutoCAD reference stub (`Matrix3d.get_Identity`), the known net48 stub problem. **Base comparison:** I built the base `6644752b` in a second private worktree and ran `BranchHostLabelTidyRuleTests` on net48: the same 2 fail (10 pass, 2 fail). So they are not from #1486. The same tests pass in the net10 full run.
5. **Tim's settings files** (before / after): `TIM_CE_CADTOOLS\CD_Settings.json` acd64e79 / acd64e79, `TIM_CE_CADTOOLS\CS_Settings.json` 622a246f / 622a246f, `CE_CVL_SUITE\settings.json` efe307c4 / efe307c4: **unchanged**. `CE_STRUC_SUITE\CS_Settings.json` 24d8e5f7 / **f68eeb5e: CHANGED** (see ANSWER FIRST 7.2; I did not report this as "unchanged").
6. **Not run:** Installer.Tests, Manager release-candidate build, Structural, full net48 lane, anything in AutoCAD or accoreconsole (not running; checked).

## 3. Hygiene

1. No PR closed, no branch deleted, no version edited, `DESK_LOG.md` not edited, nothing installed.
2. Both worktrees (`C:\ce-asm\c55`, `C:\ce-asm\c55base`), `c55logs` and `c55tmp` are removed after this report is pushed.
3. **Four words:** built (whole solution) and unit-tested. Not installed. Nobody has opened it in AutoCAD.
