# Train C-43 assembly report (Civil + Manager), Sun 18 Oct 2026 (about 06:20, Melbourne time)

**Answer first:** the C-43 train is assembled and pushed. All 3 PRs merged (#1339, #1340, #1338), none skipped. It builds with 0 errors and every test suite is green except the known Glen Eira red and the known Installer reds (36, same count as before). The first Civil test run found nothing to run (my mistake, section 6); the rerun is the one reported. Nothing was installed, deployed, version-edited or opened in AutoCAD. Built and unit-tested only; nobody has looked at any of it in AutoCAD.

## 1. The branch

1. **Branch:** `claude/rel-20261018c`, pushed to origin (new branch, normal push). Final head `0d32f1262d55395f3a0e48d1b13d797e40d1a4ea`. Local head equals origin head.
2. **Base:** `origin/claude/rel-20261018b` at `b06126db` (Version: Civil 3.0.53 / Manager 1.1.53, C-42). The tip had not moved.
3. **The branch contains** the whole C-42 branch (rel-20261018b with the 3.0.53 version commit) plus the 3 merged PRs. Plain `git merge --no-ff`, one merge commit each, no squash, no rebase, no cherry-pick. `merge-base --is-ancestor` said "not yet contained" before each.

## 2. What merged (3 of 3)

1. **#1339** `b2c0a5bb` (BUG-698, HIGH): CDSYNC keeps the size CE already recorded on a pipe instead of writing 100. Review entry 1122: MERGE.
2. **#1340** `225f0fc0` (BUG-698, second route, stacked on #1339): the drawing-recovery scan keeps the recorded size too. Merged after #1339. Entry 1123: MERGE.
3. **#1338** `1041f89b` (BUG-697): CD option E (Existing line) accepts a plain polyline, and a real CE pipe now reaches the "already a CE pipe" sentence. Entry 1121 was MERGE-WITH-FIXES at `12ec1d1c`; the head I merged is the fix commit `1041f89b` ("CD E pick lets a real CE pipe object reach..."). **Nobody has re-reviewed `1041f89b`**; the finalizer should check it against entry 1121's MEDIUM (pick filter exact match) and the two LOWs.
4. **Numstat check:** after each merge `git diff --numstat HEAD~1 HEAD` equals the PR's own numstat file by file, REGRESSION_LOG.md included (11, 10 and 11 added lines). Total added to the log: 32.
5. **Skipped:** none. No stop for conflict, version, csproj or PackageContents change.
6. **Unreviewed PRs:** no open DRAFT PR numbered above #1340 exists (checked at the start).

## 3. Hand resolution

1. **REGRESSION_LOG.md:** #1339 and #1340 merged clean. #1338 clashed at the top, as predicted. Resolved byte-safe by a script file (Latin-1 round trip, CRLF working copy kept, stored file is LF after commit, `i/lf`): both sides kept, #1338's section on top, one blank line between. Checks: 0 conflict markers, 0 duplicate headings, 32 added lines (11+10+11) exactly, 0 control characters in any added line.
2. **No other conflict.** No count test, registry row or hash needed re-pinning.

## 4. Shared, registry, Settings

1. **Files under Shared/ changed:** none. Manager source: none. Civil and Manager `CE_SHARED` stay byte-identical. Manager does not need to ship in this train.
2. **Registry, council profiles, csproj, props, PackageContents, version:** not changed.
3. **New Settings properties:** none.
4. **Behaviour changes a drafter will notice:**
   1. **CDSYNC (#1339):** a pipe that CE already has a record for keeps its recorded size. Before, a converted pipe object (no drawn width) came out as 100 mm every time and the Pit Schedule followed it. A pipe with no record still uses the drawn width, then 100.
   2. **Drawing-recovery scan (#1340):** the same rule when the schedule is rebuilt at open or a pipe is missing from it, so a recovered pipe no longer gets 100 written over its real size.
   3. **CD, answer E (#1338):** a plain drawn polyline is accepted again (it was refused since 5 Sep); a real CE pipe object now gets the "already a CE pipe" sentence instead of "That is not a polyline."
5. **Files changed:** `Rules/RecordedPipeSizeRule.cs` (new, pure), `Services/LinkService.Persistence.cs` (`ReadRecordedPipeDiameter`), `Commands/LinkCommands.cs`, `Services/ProjectDataService.Recovery.cs`, `Commands/CdCommand.ExistingLine.cs`, three new test files.

## 5. Redo-killer sweep (standing rule)

1. Only new watched call in added code: `StartOpenCloseTransaction` in `ReadRecordedPipeDiameter` (read, keeps REDO by the standing rule). No `StartTransaction`, `SetCurrentView`, `SetSystemVariable`, idle, selection-changed or timer line added. RedoSafe baseline not edited; the redo guard passed on net10 and net48.

## 6. Builds

1. **Whole `CE_ACAD_PLUGIN.slnx` Release**, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs from the CERef 24.3.0 folder, net8 refs from the 2026 ref folder, net10 off the AutoCAD 2027 install: **0 errors, 885 warnings** (same as C-42), 4 min 36 s.
2. **My mistake, cost one test cycle:** the first build passed the net8 folder as `_AcadRef80`, which made the Civil test project copy reference stubs and the net10 run printed "No test is available" (zero tests, exit 0). I deleted the Civil test net10 output, rebuilt with `_AcadRefNet8` (0 errors, 116 warnings, incremental) and reran. The small suites (Manager, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Installer, net48) ran once on the first build and are not rerun; their totals equal C-42's exactly, so the stub did not affect them.
3. The native transform file was copied read-only from another built worktree and removed again by `git clean -fdXq`. The shared build lock was taken and released around every build and test run. C: 22 GB free at start, 19.6 GB at the end.

## 7. Tests (net10 with AutoCAD 2027 on PATH, `--no-build`, one NUnit worker, log folder redirected to scratch; every run printed a non-zero total)

1. **Civil (Drainage.Tests, net10):** **18,129 run, 18,109 pass, 19 skipped, 1 failed.** C-42 was 18,115 / 18,095 / 19 / 1. The 14 extra tests are this train's. The one red is `BackTest_GlenEira24115_Computed_WithinTolerance`, the known one on the plain base.
2. **Manager:** 751 / 751 (C-42: 751).
3. **Smaller suites:** CommandTruth 64/64, TestHarness 101/101, Spine 81/81, Diagnostics 19/19, AI.Core 42/42 (net8), ReleaseTests 16/16. All equal C-42.
4. **Installer.Tests** (brief's filter, net9): 273 run, 237 pass, 36 fail. Same counts as C-38 to C-42. I did not diff the 36 names.
5. **Focused net48 run** (Drainage.Tests: `RecordedPipeSizeRuleTests`, `RecoveredPipeSizeWiringTests`, `AdoptedLineRoutePolicyTests`, `RedoSafe`): 40 run, 40 pass, 0 failed. The three new classes passed on net48 too.
6. **Not run:** Structural tests (no Structural file touched), AI.Harness tests, Manager on net48, accoreconsole, anything in AutoCAD.

## 8. Hygiene

1. **Settings files, size and hash start unchanged before and after:** `CD_Settings.json` 15,270 bytes ACD64E79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes 622A246F; `CE_STRUC_SUITE\CS_Settings.json` 34,858 bytes 24D8E5F7.
2. **Live CE folders under the roaming profile (files / bytes), before then after:** CE_CVL_SUITE 103 / 29,375,813 then 103 / 29,464,731; CE_STRUC_SUITE 2,475 / 2,096,922,440 then 2,475 / 2,096,923,903; TIM_CE_CADTOOLS 22,271 / 1,129,886,351 then 22,278 / 1,129,904,065. The byte counts grew a little. **AutoCAD was running when I started (one acad process) and was gone at the end**, so the growth most likely comes from that session's own logging; my test processes had `CE_LOG_DIR_OVERRIDE` pointed at scratch. Reported, not proven either way. Settings files did not change.
3. **AutoCAD:** I did not start it. Nothing was written to the application plugins folder. `git clean -fdXq` done, worktree clean, no screenshots or docs images regenerated into the commit.

## 9. What the finalizer should do

1. **Review `1041f89b`** (#1338 fix round) against entry 1121.
2. **Add the C-43 merge entry** to the log (the assembler adds none).
3. **Codex recipe additions** from entries 1122 to 1124: CDSYNC on a converted pipe object keeps its size (for example a 300 stays 300, Pit Schedule agrees); open an older drawing with an empty schedule and check recovered sizes; CD, answer E on a plain polyline (accepted) and on a real CE pipe (the "already a CE pipe" sentence).
4. **Test run note:** run Civil tests with the net8 ref folder passed as `_AcadRefNet8`, never `_AcadRef80`, or the Civil net10 run discovers zero tests and still exits 0.
