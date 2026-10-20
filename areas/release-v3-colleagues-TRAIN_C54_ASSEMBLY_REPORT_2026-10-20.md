# Train C-54 assembly report (Civil + Manager), Tue 20 Oct 2026

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261020h` at `a85ea975`, pushed (normal push). Base `origin/claude/rel-20261020g` at `0d3b1f49` (C-53 plus the Manager 75-file guard; the 75 guard is on the base, so no stop).
2. **Merged: 2 PRs.** #1170 (REDO safety, Civil) at its fix-round head `5d1d89e1`, and #1165 (CE_SHARED start-up check now inside each module, Civil + Manager) at its fix-round head `d3c9c142`. Both heads match the live PR heads checked with gh immediately before each merge (REVIEWLANE_LOG entries 1488 and 1489 name them).
3. **Left out:** nothing that was in scope. Structural PRs, #1382, #1384, #1419, #1423, #1191, #1183, #1180 and anything HOLD, REJECT or SUPERSEDED-BY were not touched (ruling A and the job list).
4. **Shared/:** neither merged PR changes `Shared/` against this train. `git diff --name-only 0d3b1f49 HEAD` has 0 files under `Shared/`. (gh lists 7 `Shared/` files on each PR page because the PRs sit on the older base 20261009w; those come from the train, not from the fix. Net change vs this train is 9 files, none in `Shared/`.) Civil and Manager keep the same CE_SHARED.
5. **Build:** whole solution Release, 0 errors (889 warnings, all existing kinds), 17 m 04 s.
6. **Tests:** Civil net10 full 18,949 run, 18,929 pass, 19 skipped, 1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance` (the known red, the only failure). Manager net10 full 832 of 832. Civil net48 focused (RedoSafe, DoubleClick, CeSharedCopyCheck, ProjectData) 265 of 265. The totals are in the thousands, so the wrong-ref-name trap is not in play.
7. **For the finalizer:** nothing blocking. Both merges are plain no-ff merge commits. Not run: Installer.Tests, Manager release-candidate build (PrepareReleaseBundle), full net48 lane, AutoCAD. Nothing installed or deployed; no version bumped. No bug marked FIXED (BUG-416 and BUG-522 stay open until Tim or Codex drives them in AutoCAD).

## 1. Merge list

1. **#1170 @ 5d1d89e1e33a** (base was rel-20261009w), merge commit `61950380`. Merged clean. Net change vs the train: 3 files: `Modules/Drainage.Tests/Services/RedoSafeCallGraphTests.cs` (+41), `Modules/Drainage/Services/ProjectDataService.Persistence.cs` (+16 -4), `REGRESSION_LOG.md` (+21). Every one of those 3 is in the PR's own file list. In AutoCAD terms: after U, "Select this run" / "Select whole network" no longer writes the old project file into the drawing at the click, so REDO survives.
2. **#1165 @ d3c9c142204b** (base was rel-20261009w), merge commit `a85ea975`. One conflict: `REGRESSION_LOG.md` only; kept every entry from both sides (marker lines removed, nothing else). `Modules/Manager/Plugin.cs` auto-merged (+15 lines, the check call sits with the train's CeManagerStartupWords). Net change vs the train: 7 files: Drainage and Manager `CeSharedCopyCheck.cs` (+70 each), their two test files (+92 each), `Modules/Drainage/PluginInitialization.cs` (+18), `Modules/Manager/Plugin.cs` (+15), `REGRESSION_LOG.md` (+21). All 7 are in the PR's own file list (710 and 713 files each, because the PRs sit on the older base).
3. **Numstat check note:** `gh pr view --json files` gave only the first 100 files; I used the full paginated list (`gh api .../pulls/N/files`) for the comparison. The merged change is a strict subset, as expected for PRs that already carried the train.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c54`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, every command in the foreground (the solution build ran past the 10-minute tool limit, so I polled the build lock in foreground loops until it finished). `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder on a short PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, TEMP and CE log folder per step in `C:\ce-asm\c54tmp`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (checked gone).
2. **Timings:** solution 17 m 04 s; Civil net10 5 m 12 s; Manager 5 s; net48 focused 5 s.
3. **Failing tests:** `Failed` lines read from the saved log: only Glen Eira, which is the known red and sits in code neither PR touches. No new red, so no base comparison was needed.
4. **Tim's settings files** (CD_Settings.json, CS_Settings.json in TIM_CE_CADTOOLS; CS_Settings.json in CE_STRUC_SUITE; CE_CVL_SUITE settings.json) hashed before and after: **unchanged** (acd64e79, 622a246f, 24d8e5f7, efe307c4).
5. **Not run:** Installer.Tests (never run on this PC), Manager release-candidate build, Structural, full net48 lane, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. AutoCAD and accoreconsole not running (checked). No PR closed, no branch deleted, no version edited. `DESK_LOG.md` not edited.
2. Worktree `C:\ce-asm\c54`, `c54logs`, `c54tmp` and the scratch `run54.ps1` are removed after this report is pushed.
3. **Status of the four words:** built (whole solution) and unit-tested. Not installed. Nobody has opened it in AutoCAD.
