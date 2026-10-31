# BUGFIX x7 report — B-106, CEMEMBER section-list rename, old beams still redraw (31 Oct 2026)

## FOR TIM

1. **PR:** draft PR #1932 (against the Structural train line `claude/rel-20261026s`). Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1132 and BUG-818 stay OPEN.
2. **What you will see (switch ON, the default):** in the CEMEMBER and SBEAM section lists, 34 UB and UC rows now carry the supplier's name. For example 310UB32 is now 310UB32.0, 410UB60 is 410UB59.7, 530UB92 is 530UB92.4, 100UC15 is 100UC14.8. Every size and every mass is exactly as before. A new CEMEMBER beam is saved with the new name.
3. **Old beams:** a beam saved with an old name (say 310UB32) is found through a new "former names" field on the list row and redrawn on the new row. If a name could point at two rows it is left out and the beam gets a plain "is not in the section list" line. Nothing is guessed.
4. **Important:** nothing in the Structural line calls the CEMEMBER redraw yet (the edit command is not built). So "old beams redraw" is proven by tests on the lookup and the redraw plan only. There is nothing to click in AutoCAD for it yet. The rename itself shows in the list when you place a CEMEMBER or open the SBEAM window.
5. **Switch:** `CeMember.SectionListUsesSupplierNames`, ships ON. Switched OFF the list is exactly the 1.0.125 list (same 372 names, same order). It has no row on the Settings window (no window change in this job); it lives in the settings file.
6. **Needs your decision (1 row):** 250UC73. Its own mass in the list is 73.0 kg/m but the unreviewed draft list calls it 250UC72.9. I did not rename it. Say which you want.
7. **Not done, by your rule "no engineering data":** all the BUG-818 size and mass corrections, the Lysaght Z and C purlin names (ZC400 and C40030 do not exist at Lysaght), angles, hollow sections, the 8 missing welded sizes. The corrected draft stays unreviewed. Nothing from it except the 34 names went in.
8. **Two gaps I know about:** (a) favourites and recents in the SBEAM window that were saved under an old name will not match (you re-star them); (b) typing an old name at the CEMEMBER prompt works only for the ".0" ones (310UB32 finds 310UB32.0, but 410UB60 will not find 410UB59.7). Both are in files other open PRs are editing, so I left them.
9. **Undo:** untick the switch in the settings file, or revert the PR.

## ANSWER FIRST

1. **PR:** #1932, draft, base `claude/rel-20261026s`, head `claude/b106-cemember-section-rename`, commits a66bb424 (step 1) and the rename commit on top.
2. **Fault still there on the start point:** yes. `CeMemberReplanner.Replan` compared the saved name to the row name exactly (spaces and case only) and the list had no old-names field. No caller exists yet (the redraw is latent), which matches the carpark note.
3. **Mistakes of my own:** (a) I first ran a bare python snippet to read the list (the rules say no bare python); read-only, harmless. (b) My first test script quoted a path with a space badly and failed before building; no harm. (c) Two PowerShell helper names I picked collided with built-in aliases (`R`, `Rp`); the one call that reached a real cmdlet got an "illegal path" error and removed nothing. (d) The build's after-build step could not start `powershell` (net48 build), so I ran its check by hand: the net48 binary does not contain CE_SHARED.
4. **Robot case (to be written when the CEMEMBER edit command exists):** name `S106_cemember_oldname_redraw`. Draw a CEMEMBER elevation of 310UB32 on a copy made with the old list, install this build, open the copy, run the CEMEMBER edit and check the command line does not say "is not in the section list" and the beam is redrawn at 298 deep. Switch-off control: set `CeMember.SectionListUsesSupplierNames` to false, reopen, and check the list offers 310UB32 (not 310UB32.0). Until the edit command exists the only AutoCAD check possible is: type CEMEMBER, section name 310UB32, and see it drawn as 310UB32.0 (298 x 149, same size as before).
5. **What is NOT proven:** anything in AutoCAD. The SBEAM window with the new names (not opened). The CEMEMBER prompt with the new names (not run). The redraw of a real old drawing (no caller).

## STEP 1 (written before any rename code)

- `CeMemberOldSectionNamesStillRedrawTests` places a beam with each of the 372 names on Structural 1.0.125 and checks it is found and redrawn (or gets a plain message that is not "not in the section list"). It passed on the unrenamed code (2 of 2 passed, commit a66bb424), then was moved to the new lookup and passes again.
- Control: `AnOldNameIsNotFoundWithoutTheMap_ButIsWithIt` shows all 34 renamed beams would be lost without the map (34 of 34 refused) and are all redrawn with it.

## What the real list change is

1. **BUG-818 renames:** the corrected draft (`04_REFERENCE/section_data_2026-10-18/section-catalogue_CORRECTED_DRAFT.json`) renames 35 UB and UC rows to the supplier designation. I took only the name, and only where the decimal in the new name equals the row's own existing mass to one decimal (34 of 35). The existing masses already carry the supplier decimals, so no number changes.
2. **Held back:** 250UC73 (row 73.0, draft name 250UC72.9). Everything else in BUG-818 is a data change and is listed in the carpark entry for Tim.
3. **Old names kept:** each renamed row gets `"formerNames": ["<old name>"]` in `section-catalogue.json`. 34 rows, no numbers touched (checked by the diff and by a test comparing every number with the switch ON and OFF).
4. **Mapping:** `CeMemberNameMap` (new, DesignCore) built from the list; `CeMemberReplanner.FindRow` and an optional `formerNames` argument on `Replan`. Without the map the behaviour is exactly as before.
5. **Switch OFF:** the list loader shows the first former name as the name and drops the former names, so the list is the 1.0.125 list exactly (pinned by a test comparing all 372 names in order).

## Files changed

