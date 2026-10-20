# Train C-54 finalizer report (Civil + Manager), Tue 20 Oct 2026

## ANSWER FIRST

1. **Verdict: GO.** Branch `claude/rel-20261020h`, final head `a85ea975ab37d0ba7b53884a3d2f0a60a2375ebe` (ls-remote equal to the assembly report at the start and at the end).
2. **What I changed:** nothing on the train. Both merged fixes are right as merged; no new default needed turning off. No commit, no push to the plugin repo.
3. **Manager must ship: YES.** Manager files changed between the installed line (`ac5750ec`, Civil 3.0.63 / Manager 1.1.63) and the final head: the 75-file release-build guard (`0d3b1f49`) and the CE_SHARED copy check (#1165, `Modules/Manager/Plugin.cs` and `Modules/Manager/Services/CeSharedCopyCheck.cs`).
4. **Official Manager release build on the final head:** "Complete 75-file, three-lane release candidate verified", 0 warnings, 0 errors (PrepareReleaseBundle, the same command as payload 82 and entry 1487; approved CE_SHARED from the Civil candidate `c1049`, whose three hashes equal the installed copies).
5. **Tests (Release, final head):** whole solution 0 errors (889 warnings, the usual count). Civil net10 full 18,949 run, 18,929 pass, 19 skipped, 1 failed (Glen Eira, the known red). Manager net10 832 of 832. Civil net48 focused (RedoSafe, DoubleClick, CeSharedCopyCheck, ProjectData) 265 of 265.
6. **What Tim will see in AutoCAD:**
   1. **Undo then right-click:** type U, then right-click a pit and choose "CE: Select this run" or "CE: Select whole network", then REDO: the pit comes back. Before, that click could grey out REDO.
   2. **Old project file:** a drawing with an empty CE record and an old AppData project file still gets its old pits and pipes copied in, but at the next command end or save instead of at the click. Same values, same drawing.
   3. **Start-up:** nothing new on this PC (Civil and Manager carry the same shared file; I checked the hashes). Only a PC with mismatched copies sees one line: "CE Civil (or CE Manager) and another CE plugin on this PC are from different releases: run the CE installer again." The Manager still starts.
7. **Do not mark FIXED:** BUG-416 (item 1) and BUG-522. Nobody has driven either in AutoCAD.
8. **Switches without a Settings row (unchanged standing list):** `fleetTelemetry.heartbeatEnabled`, `linking.tidyIgnoresSheetFrame`. This train adds no switch and changes no default.
9. **Risks:** all LOW (section 3). The signed-update gate cannot be affected: nothing under `Installer/`, `Installer.Tests/` or `Shared/` changed between the installed line and the final head.
10. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Reviews

1. **MERGE-WITH-FIXES re-reviews:** the two PRs on this train are the fix rounds of the round 11 MERGE-WITH-FIXES verdicts (#1170 entry 1464, #1165 entry 1469). I read the merged change against the train base `0d3b1f49` in full (9 files). Every PR on the train had a review entry.
2. **#1170 @ 5d1d89e1 (merge 61950380): MERGE, both MEDIUMs from 1464 fixed, 2 LOW.**
   1. **The record read** is the open-close kind (`LoadFromDrawingLight`), read-only, same values. Right.
   2. **The old-file copy:** it now sets `_pendingSave` and `_pendingSaveDatabase = targetDb` instead of calling `SaveToDrawing`. Checked: every caller is safe. `LoadCurrentForDrawingLocked` clears the previous drawing's waiting save (`KeepUnsavedRecordBeforeSwitchLocked`) BEFORE the load, then sets `_currentProject` to the copied data and `_currentDatabase` to the same drawing. So the waiting save writes the right record into the right drawing. Start-up (`InitializeFromAutoCAD`) is the same: record and drawing match. `SetDrawingPath` still writes straight after, as before. A preview hold keeps it waiting, as for any record. The empty-record rule (BUG-203) cannot drop it, because the copy only happens with pits or pipes.
   3. **The unfiltered test** is rooted at `LoadCurrentForDrawingLocked`, has no filter, and proves the scan walks into `LoadProjectData`.
   4. **LOW:** the first test still filters on the reviewed save chain. Only the binding root has an unfiltered check; the other paths I traced from the two clicks only read.
   5. **LOW:** close the drawing with no command and no save after the click, and the copy is not written yet. Nothing is lost: the AppData file stays and is copied again next time.
3. **#1165 @ d3c9c142 (merge a85ea975): MERGE, the HIGH from 1469 fixed, 0 findings.**
   1. **Where it lives:** the check is now in each plugin (`Modules/Drainage/Services/CeSharedCopyCheck.cs`, `Modules/Manager/Services/CeSharedCopyCheck.cs`); the two files are identical apart from the namespace. It uses one CE_SHARED type, `CeAppDataPaths`, inside its own NoInlining method. A missing type would fail inside the check's try/catch, not in the caller.
   2. **How start-up calls it:** both start-ups call it through their own NoInlining helper, inside try/catch, so the banner, the Manager start-up and What's New always run. Every failure gives no line (R-27: information only, never a block).
   3. **Shared/:** `git diff 0d3b1f49 a85ea975 -- Shared/` and `git diff ac5750ec a85ea975 -- Shared/` are empty. Civil and Manager carry the same CE_SHARED.
   4. **Tim's PC:** installed Civil and Manager CE_SHARED hashes are equal in all three lanes (61387d1c, 9e40f188, 647641ba), so Tim sees no line. Structural ships no CE_SHARED.
   5. **Info, not a risk:** an old July `CE_SUITE_MANAGER.bundle` sits in ProgramData. It has no PackageContents.xml, so AutoCAD does not load it.
   6. **REGRESSION_LOG:** no conflict markers left; all four entries are kept.
4. **Guard commit 0d3b1f49 (entry 1487): MERGE.** Exact count 78 -> 75, still exact, with both messages updated. #1165 adds no packaged file (the check compiles into the plugin DLL), so 75 still holds; the release build proves it (item 5).
5. **Official Manager release build (final head):** EXIT 0 in 0.8 min. "[CE_SUITE_MANAGER] Complete 75-file, three-lane release candidate verified.", 0 warnings, 0 errors. The CE_SHARED hash check against the Civil candidate `c1049` passed. Built in the private worktree; the worktree is removed and nothing was installed.

## 2. New defaults and installer

1. **Switches added by the train:** none. No `UserSettings` or settings file changed.
2. **Behaviour changes without a switch:**
   1. **#1170:** the copy waits until the next command end or save. Old behaviour is the bug: REDO lost after U.
   2. **#1165:** one warning line on a mismatch. Old behaviour is the bug: silent mismatch, BUG-522.
   3. **Effect on Tim's screen by default:** none. He sees no line, and the click just keeps REDO.
3. **Switches without a Settings row (standing list, unchanged):** `fleetTelemetry.heartbeatEnabled` (ON, today), `linking.tidyIgnoresSheetFrame` (ON, old behaviour is the bug). The detention freeboard copies still have no row (older R-00 gap).
4. **Installer (#1475):** #1475 is not on this train; it landed earlier and touched only `Installer/SafeBundleInstaller.cs` (entry 1481). Between `ac5750ec` and `a85ea975` nothing under `Installer/`, `Installer.Tests/` or `Shared/` changed, and no csproj except the Manager count guard. **`OfficialReleaseGate` is unchanged, so the signed-update gate cannot be affected in any way.** Installer.Tests compiled in the solution build; not run (rule).

## 3. Risks (all LOW)

1. **#1170 first test filter:** see 1.2 item 4.
2. **#1170 copy written a moment later:** see 1.2 item 5.
3. **net48 wider filter:** an extra net48 run with a wider filter (adding KeptRecord and Legacy) gave 589 run, 584 pass, 5 failed. All five are `PreparedDiameterNeverUsesLegacySeventyFiveMillimetreFallback` cases in `PreparedDetentionVisualTests`, failing with InvalidProgramException in the AutoCAD reference stub `Point3d.get_Origin`.
   1. **Why it is not this train:** that is the known net48 stub problem (the same kind as the Bug141 stub red, entries 1478 and 1482). The test file was last changed on 10 Sep, the train touches none of its code, and the same tests pass in the net10 full run.
   2. **Not proven:** I did not re-run them on the base build.
4. **Timing:** the builds ran 16:45 to 17:05, inside Tim's 3:00 to 5:30 pm AutoCAD window, at Below Normal. AutoCAD was not running.

## 4. Test evidence and hygiene

1. **Environment:** private worktree `C:\ce-fin\c54` (detached at a85ea975), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal.
   1. **References:** `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`. The Manager release build used payload 82's exact references.
   2. **Placeholders and paths:** 0-byte `CE_TRANSFORM_2027.arx` placeholder, AutoCAD 2027 on a short PATH, TEMP and CE log folder per step.
   3. **Long runs:** the solution build ran past the tool limit, so it ran as its own Below Normal process and I waited for it in the foreground.
2. **Timings:** solution 16 m 04 s; Civil net10 6 m; Manager 12 s; net48 focused 4 s; Manager release candidate 0.8 min.
3. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran; checked gone after each.
4. **Tim's settings files:** before and after **unchanged** (ACD64E79, 622A246F, 24D8E5F7, EFE307C4).
5. **Installed bundle:** untouched (Civil 3.0.63+ac5750ec, Manager 1.1.63+ac5750ec, written 15:17 / 15:19).
6. **Clean-up:** worktree removed (`git worktree remove --force`, then prune); `c54logs` and `c54tmp` deleted. `C:\ce-fin\logs` (19 Oct) is not mine and was left as found.
7. **Not run:** Installer.Tests (compile only), full net48 lane, Structural, AutoCAD or accoreconsole.
8. **Not done:** no version bump, no install, no deploy, no PR closed or deleted, no Structural / #1382 / #1384 / #1419 / #1423 merged, `DESK_LOG.md` not edited.
