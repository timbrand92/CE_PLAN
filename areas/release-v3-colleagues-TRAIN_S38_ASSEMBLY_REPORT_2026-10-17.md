# TRAIN S-38 (Structural) assembly report, 17 Oct 2026

Branch `claude/rel-20261017s`, pushed. Built and unit-tested only. Nobody has opened this train in AutoCAD. I installed nothing, opened no AutoCAD, changed no version field, touched nothing in `Shared/`, edited no BUG_CARPARK, and wrote nothing in C:\CE_PLAN except this report. Sat 17 Oct 2026, about 03:20 to 04:00 Melbourne (PC clock).

## ANSWER FIRST

1. **Final head: `d13c6768bb6111db16f7aaa039531deb9f8f29ec`**, pushed, local head equals origin head. Base: `origin/claude/rel-20261010d` tip `0dfbd1d6` (S-37, Structural 1.0.117; the tip had not moved).
2. **19 of 19 PRs merged, 0 skipped:** #1254, #1261, #1262, #1264, #1267, #1265, #1270, #1272, #1273, #1287, #1294, #1295, #1278, #1285, #1282, #1298, #1306, #1300, #1304. Plain `git merge --no-ff` for each.
3. **Builds: 9 of 9 at 0 errors**, rebuilt at the final head (Structural.Tests, Structural, DesignCore.Tests on net48, net8, net10). Warning counts equal the S-37 baseline.
4. **Tests at the final head: Structural net10 5149 of 5149 passed. Net48 4412 passed, 36 failed, 698 not run. DesignCore 2063 per lane, 2058 passed, 5 failed.** The 36 net48 failures have exactly the same names as the S-37 finalizer's 36. All 8 guards pass.
5. **One assembly commit (`d13c6768`, test lists plus a log entry, no production code):** three test allow-lists went red because of intended changes in #1294 and #1272. Details in section 4.
6. **For the finalizer, two heads are fix heads with no Opus re-check on record:** #1300 `bf7a3e82` and #1304 `dc7dfe19` (builder fixes pushed after Opus round 3, for entries 1062 and 1063). I used them because the brief names them. See section 1.

## 1. What merged, in order, with heads

