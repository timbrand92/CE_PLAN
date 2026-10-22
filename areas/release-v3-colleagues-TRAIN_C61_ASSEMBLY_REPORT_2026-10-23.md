# Train C-61 assembly report (Civil + Manager), Fri 23 Oct 2026, real clock 07:37 to about 08:25 Melbourne

Built and unit-tested only. Not installed. Nobody has opened any of it in AutoCAD. No PR closed, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` not edited.

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261023l` at `d17d47c3c89f8e8915bdc0a08e88726a2d0fc215` (normal push, new branch; the name was free). Base: the real tip of `claude/rel-20261022m` was `40ee0a36f7960145743954b39859eb6c3af92869`, exactly the tip named (Civil 3.0.70 / Manager 1.1.70, C-60).
2. **Merged: 17 of 17 listed PRs**, one plain `git merge --no-ff` commit each, no squash, rebase or cherry-pick. None was already in the base and no live head differed. After the 17 merges there are 3 commits of mine (log tidy, clash log entry plus one guard re-pin, Settings pictures). Whole branch against base: 229 files, 6,434 insertions, 219 deletions.
3. **Live heads at merge time** (all equal to the fix-round and audit reports, so none was stopped; every PR base is `claude/rel-20261022m`): #1524 `e1a59824`, #1536 `d463134a`, #1527 `f64420f4`, #1526 `3cb4c807`, #1548 `41d921d9`, #1535 `b7d77f17`, #1549 `5f37da1b`, #1530 `f18585ad`, #1531 `67ae72de`, #1538 `bf311924`, #1546 `eb613325`, #1545 `8ed03233`, #1540 `50e5efa4`, #1522 `8799d200` (equal to the expected head, so no descendant check was needed), #1523 `95eafe45`, #1525 `98c41c9d`, #1532 `aca3a793`. Full 40-character heads are in section 1.
4. **Left out, with reasons:** everything in the EXCLUDE list (#1534, #1528, #1537, #1551, #1539, #1550, #1541 to #1544, every Structural PR, #1529, #1382, #1384, #1419, #1423, #1191, #1183, #1180, anything HOLD, REJECT or SUPERSEDED-BY) and anything not named. Nothing named was skipped.
5. **Shared/ and Installer/: EMPTY** (`git diff --stat 40ee0a36..HEAD -- Shared Installer` prints nothing). **Modules/Manager changes, from #1548 and #1535 only**: 14 files, 564 insertions, 62 deletions. Six of them are NEW .cs files (`CeManagerSupportWarnings.cs`, `CommandOutcomeInfoLog.cs`, `CommandOutcomeLogService.cs`, `CommandOutcomeLogger.cs`, `CommandOutcomeRegistry.cs`, `CommandOutcomeSetting.cs`). They are source files compiled into the Manager DLL, not files the bundle carries, so the exact bundle file-count guard should not move; the finalizer or payload builder should still confirm that on a real release build, which I did not run.
6. **Config files:** `Modules/Drainage/Assets/Config/command-registry.json` CHANGED: one new hidden entry `CDCHECKIGNOREAPPLY` (from #1524, the apply step behind the one-Undo fix). No `ce-tool-register.json` change. No `PackageContents.xml` change.
7. **Settings keys added or changed, default in the merged code (I changed none):** see section 3. All three new keys ship ON. `doubleClick.sourceEditWindow` stays ON and `checks.allowIgnoreFinding` stays OFF (unchanged).
8. **Build:** whole solution Release, **0 errors** (115 warnings in the successful run). **Tests:** Civil net10 **19,447 total, 19,425 passed, 22 skipped, 0 failed**. Manager net10 **916 total, 915 passed, 1 skipped, 0 failed**. Manager net48 build 0 errors. Civil net48 focused: 418 total, 417 passed, 1 failed (an AutoCAD reference-only fault, not a regression: see section 4).
9. **The one real clash, resolved:** `CheckIgnoreCommand.cs` when #1525 met #1523 and #1524. It could not keep both intents literally (see section 2), so I kept the #1524 form plus #1523's refused lines, and re-pinned the two #1525 guard tests in a separate commit of mine. **For the finalizer to look at first.**
10. **Anything for the finalizer:** (a) the #1525 resolution above; (b) the REGRESSION_LOG entries of #1523, #1525 and #1532 landed in the middle of the file (they were written next to the old BUG-859 entries), so I moved those three to the top in merge order; (c) the 16 Settings pictures were re-rendered on the merged train; (d) the build lock was held by another job all through (section 4); (e) AutoCAD (acad.exe) was open at 07:38 and during every step up to the net48 focused run, closed by 08:14; (f) one worry about #1524 outside this job's scope, in section 2 item 6.

## 1. Merge list with heads

Each merge was done with the script `C:\ce-asm\mergeone61.sh` (live head re-read with gh immediately before, compared to the expected head and to the fetched `refs/pull/N/head`, `merge-base --is-ancestor` checked, merge, `git diff --numstat HEAD~1 HEAD` compared to `gh pr view N --json files`). Where the REGRESSION_LOG.md conflicted I kept every entry (the PR's insertion applied to the running file, 0 conflict markers left). Binary pictures count as 0/0 in gh and "-" in git; treated as equal.

1. **#1524** `e1a59824c536a9b4359236f8fe94163b0219e311`, merge `eabeda2c`. Clean. Numstat matches.
2. **#1536** `d463134aae07ccf03fc66ab88a4844f3783386cd`, merge `644f7734`. REGRESSION_LOG only. Numstat matches.
3. **#1527** `f64420f453537ea046304207187b9d85b2ae053e`, merge `3fc0c024`. Clean (REGRESSION_LOG applied). Numstat matches (78 files, mostly the automation pictures).
4. **#1526** `3cb4c807aca45e9d0ca5443bab7c016a27d38eeb`, merge `3c6627d8`. REGRESSION_LOG only. Numstat matches.
5. **#1548** `41d921d9f8323d158fb0cec5b12b67fdf3a7977f`, merge `88910782`. Manager. REGRESSION_LOG only. Numstat matches.
6. **#1535** `b7d77f17d95081aa65ee75c38b6572916fb79203`, merge `b121d90c`. Manager. REGRESSION_LOG only. Numstat matches.
7. **#1549** `5f37da1b18d8d4499b3e9c80402cda480adf2afa`, merge `6e78752f`. REGRESSION_LOG only. Numstat matches.
8. **#1530** `f18585ada58e0e848a63b660e07d0ad5b0fe5cd0`, merge `acd73cb4`. REGRESSION_LOG only. Numstat matches.
9. **#1531** `67ae72de32f8af3082d55f726e3efb6d0be10e0a`, merge `8f2d73fe`. REGRESSION_LOG plus the two known pictures `settings-dark-8-fixes.png` and `settings-light-8-fixes.png`: kept the #1526 pair already on the branch. Numstat matches the PR's list except exactly those two pictures (kept as on the branch). Later re-rendered, see item 21.
10. **#1538** `bf311924360ba24dbb882a56fe4f02fb45fbd650`, merge `218f09e7`. REGRESSION_LOG only. Numstat matches.
11. **#1546** `eb6133251cf8f14ac5d8b7371bdc1a1c62bc8d05`, merge `c56b0b82`. REGRESSION_LOG only. Numstat matches.
12. **#1545** `8ed032335cc9b85bb5e0db9b4cbc6f65257b1f34`, merge `9efcea5f`. REGRESSION_LOG only. Numstat matches.
13. **#1540** `50e5efa42c673118934d984de4e599c36aecd439`, merge `1861783a`. REGRESSION_LOG only. Numstat matches.
14. **#1522** `8799d20002550858dda0a5dedad1bc23602781dc`, merge `7c7ccac3`. REGRESSION_LOG only. Numstat matches. Never Opus-reviewed; merged as asked, head equal to the expected one.
15. **#1523** `95eafe4506ae26a9b989d34b6db96c107327479c`, merge `4b21794b`. Clean merge (it landed before #1525; the clash came with #1525). Numstat matches.
16. **#1525** `98c41c9d3d95dc59a236223f92dc3140e1495ba1`, merge `0d85cebc`. Clash in `CheckIgnoreCommand.cs` and REGRESSION_LOG. Resolved, see section 2. The merge commit's numstat is 77 lines (the new guard test file) plus 10 (the PR's log entry); `CheckIgnoreCommand.cs` is identical to the file before this merge, so the PR's own list differs from the merge by exactly that file (deliberate).
17. **#1532** `aca3a7939a120c96293213997e420716269b24b9`, merge `cbfaad98`. REGRESSION_LOG only. Numstat matches.
18. **My commit `4573cd3e`:** the three audit entries (#1532, #1525, #1523) moved to the top of REGRESSION_LOG.md in merge order. Checked that every line of the old file is still present (only two blank lines added).
19. **My commit `7bcbad55`:** the new log entry (top of REGRESSION_LOG.md) and the re-pin of `CheckIgnoreSwitchFirstTests.cs`.
20. **My commit `d17d47c3`:** the 16 Settings pictures, pictures only.
21. **Settings pictures:** a re-render tool exists (`CE_UPDATE_DOC_SCREENSHOTS=1` with `C60SettingsRowsTests`, 34 of 34 pass). I ran it on the merged train and committed the 16 `settings-dark/light-1..8` pictures separately. I looked at `settings-light-8-fixes.png`: the Fixes tab shows the Pit Schedule fixes column with "Pit Schedule depth uses the pit floor" ticked, and the three Drawing checks ticks. Its footer shows a throw-away temp folder path (`C:\ce-asm\t61_shots\...`), same kind of line as in earlier pictures. The Codex window lane should still confirm them in real windows.

## 2. The resolved CheckIgnoreCommand.cs clash (#1523 + #1524 + #1525)

1. **What clashed:** the file conflicted in three places when #1525 met the branch (which by then held #1524 and #1523). #1525 was written against the C-60 code, where the command started with `InitServicesFull(document)` (a whole-drawing sync that saves the CE project record). It moved the switch before that and added a helper `SyncAndReread` that syncs just before a write. #1524 had already removed the start-up init and sync altogether (listing and Esc save nothing; the write goes through an apply command for one Undo), and #1523 had added the refused-outcome lines.
2. **Result: the file is exactly the pre-merge #1524 + #1523 form.** The switch is read first and returns before any project-record read or save; every "Nothing was changed" ending still calls `CommandOutcomeLogService.NoteRefused("CDCHECKIGNORE")` (9 such lines). Resolved top of `IgnoreFinding`, as it stands:

```
try
{
    ChecksSettings settings = SettingsService.Current?.Checks ?? new ChecksSettings();
    if (!settings.AllowIgnoreFinding)
    {
        editor.WriteMessage("\n[CE] Ignoring a finding is switched off in CE Settings. Nothing was changed.");
        CommandOutcomeLogService.NoteRefused("CDCHECKIGNORE");
        return;
    }

    Database database = document.Database;
    if (!ProjectDataService.TryReadProjectWithoutChanging(database, out ProjectData project) || project == null)
    {
        editor.WriteMessage("\n[CE] This drawing has no CE project record yet, so there is nothing to ignore. Nothing was changed.");
        CommandOutcomeLogService.NoteRefused("CDCHECKIGNORE");
        return;
    }
```

3. **Why not "both intents" literally:** #1525's start-up lines (`InitServicesCore()`, `InitServices(document)`) and its sync helper cannot coexist with #1524's guard `CheckIgnoreUndoTests.ListingAndEscape_DoNotRunDrawingInitialisation`, which forbids `InitServices*`, `SyncWithDrawing(` and `SetDrawingPath(` anywhere in the file. #1525's own guard `CheckIgnoreSwitchFirstTests` demanded exactly one `SyncWithDrawing(` and a static `IgnoreOne`. The two PRs' guards contradict each other. Putting the sync back would also save the project record outside the one Undo step that #1524 protects. So the #1524 design wins and #1525's intent (switch first, no save before the questions are answered) is already met by it.
4. **Test follow-up (separate commit `7bcbad55`, loud):** I edited the #1525 guard file `CheckIgnoreSwitchFirstTests.cs`: the first test now ends its search at the apply command instead of at `private static void IgnoreOne(`; the second is renamed `NoForcedSyncRunsAtAll_AndTheWriteComesAfterTheLastQuestion` and asserts zero `SyncWithDrawing(` and that `WriteChoice(` comes after the last question in both Ignore and Un-ignore. This goes beyond "re-pin a count", so the finalizer should judge it.
5. **Guard tests of both PRs on the merged branch:** `CheckIgnoreSwitchFirst`, `CheckIgnoreUndo`, `CommandOutcomeLine` (#1523), `PickHandlerProbe` (#1532) and the PDF load test run together: 42 of 42 pass (net10, Release). The #1536 guard also passes (the whole net10 suite has 0 failures).
6. **One thing I noticed, not changed:** #1524's command now reads `SettingsService.Current?.Checks ?? new ChecksSettings()` with no settings initialisation. If the settings had never been loaded in that session, the switch would read OFF even when typed ON. Probably the plugin start-up already loads settings; worth one Codex check with the switch ON on a fresh AutoCAD start.

## 3. Settings keys (default in the merged code, none changed by me)

`git diff 40ee0a36..HEAD` on `UserSettings.cs` shows three hunks; `PitMigrationSettings.cs` is a new file. `DoubleClickSettings.cs` and the Checks settings are not in the diff.

1. **`pits.skipCurrentPitBlockRedefine`** (#1540, new in `PitMigrationSettings.cs`, wired through `UserSettings.Pits`): default **ON** (`= true`). Doc line says OFF always refreshes the pit block on open, as before. **No Settings page row.**
2. **`linking.pitScheduleUsesPitFloor`** (#1531, `PitScheduleUsesPitFloor`): default **ON**. New against the C-60 base. Has a row on the Fixes tab.
3. **`detention.twlUsesDrawingUnits`** (#1538, `TwlUsesDrawingUnits`): default **ON** (the fix round flipped it from OFF inside the PR; against the C-60 base it is a new key). OFF restores the old reading. **No Settings page row.**
4. **`doubleClick.sourceEditWindow`**: unchanged, ON (`SourceEditWindowDefault = true`). Has a row.
5. **`checks.allowIgnoreFinding`**: unchanged, OFF. Has a row.
6. **The #1526 rows** add no new key. #1549, #1530, #1546, #1545 have no switch.
7. **Switches with no Settings page row:** `pits.skipCurrentPitBlockRedefine` and `detention.twlUsesDrawingUnits` (row owed to the Codex window lane). With no row, the only way to switch either off is the settings file.

## 4. Test and build evidence

1. **Environment:** private worktree `C:\ce-asm\c61`, Release, every command run through `C:\ce-asm\run61.sh` (`-p:SkipDevBundle=true -nr:false --disable-build-servers`, solution `-m:1`), foreground or polled to its end; dotnet set to Below Normal right after start. Refs: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`, AutoCAD 2027 on PATH, a 0-byte placeholder at `Modules\Shared.Transform.Native2027\bin\x64\Release\CE_TRANSFORM_2027.arx` (untracked). A fresh Temp and CE log folder per step.
2. **Mistake first:** my first solution build failed (1 error, MSB3030) because I put the placeholder at the wrong path. It cost about 6 minutes. After correcting the path, the whole solution built with 0 errors. I also launched a bare `python` once by habit; it hung and I stopped it, nothing was written.
3. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` already held content written at 07:47 (a live job, not a stale file) and the write failed for every one of my steps, so I built in my own worktree with my own Temp and did not delete or touch the lock. Another build may have been running at the same time.
4. **Solution Release build** 07:55 to 07:57 (incremental after the failed first attempt): **0 errors**, 115 warnings.
5. **Civil net10 full suite** 07:57 to 08:05: **Total 19,447, Passed 19,425, Skipped 22, Failed 0** (7 m 46 s of tests). In the expected 19,430 to 19,450 band, so the reference name was right. The Glen Eira back-test is green (cleared by #1549). The PDF load test did not time out in this run and passed again alone in the guard run.
6. **Manager net10 full suite** 08:05: **Total 916, Passed 915, Skipped 1, Failed 0** (the skipped one is the palette-tile test #1535 marks `[Ignore]`). Manager net48 build (08:06): **0 errors**.
7. **Civil net48 focused** (classes: DoubleClick, CheckIgnore, IgnoreFinding, KeywordPromptBracketTag, CrossModuleGuard, SettingsWindow, SettingsFit, SettingsValue, SettingsLoad, AdvancedSettings, RedoSafe, CommandOutcomeLine, PickHandlerProbe, Bug859, C60SettingsRows): **418 total, 417 passed, 1 failed.** The one red is `PitCatchMarginSettingsTests.FindRecordedPitAt_WithNoExplicitMargin_UsesTheOfficesSettingsValue`: `InvalidProgramException` inside `Autodesk.AutoCAD.DatabaseServices.ObjectId.get_Null()`, the AutoCAD reference assemblies (reference-only, no real code on this PC). Neither the test file nor its service is in this train's diff, and it passes on net10 in the full run. It matched my filter only because "Settings" is in its name. **No base build was needed.** The settings window fit run prints "tallest tab 670 px" for all six tabs checked.
8. **A note on my first net48 run:** my first focused command lost its filter (the whole net48 suite ran, 19,268 tests, 369 failed). Those 369 are the AutoCAD-needing tests failing on the reference-only assemblies (ObjectId, Database), the same kind as item 7; they are not a result of this train. I re-ran with the filter above. Not counted as evidence.
9. **Nothing re-pinned** apart from the #1525 guard text in section 2.
10. **AutoCAD was open** (acad.exe running) at 07:38 and at the start of the solution build, Civil net10, Manager net10, Manager net48 and the unfiltered net48 steps; it was closed by 08:14 (not running for the focused net48 run). It is before Tim's 8:30 window, but the PC was not idle.
11. **Tim's settings files, before (07:38) and after (08:14):** `CS_Settings.json` 622a246f (351,713 bytes) unchanged; `CE_CVL_SUITE\settings.json` efe307c4 (672 bytes, 16 Sep) unchanged; `CE_STRUC_SUITE\CS_Settings.json` 2972ce7 (35,259 bytes, on-disk time 22 Oct 18:54) unchanged since before my start. **`TIM_CE_CADTOOLS\CD_Settings.json`: my first read at 07:38 gave 9d27b04 (15,302 bytes); my reads from 08:14 gave acd64e79 (15,270 bytes), on-disk time 11 Mar 2026 08:22, the same as the C-60 reports.** I cannot explain the first reading (AutoCAD was running and may have had a different copy in view); I did not write it, and its on-disk time is not today.
12. **Not tested:** anything in AutoCAD or accoreconsole; any window looked at on screen (apart from one off-screen picture); Structural, Installer.Tests (compiled only), Manager net48 tests, the Manager release file-count guard (needs a release payload build); the Settings pictures in real windows.
13. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 5. Hygiene

1. Branch `claude/rel-20261023l` stays on origin. Worktree `C:\ce-asm\c61`, its local branch and my `t61_*` temp folders are removed after this report is pushed; my scripts (`mergeone61.sh`, `run61.sh`, `f48.sh`) and logs stay in `C:\ce-asm\` and `C:\ce-asm\logs61`.
2. Leak-scan hook ran on the push and was clean (36 terms).

## Summary

C-61 is on `claude/rel-20261023l` (`d17d47c3`): all 17 PRs merged, no head changed. Shared and Installer untouched; Manager changes are #1548 and #1535 only (six new .cs files). Solution builds 0 errors; Civil net10 19,447 tests, 0 failed; Manager 916, 0 failed; net48 focused one environmental red. #1525 clashed with #1524 and its guards contradict; resolved to #1524's form and its tests re-pinned (finalizer, look). Not seen in AutoCAD.
