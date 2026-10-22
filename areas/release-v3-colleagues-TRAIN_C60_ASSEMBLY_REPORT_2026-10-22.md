# Train C-60 assembly report (Civil ONLY), job dated Thu 22 Oct 2026 (real clock 16:40 to about 17:10 Melbourne)

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261022m` at `037b93112d363b7c6f4ad819e3169d8fa6dbf9de` (normal push, new branch, confirmed with `git ls-remote`). Base: `claude/rel-20261022l` real tip `375a4ebcf62917cef3beb14c7602806bbf0b609c` (Civil 3.0.69 / Manager 1.1.69, C-59), exactly the tip named. No version bumped.
2. **Merged: 2 of 2 PRs**, one plain `git merge --no-ff` commit each, no squash, rebase or cherry-pick. Whole branch against base: 12 files (see numbers in section 1). Live heads read with gh immediately before each merge:
   1. **#1520 @ 9daa061da2a800828d67df0b66b6febcbfa3856f** (BUG-859, downpipe double-click reaches the Edit source window). Equal to the expected head, so Opus 1588's fix is in. Merge `97cb58ec`.
   2. **#1517 @ 440b13fa3be3fd652e25aa02bf921a64f00ce204** (UX-DI-03, CDCHECKIGNORE). Equal to the head in FIX_1517_REPORT, so no descendant check was needed. Merge `037b9311`.
3. **Left out, with reasons:** every Structural PR (trains S-41/S-42), #1382, #1384, #1419, #1423, #1191, #1183, #1180, anything HOLD, REJECT or SUPERSEDED-BY, and anything not named in the job. Nothing was skipped for a changed head and nothing was already in the base.
4. **Scope check: PASSED.** `git diff --stat 375a4ebc..HEAD -- Shared Installer Modules/Manager` is **EMPTY**. No merged PR touches Shared/, Installer/ or Modules/Manager. Manager stays byte-identical to the installed source (only the payload builder's version re-stamp will differ).
5. **Settings keys added or changed (default in the merged code, none changed by me):**
   1. **Nothing new in `UserSettings.cs` from #1520** and `git diff 375a4ebc..HEAD -- Modules/Drainage/Models/UserSettings.cs` is **empty**. `checks.allowIgnoreFinding` (property `AllowIgnoreFinding`, `UserSettings.cs` line 2786, `= false`) was already in the C-59 base and stays **OFF**.
   2. **`doubleClick.sourceEditWindow` (`DoubleClickSettings.cs`): default stays ON.** #1520 only moves the literal `true` into one named constant `SourceEditWindowDefault = true`, used by the setting, the Edit window gate and the double-click gate (the old double-click gate wrongly waited on the other switch, `opensEditWindow`, OFF; that was the bug).
6. **Build:** whole solution Release, **0 errors**, 14 min 40 s.
7. **Tests (Release):**
   1. **Civil net10 full: 19,154 total, 19,134 passed, 19 skipped, 1 failed.** The failure is the known Glen Eira back-test (`BackTest_GlenEira24115_Computed_WithinTolerance`, SSR 1.69 vs 2.58 m3). Total is in the thousands and inside the expected 19,150 to 19,170 (C-59 19,109 plus 18 from #1520 plus 26 from #1517 gives 19,153 to 19,154), so the reference name was right.
   2. **Manager net10: not run: Manager unchanged.**
   3. **Civil net48 focused: 348 of 348 passed.** Classes: DoubleClick, CheckIgnore, IgnoreFindingPicker, IgnoredChecks, Bug859, KeywordPromptBracketTag, CrossModuleGuard, SettingsWindowV3, SettingsLoadRobustness, SettingsValueCatalog, AdvancedSettings, DownpipeSettings, RedoSafe. No new red, so no base comparison was needed.
   4. **The command-count guard Opus asked about passes on the merged branch** (`CrossModuleGuardTests`, Civil commands 145 to 146, inside the net48 run; the net10 full run also has only the Glen Eira red).
   5. Installer.Tests were compiled in the solution build, not run (rule).
8. **For the finalizer:** (a) both merges were clean with **no conflict at all**, `REGRESSION_LOG.md` included, because the two entries landed at different places: the CDCHECKIGNORE entries sit at the top of the file (lines 1 to about 10) and the two BUG-859 entries sit at about line 44434. Both are present, 0 conflict markers. Order in the file is therefore not "#1520 then #1517", worth a look if the finalizer wants tidy order. (b) `sourceEditWindow` ON and `allowIgnoreFinding` OFF as asked. (c) The Settings window fit test passed (tallest tab 670 px). (d) Nothing here was seen in AutoCAD.
9. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. No bug marked FIXED, nothing closed or deleted, no PR touched.

## 1. Merge list with heads

1. **#1520** @ 9daa061d (branch `b04/bug-859-dp1-doubleclick`, PR base `claude/rel-20261020l`). Not an ancestor of the branch (checked). Merge `97cb58ec`. No conflict. Numstat equals the PR's own file list (7 files: `Bug859SourceDoubleClickTests.cs` +116, `OvernightLabelDoubleClickAndCopyTests.cs` +2/-2, `SourceTagCommand.cs` +1/-1, `DoubleClickSettings.cs` +8/-1, `CompoundEditModeService.cs` +30/-9, `DoubleClickEditTable.cs` +17, `REGRESSION_LOG.md` +17). Merge: 191 insertions, 13 deletions.
2. **#1517** @ 440b13fa (branch `claude/b4-wire-ignored-checks`, PR base `claude/rel-20261022l`). Not an ancestor (checked). Merge `037b9311`. The PR branch already holds a merge of the C-59 line, so its file list relative to the C-59 base is also its list relative to the new tip: numstat of the merge equals `gh pr view 1517 --json files` exactly (6 files: `IgnoreFindingPickerTests.cs` +146, `CrossModuleGuardTests.cs` +1/-1, `command-registry.json` +9, `CheckIgnoreCommand.cs` +156, `IgnoreFindingPicker.cs` +70, `REGRESSION_LOG.md` +10). Merge: 392 insertions, 1 deletion. Merged last, as Opus asked.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c60`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, every command run in the foreground. Refs: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`, AutoCAD 2027 on PATH, a 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked build output). A fresh Temp folder (long path form) and CE log folder inside it for every step.
2. **Build lock** `C:\CE_PLAN\desk_jobs\build.lock` taken by exclusive create only while each command ran and removed after each; not present at the end.
3. **AutoCAD (acad.exe) was NOT open** during any run (process count 0 at start of the settings check and at the end).
4. **Timings:** solution build 16:42 to 16:57, Civil net10 full 16:57 to 17:03 (5 m 40 s of tests), Civil net48 focused 17:04.
5. **Tim's four settings files, before (16:41) and after (17:04): unchanged**, same content and same modified times: `TIM_CE_CADTOOLS\CD_Settings.json` acd64e79 (15,270 bytes, 11 Mar 08:22), `TIM_CE_CADTOOLS\CS_Settings.json` 622a246f (351,713 bytes), `CE_CVL_SUITE\settings.json` efe307c4 (672 bytes), `CE_STRUC_SUITE\CS_Settings.json` 2972ce70 (35,259 bytes, written 22 Oct 14:37, before this job). The STRUC file differs from the C-59 reports (f6829293, 35,180 bytes) because something rewrote it at 14:37 today; I did not touch it and do not know what did.
6. **Not tested:** nothing in AutoCAD or accoreconsole; no window looked at on screen; CDCHECKIGNORE and the downpipe double-click have never been run on a drawing; Manager, Structural, Installer tests not run.

## 3. Hygiene

1. Remote branch `claude/rel-20261022m` stays. Local worktree `C:\ce-asm\c60`, its local branch, `C:\ce-asm\c60logs` and the `c60_*` Temp folders removed after this report was pushed. No PR closed, no branch deleted, no version edited, `DESK_LOG.md` not edited.