1. **#1254 `3af7d6b2`** (Codex, test receipts and constructor proof; based on the S-36 branch, brings its own commit).
2. **#1261 `b2e56d16`** (Codex, column picker "Press 1-9" instruction).
3. **#1262 `30e0cffe`** (Codex, Timber status message; brings its six committed pictures under `docs/image/V3_WINDOWS`).
4. **#1264 `bc0065c8`**, **#1267 `7d9599b5`**, **#1265 `670da629`**, **#1270 `8e87d666`**, **#1272 `8a1aec7c`**, **#1273 `f67d2ffc`**, **#1287 `e877b453`**, **#1294 `d153b3fc`**, **#1295 `0629b5fd`**.
5. **#1278 `6e935c2c`**, **#1285 `661e9f78`**, **#1282 `8a4bf682`** (the final-merge verdicts of entries 1065 to 1067).
6. **#1298 `80943121`**, then **#1306 `30fc0929`** (stacked on #1298, merged second).
7. **#1300 `bf7a3e82`** and **#1304 `dc7dfe19`**. Entries 1062 and 1063 reviewed #1300 at `79c6af98` (MERGE) and #1304 at `d5d64fd3` (MERGE-WITH-FIXES, 1 HIGH). Both were pushed again at 03:24 on 17 Oct by a builder (the TEAMLANE2 log line says: #1304 dc7dfe19 repeats the drag on the F keyword so the note is kept; #1300 bf7a3e82 takes the handle off the command line and names the real Properties field). `gh pr view --comments` shows no Opus comment at those heads, and the review log has no entry after 1071. They need a finalizer look.
8. **Heads re-checked:** all 19 branch tips and the S-37 tip were re-read from GitHub just before the push; none had moved. Every PR is open and draft. Every PR base was an ancestor of my base or (for #1306) of the merge before it; none of the heads was already in the base.
9. **Merge check:** after every merge the numstat of the merge against its first parent equals the PR's own numstat in every code file. REGRESSION_LOG.md gains the PR's own lines, plus at most one blank separator line where two entries met. No merge changed a version field, csproj, props, `Plugin.cs`, PackageContents or `Shared/`. (#1273 edits `VersionInfoService.cs`, which is the Settings window wording "the setup record says ...", not a version field.)

## 2. Conflicts and hand resolutions

1. **REGRESSION_LOG.md (every merge that clashed):** kept both sides, first side then second, and put one blank line between two entries where the join dropped it. Checked on the whole train: 237 lines added (229 from the merges, 8 from my entry), 0 removed, 0 conflict markers, 0 CR, 0 control characters in added lines, repeated headings unchanged from the base (the same 2 old ones). Stored LF.
2. **`SettingsService.LoadRecovery.cs` (#1295, #1278, #1282, #1300):** the label lines after `RafterJoist.Fj1LayerName` all kept. Final order: `Options.FastSaveAlsoCleans`, `RafterJoist.SizeReadbackToleranceMm`, `Layouts.FollowAnyDrawingScale`, `Options.RestoreCurrentAppearance`, `Options.RebuildDimensionAfterScaleChange`, and the section-mark labels from #1298 and #1306 (those two merged without a clash).
3. **`UserSettings.cs`, `OptionsSettings` after `RedoHoldSeconds` (#1282 onto #1287, then #1300):** kept `FastSaveAlsoCleans`, `RestoreCurrentAppearance`, `RebuildDimensionAfterScaleChange` in that order; put back the blank line and the opening `/// <summary>` of the second and third property.
4. **`BreaklineCommands.cs` (#1285 onto #1278), as entry 1068.3:** kept #1278's block (`anyScale`, `drawingScale`, `GetBreakDimensions(drawingScale, ..., anyScale)`), deleted #1285's duplicate `GetBreakDimensions(dimScale, out double extDist, ...)` line, kept #1285's `if (CurrentSpaceReader.IsPaperSpace())` override after it. The merged numstat of the file (13 added, 4 removed) equals #1285's own.
5. **`DimensionCommands.cs` (#1300 onto #1264), as entry 1068.2:** four keep-both hunks, #1264's lines first: DUP counters (`lockedLeft`, `lockedLayers`, then `dimsStillOld`), DUP end (locked-layer line, then the "still show the old number" line), DSET1 counters, DSET1 end. Numstat equals #1300's own (21 added).
6. **No other code clash.** #1265 and #1278 both edit `HatchUpgradeCommands.cs`, #1264, #1267, #1282 and #1300 all edit `DimensionCommands.cs`; git merged those by itself.

## 3. New Settings, defaults, registry, Shared

1. **New Settings properties (all in `Models/UserSettings.cs`; a stored value is never rewritten):**
   1. `Options.FastSaveAlsoCleans` **false** (#1287). Note: the default changes what FASTSAVE does. It now only saves (Tim's ruling ST5-14 per the PR); turning this ON brings back the old purge and Xref move.
   2. `Options.RestoreCurrentAppearance` **true** (#1282). Visible: after a CE command the drafter's colour, linetype, lineweight (and current dimension style for AD, LD, Q, QD, RD) are put back.
   3. `Options.RebuildDimensionAfterScaleChange` **true** (#1300). Visible: DSET, DSET1 and DUP redraw the dimension and may print a "still shows the old number" warning.
   4. `Layouts.FollowAnyDrawingScale` **true** (#1278). Visible: hatch presets and the BL break line follow any drawing scale, not only 1:20 and 1:100 (identical at those two).
   5. `Annotation.SectionMarkIdentifierInClearHalf` **true** (#1298). Visible: the section mark letter moves into the clear half of the bubble.
   6. `Annotation.SectionMarkOfferNextIdentifier` **false** (#1306): OFF. `Annotation.SectionMarkSkipLetters` blank (#1306): skips none.
   7. `RafterJoist.SizeReadbackToleranceMm` **0.5** (#1295): R1, FJ1 and P1 say so when the placed block did not take the span size; never blocks.
2. **Default changes:** the four visible ON defaults in items 2 to 5 above, and item 1 (FASTSAVE no longer purges). The PRs describe each as a Tim ruling or a recommended default marked DRAFT. Items not behind a switch: #1285's layout-sheet sizes (note text at the Settings label height, BL zigzag 1.5 / 2 / 2 mm on a layout sheet), #1272's wind-class entry (blank saves nothing, Esc at "Use N2?" stops), #1264/#1267's locked-layer and DSET wording and behaviour.
3. **Registry:** no entries added or removed (still 375, valid JSON). #1304 changes two prompt strings in `command-registry.json` to add "(F swaps the side)".
4. **Files changed under `Shared/`:** none. Structural ships no CE_SHARED.
5. **`RedoSafeReviewedHooks.baseline.txt`:** #1282 adds 13 lines to it itself; I did not edit it. The redo-safe tests passed on net10 and net48.

## 4. Assembly fix commit `d13c6768` (test lists and a log entry only)

Three guards went red after the merges; each followed an intended change. I fixed the lists, no production file:
1. **`Stage3B6_RoutesCommandsOneTwoFourAndFiveOnly` (Plugin/command boundary pin):** its allow-list of files in the beam command host folder now names `BeamDrawingUnitsUnsupportedException.cs`, the new file from #1294.
2. **`NoStructuralQuestionShowsItsListOrDefaultTwice`:** #1272's new helper `AskYesOrCancel` takes its whole question from the caller; its one caller passes a plain "Use N2? ", so the helper joins `BareMessageHelpers` (the guard's own message says to do exactly this once callers are checked).
3. **`OnlyAllowListedFiles_ReadTheDrawingUnits` (found by the first net10 run):** #1294 reads `Database.Insunits` in `BeamCommandAutoCadPromptAdapter.cs` and `BeamSpecialCommandAutoCadPromptSession.cs` only to name the unit in its refusal line; both are now on the allow-list with a comment.
4. **REGRESSION_LOG:** one entry at the top in AutoCAD words with a short check (CSWINDCLASS, Esc at "Use N2?").
5. **Finalizer to judge:** items 2 and 3 are allow-list additions on my reading of "a test baseline that followed an intended change"; if the finalizer reads the rule more narrowly, they are easy to take out.
6. This is one commit (I amended it once before pushing, to include item 3 and the log wording). #1294 and #1272 did not carry these list changes themselves; tell the review lane.

## 5. Builds

1. Release, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, build lock taken for every build and test run and released after each. Refs: net48 AutoCAD 2024 ref folder, net8 ref folder, net10 off the AutoCAD 2027 install. C: free 27.6 to 28.2 GB at every build.
2. **0 errors on all nine, three times** (at the merged head, after the first pin commit, after the amend). Warnings: Structural.Tests 10 (net48), 12 (net8), 12 (net10); Structural 0 / 0 / 0; DesignCore.Tests 51 / 52 / 52. All equal to the S-37 finalizer's.

## 6. Tests against the S-37 finalizer baseline

Method as S-33 to S-37: 413 class names from source in 14 chunks of 30 (the Sbeam evidence class left out), `--no-build`, NUnit workers 1, `CE_LOG_DIR_OVERRIDE` at a scratch folder, AutoCAD 2027 on PATH, 900 s kill timer (none killed).
1. **Structural net10: 5149 of 5149 passed** (final head, second full run). Baseline 4946: +203 new tests. The first full run, one commit earlier, had 1 failure (item 3 of section 4) and nothing else.
2. **Structural net48: 4412 passed, 36 failed, 698 not run.** Baseline 4209 / 36 / 698: +203 passed, same failures, same not-run count. The 36 failing names are identical to the baseline's by direct comparison; they sit in the nine old classes (BeamWallClashGeometryTests, DbTextMoveAnchorReconcilerTests, SbeamAutoCadPlacementAdapterTests, BracingLengthSettingsTests, BeamCommandAutoCadPromptAdapterTests, S2UndoReviewFixTests, StructuralWindowRenderTests, HatchBackgroundContractTests, CeSharedBinaryCompatibilityTests).
3. **DesignCore: 2063 per lane (net48, net8.0, net10.0), 2058 passed, 5 failed per lane.** Baseline 2050, 2044 passed, 6 failed. The 5 failures are the baseline names (HostedAndStandaloneModernOutputs, LoadOrder x2, StandaloneReleaseLanes x2). `ProductionPartials_StayWithinEightHundredLinesAndUseSharedPolicy`, red at S-37, **passes now**; I confirmed it alone on net10 and did not investigate why (#1254 repairs DesignCore test receipts, which is my guess, not checked).
4. **Guards, 8 of 8 on net10 and net48 (and inside the full final-head runs):** the command-class list, the Foundations choice-list, the AutoCAD-copy-off guard, the doubled-question guard, the Plugin.cs pin, and the three #949 zero-call tests.
5. **Not run:** Structural net8 tests (built only), Drainage, Manager, Installer, ReleaseTests, CommandTruth, the Sbeam evidence class. Nothing opened in AutoCAD.

## 7. Redo-killer scan (standing rule)

Scanned every added line in Modules for `StartTransaction`, `SetCurrentView`, `SetSystemVariable`. Four production hits, none on an automatic path (no Idle, document-switch, selection, palette, overrule or timer):
1. `Commands/HatchPersistencePolicy.cs:782` (#1265): a read transaction inside CEHATCHAUDIT / CEHATCHCHANGE.
2. `Services/CommandExecutionService.cs:233` (#1282): `SetSystemVariable` in the finally of the drafter's own command, putting back only what the command changed.
3. `Services/NativeXrefLayerService.cs:134` (#1287): a read transaction inside XRL and its fast and silent variants (command only).
4. `Services/SectionMarkRegistry.cs:46` (#1306): a short read transaction inside SM, aborted.
No finding rated HIGH. No test edits to the redo baseline by me.

## 8. Hygiene

1. **Tim's three settings files, size and first 16 of SHA-256, identical before and after the whole job and before and after every test chunk:** CD_Settings 15,270 bytes `ACD64E79A33BE9C1`; TIM_CE_CADTOOLS CS_Settings 351,713 bytes `622A246F7D3B1629`; Structural CS_Settings **34,217 bytes `C5186042053FF7C5`**. That is not the 34,196-byte `B339F3E9` the brief quotes: the file already read 34,217 bytes when I started (AutoCAD rewrote it after the S-37 install); it did not change during my run.
2. **Installed Structural DLLs** are `1.0.117+0dfbd1d6` (Legacy, Modern, Net8, plus DesignCore), same hashes before and after. Nothing written under ApplicationPlugins.
3. **Live CE manifest** (files named CE_ or TIM_CE under the roaming profile): 74,388 files / 9,792,827,740 bytes before and after (my own scan; its count differs from earlier reports because the scan root differs). acad.exe was not running at either reading.
4. **Pictures:** test passes rewrote about 70 files under `docs/image/V3_WINDOWS` twice; restored with `git checkout -- docs/image` and `git clean -fdq docs/image`. The train changes only the six pictures #1262 commits itself.
5. **One dotnet process at a time**, through the build lock at `C:\CE_PLAN\desk_jobs\build.lock`; never held across a tool call that could time out without a final release (checked after every call).
6. **Shared scratch folder:** this session's scratch folder turned out to be shared with another assembler session. It overwrote my copy of a generic helper script (`finish.sh`) while I worked. All my merges were finished by then and my later scripts sit in my own sub-folder; nothing of theirs was changed by me knowingly. Worth a word to whoever owns the C-40 train.
7. **No bare python, no long-lived background shell command, no `taskkill`, no `EnterWorktree`/`ExitWorktree`.** All scripts were files in the scratch folder; no repo build, deploy or version script was created.

## 9. For the finalizer

1. Re-review #1300 `bf7a3e82` and #1304 `dc7dfe19` (fix heads, section 1.7), and confirm the F-key repeat in #1304 against entry 1063.
2. Judge the two allow-list additions (section 4, items 2 and 3).
3. Four visible ON defaults and the FASTSAVE change (section 3) are for Tim's checklist; none has been seen in AutoCAD.
4. Entry 1066's wording LOW on #1282 ("DIMSTYLE shows no style overrides") and the other open LOWs of entries 1061 to 1067 are unchanged by me.

## 10. Branch contents

`claude/rel-20261017s` contains the S-37 branch (`claude/rel-20261010d`, `0dfbd1d6`, Structural 1.0.117) plus the 19 merged PRs above and one test-list commit. It does not contain #1260 (HOLD), #1256 or #1258 (Civil), or any Civil PR.