`Modules/Structural/Assets/Config/section-catalogue.json` (names and formerNames only), `Modules/Structural/Services/SectionDatabaseService.cs`, `Modules/Structural/Services/SettingsService.cs` (one read-only property `CurrentIfLoaded`, so reading the list never starts the settings load), `Modules/Structural/Models/UserSettings.cs` (the switch, in `CeMemberUserSettings` after `DefaultScale`), `Modules/Structural.DesignCore/SteelSections/CeMemberNameMap.cs` (new), `CeMemberReplanner.cs`, tests `CeMemberOldSectionNamesStillRedrawTests.cs`, `CeMemberSupplierNamesTests.cs` (new, 14 tests), `CeMemberNameMapTests.cs` (new, 6 tests), `REGRESSION_LOG.md`. No CE_SHARED change, no window change.

## Tests run (focused only, one project per command, net10, SkipDevBundle, -m:2)

1. Structural.Tests: `CeMemberOldSectionNamesStillRedrawTests`, `CeMemberSupplierNamesTests`, `SectionCatalogueIntegrityTests` — 20 of 20 passed (the integrity guard still sees 372 sections, no duplicate names).
2. Structural.DesignCore.Tests: all `CeMember*` — 143 of 143 passed.
3. Structural.Tests: `SectionDetailBatch2cTests`, `CeMemberCommandSourceGuardTests`, `CeMemberUnitsGuardTests`, `S44NewSwitchDefaultsTests`, `S45NewSwitchDefaultsTests` — 24 of 24 passed.
4. net48 build of `Modules/Structural/CE_STRUC_SUITE.csproj`: compiles, 0 errors in code; the after-build step failed only because `powershell` was not on the build's path; I ran its check by hand (binary has no CE_SHARED).
5. Not run (by the job's rule): the full Structural suite, Manager and Civil suites, the net8 target.

## Shared files and open PR clashes

- Searched `gh pr list --state open` for `UserSettings.cs`, `SectionDatabaseService.cs`, `CeMemberReplanner.cs`, `section-catalogue.json`. `UserSettings.cs` is edited by many open PRs (#1900, #1902, #1903, #1904, #1905, #1914, #1930 among them), each in a different block. I put my switch in `CeMemberUserSettings` after `DefaultScale`; #1900 edits the same class lower down (after `SectionBeyondLayer`), a different hunk.
- I avoided the files #1900 (`CeMemberPrompts.cs`, `CeMemberCommands.cs`), #1902 (picker display and settings recovery), #1905 (`SbeamSelectionContract.cs`, `SbeamSelectionPlanner.cs`, `SbeamPickerController.cs`), #1903/#1904 (`ExcelMTextService.cs`), #1914 (`MemberScheduleFromPlan.cs`) and #1930 (pad library).
- Trial merge of my branch against each of #1900, #1902, #1903, #1904, #1905, #1914, #1930: the only conflict reported was `REGRESSION_LOG.md` (every PR adds an entry at the top; keep both sides).
- #1914 (member schedule counts 310UB32 and 310 UB 32 as one size) reads names from drawings, not this list, so it is not affected; but when it merges, a schedule row for 310UB32.0 and an old 310UB32 may need the same former-name map. Not done here.

## Real-files compare (rule: before first test and after last)

- I listed names, sizes and last-write times (no contents) of `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` (including `CE_Admin`) and `CE_SUITE` at 17:39 (33,434 files) and at 17:48 (33,443 files). The two full listings are 33k lines each; they sat in my scratch folder, which I removed. The settings-file part is below.
- **Settings-type files (47 listed each time):** the only difference is `TIM_CE_CADTOOLS\CD_Settings.json`: 15270 bytes, 2026-10-04 08:22:30 before; 15298 bytes, 2026-10-31 17:44:51 in the second listing; and by 17:50 it read 15270 bytes, 2026-10-04 08:22 again. That is the **Civil** settings file, and only Civil (Drainage) code names it: nothing in Structural, DesignCore, the Structural tests or CE_SHARED does. AutoCAD (`acad.exe`) was running on Tim's PC the whole time.
- **Other differences:** Civil and Structural logs, Manager menu state, session files, usage outbox files (9 sent files gone, a few machine files rewritten), `CD_RecentValues.json`. All consistent with a live AutoCAD session and the 8-minute Admin cycle (two files change at xx:42 both times). None of the log lines I could check mention a test host.
- **My own redirect folders** (`CE_STRUC_SUITE_APPDATA_ROOT`, `CE_LOG_DIR_OVERRIDE`, TEMP) stayed empty of settings or log files, so the tests wrote nothing through them. I cannot prove from timestamps alone that none of the changed files came from my test processes; the evidence above says they did not. If you want a stricter check, compare against the Admin cycle times.

## Disk and time

- C: free space at the start 43.16 GB; at the end (after removing my worktree and scratch) 43.1 GB, so about 0.06 GB net (other jobs were also running). Worktree `C:\CE_WORK\build\x7` removed (`git clean -fdXq` then `git worktree remove`); scratch `C:\CE_WORK\scratch\x7` emptied of the test folders (the report is the only record).
- Started 17:34, PR opened 17:49, finished with this report at the time stamped below.

## Open items for Tim (numbered, nothing blocks)

1. 250UC73 or 250UC72.9? (6 in FOR TIM)
2. Should SBEAM favourites and recents saved under an old name be carried over to the new name? (small change inside the picker files other PRs are editing; do after #1905 and #1902 merge)
3. When the CEMEMBER edit command is built, it must call `CeMemberReplanner.FindRow(list, record, SectionDatabaseService.GetFormerNameMap())` and `Replan(..., formerNames)`; and write the new name back into the record after a redraw.

Finished: Sat 31 Oct 2026, 17:55 (Melbourne time).
