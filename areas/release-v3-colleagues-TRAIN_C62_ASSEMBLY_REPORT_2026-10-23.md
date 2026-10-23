# Train C-62 assembly report (Civil + Manager), Fri 23 Oct 2026, real clock 14:47 to 15:35 Melbourne

Built and unit-tested only. Not installed. Nobody has opened any of it in AutoCAD. No PR closed or retargeted, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` not edited. Structural is not in this train.

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261023m` at `dd13cf580b3ef68029a028e48ebfe7775f8823c3` (normal push, new branch, name was free; `claude/rel-20261023n` not needed). Base: the real tip of `claude/rel-20261023l` was exactly `88bd62f704b66a7e156da572c212812dc4b0c61a` (Civil 3.0.71 / Manager 1.1.71, C-61), as named.
2. **Merged: 23 of 23 listed PRs** (#1613, #1632, #1610, #1609, #1619, #1625, #1623, #1611, #1617, #1612, #1552, #1553, #1586, #1591, #1557, #1558, #1570, #1567, #1562, #1556, #1594, #1595, #1645), one plain `git merge --no-ff` commit each, no squash, rebase or cherry-pick. None was already in the base. Every live head equalled the expected head, so no PR was stopped. After the 23 merges there is one commit of mine (blank line before each merged log heading, no text changed). Whole branch against base: 74 files changed, 2,708 insertions, 113 deletions.
3. **Live heads at merge time** (each re-read with gh immediately before its merge and compared to the fetched `refs/pull/N/head`): see section 1 for the full 40-character heads. All equal the fix-round report. PR bases on GitHub are still the old branches (`claude/rel-20261022m` for most; `claude/rel-20261023l` for #1632 and #1645); none changed.
4. **Left out:** everything in the EXCLUDE list (#1576, #1555 HOLD; #1621 REJECT; #1630, #1624, #1622 duplicates; #1537, #1551, #1534, #1528, #1539, #1550; every Structural PR; #1529, #1382, #1384, #1419, #1423, #1191, #1183, #1180) and anything not named. Nothing named was skipped.
5. **Shared/ and Installer/: EMPTY** (`git diff --stat 88bd62f7..HEAD -- Shared Installer` prints nothing; also nothing under `Modules/Manager/Installer`). **Modules/Manager changes (9 product files plus tests)** come from four PRs: #1613, #1632, #1594, #1595 (list in section 3). **One NEW Manager product file: `Modules/Manager/Services/CeManagerCommandSender.cs` (from #1613).** It is a source file compiled into the Manager DLL, not a file the bundle carries, and `CE_SUITE_MANAGER.csproj` is unchanged, so the exact 75-file bundle guard should not move; I did not run a release payload build, so the payload builder must confirm it.
6. **Config files:** `command-registry.json`, `ce-tool-register.json` and every `PackageContents.xml`: **none changed** (empty net diff against the base). No command added or removed, so the CrossModuleGuard counts do not move (the guard passes on net10 and net48).
7. **Settings keys added: four new switches, all default ON in the merged code** (I changed none): `propagateWritesSingleIlToItsOwnEnd` (#1567), `escKeepsPlacedCalloutLinks` (#1562), `scheduleRefreshKeepsTwinAndTrenchText` (#1570), `importReviewRefusesChangedSource` (#1558). Each documentation line ends "Default: on.". **None has a Settings page row.** Detail in section 4.
8. **Build:** whole solution Release, **0 errors** (891 warnings), net48, net8.0-windows and net10.0-windows all built (so the net48 compile of the merged train is clean, which was the open worry from the fix round). **Tests:** Civil net10 **19,545 total, 19,523 passed, 22 skipped, 0 failed**. Manager net10 **932 total, 931 passed, 1 skipped, 0 failed**. Manager net48 build 0 errors. Civil net48 focused: 1,697 total, 1,629 passed, 51 skipped, **17 failed, all 17 are the reference-only AutoCAD fault** (section 5). RedoSafeCallGraphTests: **25 of 25 pass** on net10 (26 of 26 RedoSafe tests on net48).
9. **The one real clash, resolved as briefed:** `UserSettings.cs` at #1562 (section 6). `REGRESSION_LOG.md` conflicted at nearly every merge and was resolved keeping every entry. No other clash. **#1645 did not clash with #1552** in any file other than `REGRESSION_LOG.md`.
10. **For the finalizer:** (a) #1645 was never Opus-reviewed, review it fully; (b) the Settings pictures were NOT re-rendered (four new switches have no row, so none changed); (c) the C62 copy of `C61NewSwitchDefaultsTests` for the four new switches is still owed (fix-round item 8); (d) my filter `Settings` on net48 matches the whole suite (section 5); (e) AutoCAD (acad.exe) was open during every run.

## 1. Merge list with heads (merge order)

Each merged by `C:\ce-asm\mergeone62.sh` (live head vs fetched head vs expected head; `merge-base --is-ancestor` check; merge; numstat of `HEAD~1..HEAD` compared with the PR's file list). Note on the numstat check: the PR branches contain an earlier merge of the C-61 line, so `gh pr view --json files` (relative to the old C-60 base) lists many files the merge does not change. I therefore also compared the merge numstat with the PR's own diff against the merge-base with the C-61 tip: **identical for all 23**. Where gh's list matched outright it said so.

1. **#1613** BUG-1017, head `f514c8ef591afc4e6f9cfbbb09ee12bbf0945c14`, merge `97a1e472`. REGRESSION_LOG only.
2. **#1632** BUG-947, head `1899db506693d7002db73a25782075211b3cbfd3`, merge `e492f4bd`. REGRESSION_LOG only.
3. **#1610** BUG-957, head `78a2303fcf041927a814b4187d60e93d4fc60f80`, merge `3f9f2745`. REGRESSION_LOG only.
4. **#1609** BUG-892, head `498f0f7a4059c45f8a76416df581aac901594c88`, merge `214e31ea`. REGRESSION_LOG only.
5. **#1619** BUG-969, head `a47286eef36381160013f23e4ce4ea0efd2a1aed`, merge `ebbcf4b3`. REGRESSION_LOG only.
6. **#1625** BUG-1019, head `08e3002651098817ddac9acfbe37ce28d2215468`, merge `e419e0e9`. REGRESSION_LOG only.
7. **#1623** BUG-1004, head `e0397253747bd872c403e315db51d030f6a0976f`, merge `fc477fac`. REGRESSION_LOG only.
8. **#1611** BUG-987, head `b32cb106e2459de8ca23374cb6afc26afab927fe`, merge `ce0c8865`. REGRESSION_LOG only (the merge brings 3 files: its test, `ProjectDataRecoveryGuardService.cs`, the log).
9. **#1617** BUG-999, head `eadc79ee54da6d99d189a248601e610615e70b3f`, merge `a2ae5718`. REGRESSION_LOG only.
10. **#1612** BUG-1011, head `8690ce145a3c5d4bb35d7953502582b137ab9ddb`, merge `5f590a1b`. REGRESSION_LOG only.
11. **#1552** BUG-966, head `277ca0de5e409026e456a07013d5f04d66766df4`, merge `c93778d4`. REGRESSION_LOG only.
12. **#1553** BUG-967, head `a51a9216112a73e833a9cee79a34a4d26d352405`, merge `c1ec595d`. REGRESSION_LOG only.
13. **#1586** BUG-878, head `ea52fbb5dc48ba74cc155b0c0e4026ad1de47a8e`, merge `f7093278`. REGRESSION_LOG only.
14. **#1591** BUG-968, head `2759f760bd15cb6e43017435a5d8c88c21795cb7`, merge `d3d5b71a`. REGRESSION_LOG only.
15. **#1557** BUG-876, head `951e5b50e312693a563fcaa2ac1ff7c59da36681`, merge `06d53db5`. REGRESSION_LOG only.
16. **#1558** BUG-877, head `980069886b8058767f3959c6b3e8eb793ea73a7d`, merge `0db7b4e2`. REGRESSION_LOG only.
17. **#1570** BUG-965, head `92e83fa5ef6c7bb60c61108aec40778e235aa07f`, merge `1cc11762`. REGRESSION_LOG only.
18. **#1567** BUG-963, head `111b8e0a7a8efce26e2ab51800b1dda552c388c9`, merge `5f2dd188`. REGRESSION_LOG only.
19. **#1562** BUG-874, head `f119d8e7a4f52787f491f7dc5e4af9d6955eee50`, merge `6f7845ca`. **`UserSettings.cs` and REGRESSION_LOG clashed**; resolved (section 6). Merge numstat equals the PR's own diff (8 lines in `UserSettings.cs`, the REDO baseline file +10, `LinkService.Reactors.cs`, `CancelledPlacementRegistrationRule.cs`, three test files).
20. **#1556** BUG-970, head `2bd5c2bec6a7e779c5b05727f75b238484d84f67`, merge `47626a13`. REGRESSION_LOG only.
21. **#1594** BUG-946 (Manager), head `5fc37df6c866ad85a184ff98e4eef96c83246b6d`, merge `eced4bf9`. REGRESSION_LOG only. `PluginManagerCommands.cs` merged cleanly with #1595.
22. **#1595** BUG-948 (Manager), head `6db38faf98b2854e878750ca97f64eb9990f6d6a`, merge `98ffff82`. REGRESSION_LOG only.
23. **#1645** CDRG raingarden readback accepts ByLayer (branch `fw2/cdrg-rollback`, confirmed with `gh pr view 1645` and `git ls-remote`), head `80b77a157b378c280079f5f9aede6bbf32372e51`, merge `4e5464d5`. REGRESSION_LOG only, so no clash with #1552 in code.
24. **My commit `dd13cf58`:** the patch method I used to keep log entries left 8 headings in the new entries without a blank line before them; I inserted a blank line before each (8 lines added, no text changed, checked with `git diff --numstat`: 8 insertions, 0 deletions). The older entries below the new ones were left as they were. Zero conflict markers anywhere (`git grep` clean).
25. **Log order (top to bottom):** #1645, #1595, #1594, #1556, #1562, #1567, #1570, #1558, #1557, #1591, #1586, #1553, #1552, #1612, #1617, #1611, #1623, #1625, #1619, #1609, #1610, #1632, #1613, then the C-61 entries. (Newest merge on top.)

## 2. What was NOT merged and why

1. The EXCLUDE list in the brief, exactly. Nothing else touched.

## 3. Scope check

1. **`git diff --stat 88bd62f7..HEAD -- Shared Installer`:** EMPTY. CE_SHARED unchanged, installer unchanged. Also empty for `Modules/Manager/Installer`. No PR touches Shared/ or Installer/.
2. **Manager product files changed, per PR (from each PR's own merge commit):**
   1. **#1613:** `CeBlocksPaletteService.cs`, **`CeManagerCommandSender.cs` (NEW)**, `CePluginRegistryService.cs`, `PluginManagerWindow.Help.cs`, `PluginManagerWindow.Settings.cs`, `PluginManagerWindow.xaml.cs`; tests `Bug1017ManagerSendCommandTests.cs` (new), `HelpWorkspaceHostTests.cs`, `SettingsWorkspaceHostTests.cs`.
   2. **#1632:** `CeUpdateStagingService.cs`; tests `CeUpdateStagingServiceTests.Bug947.cs` (new), `CeUpdateStagingServiceTests.cs`.
   3. **#1594:** `PluginManagerCommands.cs`, `CeHealthChecks.cs`; test `HuntM09HealthChecksTests.cs`.
   4. **#1595:** `PluginManagerCommands.cs`, `PluginManagerWindow.xaml.cs`; tests `Bug948UpdatesButtonColleagueTests.cs` (new), `CeManagerWindowReopenTests.cs`.
3. **New file the Manager bundle would carry:** none by my reading. The one new product file (`CeManagerCommandSender.cs`) is compiled source; the csproj is unchanged. The new files under `Manager.Tests` are test sources and do not ship. Payload builder: confirm the 75-file count on the real release build.
4. **Config:** `Assets/Config/command-registry.json`, `ce-tool-register.json` and every `PackageContents.xml`: unchanged against the base (empty `git diff --stat` for those paths). No new or removed command.

## 4. Settings keys (default in the merged code; none changed by me)

`git diff 88bd62f7..HEAD -- Modules/Drainage/Models/UserSettings.cs` has three hunks, 33 added lines. No other settings model changed, and no Manager switch file changed (the `PluginManagerWindow.Settings.cs` change in #1613 is a command-sending change, not a key).

1. **`propagateWritesSingleIlToItsOwnEnd`** (#1567, `LinkingSettings.PropagateWritesSingleIlToItsOwnEnd`): default **ON** (`= true`). Doc line ends "Default: on." Not a block (R-27). **No Settings page row.**
2. **`escKeepsPlacedCalloutLinks`** (#1562, `LinkingSettings.EscKeepsPlacedCalloutLinks`): default **ON**. Doc line ends "Default: on." **No Settings page row.**
3. **`scheduleRefreshKeepsTwinAndTrenchText`** (#1570, `LinkingSettings.ScheduleRefreshKeepsTwinAndTrenchText`, further down the class at about line 709, not at the top): default **ON**. Doc line ends "Default: on." **No Settings page row.**
4. **`importReviewRefusesChangedSource`** (#1558, `XcivilImportSettings.ImportReviewRefusesChangedSource`, about line 2731): default **ON**. Doc line ends "Default: on." **No Settings page row.**
5. **Correction to the fix-round report:** it said the three `LinkingSettings` additions (#1567, #1570, #1562) all sit at the top of that class. In the merged code only #1567 and #1562 are at the top; #1570's block is further down in the same class (so only those two clashed).
6. **No key added or changed by** #1613, #1610, #1609, #1619, #1625, #1623, #1632, #1586, #1591, #1557, #1556, #1553, #1594, #1595, #1645 (searched the whole diff for new `JsonProperty` entries: the only other two hits are `orificeHeadM` and `detentionRequired` from #1623, which are fields of the saved design record in `AgreedDesignSnapshot.cs` and `CivilProjectStartDraft.cs`, data not settings).
7. **Switches with no Settings page row:** all four (`git grep` of each property name finds nothing under ViewModels, UI or Views). The only way to switch any of them off is the settings file. The Settings pictures were not touched (no row changed).

## 5. Build and test evidence

1. **Environment:** private worktree `C:\ce-asm\c62` (short path), Release, every command through `C:\ce-asm\run62.sh` (`-p:SkipDevBundle=true -nr:false --disable-build-servers`, solution `-m:1`, dotnet set Below Normal right after start). Refs: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`, AutoCAD 2027 on PATH, a 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked), a fresh TEMP and CE log folder per step with the override inside TEMP. Never deployed.
2. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` did not exist; my run script took it for each step ("lock taken" every time) and released it after each.
3. **Whole solution Release build** 14:53 to 15:04 (10 m 22 s): **0 errors**, 891 warnings. Target frameworks built: **net48, net8.0-windows and net10.0-windows** for `CE_CVL_SUITE.dll` and `CE_SUITE_MANAGER.dll` (and the installer fixtures for net48, net8.0 and net10.0). So the net48 compile of batches 2 and 3 is proven clean on the merged train.
4. **Civil net10 full suite** 15:04 to 15:10 (test run 5 m 10 s): **Total 19,545, Passed 19,523, Skipped 22, Failed 0.** It is above my brief's 19,480 to 19,520 guess by 25 (the 23 PRs add more tests than I allowed for); it is in the thousands, so the reference name was right. The PDF load test passed (no re-run needed).
5. **Manager net10 full suite:** **Total 932, Passed 931, Skipped 1, Failed 0** (the brief's 918 grew by 14 with #1613's and #1632's new tests). **Manager net48 build:** 0 warnings, 0 errors.
6. **Civil net48 full-suite check (filter `Settings`):** the term `FullyQualifiedName~Settings` as the brief gave it matches the whole suite on net48 (19,366 tests: 18,602 passed, 395 skipped, **369 failed**). I ran it twice by accident before finding out. The 369 are the AutoCAD-needing tests failing on the reference-only assemblies (same kind and the **same count, 369**, as the unfiltered net48 run in the C-61 report, which suggests no new red from this train; I did not compare names). Not counted as evidence of anything else.
7. **Civil net48 focused (real filter):** classes SettingsWindow, SettingsFit, SettingsValue, SettingsLoad, AdvancedSettings, C60SettingsRows, C61NewSwitch, UserSettings, RedoSafe, CommandOutcomeLine, KeywordPromptBracketTag, CrossModuleGuard, CheckIgnore, DoubleClick, PickHandlerProbe, Raingarden, PitSchedule, Bug859, Twl, Import, Propagate: **1,697 total, 1,629 passed, 51 skipped, 17 failed.** All 17 carry the same cause, `System.InvalidProgramException: Common Language Runtime detected an invalid program` (17 of 17 counted in the log), i.e. the AutoCAD reference-only assemblies on this PC: `NonfiniteSource_IsRefusedBeforeFlattening` (3), `EditorPick_UsesRotatedTranslatedUcsOnce` (2), `JigWorldPoint_PreviewTemporarySegmentAndFinalVertexHaveExactSameXY` (2), `Raingarden_SameOutlineInMillimetresOrMetres_Is600SquareMetres` (2), `Raingarden_UnitlessDrawing_PlacesWithAreaUnknownAndReason`, `Raingardens_AreNamedRG1_RG2_InOrder_AndNeverReuseAName`, `MillimetreDrawing_Raingarden_IsBitIdenticalToTheOldDivision`, `TiltedNestedSource_ComposesAllFramesBeforeFlattening`, `OverflowDuringTransform_IsRefused`, `DefaultImportAndSideDatabaseParametersDoNotOptIntoCdPlanAdmission`, `XcivilImport_DoesNotAskForTheMainToBeTidied`, `FindRecordedPitAt_WithNoExplicitMargin_UsesTheOfficesSettingsValue` (the same environmental one as in C-61). I did not check whether any of these tests was changed by a merged PR (#1645 changes `RaingardenAtomicPlacementTests`, whose test names do not appear in the red list), and I did **not** build the base to prove they fail there too; an invalid-program fault comes from the reference assemblies, not from the code under test. The same names pass on net10 in the full run (0 failed). Finalizer: say if you want the base run.
8. **Per class on net48 (single runs, same build):** RedoSafe 26 of 26 pass; CommandOutcomeLine 26 of 26; KeywordPromptBracketTag 1 of 1; CrossModuleGuard 6 of 6; CheckIgnore 10 of 10; DoubleClick 145 of 145; PickHandlerProbe 7 of 7; PitSchedule 848 passed, 2 skipped, 0 failed; Twl 72 of 72; Propagate 5 passed, 1 skipped; Raingarden 61 passed, 8 skipped, 14 failed (environmental, in the list above); Import 259 passed, 40 skipped, 2 failed (environmental, in the list above).
9. **REDO-safety call-graph baseline** (`RedoSafeCallGraphTests`, net10, after the merged #1562): **25 total, 25 passed, 0 failed.** `RedoSafeReviewedHooks.baseline.txt` is #1562's own +10 lines; nothing re-pinned by me.
10. **Nothing re-pinned, no code fixed by me.** My only commit changes blank lines in the log.
11. **Tim's settings files, before (14:48) and after (15:27):** `TIM_CE_CADTOOLS\CD_Settings.json` acd64e79 (15,270 bytes, on-disk time 11 Mar 2026), `CS_Settings.json` 622a246f (351,713 bytes), `CE_CVL_SUITE\settings.json` efe307c4 (672 bytes), `CE_STRUC_SUITE\CS_Settings.json` 2972ce7 (35,259 bytes): **all unchanged** (hash and size identical; no settings file under Roaming newer than 14:40 today).
12. **AutoCAD:** acad.exe was running at 14:48 and at every step (the check printed 1 before the solution build, Civil net10, Manager and every net48 step; 1 again at 15:27). The runs were all inside Tim's 2:00pm to 3:00pm free window until about 15:00, and after 3:00pm (the second half) they overlapped his afternoon AutoCAD window (Below Normal priority). The PC was not idle.
13. **Mistakes first:** I ran the net48 "Settings" filter in the brief twice before seeing it matches everything; it cost about 10 minutes of machine time and is not used as evidence. The first merge-check script reported the PR file-list differences as a stop for #1611 because gh's list is against the old C-60 base; I added the second comparison (own diff against the C-61 merge-base) and re-checked #1611 by hand: identical.
14. **Not tested:** anything in AutoCAD or accoreconsole; any window or picture; Structural; Installer.Tests (never run on this PC, compiled only by the solution build); Manager net48 tests; the Manager release file-count guard (needs a release payload build); the net48 full list of 369 reds compared by name against the base.

## 6. The resolved `UserSettings.cs` block (#1562 against #1567)

Conflict was in `LinkingSettings`, at the top of the class. Both blocks kept, each with its own doc line and default, side by side (the file is LF in git; shown here as it stands):

```
    public class LinkingSettings
    {
        /// <summary>
        /// BUG-963 (HIGH): ON = when a pipe has only ONE invert text left (the other was hidden in Edit Pipe), CDPROPAGATE writes into it the
        /// level of the end that text belongs to (first-point or last-point), not always the first end. A single text whose end is not recorded
        /// is left alone and named in the summary. OFF = the old behaviour (the single text always got the first end's level).
        /// Not a block (R-27): the pipe is reported and can be checked by hand. Default: on.
        /// </summary>
        [JsonProperty("propagateWritesSingleIlToItsOwnEnd")]
        public bool PropagateWritesSingleIlToItsOwnEnd { get; set; } = true;

        /// <summary>
        /// BUG-874 (HIGH): ON = when Esc ends CD after a pipe with a callout was already placed, the callout is linked to its pipe inside that
        /// command (one Undo step with the pipe), as at a normal command end. OFF = the old behaviour (Esc threw the link away, so erasing the
        /// pipe left its label behind). Not a block (R-27). Never writes at U / UNDO / REDO / MREDO or while REDO is available. Default: on.
        /// </summary>
        [JsonProperty("escKeepsPlacedCalloutLinks")]
        public bool EscKeepsPlacedCalloutLinks { get; set; } = true;

        [JsonProperty("pitLabelMaxDistanceMm")]
        public double PitLabelMaxDistanceMm { get; set; } = 5000.0;
```

The `REGRESSION_LOG.md` clash was resolved the same way as at every other step: the PR's own insertion applied to the running file (every entry kept, newest merge on top, zero conflict markers). The merged `UserSettings.cs` was checked for conflict markers (none), and the Civil suite builds and passes on top of it.

## 7. For the finalizer

1. **#1645** (CDRG) was never Opus-reviewed. Review it fully. It touches only the raingarden readback and its tests; no clash with #1552 (CDSPOON).
2. **Four new switches, all ON, none with a Settings row.** The doc lines say "Default: on." as required by the C-61 census test, which passes on net10. A row for each is owed to the Codex window lane.
3. **C62 copy of `C61NewSwitchDefaultsTests`** for the four new switches (fix-round item 8) is still not written.
4. **Manager:** one new product source file (`CeManagerCommandSender.cs`); confirm the 75-file bundle guard on the real release payload build.
5. **net48:** compile is clean for the whole solution. Test reds on net48 are the reference-only fault only. Say if you want the base built for the by-name comparison.
6. **Versions** not bumped (the payload builder does Civil 3.0.72 / Manager 1.1.72).
7. **Hygiene:** worktree `C:\ce-asm\c62`, its local branch, and my `t62_*` temp folders are removed after this report is pushed; scripts and logs stay in `C:\ce-asm\` (`mergeone62.sh`, `run62.sh`, `f48_62.sh`, `logs62`, `list62*.txt`). The leak-scan hook ran on the push and was clean.

Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted or Codex-accepted.**

## Summary

C-62 is on `claude/rel-20261023m` (`dd13cf58`): all 23 PRs merged at their expected heads. Shared and Installer untouched; Manager changes from #1613, #1632, #1594, #1595 (one new source file). Four new switches, all ON, no Settings rows. Solution builds 0 errors on net48 and net10; Civil net10 19,545 tests, 0 failed; Manager 932, 0 failed; net48 focused 17 reference-only reds; REDO baseline 25 of 25. #1645 needs a full review.
