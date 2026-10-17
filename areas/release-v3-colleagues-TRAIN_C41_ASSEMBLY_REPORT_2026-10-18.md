# Train C-41 assembly report (Civil + Manager), Sat 17 Oct 2026 (evening, Melbourne time)

**Answer first:** the C-41 train is assembled and pushed. It builds with 0 errors on all lanes and the tests are green apart from the known Glen Eira red, two net48-only environment reds and the known Installer reds. All four PRs merged; every new switch ships OFF. Nothing was installed, deployed, version-edited or opened in AutoCAD. Built and unit-tested only; nobody has looked at any of it in AutoCAD.

## 1. The branch

1. **Branch:** `claude/rel-20261018a`, pushed to origin (new branch, normal push). Final head `a78b0388f2117bc921e9610c0c63e26c7bc28d8b`. Local head equals origin head.
2. **Base:** `origin/claude/rel-20261017c` at `4e2bdfeb` ("Version: Civil 3.0.51 / Manager 1.1.51 (C-40)"), verified; this is the installed 3.0.51 build. The branch contains the whole C-40 line plus the four PRs below, plain `git merge --no-ff`, one merge commit per PR, no squash, no rebase, no cherry-pick, plus one assembly fix commit.
3. **Installed Civil bundle (read only):** 3.0.51+4e2bdfeb. No version field, csproj or PackageContents changed by any PR.

## 2. What merged (4 of 4 PRs, in this order, heads used)

1. **#1313** `ed5680ba` (pit-label double-click, switch OFF, parity with 3.0.51). Open, draft, base rel-20261017c, 9 commits ahead, 0 behind. Clean merge. Numstat equals the PR's own, REGRESSION_LOG included (39 added).
2. **#1315** `399309e3` (the one Checks list, switch OFF). Open, draft, same base. REGRESSION_LOG.md clash only. Numstat equals the PR's own.
3. **#1314** `84c5f5e1` (Tidy labels, switch OFF). Open, draft, same base. Three clashes (section 4). Numstat equals the PR's own except the hand-resolved Help guide test file (5/1 instead of 5/2, because #1315 had already changed that line).
4. **#1316** `88b02d98` (double-click on every Civil object, stacked on #1313). Open, draft, base is a stack branch that contains #1313's head (checked with `merge-base --is-ancestor`). Clean merge, merged after #1313. Numstat equals the PR's own against #1313, REGRESSION_LOG included (19 added).
5. **Heads vs the review round:** all four heads are newer than the heads Opus reviewed in entries 1074 to 1081 (dcc136b6, cfb61a0a, 8f21e247); the builders pushed the fix rounds (default OFF, guide count, parity with 3.0.51). I did not re-review them. The finalizer should confirm the fixes in the newer heads.
6. **Skipped:** none. No PR was stopped for a conflict, version, csproj or PackageContents change.

## 3. Hand resolutions

1. **REGRESSION_LOG.md:** clashed at #1315 and #1314. Resolved byte-safely (stored LF, no CR added), keeping every entry of both sides, blank line put back between the sections. Final checks: 0 conflict markers, 0 duplicate `## ` headings, 179 lines added and 0 removed against C-40 (39 + 26 + 95 + 19), 0 control characters in any added line.
2. **CrossModuleGuardTests.cs (command count):** #1314 and #1315 clashed. Resolved exactly as entry 1079.3: `Is.EqualTo(145)` with both notes kept ("+ CDCHECKS ... 144 is now 145 + CDTIDYLABELS ... 143 is now 144").
3. **HelpGuideWindowRenderTests.cs (Help guide entry count):** this DID conflict textually when #1314 went in after #1315 (entry 1079.4 expected a silent merge). Resolved to `"81"` with both notes and a train note.
4. **UserSettings.cs:** merged without a clash (all blocks of all PRs present).
5. **RedoSafeReviewedHooks.baseline.txt:** not edited by me. #1313 itself renumbers the CDEDIT-start line (`StartCdEditAsync d__29` becomes `d__38`); it merged without conflict and the redo guard passed.
6. **Assembly fix commit** (`a78b0388`): re-pin of the Civil command-registry row count (137 to 139) and SHA-256 in `Assets/Config/ce-tool-register.json`. Reason: #1314 and #1315 each added a registry command and neither re-pinned the central tool register, so `CentralRegister_OwnsApprovedFoundationToolsAndRecordsLegacyInputs` (CommandTruth and TestHarness) went red (expected 139, found 137). A test baseline that followed an intended change, same kind as the C-18 and C-23 assembly fixes. Test-only data, no product code.

