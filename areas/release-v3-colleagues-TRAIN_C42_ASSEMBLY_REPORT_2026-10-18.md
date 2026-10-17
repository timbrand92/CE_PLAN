# Train C-42 assembly report (Civil + Manager), Sun 18 Oct 2026 (about 01:25, Melbourne time)

**Answer first:** the C-42 train is assembled and pushed. All 21 Hunt Civil E bug-fix PRs (#1317 to #1337) merged, none skipped. It builds with 0 errors on every lane and the tests are green apart from the known Glen Eira red, eight net48-only environment reds and the known Installer reds. Every new switch that changes drawing output ships ON only where the review said ON is right (the old behaviour is the bug); the copy-and-grip switch ships OFF. Nothing was installed, deployed, version-edited or opened in AutoCAD. Built and unit-tested only; nobody has looked at any of it in AutoCAD.

## 1. The branch

1. **Branch:** `claude/rel-20261018b`, pushed to origin (new branch, normal push). Final head `6c700e2c5352bebfd6df7437b86ce5021ade9613`. Local head equals origin head.
2. **Base:** `origin/claude/rel-20261018a` at `f51e6307` (the C-41 line with the version commit, Civil 3.0.52 / Manager 1.1.52). Verified: the tip had not moved. The installed Civil bundle reads 3.0.52+f51e6307 (read only).
3. **Method:** plain `git merge --no-ff`, one merge commit per PR (21 merge commits), no squash, no rebase, no cherry-pick. Before every merge `merge-base --is-ancestor` said "not yet contained". No assembly fix commit was needed this time (no count or hash re-pin followed from any merge).
4. **The branch contains** the whole C-41 branch (rel-20261018a with the 3.0.52 version commit) plus the 21 PRs.

## 2. What merged (21 of 21, in this order, heads used)

The order is the one in the Opus review entry 1110: the 15 MERGE ones first, then the six fix rounds. Every PR is open, draft, base `claude/rel-20261018a`. No head moved while I worked (re-checked at the end; no open PR above #1337).

1. **#1319** `6e30fc50`, **#1320** `2c21b843`, **#1323** `3c539f02`, **#1324** `4e41ad56`, **#1325** `c9ee9843`, **#1326** `f100040a`, **#1329** `503faf55`, **#1330** `e857dedb`, **#1332** `5bc5a17b`, **#1333** `c0525699`, **#1334** `a1320ec6`, **#1335** `934dc9c0`, **#1336** `212ca77d`, **#1328** `59255e05`, **#1337** `6b57f96c`.
2. **The six fix rounds, newest heads:** **#1317** `c14f04c8`, **#1318** `4a56a72d`, **#1321** `6db4dc78`, **#1322** `2f6cfca5`, **#1327** `2644c197`, **#1331** `5af6ef3e` (all six as named in the brief).
3. **One head is newer than the one Opus reviewed with MERGE:** **#1323** was reviewed at `2b8ab057` (MERGE with one LOW: the printed line said "Nothing was changed" next to "Continuing as drawn"). The PR is now at `3c539f02`. I merged the newer head; I did not re-review it. The finalizer should confirm the LOW is fixed. The other 14 MERGE heads equal the reviewed heads.
4. **Heads of the six fix rounds** are newer than the heads Opus reviewed (3373b6cd, 1a091ee5, c95e3264, 255338cd, 7a6b20b3, b675df6e); they are the fix rounds entries 1089, 1090, 1093, 1094, 1099 and 1103 asked for. I did not re-review the fixes. The finalizer should confirm each fix against its entry.
5. **Numstat check:** after every merge `git diff --numstat HEAD~1 HEAD` was compared with the PR's own numstat (`base...head`). All 21 are identical file by file, except REGRESSION_LOG.md on two PRs where the added-line count differs by one blank separator line (#1324: 10 in the merge against 9 in the PR; #1327: 11 against 12). Explained in section 3.1; the totals add up exactly.
6. **Skipped:** none. No PR was stopped for a conflict, version, csproj or PackageContents change.
7. **Unreviewed PRs:** no open DRAFT PR numbered above #1337 exists (checked at the start and again at the end).

## 3. Hand resolutions

1. **REGRESSION_LOG.md:** clashed on 20 of the 21 merges (every PR adds its section at the top). Resolved byte-safe by a script file: Latin-1 round trip so no byte changes, both sides kept, the incoming PR's section put on top (newest first), one blank line between sections, the existing line endings kept (the working copy is CRLF, the stored file is LF; `git ls-files --eol` reads `i/lf` after every commit). Final checks on the finished file: 0 conflict markers, 1,074 headings and 0 duplicates, the 287 added lines equal the sum of the 21 PRs' own added lines exactly (every non-blank added line of every PR is present, 0 missing), no new control characters (the 4 that exist are in the base), no heading without a blank line before it, one double blank line in the first 400 lines that was already in the base (line 387, inside the C-41 entries).
2. **UserSettings.cs:** clashed twice as Opus predicted. #1337 against #1335 and #1322 against #1337, both at the same spot after `pitScheduleNaturalOrder`. Resolved by keeping every block whole, each with its own `/// <summary>` opening line and a blank line between (the shared opening summary line had been taken by one side). Order in the file: `refuseSplitOfPairedPipe`, `copyCleanUpKeepsEveryPiece`, `relinkKeepsRecordedDirection`. Braces and structure checked by eye and by the build. `cascadeKeepsPitDrop` (#1317) and `cleanUpGripRotateScaleCopies` (#1328) merged without a clash.
3. **RedoSafeReviewedHooks.baseline.txt:** not edited by me. #1333 adds its own 3 reviewed lines (`LinkService.RestoreSkippedPipesToPitLists => TransactionManager.StartTransaction [normal transaction]`, once in each of the file's three sections); no PR renumbered an existing line. The redo guard passed.
4. **Count tests and registry rows:** none changed (no command, guide or registry count moved in any of the 21), so nothing was re-pinned. `ce-tool-register.json` was not touched.

## 4. Shared, registry and Settings

1. **Files under Shared/ that changed:** none. Manager source: none. Civil and Manager `CE_SHARED` stay byte-identical (nothing in either changed). Manager does not need to ship in this train.
2. **Registry:** `command-registry.json`, `council-profiles.json` and the Manager and Structural registries: not changed. No csproj, props, PackageContents or version file changed.
3. **New Settings properties, 5 in all (no Settings window row for any, R-00 standing LOW from the review):**
   1. `linking.cascadeKeepsPitDrop` default **true** (#1317). Old behaviour is the bug: a level change used to push a bare level down and lose the pit drop.
   2. `linking.relinkKeepsRecordedDirection` default **true** (#1322). Old behaviour is the bug: a pipe drawn from its low end turned round on relink.
   3. `linking.refuseSplitOfPairedPipe` default **true** (#1335). Old behaviour gave a wrong level.
   4. `linking.copyCleanUpKeepsEveryPiece` default **true** (#1337). Old behaviour lost labels.
   5. `linking.cleanUpGripRotateScaleCopies` default **false** (#1328). OFF is right (pinned performance contract; no Codex pass yet).
   Four of the five ship ON by the review's ruling that the old behaviour is the bug; none changes an existing default.
4. **Behaviour changes a drafter will notice (all from the review entries; none seen in AutoCAD):**
   1. **Edit Pipe cascade (#1317):** after "Recalculate downstream?" the levels downstream move with the pit drop kept (50 mm) instead of copying the bare level; a blank end is skipped and named; the junction takes the lowest arriving pipe and says so.
   2. **Turned pits (#1318):** CD's pipe-fits-pit check and the label and cover-text step use the pit's own turn (block rotation); an unturned pit is exactly as before.
   3. **Edit Pipe (#1319):** a change to the Q box alone is now saved.
   4. **Flow arrow (#1320):** a given level of 0.00 is a real level for the arrow.
   5. **CD Existing line (#1321):** a curved or closed source line is kept and the pipe is drawn from its points, with a plain-words message.
   6. **Relink (#1322):** a pipe keeps its recorded From and To; this also changes when the pit keys are written on CD, COPY and relink (review entry 1094 asked for a separate flag or a test; the PR head is the fix; confirm).
   7. **Pit numbers (#1323):** CDEDIT batch gives each no-record pit its own next number; CD Upsize takes the number from the record and, if the label disagrees, does not upsize and says why.
   8. **Lid wording (#1324), Pit Schedule level on one half of a breakline pipe (#1325), pit turn and multi-resize re-snap (#1326), batch Design grade warning and held-end text (#1327), rotated-UCS end pick (#1329), CDUPGRADE Merge keeps typed fields (#1330), downpipe junction and CDREPAIR reach in metre drawings (#1331), pit labels follow every move on AutoCAD 2027 (#1332, #1334), pit relink restores skipped pipes (#1333), inline split of one half of a broken pipe refused (#1335), erased label no longer stops the rebuild (#1336), copy clean-up keeps every piece (#1337).**
   9. **#1332 with #1334:** on AutoCAD 2027 the label memory never hit before, so Tim's PC will see the stored baseline used for the first time.

## 5. Redo-killer sweep (standing rule)

1. **Added non-test C# lines with the watched calls:** one, `db.TransactionManager.StartTransaction()` in `LinkService.RepairAudit.Relink.cs` (#1333, `RestoreSkippedPipesToPitLists`). It is reached only from the scoped pit relink inside the same pass, not from a hook; its 3 baseline lines are in the PR and Opus accepted it (entry 1105). Not HIGH.
2. **No** new `SetCurrentView`, `SetSystemVariable`, `Application.Idle`, `CommandWillStart`, `DocumentActivated`, selection-changed or timer line in any added Drainage code. #1332 and #1334 change the label memory and the "followed this command" note only (no call added).
3. **Redo guard tests:** green on net10 (inside the Civil run) and on net48 (focused run).

## 6. Builds

1. **Whole `CE_ACAD_PLUGIN.slnx` Release**, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs from the CERef 24.3.0 folder, net8 from the 2026 ref folder, net10 off the AutoCAD 2027 install: **0 errors, 885 warnings** (same warning count as C-41), 3 min 41 s.
2. **Native transform file:** copied read-only from another built worktree into the ignored build folder, removed again by `git clean -fdXq`.
3. **Disk:** about 24 GB free throughout. The shared build lock was taken and released around every build and test run (no waits).

## 7. Tests (net10 with AutoCAD 2027 on PATH, `--no-build`, one NUnit worker, log folder redirected to scratch; every run printed a non-zero total)

1. **Manager:** 751 run, 751 pass (C-41: 751).
2. **Civil (Drainage.Tests, net10):** **18,115 run, 18,095 pass, 19 skipped, 1 failed.** C-41 was 17,966 / 17,946 / 19 / 1. The 149 extra tests are this train's. The one red is `BackTest_GlenEira24115_Computed_WithinTolerance`, the known one on the plain base. The redo guard, the command count test (145), the Help guide count test (81) and the registry-hash tests passed.
3. **Smaller suites:** CommandTruth 64/64, TestHarness 101/101, Spine 81/81, Diagnostics 19/19, AI.Core 42/42 (net8), ReleaseTests 16/16. All equal C-41. The TestHarness flake `OfflineHelpTests.ReadingStateRoundTripsAndRecoversFromCorruptOrRemovedTopic` did not fire this time.
4. **Installer.Tests** (brief's filter, net9): 273 run, 237 pass, 36 fail. Same counts as C-38 to C-41. I did not diff the 36 names against the earlier lists.
5. **Focused net48 run** (Drainage.Tests, every changed test class plus RedoSafe, the IL dependency tests, DoubleClick and TidyLabels): 380 run, 355 pass, 17 skipped, **8 failed. All eight are environment-only** (the net48 lane builds against AutoCAD reference stubs with no method bodies, so a test that touches an AutoCAD value type throws `InvalidProgramException`):
   1. `Bug687DesignFlowOnlyChangeTests` x4 (`QChangedFrom30To45_IsAChange`, `QClearedWhereOneWasSaved_IsAChange`, `QTypedWhereNoneWasSaved_IsAChange`, `QUntouched_IsNotAChange`): `ObjectId.get_Null()` in `PipeEditContext..ctor` (#1319's new tests). They pass on net10.
   2. `PreparedPipeAggregateTests.MissingAnyAcceptedAnnotationRefusesBeforeOutputStarts(0..3)`: `Point3d.get_Origin()` in the test's `Parameters()`. That test and `Point3d.Origin` already exist in the C-41 base (line 93 there), so it is the same stub-lane trap, not new.
   3. The two Tidy labels net48 reds of C-41 were not among the failures this time (the log lists only failed and skipped tests, and neither name is in it; I did not investigate why they differ from C-41).
   The fix is in the tests (read the value, not the stub, or skip on the stub lane). Not a baseline pin, so I left it.
6. **Not run:** Structural tests (no Structural file touched), AI.Harness tests, Manager on net48 (net10 only), accoreconsole, anything in AutoCAD.

## 8. Hygiene

1. **Settings files, hashes unchanged before and after all runs:** `CD_Settings.json` 15,270 bytes ACD64E79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes 622A246F; `CE_STRUC_SUITE\CS_Settings.json` 34,858 bytes 24D8E5F7.
2. **Live CE folders under the roaming profile (files / bytes), identical before and after:** CE_CVL_SUITE 102 / 33,997,512; CE_STRUC_SUITE 2,474 / 2,096,880,689; TIM_CE_CADTOOLS 22,193 / 1,130,251,109.
3. **AutoCAD:** not running at any point. Nothing was written to the application plugins folder. `git clean -fdXq` done, worktree clean, no screenshots or docs images regenerated into the commit.

## 9. What the finalizer should do

1. **Confirm the newer heads** against the review entries: #1323 (`3c539f02`, the "Nothing was changed" LOW), and the six fix rounds #1317 (HIGH: Edit Pipe cascade reads the edited pipe's OLD arriving level; MEDIUM: preview recompute keeps the anchor), #1318 (block rotation in the CD fit check), #1321 (closed polyline kept, no loop), #1322 (key write separated or tested and announced), #1327 (held end Hidden, not Enabled), #1331 (chainage stored as before, converted for the words only).
2. **Add the C-42 merge entry** to the log (the assembler adds none).
3. **Fix the net48 tests** in section 7.5 if net48 test runs are part of the gate.
4. **Codex recipe additions** from review entry 1112: Edit Pipe raise and lower with a 50 mm pit drop; ROTATE then CD a wide pipe into a 600 x 900 pit; closed and curved polylines in CD E; a downpipe on a run in a metre drawing (junction wording still shown); two Properties-palette pit moves in a row (#1332 with #1334); Pit Schedule level on one half of a breakline pipe; erase a pipe in an older drawing; plus #1328 with #1337 (copy clean-up) and #1317 with #1327 (two cascade routes).
5. **Settings window:** none of the five new switches has a row in the Settings window (R-00); decide whether that blocks the install.
