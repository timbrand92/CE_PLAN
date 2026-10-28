# Train C-75 assembly report (Civil + Manager, bug-fix train of three PRs: #1831 BUG-665 and BUG-672, #1832 BUG-1222, #1833 BUG-1223), Wed 28 Oct 2026 (real clock 20:00 to about 21:15 Melbourne)

Sonnet 5.5, Team, headless assembler. Built and unit-tested only. Nothing is installed or accepted by this job, nothing was opened in AutoCAD by me, and BUG-665, BUG-672, BUG-1222 and BUG-1223 are NOT fixed (they stay open).

## ANSWER FIRST

1. **My own mistakes first.** None cost anything. (a) I called `powershell.exe` from the Bash tool once and it is not on that PATH (the hash step failed and I redid it from PowerShell). (b) My first net48 filter list was the C-74 one plus the new classes; I added three EXISTING classes the C-74 filter did not carry (`Bug260ArrowTurn`, `PipeEditCommandDataCollection`, `C5RefreshDirection`, all named in the job). They turned out to be reference-only reds on net48, so the net48 red count reads 84, not 55. I then built the base tip to prove they are red there too (item 10). (c) The whole-solution build and the long test runs ran longer than the tool's 10 minute limit, so the tool moved each to the background; none was killed, each wrote its own end marker.
2. **Branch and head.** `claude/rel-20261026z` (it did not exist; the first free letter after the job text), pushed with normal pushes (after each merge). Head `905dd2baea9abe039586361f58f62fefafdfa9c4` (merge of #1833). If a report commit or later commit sits on top, it is only this report in `C:\CE_PLAN` (a different repository); the plugin branch has no commit after the third merge.
3. **Base tip used:** `94f521cc75811785800faf436d7c259c26337569`, the C-74 version commit "Version: Civil 3.0.84 / Manager 1.1.84 (C-74)". It is a descendant of the C-74 finalizer's signed head `6d76a2678aef5476b90e901fd86b7a2968fd6e96` (`git merge-base --is-ancestor` true) and `git log 6d76a267..94f521cc` shows exactly one commit, the version commit. The four version places on the tip read Civil 3.0.84 (`Installer\PackageContents.xml`, `Modules\Drainage\CE_CVL_SUITE.csproj`) and Manager 1.1.84 (`Modules\Manager\CE_SUITE_MANAGER.csproj`, `Modules\Manager\Installer\PackageContents.xml`). The C-74 finalizer report line 11 reads "1. **GO at `6d76a2678aef5476b90e901fd86b7a2968fd6e96`.**". `git ls-remote origin refs/heads/claude/rel-20261026y` read `94f521cc...` at the start and the branch is the base of all three PRs.
4. **Installed (read from the six DLLs, read-only, script `readver.ps1` using `FileVersionInfo`):** Civil Legacy, Modern and Net8 `CE_CVL_SUITE.dll` all file 3.0.84.0, product `3.0.84+94f521cc75811785800faf436d7c259c26337569`; Manager Legacy, Modern and Net8 `CE_SUITE_MANAGER.dll` all file 1.1.84.0, product `1.1.84+94f521cc75811785800faf436d7c259c26337569`. That is C-74 installed, acceptable for the assembler. Structural was not read (not in this train).
5. **Merged: 3 of 3**, in the list's order, plain `--no-ff`, one merge commit each, no squash, no rebase. #1831 at `6f7736c5593d8ffb20dc169f169e0bd8b8ef84ac` (merge `c470c675`), #1832 at `76171d1e5b2869d18e74fe214ba6da306463c81d` (merge `8d80c4f3`), #1833 at `7e93456c97335d5db5a4689b2b7c4568c47c828c` (merge `905dd2ba`). The second parent of each merge equals the live head I merged (checked). Each PR's own numstat equals the merge's own contribution (the script printed MATCH three times) and equals the list: #1831 11 files, 430 added, 14 removed; #1832 5 files, 348, 4; #1833 5 files, 318, 2.
6. **Live head at merge time, and did it move:** for each PR `gh pr view`, `git ls-remote origin refs/pull/<n>/head` and my own fetch of `refs/remotes/pr/<n>` all read the same 40 characters, equal to the reference head in the list. None of the three moved. All three OPEN (draft, base `claude/rel-20261026y`). **None of the three has had an independent read.** The list file I read is `C:\CE_PLAN\areas\TRAIN_C75_PR_LIST_2026-10-28.md`, last commit `e74b2b5163d14e7690a1d275ede07248895bab56` ("C-75 train: PR list (3 bug-fix PRs #1831-#1833)..."); it agrees with the job text.
7. **Shared, Installer, Manager: none touched.** `git diff --stat <base>..HEAD` is EMPTY for `Shared`, for `Installer Installer.Tests Modules/Manager/Installer`, and for `Modules/Manager Modules/Manager.Tests`; no file was ADDED there. **Manager code is UNCHANGED in this train (Manager 1.1.85 is a re-stamp).** The four version places still read 3.0.84 / 1.1.84 on my branch; I did not bump anything.
8. **Settings: FOUR keys added and nothing else, all ON.** `UserSettings.cs` diff is 41 added, 0 removed (19 + 11 + 11): `RotateScaleCopyLikeCopy` (`linking.rotateScaleCopyLikeCopy`) and `PitCopyLineNamesOnlyWhatIsMissing` (`linking.pitCopyLineNamesOnlyWhatIsMissing`) in `LinkingSettings`; `EditPipeReverseArrowReadsDrawnEnds` (`pipe.editPipeReverseArrowReadsDrawnEnds`) in `PipeSettings`; `SourcePickComparesPipeRecordLikeForLike` (`linking.sourcePickComparesPipeRecordLikeForLike`) in `LinkingSettings`; each `= true`, each documented "Default: on." `DiagSettings.cs` diff is EMPTY (the nineteen `diag.redo` keys, all `= false`).
9. **Build:** whole solution Release `-m:1`, **0 errors**, 909 warnings, exit 0, 20:04 to 20:28 (24 min 32 s). Built net48, net8.0-windows and net10.0-windows (Civil and Manager); `Tests\CE.TestHarness.Tests` built (net10.0-windows); `Installer` (net9.0, built into its `bin\Debug` path) and `Installer.Tests` (net9.0-windows, Release) COMPILED, not run.
10. **Tests:** Civil net10 Release full **20,782 total, 20,750 passed, 32 skipped, 0 failed** (the list expected about 20,782 to 20,783; the C-74 floor was 20,720). Manager net10 **1,041 total, 1,040 passed, 1 skipped, 0 failed**. Manager net48 build 0 errors. Civil net48 focused **3,215 total, 2,997 passed, 134 skipped, 84 failed, every red an `InvalidProgramException`** (no other kind of red): the 55 known reference-only names, plus 29 in four classes the C-74 filter did not include: `Bug260ArrowTurnTests` 10, `PipeEditCommandDataCollectionTests` 8, `C5RefreshDirectionTests` 4 (all three EXIST at the base and fail there with the identical names, proved by building and running the base tip: 22 of 22 identical), and `Bug1222EditPipeArrowReadTests` 7 of the PR's 14 (see the test evidence: those 7 call a method on `PipeEditCommand`, so the reference-only AutoCAD DLL cannot run them; all 14 pass on net10). `RedoSafeCallGraphTests` 25 of 25 on net10 (25 passed, 2 not executed on net48), no baseline touched. Arch Civil half 14 of 14.
11. **Clash blocks resolved:** `REGRESSION_LOG.md` clashed on the second and third merge; the script kept both sides (newest merge on top). `UserSettings.cs` did NOT clash: git merged it on its own with no conflict marker, because the three PRs' additions sit in different places (the #1833 property after `ReopenedDrawingLoadsItsOwnRecord`, the #1831 pair after `CleanUpGripRotateScaleCopies`, the #1832 property in `PipeSettings`). The `UserSettings.cs` hunks are in item 4 of the merged code below (pure additions, nothing renamed, no default changed). `REGRESSION_LOG.md`: headings with no blank line before them: base 160, after 160 (equal); headings 1,503 before, 1,506 after (three new entries); conflict markers anywhere: 0 after every merge; `REGRESSION_LOG.md` diff is 48 added, 0 removed.
12. **SCOPE CHECK 9 hit list (for the finalizer, not judged).** Searched the added lines of `git diff -U0 <base>..HEAD -- Modules/Drainage ':!Modules/Drainage.Tests'` (307 added lines) for the listed words. Real hits (file, line on the merged branch, PR):
    1. `Modules/Drainage/Services/ExternalMutationCommandPolicy.cs` line 107 `try { return ...RotateScaleCopyRule.IsOn(SettingsService.Current?.Linking); }` and line 108 `catch { return true; }` (#1831; reads the switch, an unreadable settings file reads ON).
    2. `Modules/Drainage/Services/LinkService.SourceLanding.cs` line 499 `try { return SourcePickPipeRecordRule.IsOn(SettingsService.Current?.Linking); }` and line 500 `catch { return true; }` (#1833; the same shape for its switch).
    3. `Modules/Drainage/Services/LinkService.CloneRegeneration.cs` line 308 `skips?.Add(labelLayer?.Name ?? attachment?.Layer, labelLayer?.IsLocked == true, cand.CloneHandle, kind);` (#1831; this READS `IsLocked` of a layer to pass it to the message collector; the old line read it too, the same way).
    4. False hits by substring, listed so you do not hunt for them: `PipeEditCommand.DataCollection.cs` line 702 `GeometryHelper` (contains "try", #1832); and every added line in `LinkService.CloneRegeneration.cs` matches "Regen" only through the file NAME in my search, not through the text. None of `StartTransaction`, `SetSystemVariable`, `GetSystemVariable`, `SendStringToExecute`, `UpdateScreen`, `LockDocument`, `UpgradeOpen`, `Unlock`, `LayerLocked`, `+=`, `-=`, `Idle`, `CommandWillStart`, `CommandEnded`, `DocumentActivated`, `DocumentToBeDestroyed`, `throw` appears on an added line, and a text search for the word `Regen` (not the file name) on the added lines gives no hit.
    5. Not in your list but the finalizer should know: (a) #1831 adds a log line `LoggingService.Info(... "turned or mirrored copy, annotations not copied")` in `ClonePitAttachmentsByDisplacement` (a mirrored copy now logs); (b) #1831 adds `IsMirroredBlock` (reads `ScaleFactors`, read only); (c) #1831 calls `BlockService.IsPitLabelBlock(labelBlock, tr)` to classify the skipped annotation; (d) #1833 calls `SourceTagService.TryGetTag(existing, tr, out existingTag)` on a block opened `ForRead`; (e) #1832 adds one more call to `TryResolveReverseArrowFromAttachment` at the end of `TryCollectPipeData` inside the existing read pass (the early call stays for the switch-OFF path).
13. **For the finalizer (read, do not trust):** (a) with `linking.rotateScaleCopyLikeCopy` ON the new rule line is `CommandCanCopy` added as a THIRD `||` term in `CanCreateClones`, so a plain ROTATE or SCALE is now "copy-capable"; the PR says a plain one appends nothing so does no clone work: read that. (b) `LinkService.CloneRegeneration.cs` line 280 onward: the old rotation check is now the rule, and a MIRRORED copy (odd negative scale) is still skipped, now with a log line. (c) #1833 reads the pick compare for the pipe record only when the switch is ON; with it OFF `ExpectedLiveRow` returns the index's filled row (the old behaviour). (d) The reworded refusal in #1833 uses the literal `true` for the switch in `LandingRefusalWords(true, ...)` because the `if` above it already tested `PickComparesPipeRecordLikeForLike()`: the rule function's own switch parameter is therefore not what gates it. (e) Four existing test files were edited by #1831 to change old expectations (`C4CopyPasteMirrorOopsTests` 1/1, `CopyOfAPitOrPipeKeepsNoIdentityTests` 8/4, `LinkServiceCommandPerformanceContractTests` 2/1, `OvernightLabelDoubleClickAndCopyTests` 2/1); read each as a true change of expectation. All four pass on net10 (and on net48 where they run).
14. **Not tested:** anything in AutoCAD. Nobody has run #1831, #1832 or #1833 in AutoCAD; the grip Ctrl-drag copy and a mirrored pit copy are not changed (the grip key `linking.cleanUpGripRotateScaleCopies` reads OFF, unchanged); whether a floor waste may sit on an inspection opening is Tim's open question, not mine, and the draft keeps the refusal. An `acad.exe` WAS open during my runs (see test evidence item 9); I never touched it. `Installer.Tests` were compiled, never run. I did not run the Structural Arch half (KNOWN RED 3 of 4 on this Structural line).

## 1. What I read first

1. `C:\TimOS\RULES.md` in full, the job text, the PR list `C:\CE_PLAN\areas\TRAIN_C75_PR_LIST_2026-10-28.md` in full, the three author reports (`release-v3-colleagues-BUG665_672_FIX_REPORT.md`, `...BUG1222_FIX_REPORT.md`, `...BUG1223_FIX_REPORT.md`; I read their ANSWER FIRST and Detail blocks, the first 40 lines of each, which cover cause, fix, tests and what is not tested), the C-74 assembly report in full and the first block and last paragraph of the C-74 finalizer report.
2. `train_c75_assembler_job.log` was empty at the start: a fresh run, not a relaunch. No earlier push of `claude/rel-20261026z` existed.
3. I re-pointed the C-74 runner scripts to C-75 with a copying script (same scripts, new paths, no new build script): `C:\ce-asm\*75*.sh` and `*75*.ps1`, plus `domerge75.sh` which reads `list75.txt` (the PR list lines: number, label, reference head) and calls the existing merge script for each.

## 2. Merge record

1. Worktree `C:\ce-asm\c75` on `claude/rel-20261026z` from `94f521cc`; checked first that `refs/heads/claude/rel-20261026z` did not exist on origin (it did not).
2. **#1831** "Merge PR #1831 (BUG-665 BUG-672) at 6f7736c5", merge SHA `c470c675c49d2471925ed51a4ae62ea16ca2a275`, parent 2 `6f7736c5593d8ffb20dc169f169e0bd8b8ef84ac`. Clean merge, no conflict. 11 files: the numstat list in the PR list (430 added, 14 removed), MATCH.
3. **#1832** "Merge PR #1832 (BUG-1222) at 76171d1e", merge SHA `8d80c4f3396338221b66c5f6d09f4db515771dff`, parent 2 `76171d1e5b2869d18e74fe214ba6da306463c81d`. Clash in `REGRESSION_LOG.md` only; resolved by keeping both. 5 files, 348 added, 4 removed, numstat MATCH with the PR's own diff.
4. **#1833** "Merge PR #1833 (BUG-1223) at 7e93456c", merge SHA `905dd2baea9abe039586361f58f62fefafdfa9c4`, parent 2 `7e93456c97335d5db5a4689b2b7c4568c47c828c`. Clash in `REGRESSION_LOG.md` only; resolved by keeping both. 5 files, 318 added, 2 removed, numstat MATCH.
5. `git rev-list --merges --count` since the base: 3; commits since the base: 6 (three merges and the three PR commits). The leak-scan hook was clean on every push (36 terms).
6. **Whole train diff:** `git diff --shortstat <base>..HEAD` reads **17 files changed, 1,096 insertions, 20 deletions**. (The PR list said 19 distinct files: 11 + 5 + 5 is 21 and two files, `UserSettings.cs` and `REGRESSION_LOG.md`, are each counted three times, so the true distinct count is 17. The inserted and removed lines equal the list's 1,096 and 20 exactly.) After the keep-both merges `UserSettings.cs` is 41/0 and `REGRESSION_LOG.md` is 48/0, as expected.
7. Full file list with added/removed: `Modules/Drainage.Tests/Commands/Bug1222EditPipeArrowReadTests.cs` 269/0 (new); `Modules/Drainage.Tests/Rules/C4CopyPasteMirrorOopsTests.cs` 1/1; `Modules/Drainage.Tests/Services/Bug1223FloorWasteOpeningTests.cs` 204/0 (new); `.../Bug665672RotateCopyLabelTests.cs` 255/0 (new); `.../CopyOfAPitOrPipeKeepsNoIdentityTests.cs` 8/4; `.../LinkServiceCommandPerformanceContractTests.cs` 2/1; `.../OvernightLabelDoubleClickAndCopyTests.cs` 2/1; `Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs` 28/4; `Modules/Drainage/Models/UserSettings.cs` 41/0; `Modules/Drainage/Rules/EditPipeReverseArrowReadRule.cs` 26/0 (new); `Modules/Drainage/Rules/RotateScaleCopyRule.cs` 60/0 (new); `Modules/Drainage/Rules/SourcePickPipeRecordRule.cs` 57/0 (new); `Modules/Drainage/Services/CloneCleanupMessages.cs` 35/4; `Modules/Drainage/Services/ExternalMutationCommandPolicy.cs` 9/1; `Modules/Drainage/Services/LinkService.CloneRegeneration.cs` 20/2; `Modules/Drainage/Services/LinkService.SourceLanding.cs` 31/2; `REGRESSION_LOG.md` 48/0.

## 3. Scope check

1. `git diff --stat <base>..HEAD -- Shared`: EMPTY (CE_SHARED unchanged).
2. `-- Installer Installer.Tests Modules/Manager/Installer`: EMPTY.
3. `-- Modules/Manager Modules/Manager.Tests`: EMPTY. No file ADDED in Manager, Installer or Shared.
4. `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json` and every `PackageContents.xml`: not changed (no CrossModuleGuard count change; `CrossModuleGuardTests` 6 of 6 on net48).
5. Files matching `sign`, `Signing`, `Release` authority or deploy script names: none.
6. No `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx` or `.github` file changed. `Modules/Arch.Tests` and `Modules/Arch.Tests.Structural`: EMPTY. `CE.AI.Core` and `CE.AI.Core.Tests`: EMPTY. The Manager bundle file-count guard stays 75; this train adds no bundle file.
7. Totals: see Merge record item 6.
8. `git diff <base>..HEAD -- Modules/Drainage ':!Modules/Drainage.Tests'` lists exactly the nine product files named in the list (`PipeEditCommand.DataCollection.cs`, `UserSettings.cs`, `EditPipeReverseArrowReadRule.cs`, `RotateScaleCopyRule.cs`, `SourcePickPipeRecordRule.cs`, `CloneCleanupMessages.cs`, `ExternalMutationCommandPolicy.cs`, `LinkService.CloneRegeneration.cs`, `LinkService.SourceLanding.cs`) and nothing else.
9. **Defaults of the neighbouring switches, read from the merged code (all unchanged by this train):** the nineteen `diag.redo` keys in `DiagSettings.cs`: 19 `public bool` properties, 19 `= false` (all false); `linking.reopenedDrawingLoadsItsOwnRecord` true (ON); `pipeSpeedChecks.useMaterialLimit` false (OFF); `detention.orificeUsesRuledGravity` true; `detention.detentionTabUsesCouncilOrificeCo` true; `sharedValues.pitDropFollowsBox` false (OFF); `linking.pasteLineForDrawingWithNoRecord` true; `linking.inspectorPickWaitsAfterUndo` true; `linking.cleanUpGripRotateScaleCopies` **false** (OFF, unchanged: the grip Ctrl-drag and the old route); `linking.copyCleanUpKeepsEveryPiece` **true**; `surface.slabMinimumFalls` ConcreteOneIn 100 / PaversOneIn 50 / AsphaltOneIn 67. The four new keys are all true.
10. The `DiagSettings.cs` diff is EMPTY (0 lines).

## 4. The merged code at the changed places (read after the merge)

The full text of the files and hunks the job asked me to read is in the APPENDIX at the bottom of this report (written straight from `git` on branch head `905dd2ba`, so it is the merged code, not a copy by hand). Short reading of each:

1. **`UserSettings.cs`** (appendix A): three pure-addition hunks, 41 lines, each ending `= true;` with a documentation summary that ends "Default: on.". No property renamed, no default changed, nothing removed.
2. **`RotateScaleCopyRule.cs`** (60 lines, appendix B): `IsOn`, `LineNamesOnlyWhatIsMissing`, `CommandCanCopy` (ROTATE or SCALE only when the switch is on), `CopiesPitAnnotationsAcross` (the same rotation always; switch on and both or neither mirrored also), `MissingWords`.
3. **`EditPipeReverseArrowReadRule.cs`** (26 lines, appendix C): `IsOn`, `ArrowIsReversed`.
4. **`SourcePickPipeRecordRule.cs`** (57 lines, appendix D): `IsOn`, `ExpectedLiveRow`, `Unchanged`, the constant `MoreThanOneConnectionReason`, `LandingRefusalWords`, `ExistingSourceWords`.
5. **`ExternalMutationCommandPolicy.cs` `CanCreateClones`** (appendix E). OLD: command in `CloneCapableCommands`, or (command in `TransformCommandsThatCanCopy` and `CleanUpGripRotateScaleCopies()`). NEW: the same two terms, plus `|| RotateScaleCopyRule.CommandCanCopy(RotateScaleCopyLikeCopy(), commandName)` (with a new private reader that returns ON if settings cannot be read).
6. **`LinkService.CloneRegeneration.cs` `ClonePitAttachmentsByDisplacement`** (appendix F). OLD: skip the whole pit's annotations when `Math.Abs(source.Rotation - clone.Rotation) > 1e-6`. NEW: skip only when `!RotateScaleCopyRule.CopiesPitAnnotationsAcross(switch, rotations, mirrored flags)`, with a log line when it skips a real copy; the locked-annotation branch now passes the pit handle and the kind (label or cover text) to the message collector and calls `NothingCopied()` on the older route.
7. **`CloneCleanupMessages.cs` `PitLabelCopySkips`** (appendix G). OLD: `Add(layer, locked)` always counted a pit and `Line()` always said "no label or cover text". NEW: `Add` overload with handle and kind (each pit counted once when the switch is on), `Line()` takes the words from `RotateScaleCopyRule.MissingWords`; with the switch off, or when the kind is not known, the old words.
8. **`PipeEditCommand.DataCollection.cs`** (appendix H). `AnalyzeAttachmentState`: OLD ran the reverse-arrow read there always; NEW runs it there only with the switch OFF, and with the switch ON runs it at the end of `TryCollectPipeData` after `RecordLevelFillRule.Orient` has put the boxes on their drawn ends. `TryReadReverseArrow` is the old body split out as an internal static method (logic unchanged; the last line calls `ArrowIsReversed`, same `!=` comparison).
9. **`LinkService.SourceLanding.cs`** (appendix I). The nearby-pipe check in `ReadCompleteSourceLanding`: OLD compared the live pipe row with `before.RowJson` (the index's own, key-filled copy). NEW with the switch ON compares it with `index.LivePipeRow(handle)` (the live row captured when the index was built); OFF returns to `before.RowJson`. The refusal sentence for a real change is unchanged. New: the reworded "<tag> is already at this point" refusal, and `LivePipeRow` captured beside `LivePitRow`.

## 5. Test evidence

Environment: Below Normal priority (the runner script sets it), normal TEMP for builds, fresh TEMP and CE log folder (log folder inside that TEMP, backslash form with the long folder names) only for test steps, never deployed, no AutoCAD or accoreconsole launched by me. `C:\asm75\w` (same commit as `C:\ce-asm\c75` at `905dd2ba`) was used for builds and tests; the base tip check ran in `C:\asm75\b` at `94f521cc`. A 0-byte `CE_TRANSFORM_2027.arx` placeholder was made in each untracked bin folder. Restores were done project by project (Shared x3, CE.AI.Core, Drainage, Manager, both test projects, Installer, Installer.Tests, TestHarness.Tests): each 1 to 7 seconds, no stall; then the solution build with `-m:1`.

1. **Desk build lock:** taken for EVERY step (the lock file was free each time: `sln`, `civil10`, `mgr10`, `named10`, `mgr48build`, `civil48f`, `arch10`, `baseb`, `basetest` all wrote "lock taken"); each run removed its own lock file; the lock file does not exist now (checked).
2. **Whole solution Release build** (`dotnet build CE_ACAD_PLUGIN.slnx -c Release -m:1`): 20:04:07 to 20:28:40 (24 min 32 s), **0 errors**, 909 warnings, exit 0. Frameworks seen in the log: net48, net8.0-windows, net10.0-windows (and `net8.0` for the shared projects). `Tests\CE.TestHarness.Tests` built; `Installer` and `Installer.Tests` compiled (not run). C: free 23.5 GiB before, 22.3 GiB after.
3. **Civil net10 Release full** (20:29:16 to 20:43:04, 13 m 28 s): **Total 20,782, passed 20,750, skipped 32, failed 0.** Total is in the tens of thousands, above the 20,720 floor, and equals the authors' sum (20,720 + 33 + 14 + 15 = 20,782). No red, so no re-run was needed. The PDF page test did not fail in the full run and passed again alone (item 5).
4. **Manager net10 full** (20:43:09 to 20:44:27): **1,041 total, 1,040 passed, 1 skipped, 0 failed.** Manager by name (trx): `TestHygieneAppDataGuardTests` 10 of 10, `TestHygieneOfficeFolderGuardTests` 4 of 4, `CeAdminPluginOutboxDrainTests` 19 of 19, `CeAdminPolicyServiceTests` 21 of 21, `CeAdminUploadTempFilesTests` 1 of 1: all passed (there is no class named CeAdminStorage in the trx). **Manager net48 build** (20:45:47 to 20:47:05): 0 errors, exit 0.
5. **Named classes on net10** (`named10`, filter by class name, 532 total, 529 passed, 3 skipped = the `NotExecuted` rows of `C60AuditSourcePinGuardTests`, 0 failed; 20:44:28 to 20:45:46): `RedoSafeCallGraphTests` **25 of 25**; `PickHandlerProbeTests` 7 of 7; `InspectorPaletteServiceHintTests` 13, `InspectorPaletteWordingTests` 5, `InspectorPaletteRenderTests` 22: all passed; `Bug861RedoFirstClickTests` 4 of 4; `Bug861DiagSwitchesTests` 36 of 36; `Bug861Diag2SwitchesTests` 25 of 25; `Bug1225ReopenedDrawingRecordTests` 17 of 17; **`Bug665672RotateCopyLabelTests` 34 of 34, `Bug1222EditPipeArrowReadTests` 14 of 14, `Bug1223FloorWasteOpeningTests` 15 of 15**; `C74NewSwitchDefaultsTests` 11, `C73NewSwitchDefaultsTests` 11, `C72NewSwitchDefaultsTests` 7, `C71NewSwitchDefaultsTests` 6, `C70NewSwitchDefaultsTests` 25: all passed (no PR edited them; no count changed); `C60AuditSourcePinGuardTests` 42 (39 passed, 3 not executed): `NewSettingsKeys_NeedADocumentedDefault` **PASSED**; the Settings-fit test: `SettingsWindowV3Tests` 5 of 5 passed (the five screen cases, which include `EveryTab_FitsTheScreen_AtOneFixedHeight`; I did not read the 670 px figure, the test asserts it; no PR touches the Settings window); `Bug260ArrowTurnTests` 14, `PipeEditCommandDataCollectionTests` 8, `PipeEditCommandDataCollectionOrderTests` 2, `C5RefreshDirectionTests` 31, `SourceAtomicCoordinatorDependencyTests` 24, `LinkServiceCommandPerformanceContractTests` 53, `CopyOfAPitOrPipeKeepsNoIdentityTests` 24, `C4CopyPasteMirrorOopsTests` 33, `OvernightLabelDoubleClickAndCopyTests` 5: all passed. The engineering back-test `BackTest_GlenEira24115_IssuedDischarge_WithinTolerance` (two methods) and `GlenEira24115_EnginesOwnDischargeSum_WithinTwentyPerCentOfTheIssuedSheet` PASSED. `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`: it RAN (not skipped) and PASSED, alone (AutoCAD was not counted open at that step, count 0).
6. **Civil net48 focused Release**, class-name filters (20:47:05 to 20:57:38, 10 m 33 s): **3,215 total, 2,997 passed, 134 skipped, 84 failed**. By class the reds are: `BranchHostLabelTidyRuleTests` 1, `Bug1190NestedSurveyBlockTransformTests` 3, `Bug1194ClickedLegTests` 6, `Bug230DrawingUnitsTests` 4, `C5MixedUnitsTests` 4, `CdCreationPlanPointTests` 18, `PitCatchMarginSettingsTests` 1, `RaingardenPlanPointTests` 9, `Rd09AnnotationPreparationTests` 8, `SourceTypeRulingsTests` 1 (these ten make the **55 reference-only names, identical to C-74**, and none changed), and the 29 new-to-this-filter reds: `Bug260ArrowTurnTests` 10, `PipeEditCommandDataCollectionTests` 8, `C5RefreshDirectionTests` 4, `Bug1222EditPipeArrowReadTests` 7. Every one of the 84 is a `System.InvalidProgramException` ("Common Language Runtime detected an invalid program": the reference-only AutoCAD DLL); the script found NO red with another message. The Bug960 palette clash seen in C-74 did NOT recur (nothing to re-run).
7. **Do the 29 fail on the base too? (item 6 of BUILD AND TEST)** Built the base tip `94f521cc` in `C:\asm75\b` (net48, Release, 0 errors, 5 min 12 s) and ran the three EXISTING classes there: 55 total, 22 failed, 33 passed; the failed names are **identical** to the 22 red names on my head (`Bug260ArrowTurnTests` 10, `PipeEditCommandDataCollectionTests` 8, `C5RefreshDirectionTests` 4; Compare-Object found no difference), every one `InvalidProgramException`. So those 22 are pre-existing reference-only reds that C-74's filter simply did not carry. The other 7 are in `Bug1222EditPipeArrowReadTests`, which does not exist on the base: they call `PipeEditCommand.TryReadReverseArrow` and fail with the same `InvalidProgramException` ( `ThatFalseTick_TurnsTheArrowBackUphill_OnTheNextSave_AsTheRobotSaw`, `TheNewReading_LevelsOnTheirDrawnEnds_ReadsTheTurnedArrowAsNotReversed`, `TheOldReading_LevelsStillUpstreamFirst_TakesTheTurnedArrowForADrafterReversedOne`, `WithTheRightTick_TheNextSaveKeepsTheArrowTurnedRound`, `ADrafterReversedArrow_IsStillReadAsReversed_AtTheDrawnEnds`, `APipeNeverTurnedRound_ReadsTheSameEitherWay`, `TheZeroLevelPipe_OfR32_ReadsTheSameWay` ). The other 7 tests of that class pass on net48 (the switch-load tests, the rule table, the source guards). On net10 all 14 pass, so the fault itself IS reproduced and fixed by a test there. The net48 lane therefore cannot run those 7; the finalizer should rely on net10 for them.
8. **Named classes on net48** (from the same trx): `RedoSafeCallGraphTests` 27 (25 passed, 2 not executed); `PickHandlerProbeTests` 7; `InspectorPalette*` 13 and 5 (all passed); `Bug861RedoFirstClickTests` 4; `Bug861DiagSwitchesTests` 36; `Bug861Diag2SwitchesTests` 25; `Bug1225ReopenedDrawingRecordTests` 17; `Bug665672RotateCopyLabelTests` **34 of 34 passed on net48 too**; `Bug1223FloorWasteOpeningTests` **15 of 15 passed on net48 too**; `Bug1222EditPipeArrowReadTests` 7 of 14 passed (item 7); `C74NewSwitchDefaultsTests` 11, `C73` 11, `C72` 7, `C71` 6, `C70` 25: all passed; `C60AuditSourcePinGuardTests` 42 (39 passed, 3 not executed) with `NewSettingsKeys_NeedADocumentedDefault` PASSED; `SourceAtomicCoordinatorDependencyTests` 24 of 24; `CrossModuleGuardTests` 6 of 6; `HelpGuideVersionTests` 2 of 2. No count or fingerprint needed re-pinning: **I made no commit on the plugin branch beyond the three merges**; the call-graph baseline file is untouched and `RedoSafeCallGraphTests` still passes with three new files in `Rules`.
9. **Arch smoke check** (`Modules\Arch.Tests\CE_ARCH.Tests.csproj -f net10.0-windows`, restored alone first, same refs): **14 of 14 passed** (34 s; 20:58:37 to 20:59:55). The Structural half (`Arch.Tests.Structural`) is KNOWN RED 3 of 4 on this Structural line and was NOT run.
10. **AutoCAD (`acad.exe`) during my runs:** an `acad.exe` WAS open on this PC (process 95084 at my last read; not mine; a robot or Codex pass). Its count was read at the start of each step: 1 for `civil10`, `mgr10`, `mgr48build`, `civil48f`, `arch10`, `baseb`; 0 for `named10`. I never touched it or its lock.
11. **Tim's settings files (SHA-256 first 12 characters, before at 20:04:04, after at 21:07:32): UNCHANGED.** `TIM_CE_CADTOOLS\CD_Settings.json` `ACD64E79A33B` 15,270 bytes (last written 2026-10-04); `TIM_CE_CADTOOLS\CS_Settings.json` `622A246F7D3B` 351,713 bytes; `CE_STRUC_SUITE\CS_Settings.json` `B3B5A004B929` 35,586 bytes; `CE_CVL_SUITE\settings.json` `EFE307C4FC74` 672 bytes. The installed bundle was never written by me (never built without the skip flag; every dotnet command carried `-p:SkipDevBundle=true -nr:false --disable-build-servers`).
12. **Disk:** C: free 23.8 GiB at the start, 20.5 GiB at the end (floor 8). Nothing deleted outside my own folders.

## 6. Clean-up

1. Pushed: branch `claude/rel-20261026z` at `905dd2ba` (no commit after the third merge). Worktrees `C:\ce-asm\c75` (kept until this report is committed, see below), `C:\asm75\w` and `C:\asm75\b` are removed with `git worktree remove --force` at the end; my scratch under `C:\ce-asm` (scripts `*75*`, `logs75`, `s75`, `t75_*`, `c75scratch`) is left for the finalizer to read and is mine only. The empty `C:\asm72`, `C:\asm73` and `C:\asm74` folders are left alone.
2. I did not edit `DESK_LOG.md` or `BUG_CARPARK.md`. No PR was closed, retargeted or changed; no branch deleted; nothing marked FIXED.

## Summary (under 100 words)

C-75 assembled on `claude/rel-20261026z`, head `905dd2ba`, from the C-74 version commit `94f521cc` (3.0.84 / 1.1.84 installed). Three PRs merged, none moved: #1831, #1832, #1833, 17 files, 1,096 added, 20 removed; four keys, all ON; no Shared, Installer or Manager change. Solution 0 errors; Civil net10 20,782, 0 failed; Manager 1,041, 0 failed; net48 reds all reference-only (55 known, 22 base-proved, 7 in the new arrow tests); Arch 14 of 14. Nobody has run these in AutoCAD.

---

## APPENDIX: merged code, straight from git at `905dd2ba`

### A. UserSettings.cs (git diff -U2, the three added hunks)

```
diff --git a/Modules/Drainage/Models/UserSettings.cs b/Modules/Drainage/Models/UserSettings.cs
index 35db73e7..267778e3 100644
--- a/Modules/Drainage/Models/UserSettings.cs
+++ b/Modules/Drainage/Models/UserSettings.cs
@@ -627,4 +627,15 @@ namespace CE_CVL_SUITE.Models
         public bool ReopenedDrawingLoadsItsOwnRecord { get; set; } = true;
 
+        /// <summary>
+        /// BUG-1223 (MEDIUM): ON = when a floor waste, downpipe or other source is picked at a pipe end (an inspection opening, for
+        /// example), the check that a nearby pipe's Civil record has not changed compares the record at the pick with the record
+        /// when CE read the drawing, not with CE's own copy that already has the pipe's end identities filled in. Nothing changed,
+        /// so the source is placed and joined to the free pipe end instead of "A nearby pipe's Civil record changed while you
+        /// picked". A real change to that pipe's record still refuses. OFF = the old behaviour. Fixes a fault, so ships ON.
+        /// Not a block (R-27). Default: on.
+        /// </summary>
+        [JsonProperty("sourcePickComparesPipeRecordLikeForLike")]
+        public bool SourcePickComparesPipeRecordLikeForLike { get; set; } = true;
+
         [JsonProperty("pitLabelMaxDistanceMm")]
         public double PitLabelMaxDistanceMm { get; set; } = 5000.0;
@@ -817,4 +828,23 @@ namespace CE_CVL_SUITE.Models
         public bool CleanUpGripRotateScaleCopies { get; set; } = false;
 
+        /// <summary>
+        /// BUG-665 (HIGH, robot R34 R34s R34so on Civil 3.0.84): ON = a pit or pipe copied with the Copy option of ROTATE or SCALE
+        /// gets the same clean-up a plain COPY gets (its own number, schedule row, number label and cover text), and a pit copied
+        /// turned (ROTATE Copy) gets its label and cover text too, placed beside it as a COPY places them. Grip Ctrl-drag stays
+        /// with linking.cleanUpGripRotateScaleCopies. A mirrored copy is handled as before. OFF = the old behaviour (with the older
+        /// tick off, such a copy keeps the original's identity; with it on, a turned pit copy gets no label or cover text). Fixes
+        /// a fault, so ships ON (Monday question 8, recommended answer). Not a block (R-27). Default: on.
+        /// </summary>
+        [JsonProperty("rotateScaleCopyLikeCopy")]
+        public bool RotateScaleCopyLikeCopy { get; set; } = true;
+
+        /// <summary>
+        /// BUG-672 (LOW, robot R33m on Civil 3.0.84): ON = the line after copying a pit whose label or cover-text layer is locked
+        /// names only what is really missing ("no cover text" when the number label WAS drawn), and counts each pit once. OFF = the
+        /// old fixed sentence "no label or cover text". Fixes a fault, so ships ON. Not a block (R-27). Default: on.
+        /// </summary>
+        [JsonProperty("pitCopyLineNamesOnlyWhatIsMissing")]
+        public bool PitCopyLineNamesOnlyWhatIsMissing { get; set; } = true;
+
         /// <summary>BUG-742 (Hunt Civil B, 18 Oct 2026): CDTAG on a block with no tag refuses a numbered name (such as DP3) that another
         /// block already carries, with one plain line and nothing changed. OFF gives the old behaviour (two blocks can share it).</summary>
@@ -1295,4 +1325,15 @@ namespace CE_CVL_SUITE.Models
         public bool BlankInvertIsWarningNotBlock { get; set; } = true;
 
+        /// <summary>
+        /// BUG-1222 (HIGH): ON = when Edit Pipe opens, it decides whether the drafter reversed the flow arrow by comparing the
+        /// arrow with the two levels on their DRAWN ends (the levels the window shows), so a pipe whose levels were turned round
+        /// in an earlier Save no longer opens with the "reverse the flow arrow" choice silently on, and a later Save (nothing
+        /// typed, or only the size changed) keeps the arrow pointing from the higher level to the lower one. OFF = the old
+        /// behaviour (the reading used the record's upstream-first order and the second Save turned the arrow back uphill).
+        /// Only a reading moves; nothing is written. Fixes a fault, so ships ON. Not a block (R-27). Default: on.
+        /// </summary>
+        [JsonProperty("editPipeReverseArrowReadsDrawnEnds")]
+        public bool EditPipeReverseArrowReadsDrawnEnds { get; set; } = true;
+
         /// <summary>
         /// Tim, 15 Sep 2026: when a newly drawn pipe runs ACROSS existing pits, inspection openings or floor
```

### B. Rules/RotateScaleCopyRule.cs (in full)

```
using System;
using CE_CVL_SUITE.Models;

namespace CE_CVL_SUITE.Rules
{
    /// <summary>
    /// BUG-665 and BUG-672 (28 Oct 2026, robot R34 R34s R34so R33m on Civil 3.0.84). Two faults in the copy clean-up of a pit:
    /// (1) ROTATE and SCALE with the Copy option were treated as plain moves unless the older tick linking.cleanUpGripRotateScaleCopies
    /// was on (it ships OFF), so the copy kept the original's identity and had no label or cover text; and even with that tick on, a
    /// pit copied TURNED was refused its label and cover text by a "same rotation only" check, while CE still said "numbered as new".
    /// (2) the line after a copy with a locked annotation layer always said "no label or cover text", even when the label was drawn.
    /// Switches linking.rotateScaleCopyLikeCopy and linking.pitCopyLineNamesOnlyWhatIsMissing, both ON (R-27). Headless, so the
    /// net48 and net10 test lanes run it.
    /// </summary>
    internal static class RotateScaleCopyRule
    {
        /// <summary>The switch linking.rotateScaleCopyLikeCopy; a missing settings file or group reads ON (R-27).</summary>
        internal static bool IsOn(LinkingSettings linking) => linking?.RotateScaleCopyLikeCopy ?? true;

        /// <summary>The switch linking.pitCopyLineNamesOnlyWhatIsMissing; a missing settings file or group reads ON (R-27).</summary>
        internal static bool LineNamesOnlyWhatIsMissing(LinkingSettings linking) => linking?.PitCopyLineNamesOnlyWhatIsMissing ?? true;

        /// <summary>
        /// Whether ROTATE or SCALE (whose Copy option appends a copy) counts as a command that can make copies. Grips are not
        /// named here: they stay with the older tick.
        /// </summary>
        internal static bool CommandCanCopy(bool switchOn, string commandName) =>
            switchOn &&
            (string.Equals(commandName, "ROTATE", StringComparison.OrdinalIgnoreCase) ||
             string.Equals(commandName, "SCALE", StringComparison.OrdinalIgnoreCase));

        /// <summary>
        /// Whether the original pit's label and cover text are copied across to its copy (moved by the same distance the pit
        /// moved, so they sit beside it exactly as after a COPY and stay readable). A copy with the original's rotation always is
        /// (the old rule). Switch on: a copy turned by ROTATE Copy is too. A copy mirrored against its original keeps the old rule.
        /// </summary>
        internal static bool CopiesPitAnnotationsAcross(
            bool switchOn,
            double sourceRotation,
            double cloneRotation,
            bool sourceMirrored,
            bool cloneMirrored)
        {
            if (Math.Abs(sourceRotation - cloneRotation) <= 1e-6)
                return true;
            return switchOn && sourceMirrored == cloneMirrored;
        }

        /// <summary>
        /// The words for what a copied pit is missing. Switch off, or when what was left out is not known: the old "label or
        /// cover text". Switch on: only the kind(s) really left out.
        /// </summary>
        internal static string MissingWords(bool switchOn, bool labelLeftOut, bool coverLeftOut, bool unknownLeftOut)
        {
            if (!switchOn || unknownLeftOut || labelLeftOut == coverLeftOut)
                return "label or cover text";
            return labelLeftOut ? "label" : "cover text";
        }
    }
}
```

### C. Rules/EditPipeReverseArrowReadRule.cs (in full)

```
using CE_CVL_SUITE.Models;

namespace CE_CVL_SUITE.Rules
{
    /// <summary>
    /// BUG-1222 (28 Oct 2026): Edit Pipe works out, when it opens, whether the drafter reversed the flow arrow: it compares
    /// the way the arrow points along its own segment with the way the two levels fall. It used to do that BEFORE the two
    /// level boxes were put on their drawn ends, while they still held the record's From/To levels (upstream first). On a
    /// pipe whose levels had been turned round in an earlier Save (record From = the drawn SECOND end), the record order said
    /// "falls forward" while the arrow, correctly, pointed back: the window opened with "reverse the flow arrow" on, and the
    /// next Save applied it, turning the arrow back uphill against its own IL texts. With the switch on the reading waits
    /// until the boxes hold the levels on their drawn ends. Headless, so the net48 and net10 test lanes run it.
    /// </summary>
    internal static class EditPipeReverseArrowReadRule
    {
        /// <summary>The switch pipe.editPipeReverseArrowReadsDrawnEnds; a missing settings file or group reads ON (R-27).</summary>
        internal static bool IsOn(PipeSettings pipe) => pipe?.EditPipeReverseArrowReadsDrawnEnds ?? true;

        /// <summary>
        /// The drafter reversed the arrow when it points the other way to the fall of the levels. Both answers are along the
        /// drawn direction of the arrow's segment, so the levels must be on their drawn ends.
        /// </summary>
        internal static bool ArrowIsReversed(bool arrowPointsAlongDrawnDirection, bool levelsFallAlongDrawnDirection) =>
            arrowPointsAlongDrawnDirection != levelsFallAlongDrawnDirection;
    }
}
```

### D. Rules/SourcePickPipeRecordRule.cs (in full)

```
using CE_CVL_SUITE.Models;

namespace CE_CVL_SUITE.Rules
{
    /// <summary>
    /// BUG-1223 (28 Oct 2026, robot R36e and its twins p2 to p4, Civil 3.0.83 and 3.0.84): CDFW (and any source) picked at
    /// a pipe end, such as an inspection opening, refused with "A nearby pipe's Civil record changed while you picked" when
    /// nothing had changed. The landing index fills a pipe row's missing end identities from the owners it has just proved
    /// at the pipe's physical ends ("CDRG index filled pipe ... end key"), and that FILLED row is what the pick check then
    /// compared with the live record. The live record only gets those identities when a placement commits, and the refusal
    /// came before any commit, so it could never settle: every pick at that pipe end refused. In open ground no pipe is
    /// near, which is why the same command placed there. The pick check now compares like with like: the live record at
    /// the pick against the live record when the index was read (the same fix the nearby pit check got on 14 Sep 2026).
    /// A real change to the pipe's record between the two still refuses. Headless, so the net48 and net10 lanes run it.
    /// </summary>
    internal static class SourcePickPipeRecordRule
    {
        /// <summary>The switch linking.sourcePickComparesPipeRecordLikeForLike; a missing settings file or group reads ON (R-27).</summary>
        internal static bool IsOn(LinkingSettings linking) => linking?.SourcePickComparesPipeRecordLikeForLike ?? true;

        /// <summary>
        /// The pipe row the live record must still equal at the pick. Switch on: the live row as it was when the index was
        /// read (when one was captured). Switch off, or no live row captured: the index's own row, which may carry end
        /// identities the index filled in (the old behaviour).
        /// </summary>
        internal static string ExpectedLiveRow(bool switchOn, string liveRowAtIndex, string indexRow) =>
            switchOn && liveRowAtIndex != null ? liveRowAtIndex : indexRow;

        /// <summary>True when the live pipe row at the pick shows no change.</summary>
        internal static bool Unchanged(bool switchOn, string liveRowNow, string liveRowAtIndex, string indexRow) =>
            liveRowNow != null && liveRowNow == ExpectedLiveRow(switchOn, liveRowAtIndex, indexRow);

        /// <summary>SourceCompleteLandingRule.Decide's words when a source, pit or run already claims the pick.</summary>
        internal const string MoreThanOneConnectionReason = "The source would have more than one possible connection. Move it and pick again.";

        /// <summary>
        /// BUG-1223 part 2: once the false "record changed" refusal is gone, a pick ON an existing source (an inspection opening
        /// is one: on DRV1_B1 the pipe ends at each opening carry the opening's own CE-CIV-SRC identity) is still refused by
        /// the landing rule, deliberately: a new source never sits on top of another. Its words said "more than one possible
        /// connection", which a drafter cannot act on. Switch on, when exactly one existing source and no pit is under the
        /// pick, the refusal names it instead. Any other refusal keeps its own words.
        /// </summary>
        internal static string LandingRefusalWords(bool switchOn, string decidedReason, int pitCount, int sourceUnderPickCount, string existingTag) =>
            switchOn && decidedReason == MoreThanOneConnectionReason && pitCount == 0 && sourceUnderPickCount == 1
                ? ExistingSourceWords(existingTag)
                : decidedReason;

        /// <summary>The plain refusal for a pick on an existing source; ends "pick again." so the command line adds only "or press Esc".</summary>
        internal static string ExistingSourceWords(string existingTag)
        {
            string tag = (existingTag ?? string.Empty).Trim();
            return tag.Length == 0
                ? "Another source is already at this point, and a new source cannot sit on top of it. Move clear of it and pick again."
                : tag + " is already at this point, and a new source cannot sit on top of it. Move clear of " + tag + " and pick again.";
        }
    }
}
```

### E. ExternalMutationCommandPolicy.cs (old lines start with minus, new with plus)

```
diff --git a/Modules/Drainage/Services/ExternalMutationCommandPolicy.cs b/Modules/Drainage/Services/ExternalMutationCommandPolicy.cs
index eb44df50..422c7e5b 100644
--- a/Modules/Drainage/Services/ExternalMutationCommandPolicy.cs
+++ b/Modules/Drainage/Services/ExternalMutationCommandPolicy.cs
@@ -101,9 +101,17 @@ namespace CE_CVL_SUITE.Services
             catch { return false; /* settings unavailable: today's list */ }
         }
 
+        /// <summary>BUG-665: linking.rotateScaleCopyLikeCopy (ON); settings unavailable reads ON (R-27).</summary>
+        private static bool RotateScaleCopyLikeCopy()
+        {
+            try { return CE_CVL_SUITE.Rules.RotateScaleCopyRule.IsOn(SettingsService.Current?.Linking); }
+            catch { return true; }
+        }
+
         internal static bool CanCreateClones(string commandName) =>
             CloneCapableCommands.Contains(commandName ?? string.Empty) ||
-            (TransformCommandsThatCanCopy.Contains(commandName ?? string.Empty) && CleanUpGripRotateScaleCopies());
+            (TransformCommandsThatCanCopy.Contains(commandName ?? string.Empty) && CleanUpGripRotateScaleCopies()) ||
+            CE_CVL_SUITE.Rules.RotateScaleCopyRule.CommandCanCopy(RotateScaleCopyLikeCopy(), commandName); // BUG-665
 
         internal static bool ShouldStartTracking(string commandName, bool isCeOwnedDrawing) =>
             isCeOwnedDrawing && IsTracked(commandName);
```

### F. LinkService.CloneRegeneration.cs ClonePitAttachmentsByDisplacement (diff)

```
diff --git a/Modules/Drainage/Services/LinkService.CloneRegeneration.cs b/Modules/Drainage/Services/LinkService.CloneRegeneration.cs
index 01a860cc..36fd5a01 100644
--- a/Modules/Drainage/Services/LinkService.CloneRegeneration.cs
+++ b/Modules/Drainage/Services/LinkService.CloneRegeneration.cs
@@ -277,9 +277,14 @@ namespace CE_CVL_SUITE.Services
             {
                 BlockReference source = tr.GetObject(sourceId, OpenMode.ForRead, false, true) as BlockReference;
                 BlockReference clone = tr.GetObject(cand.Id, OpenMode.ForRead, false, true) as BlockReference;
+                // BUG-665: a copy turned by ROTATE Copy gets its label and cover text too (moved as a COPY moves them).
                 if (source == null || clone == null || source.IsErased || clone.IsErased ||
-                    Math.Abs(source.Rotation - clone.Rotation) > 1e-6)
+                    !CE_CVL_SUITE.Rules.RotateScaleCopyRule.CopiesPitAnnotationsAcross(
+                        CE_CVL_SUITE.Rules.RotateScaleCopyRule.IsOn(SettingsService.Current?.Linking),
+                        source.Rotation, clone.Rotation, IsMirroredBlock(source), IsMirroredBlock(clone)))
                 {
+                    if (source != null && clone != null && !source.IsErased && !clone.IsErased)
+                        LoggingService.Info($"[CloneReconcile] pit {cand.CloneHandle}: turned or mirrored copy, annotations not copied");
                     tr.Commit();
                     return 0;
                 }
@@ -295,12 +300,18 @@ namespace CE_CVL_SUITE.Services
                         // C-4 finding 1: the copy keeps its own number; the missing label is SAID (layer named), not only logged.
                         LayerTableRecord labelLayer = attachment == null ? null
                             : tr.GetObject(attachment.LayerId, OpenMode.ForRead, false) as LayerTableRecord;
-                        skips?.Add(labelLayer?.Name ?? attachment?.Layer, labelLayer?.IsLocked == true);
+                        // BUG-672 message: which kind was left out (the PIT LABEL block, or the cover text), so the line names only that.
+                        PitAnnotationKind kind = attachment == null ? PitAnnotationKind.Unknown
+                            : attachment is BlockReference labelBlock && BlockService.IsPitLabelBlock(labelBlock, tr) ? PitAnnotationKind.Label
+                            : attachment is DBText || attachment is MText ? PitAnnotationKind.CoverText
+                            : PitAnnotationKind.Unknown;
+                        skips?.Add(labelLayer?.Name ?? attachment?.Layer, labelLayer?.IsLocked == true, cand.CloneHandle, kind);
                         LoggingService.Warning(
                             $"[CloneReconcile] pit {cand.CloneHandle}: protected or foreign source annotation {handle}; annotation copy refused");
                         // BUG-672: one annotation on a locked layer is left out and said so; the ones on open layers are still copied.
                         if (CopyCleanUpCompletenessRule.CopiesTheRestPastAProtectedOne(CopyCleanUpCompletenessRule.Enabled))
                             continue;
+                        skips?.NothingCopied(); // the older route stops here: nothing of this pit's was copied
                         tr.Commit();
                         return 0;
                     }
@@ -343,6 +354,13 @@ namespace CE_CVL_SUITE.Services
             return copied;
         }
 
+        /// <summary>BUG-665: a block inserted mirrored (an odd number of negative scale factors). Read only.</summary>
+        private static bool IsMirroredBlock(BlockReference block)
+        {
+            Scale3d s = block.ScaleFactors;
+            return s.X * s.Y * s.Z < 0;
+        }
+
         /// <summary>
         /// BUG-269: the source pipe's label wording is read once per batch. Copies of one source (a -ARRAY of one pipe) share it, and
         /// the source is not changed while the clean-up runs.
```

### G. CloneCleanupMessages.cs PitLabelCopySkips (diff)

```
diff --git a/Modules/Drainage/Services/CloneCleanupMessages.cs b/Modules/Drainage/Services/CloneCleanupMessages.cs
index c870b353..af1e72a1 100644
--- a/Modules/Drainage/Services/CloneCleanupMessages.cs
+++ b/Modules/Drainage/Services/CloneCleanupMessages.cs
@@ -107,6 +107,14 @@ namespace CE_CVL_SUITE.Services
         }
     }
 
+    /// <summary>BUG-672: which annotation of a copied pit was left out (its PIT LABEL block, or its cover text).</summary>
+    internal enum PitAnnotationKind
+    {
+        Unknown,
+        Label,
+        CoverText
+    }
+
     /// <summary>
     /// C-4 (review 2, finding 1): a pit copied on its own gets a copy of its own label and cover text, drawn on the
     /// original's layer. When that layer is locked (or cannot be read) CE does not draw there; the copy still gets its
@@ -115,28 +123,51 @@ namespace CE_CVL_SUITE.Services
     internal sealed class PitLabelCopySkips
     {
         private readonly List<(string Layer, bool Locked)> _layers = new List<(string, bool)>();
+        // BUG-672: what was left out, and each copied pit counted once.
+        private readonly HashSet<string> _pits = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
+        private bool _labelLeftOut, _coverLeftOut, _unknownLeftOut;
 
         internal int Pits { get; private set; }
 
-        internal void Add(string layer, bool locked)
+        internal void Add(string layer, bool locked) => Add(layer, locked, null, PitAnnotationKind.Unknown);
+
+        /// <summary>BUG-672: one annotation of copied pit <paramref name="pitHandle"/> left out; the pit is counted once.</summary>
+        internal void Add(string layer, bool locked, string pitHandle, PitAnnotationKind kind)
         {
-            Pits++;
+            bool countsPerPit = CE_CVL_SUITE.Rules.RotateScaleCopyRule.LineNamesOnlyWhatIsMissing(SettingsService.Current?.Linking);
+            if (!countsPerPit || string.IsNullOrWhiteSpace(pitHandle) || _pits.Add(pitHandle.Trim()))
+                Pits++;
+            if (kind == PitAnnotationKind.Label) _labelLeftOut = true;
+            else if (kind == PitAnnotationKind.CoverText) _coverLeftOut = true;
+            else _unknownLeftOut = true;
             string clean = string.IsNullOrWhiteSpace(layer) ? "(unnamed)" : layer.Trim();
             if (!_layers.Any(l => string.Equals(l.Layer, clean, StringComparison.OrdinalIgnoreCase)))
                 _layers.Add((clean, locked));
         }
 
-        internal string Line()
+        /// <summary>BUG-672: the older route stopped at the first protected annotation, so nothing of this pit's was copied.</summary>
+        internal void NothingCopied()
+        {
+            _labelLeftOut = true;
+            _coverLeftOut = true;
+        }
+
+        internal string Line() => Line(CE_CVL_SUITE.Rules.RotateScaleCopyRule.LineNamesOnlyWhatIsMissing(SettingsService.Current?.Linking));
+
+        /// <summary>The one line; <paramref name="namesOnlyWhatIsMissing"/> is linking.pitCopyLineNamesOnlyWhatIsMissing.</summary>
+        internal string Line(bool namesOnlyWhatIsMissing)
         {
             if (Pits == 0)
                 return null;
+            string missing = CE_CVL_SUITE.Rules.RotateScaleCopyRule.MissingWords(
+                namesOnlyWhatIsMissing, _labelLeftOut, _coverLeftOut, _unknownLeftOut);
             string reasons = string.Join("; ", _layers.Select(l => "layer " + l.Layer + (l.Locked ? " is locked" : " could not be checked")));
             var actions = new List<string>();
             string[] locked = _layers.Where(l => l.Locked).Select(l => l.Layer).ToArray();
             string[] unread = _layers.Where(l => !l.Locked).Select(l => l.Layer).ToArray();
             if (locked.Length > 0) actions.Add("unlock layer " + string.Join(" and ", locked));
             if (unread.Length > 0) actions.Add("check layer " + string.Join(" and ", unread));
-            return "[CE] " + Pits.ToString(CultureInfo.InvariantCulture) + " copied pit(s) got their own number but no label or cover text: " +
+            return "[CE] " + Pits.ToString(CultureInfo.InvariantCulture) + " copied pit(s) got their own number but no " + missing + ": " +
                    reasons + ", and CE does not draw on it. Undo (U), " + string.Join(" and ", actions) + ", then copy again.";
         }
     }
```

### H. PipeEditCommand.DataCollection.cs AnalyzeAttachmentState and TryReadReverseArrow (diff)

```
diff --git a/Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs b/Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs
index 0b818946..deca04be 100644
--- a/Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs
+++ b/Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs
@@ -273,6 +273,15 @@ namespace CE_CVL_SUITE.Commands
                 context.SecondInvert = secondBox;
                 context.FirstInvertFromRecord = firstFromRecord;
                 context.SecondInvertFromRecord = secondFromRecord;
+
+                // BUG-1222: the reverse-arrow reading, now against the levels on their drawn ends (the boxes the window
+                // shows). Read only: the arrow and the drawing are not touched.
+                if (Rules.EditPipeReverseArrowReadRule.IsOn(SettingsService.Current?.Pipe) &&
+                    !context.ArrowAttachmentId.IsNull &&
+                    TryResolveReverseArrowFromAttachment(tr, context, out bool reverseArrowAtDrawnEnds))
+                {
+                    context.ReverseArrow = reverseArrowAtDrawnEnds;
+                }
                 context.PipeLength = pipe.Length;
                 context.MainLabelGradeLengthBasis = PipeLabelGradeLengthBasisPolicy.Resolve(
                     hasAuthoritativePipeLink,
@@ -433,7 +442,10 @@ namespace CE_CVL_SUITE.Commands
             else if (string.IsNullOrWhiteSpace(context.SecondInvert))
                 context.SecondInvertEnabled = false;
             // else: keep context.SecondInvertEnabled as loaded from schedule data at line 334
-            if (!context.ArrowAttachmentId.IsNull &&
+            // BUG-1222: with pipe.editPipeReverseArrowReadsDrawnEnds on, this reading waits until the level boxes are on their
+            // drawn ends (end of TryCollectPipeData); here they may still hold the record's upstream-first levels.
+            if (!Rules.EditPipeReverseArrowReadRule.IsOn(SettingsService.Current?.Pipe) &&
+                !context.ArrowAttachmentId.IsNull &&
                 TryResolveReverseArrowFromAttachment(tr, context, out bool reverseArrow))
             {
                 context.ReverseArrow = reverseArrow;
@@ -671,11 +683,23 @@ namespace CE_CVL_SUITE.Commands
             if (!(ent is BlockReference blockRef))
                 return false;
 
-            Point3d arrowPoint = blockRef.Position;
+            return TryReadReverseArrow(context, blockRef.Position, blockRef.Rotation, out reverseArrow);
+        }
+
+        /// <summary>
+        /// BUG-1222: the AutoCAD-free half of <see cref="TryResolveReverseArrowFromAttachment"/>, unchanged: the arrow's place
+        /// and turn against the fall of <paramref name="context"/>'s two level boxes, read along the arrow's own segment.
+        /// </summary>
+        internal static bool TryReadReverseArrow(PipeEditContext context, Point3d arrowPoint, double arrowRotation, out bool reverseArrow)
+        {
+            reverseArrow = false;
+            if (context == null || context.WorldPoints == null || context.WorldPoints.Count < 2)
+                return false;
+
             if (!TryGetNearestSegmentAngle(context.WorldPoints, arrowPoint, out double segmentAngle))
                 return false;
 
-            double actualRotation = GeometryHelper.NormalizeAngle(blockRef.Rotation);
+            double actualRotation = GeometryHelper.NormalizeAngle(arrowRotation);
             double normalizedSegment = GeometryHelper.NormalizeAngle(segmentAngle);
             double oppositeSegment = GeometryHelper.NormalizeAngle(segmentAngle + Math.PI);
             bool actualForward = AngularDifference(actualRotation, normalizedSegment) <= AngularDifference(actualRotation, oppositeSegment);
@@ -689,7 +713,7 @@ namespace CE_CVL_SUITE.Commands
                 return false;
             }
 
-            reverseArrow = actualForward != expectedForward;
+            reverseArrow = Rules.EditPipeReverseArrowReadRule.ArrowIsReversed(actualForward, expectedForward);
             return true;
         }
 
```

### I. LinkService.SourceLanding.cs ReadCompleteSourceLanding and LivePipeRow (diff)

```
diff --git a/Modules/Drainage/Services/LinkService.SourceLanding.cs b/Modules/Drainage/Services/LinkService.SourceLanding.cs
index ff7a832f..992fe233 100644
--- a/Modules/Drainage/Services/LinkService.SourceLanding.cs
+++ b/Modules/Drainage/Services/LinkService.SourceLanding.cs
@@ -99,6 +99,11 @@ namespace CE_CVL_SUITE.Services
                 if (ProjectDataService.TryPeekCurrent(db, out ProjectData liveAtBuild) && liveAtBuild?.Pits != null)
                     foreach (PitData p in liveAtBuild.Pits.Where(p => p != null && !string.IsNullOrWhiteSpace(p.EntityHandle)))
                         livePitRows[SourceTagChildClaim.CanonicalHandle(p.EntityHandle)] = JsonConvert.SerializeObject(p);
+                // BUG-1223: the same live-at-index-time capture for pipes. The index's own pipe rows can carry end
+                // identities it filled in (FillMissingVerifiedOwnerKeys); the live record gets them only at a commit.
+                if (liveAtBuild?.Pipes != null)
+                    foreach (PipeData p in liveAtBuild.Pipes.Where(p => p != null && !string.IsNullOrWhiteSpace(p.EntityHandle)))
+                        livePipeRows[SourceTagChildClaim.CanonicalHandle(p.EntityHandle)] = JsonConvert.SerializeObject(p);
                 DecisionsJson = decisions; DatabaseSession = db.UnmanagedObject.ToString();
                 pipeReads = reads.ToArray();
                 pipeReadByHandle = pipeReads.ToDictionary(p => p.Handle, StringComparer.OrdinalIgnoreCase);
@@ -165,6 +170,9 @@ namespace CE_CVL_SUITE.Services
             }
             /// <summary>The live (in-memory) pit row at index time; null when none was captured.</summary>
             internal string LivePitRow(string handle) => livePitRows.TryGetValue(handle, out string row) ? row : null;
+            private readonly Dictionary<string, string> livePipeRows = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
+            /// <summary>BUG-1223: the live (in-memory) pipe row at index time; null when none was captured.</summary>
+            internal string LivePipeRow(string handle) => livePipeRows.TryGetValue(handle, out string row) ? row : null;
             private static long Cell(double value)
             {
                 if (!IsFinite(value) || Math.Abs(value) > 1e12) throw new InvalidOperationException("A landing bound is not finite or usable.");
@@ -415,9 +423,13 @@ namespace CE_CVL_SUITE.Services
                 if (BuildTrackedPreviewGeometryFingerprint(pipe, tr) != BuildLandingStoredPipeFingerprint(index, candidate.PipeHandle))
                     throw new InvalidOperationException(NearbyPipeChangedRefusal);
                 var before = index.PipeRead(candidate.PipeHandle);
+                // BUG-1223: before.RowJson may carry end identities this index filled in; the live record gets them only
+                // at a commit. Switch on: compare live-at-pick with live-at-index-time, as the nearby pit check does.
                 if (!ProjectDataService.TryPeekCurrent(db, out ProjectData live) || live.Pipes.Count(p =>
-                    SourceTagChildClaim.CanonicalHandle(p.EntityHandle) == before.Handle) != 1 || JsonConvert.SerializeObject(live.Pipes.Single(p =>
-                    SourceTagChildClaim.CanonicalHandle(p.EntityHandle) == before.Handle)) != before.RowJson)
+                    SourceTagChildClaim.CanonicalHandle(p.EntityHandle) == before.Handle) != 1 ||
+                    !SourcePickPipeRecordRule.Unchanged(PickComparesPipeRecordLikeForLike(),
+                        JsonConvert.SerializeObject(live.Pipes.Single(p => SourceTagChildClaim.CanonicalHandle(p.EntityHandle) == before.Handle)),
+                        index.LivePipeRow(before.Handle), before.RowJson))
                     throw new InvalidOperationException(NearbyPipeRecordChangedRefusal);
                 Point3d startPoint = pipe.GetPoint3dAt(0), endPoint = pipe.GetPoint3dAt(pipe.NumberOfVertices - 1);
                 if (SourceOwnerDistance(startPoint, point, true) <= landingRadius)
@@ -468,9 +480,26 @@ namespace CE_CVL_SUITE.Services
             if (decision.Kind == SourceLandingKind.PipeRun && decision.Disposition != SourceLandingDisposition.Refused && run.ComparisonOnlyGeometry && !supported)
                 decision = new SourceLandingDecision(SourceLandingKind.PipeRun,
                     SourceLandingDisposition.Refused, "Pipe identified in PLAN. Its existing elevation needs a qualified connection before placing this source.");
+            // BUG-1223 part 2: a pick on one existing source (an inspection opening, say) stays refused, in words that name it.
+            if (decision.Disposition == SourceLandingDisposition.Refused && pit.CandidateCount == 0 && source.CandidateCount == 1 &&
+                decision.Reason == SourcePickPipeRecordRule.MoreThanOneConnectionReason && PickComparesPipeRecordLikeForLike())
+            {
+                string existingTag = null;
+                if (!source.OwnerId.IsNull && tr.GetObject(source.OwnerId, OpenMode.ForRead, false) is BlockReference existing)
+                    SourceTagService.TryGetTag(existing, tr, out existingTag);
+                decision = new SourceLandingDecision(decision.Kind, decision.Disposition,
+                    SourcePickPipeRecordRule.LandingRefusalWords(true, decision.Reason, pit.CandidateCount, source.CandidateCount, existingTag));
+            }
             return new CompleteSourceLandingReceipt(index, point, decision, pitHandle, ends.Count == 1 ? ends[0] : null, target, nativeSession);
         }
 
+        /// <summary>BUG-1223: the switch linking.sourcePickComparesPipeRecordLikeForLike, read at each pick; unreadable reads ON (R-27).</summary>
+        private static bool PickComparesPipeRecordLikeForLike()
+        {
+            try { return SourcePickPipeRecordRule.IsOn(SettingsService.Current?.Linking); }
+            catch { return true; }
+        }
+
         private static string BuildLandingStoredPipeFingerprint(CompleteSourceLandingIndex index, string handle) =>
             index.Pipes.StoredGeometryFingerprint(handle);
 
```