## 4. Shared, registry and Settings

1. **Files under Shared/ that changed:** none. Manager source: none. Civil and Manager `CE_SHARED.dll` are byte-identical (net48 de96e6fa, net8 0bd35835, net10 0f6e253b, same in Shared, Drainage and Manager output). Manager does not need to ship in this train.
2. **command-registry.json (Drainage):** two commands added, 137 to 139 rows. CDCHECKS (hidden: true; "Not switched on yet" text, appears when the switch is on) and CDTIDYLABELS (Draft panel, group Core). council-profiles.json: not changed. Manager and Structural registries: not changed.
3. **New Settings properties, all OFF or equal to today:**
   1. `doubleClick.opensEditWindow` false (#1313/#1316). Old key `doubleClick.pitLabelOpensEditPit` is still read once (a drafter who set it keeps it).
   2. `linking.tidyLabelsEnabled` false; `tidyMovesPitText` false; `tidyLeaderOut` false; `tidyLeaderOutMaxMm` 1500 (only used when leader-out is on); `tidyRearrangeNeighbours` false (#1314).
   3. `checks.checksCommandEnabled` false (#1315).
4. **One existing default changed:** `checks.typedAnswersPointToChecksPalette` false to true (#1315). It is gated by `checksCommandEnabled`, so with the main switch OFF the extra line never shows. Visible behaviour equals today until the switch goes ON. Flag for the finalizer.
5. **Stale comment:** the XML summary on the new `DoubleClick` property in `UserSettings.cs` still says "the pit-label switch is ON". The real default is OFF. Words only; worth fixing in the finalizer pass.

## 5. Redo-killer sweep (standing rule)

1. **Added non-test C# lines containing the watched calls:** one `_editor.SetCurrentView(view)` at `Modules/Drainage/Services/Checks/AutoCadShowWhereSurface.cs:60` (#1315). It runs only from the drafter's own Show where button click, not from any hook, and the switch is OFF. It ends REDO the same way a typed ZOOM would (the reviewer asked for "U, Show where, REDO" in the Codex recipe). Not HIGH.
2. **`CompoundEditModeService.cs:662`** `Application.Idle += OnCdEditIdle` and `CommandWillStart` at line 116 already existed; the Idle start only happens after the drafter's own double-click. No new StartTransaction or SetSystemVariable on a hook path.
3. **Redo guard tests:** green on net10 (inside the Civil run) and on net48 (focused run). No baseline line needed.

## 6. Builds

1. **Whole `CE_ACAD_PLUGIN.slnx` Release**, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs from the CERef 24.3.0 folder, net8 from the 2026 ref folder, net10 off the AutoCAD 2027 install: **0 errors, 885 warnings** (same as C-40), 4 min 1 s.
2. **Native transform file:** copied read-only from another built worktree into the ignored build folder, removed again by `git clean -fdXq`.
3. **TestHarness test project** rebuilt once after the re-pin (0 errors) because it embeds the central register.
4. **Disk:** about 24 GB free throughout. The shared build lock was taken and released around every build and test run.

## 7. Tests (net10 with AutoCAD 2027 on PATH, `--no-build`, one NUnit worker, log folder redirected to scratch, every run printed a non-zero total)

1. **Manager:** 751 run, 751 pass (C-40: 751).
2. **Civil (Drainage.Tests):** **17,966 run, 17,946 pass, 19 skipped, 1 failed.** C-40 was 17,764 / 17,744 / 19 / 1. The 202 extra tests are this train's. The one red is `BackTest_GlenEira24115_Computed_WithinTolerance`, the known one on the plain base. The two `SourceAtomicCoordinatorDependencyTests` IL tests passed, the Help guide count and command count tests passed (145 and 81), and the redo guard passed.
3. **CommandTruth** 64/64, **TestHarness** 101/101, **Spine** 81/81, **Diagnostics** 19/19, **AI.Core** 42/42 (net8), **ReleaseTests** 16/16, all after the re-pin. Before the re-pin CommandTruth and TestHarness each had one red (the register count test), see section 3.6.
4. **TestHarness first run:** a second red `OfflineHelpTests.ReadingStateRoundTripsAndRecoversFromCorruptOrRemovedTopic`, the known flake; 101/101 on the rerun.
5. **Installer.Tests** (with the brief's filter, net9): 273 run, 237 pass, 36 fail. Same count as C-38, C-39 and C-40. The names are the installer-route, packaging and manifest tests; I did not diff the name list against the earlier lists this time.
6. **Focused net48 run** (Drainage.Tests, every changed test class plus redo, double-click and the IL tests): 341 run, 339 pass, 2 fail. **Both are environment-only:** `TidyLabelsCommandTests.AllMeansTheCurrentSpaceOnly_APipeInAnotherLayoutIsLeftAlone` and `TidyLabelsGateTests.TheCommandAsksForTheCePipeObjectToo_NotJustPlainPolylines` (both #1314) throw `InvalidProgramException` at `TypedValue.get_TypeCode()`. The net48 lane builds against AutoCAD reference stubs with no method bodies, and the two tests read a TypedValue code. They pass on net10 against the real AutoCAD. The fix is in the tests (read the value, not TypeCode, or skip on the stub lane); not a baseline pin, so I left it.
7. **Not run:** Structural tests (no Structural file touched), AI.Harness tests, Manager on net48 (the Manager test project is net10 only), accoreconsole, anything in AutoCAD.

## 8. Hygiene

1. **Tim's settings files, unchanged around every run:** `CD_Settings.json` 15,270 bytes ACD64E79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes 622A246F; `CE_STRUC_SUITE\CS_Settings.json` now 34,858 bytes 24D8E5F7 (changed since C-40's 34,217 / C5186042 before I started; unchanged during my work).
2. **Live CE folders under the roaming profile (files / bytes), identical at start and end:** CE_CVL_SUITE 99 / 33,703,049; CE_STRUC_SUITE 2,474 / 2,096,871,913; TIM_CE_CADTOOLS 22,173 / 1,130,215,186.
3. **AutoCAD:** not running at any point. Nothing was written to the application plugins folder. `git clean -fdXq` done, worktree kept clean, no screenshots or docs images regenerated into the commit.

## 9. What the finalizer should do

1. **Confirm the newer fix heads** of #1313, #1314, #1315 and #1316 against the review notes (entries 1075 to 1081): default OFF, guide count, plain-English fold-in line (#1315 MEDIUM), parity with 3.0.51 (#1316).
2. **Add the C-41 merge entry** to the log (the assembler adds none) and decide whether to keep the assembly re-pin commit `a78b0388` as is.
3. **Fix the stale `DoubleClick` summary** ("switch is ON") and decide on the `typedAnswersPointToChecksPalette` default change (gated, so invisible while OFF).
4. **Fix the two net48 tests** (section 7.6) if net48 test runs are part of the gate.
5. **Codex recipe:** include "U, Show where, REDO" (section 5.1) and the pit-label double-click, a source-block double-click and a Tidy labels run on a real sheet. None of these has been seen in AutoCAD.
