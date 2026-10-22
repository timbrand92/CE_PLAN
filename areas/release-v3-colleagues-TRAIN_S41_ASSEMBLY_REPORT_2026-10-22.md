# TRAIN S-41 (Structural) assembly report, 22 Oct 2026

Branch `claude/rel-20261022s2`, pushed. Built and unit-tested only. Nobody has opened this train in AutoCAD. I installed nothing, opened no AutoCAD or accoreconsole, changed no version field, closed no PR, deleted no branch, marked no bug FIXED, did not edit DESK_LOG.md. Thu 22 Oct 2026, about 12:21 to 13:00 Melbourne (PC clock). Sonnet 5.5, Team, headless.

## ANSWER FIRST

1. **Branch `claude/rel-20261022s2`, head `7fcbdd4b33895fc0f3d9aa48adc2c4775cfd2f06`**, pushed (local equals origin). Base: `origin/claude/rel-20261022s` head `329691b70703b025fa78c45a986b0dd7c1bdffb2` (the installed Structural 1.0.120, train S-40). `git ls-remote` gave `329691b7` at the start and again at the end: the base had not moved. The name `claude/rel-20261022s2` was free on origin.
2. **5 of 5 PRs merged, 0 skipped:** #1510, #1498, #1496, #1509, #1518. Plain `git merge --no-ff`, one merge commit each, no squash, rebase or cherry-pick. Every live head equalled the head named in the brief, re-read from GitHub immediately before each merge and fetched from `refs/pull/N/head` (the two equal).
3. **Left out, as ordered:** every Civil and Manager PR (train C-59), #1382, #1384, #1419, #1423, #1247, #1193, #1213, #1214 (plan items on hold), #1517, anything HOLD, REJECT or SUPERSEDED-BY. Nothing else was considered.
4. **Shared / Civil / Manager files touched by the merged PRs: none.** Outside `Modules/Structural*` the five PRs change only `REGRESSION_LOG.md`. Nothing under `Shared/`, `Modules/Drainage`, `Modules/Manager`, `CE.Host` or `Installer`, and not `Assets/Config/ce-tool-register.json` or Structural `command-registry.json`. The whole train against the S-40 base: 30 files, +1011 -92.
5. **Settings values added (all default ON, all with a recovery label):**
   1. `Layouts.HatchDensityFollowsPaper` (#1498), default `true`.
   2. `Layouts.TagTextFollowsLabelHeight` (#1496), default `true`.
   3. Nothing else. #1509 (pure engine, no caller) and #1518 add no Settings value; #1510 adds none.
6. **Conflicts:** `REGRESSION_LOG.md` in every PR except #1518 (kept every entry, in order, zero markers; the five merges add 74 lines and remove 0 in total). #1496 clashed with #1498 in `UserSettings.cs` and `SettingsService.LoadRecovery.cs` as expected; kept both, and S-40's `FollowAnyDrawingScale` label (the one naming AD, LD and Q). Lines still present, section 2.
7. **Build: 0 errors.** Whole solution Release 0 errors (927 warnings); Structural standalone and hosted 0 errors; the three Structural test projects built on net48, net8 and net10.
8. **Tests at the final head:**
   1. **Structural net10: 5211 passed, 0 failed (5211 run).** S-40 finalizer was 5191.
   2. **Structural net48: 4471 passed, 39 failed, 698 not run (5208).** I built the S-40 base `329691b7` in a second worktree and ran the same chunks: **37 failed, 4452 passed, 698 not run (5187)**. The train list is the base list **plus exactly two new names**: `ZcOutline_IsACleanZ_ItNeverCrossesItself` and `ZcOutline_WebIsOneThicknessThick_AndTheFlangesPointOppositeWays`. Both are new tests added by #1510 (they do not exist on the base), both throw `System.InvalidProgramException` (the net48 reference stub, the same kind as the base's `ZcProductionVertexBuilder_MatchesSharedTranslatedEnvelope` and `TheMoveAutoCADApplies_LandsEveryPointWhereTheEngineSays`), and both pass on net10. Not a code fault of #1510. No base red turned green.
   3. **DesignCore: 2195 per lane (net48, net8, net10), 2190 passed, 5 failed per lane**, the same five release-settings names as S-40 (`HostedAndStandaloneModernOutputs_AreIsolatedAndCompileOppositeRuntimeContracts`, `LoadOrder_CannotBindStandaloneStructuralToCeShared` x2, `StandaloneReleaseLanes_HaveNoCeSharedDependencyOrPayload`, `StandaloneReleaseLanes_KeepCommandClassesAndSbeam_LeaveCeVersionToManager`). 2195 vs 2173 is the #1509 record tests and the #1518 layer test.
   4. **CE.CommandTruth.Tests (net10): 22 of 23.** The one red is the standing `Structural_KnownRegistryDriftRemainsPinnedBacklog` ("Expected: 301"), red on S-39 and S-40 too. No new red.
   5. **Structural.ReleaseTests: 10 of 10 on net48, net8 and net10.**
   6. **Guards:** all ran inside the full runs (Plugin.cs pin, keyword guard, doubled-question guard, redo-safe, drawing-units); none is red on net10, none is among the net48 reds.
9. **Re-pins by me: none.** No fingerprint or count was changed by a merged PR, so I made no assembly commit. The branch head is the #1518 merge commit.
10. **Tim's four settings files: unchanged** between my start (12:21) and end (12:57). One note: the Structural `CS_Settings.json` is `f682929` / 35,180 bytes, last written 08:36 today; the S-40 report logged `f68eeb5e` / 34,856 bytes. That change happened before this job (AutoCAD is running on this PC now and writes that file at its own start); I did not cause it.
11. **Do not mark FIXED:** BUG-858 (Z purlin and its SBEAM window preview), BUG-748 (hatch density), BUG-531 (tag height), CEMEMBER (b) to (h). Each needs a robot PASS plus a Codex PASS in AutoCAD.
12. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Merge list, in order, with heads

1. **#1510 `1ea2517d`** (BUG-858, SBEAM window Z purlin picture uses the shared outline; base `claude/rel-20261020s`). Merge `ec875406`. Conflict in `REGRESSION_LOG.md` only; kept both. 7 files, matches the PR file list; log +19 -0.
2. **#1498 `80f28581`** (BUG-748, hatch density follows paper; stacked on #1497, whose head `4eb7b5be` is inside S-40, checked with merge-base). Merge `13a7a973`. Conflict in `REGRESSION_LOG.md` only; `UserSettings.cs` and `SettingsService.LoadRecovery.cs` auto-merged. 11 files, matches; log +10 -0.
3. **#1496 `48e4724b`** (BUG-531, tag text height follows label height; base `claude/rel-20261017s`). Merge `81a873df`. Conflicts in `REGRESSION_LOG.md`, `UserSettings.cs` and `SettingsService.LoadRecovery.cs`, all resolved keeping both. 7 files, matches; log +10 -0.
4. **#1509 `519afb37`** (CEMEMBER saved record and redraw plan, pure engine, no caller; stacked on #1506, merge `ea431d21` is inside S-40). Merge `58f753f8`. Conflict in `REGRESSION_LOG.md` only; kept both. 4 files, matches; log +25 -0.
5. **#1518 `45d50263`** (CEMEMBER office-renamed hidden or section-beyond layer is made dashed, colours 8 and 9, linetypes HIDDEN and HIDDEN2; base `claude/rel-20261022s`). Merge `7fcbdd4b`. Clean. 7 files, matches; log +10 -0.
6. **Checks:** before each merge `git merge-base --is-ancestor` showed the head was not already in the train. After each merge `git diff --numstat HEAD~1 HEAD` equalled the PR's own `gh pr view --json files` list, for all five. `REGRESSION_LOG.md` against the base: 74 lines added, 0 removed, no conflict markers. Live heads re-read after the push: unchanged for all five.
7. **Redo-killer scan (standing rule):** no added line in the whole train contains `SetCurrentView` or `SetSystemVariable`. Nothing runs on load other than the existing registrations.
8. **Registry:** no row changed. `command-registry.json` and `ce-tool-register.json` untouched.

## 2. The two Settings lines of each PR, still present after the #1496 / #1498 resolution

`UserSettings.cs` (all three properties present, each with its own summary comment):
1. `FollowAnyDrawingScale` (#1497, in S-40, line 1922): `public bool FollowAnyDrawingScale { get; set; } = true;`
2. **#1498:** line 1930: `public bool HatchDensityFollowsPaper { get; set; } = true;`
3. **#1496:** line 1937: `public bool TagTextFollowsLabelHeight { get; set; } = true;`

`SettingsService.LoadRecovery.cs` (lines 1321 to 1323):
1. `{ "Layouts.FollowAnyDrawingScale", "Hatches, break lines and the dimension tools (AD, LD, Q) follow any drawing scale (not only 1:20 and 1:100)" },` (S-40's label kept; #1496's older label of the same key dropped)
2. **#1498:** `{ "Layouts.HatchDensityFollowsPaper", "Hatches look the same density on paper at every scale (off = the earlier flat pattern scale)" },`
3. **#1496:** `{ "Layouts.TagTextFollowsLabelHeight", "Beam tags (EBT and the rest of that family) use the label height on paper times the drawing scale, like a 25C note (off = fixed 250)" },`

`git diff 329691b7 HEAD` on `UserSettings.cs` adds exactly the two new properties (+15 lines with comments), removes nothing.

## 3. Test evidence

1. **Environment:** private worktree `C:\ce-asm\s41` (short path), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, every command in the foreground (long ones waited on with a foreground poll), build lock folder `C:\CE_PLAN\desk_jobs\build.lock` taken only while a command ran (gone at the end). `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder at the front of a short de-duplicated PATH, a scratch `CE_LOG_DIR_OVERRIDE` per run, NUnit workers 1. My runner scripts are throwaway files in `C:\ce-asm` (not in any repo).
2. **Whole solution method (as S-39 item 2):** restore with `EnableUnifiedHostAdapters=true`; then a separate restore and build of `CE_STRUC_SUITE.csproj` standalone (without that property: with it the build only writes `bin\Hosted`) and a copy of `bin\Standalone\Release` to `bin\Release` (CommandTruth reads that path); then the solution with `EnableUnifiedHostAdapters=true`. 0 errors. Installer.Tests compiled, not run.
3. **Structural.Tests net10 and net48:** 422 class names read from source in 15 chunks of 30 (the `SbeamEditAutoCadEvidenceReaderTests` class left out: it hangs) plus the nested-class filter (`FullyQualifiedName~+`, 7 tests). Net10 chunk passes 375, 322, 221, 284, 357, 281, 362, 361, 359, 714, 392, 316, 327, 506, 27, 7 = **5211, 0 failed**. Net48: 39 failed, 4471 passed, 698 not run (same skip total as the base). The extra 20 net10 tests over S-40 come from the new tests of #1496, #1498, #1509, #1510 and #1518; I did not reconcile to an exact per-file count.
4. **Net48 base comparison:** base `329691b7` built in `C:\ce-asm\s41b` (Structural.Tests net48), same chunks: 37 failed; names compared with `comm`: the train adds only the two #1510 Zc tests, removes none.
5. **DesignCore and ReleaseTests:** TFMs `net48`, `net8.0`, `net10.0` for DesignCore (totals read, not zero), `net48`, `net8.0-windows`, `net10.0-windows` for ReleaseTests.
6. **Not run:** Structural net8 tests (built only, as S-39 and S-40), the Sbeam evidence class (hangs), Drainage, Manager, Installer.Tests (compile only), the DesignCore release-lane gate with its environment set, anything in AutoCAD or accoreconsole.

## 4. Hygiene

1. **Tim's settings files, first 8 hex of SHA-256, before (12:21) and after (12:57), all unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 bytes `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes `622a246f`; `CE_CVL_SUITE\settings.json` 672 bytes `efe307c4`; `CE_STRUC_SUITE\CS_Settings.json` 35,180 bytes `f682929` (my hash script prints seven characters; the file was written at 08:36, before this job, and differs from S-40's `f68eeb5e` / 34,856 bytes).
2. **Pictures:** test runs rewrote about 70 files under `docs/image/V3_WINDOWS`; none was committed (the branch holds merge commits only) and the worktree was removed.
3. **Leak scan:** clean on the push. No `--no-verify`.
4. **No PR closed, no branch deleted, no version edited, nothing installed or deployed, DESK_LOG.md untouched, no bare python.**
5. **Cleanup:** worktrees `C:\ce-asm\s41` and `C:\ce-asm\s41b` removed with their logs, runner scripts and `refs/tmp/pr*` helper refs. Older `C:\ce-asm` files from other jobs are not mine and were left.

## 5. For the finalizer

1. **Judge the five merges together.** #1510 needs a look that the SBEAM window preview and the drawing now share the one Z outline (BUG-858). #1498 and #1496 add two Settings switches (default ON, no Settings-page row yet). #1509 is dead code until a caller exists. #1518 changes which layers CEMEMBER creates (a renamed hidden layer now dashed), closing the S-40 LOW.
2. **The two new net48 reds** (`ZcOutline_*`) are the stub failure, not a fault; they only show that the net48 lane here cannot run tests that touch AutoCAD geometry types.
3. **Values and switches without a Settings page row:** `HatchDensityFollowsPaper`, `TagTextFollowsLabelHeight`, `FollowAnyDrawingScale` and the CeMember group (Codex window lane).
4. **Carryover from S-40:** the stale CEMEMBER help text; the version field is still 1.0.120 (payload job bumps).
5. **What Codex should look at in AutoCAD (copies only), after install:** SBEAM with a Z purlin: the window picture and the drawn section are the same clean Z. LBUH dots at 1:20, 1:50 and 1:100: same density on paper. EBT tag text at 1:50 or 1:200 with label height 2.5 mm: the tag is 2.5 mm on paper. CEMEMBER: rename the hidden layer in settings, draw an elevation, check the hidden lines show dashed on the renamed layer.
