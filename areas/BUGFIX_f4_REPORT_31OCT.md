# BUGFIX f4 report: BUG-788 two Save As Xrefs (B-113, 31 Oct 2026)

## FOR TIM

1. **PR:** #1925 (draft, base claude/rel-20261102a, Civil 3.0.88 line). BUG-788 stays open. Built and unit-tested only. Nobody has opened this in AutoCAD.
2. **What you will see differently:** attach two Xrefs where the second was made by Save As from the first, with different pits in each. Before, the Pit Schedule source list showed one source and the second Xref's pits were missing. Now it lists two sources: the first offered, the second named with "has the same internal drawing ID as another Xref but different pit data ... not offered" (the existing note from PR #1404). A single Xref looks the same as before.
3. **Why it did not work before:** the earlier fix only taught the final check to notice two different sets of pit data. But the step before it, which reads each Xref, handed the second Xref the first one's pit data (it remembered by drawing ID alone), so the check never saw a difference.
4. **Switch:** the existing Settings switch "linking.pitScheduleXrefSeparatesSaveAsCopies" (ON by default). Switch OFF gives exactly the old behaviour. No new switch.
5. **My own mistakes:** none that changed the result. The first test build failed because the worktree lacked the 0-byte CE_TRANSFORM_2027.arx placeholder (untracked, as in the C-62 assembly report); I made it and re-ran.
6. **NOT tested:** AutoCAD itself, reading real Xrefs, net48 tests (only the net48 compile: 0 errors), the whole suite, Manager tests.
7. **Robot case proposed: N98_xref_saveas_twins (C98).**
   1. **Fixture (made-up data, no client drawings):** A.dwg with one pit A1, cover RL 20.00. B.dwg made by SAVEAS from A.dwg, cover changed to 21.00 and pit B2 added. Confirm A and B report the same non-empty FINGERGUID. A host drawing with both attached by _XATTACH.
   2. **Types:** PITSCHEDULE, Source, Drainage XREFs, Refresh.
   3. **Checks:** two source entries; the second carries the "same internal drawing ID ... not offered" note.
   4. **Switch-off control:** with the switch OFF, one entry and no note.
   5. **Repeat** with the attach order reversed.
   6. **Reach unproven:** the robot must be able to read the Pit Schedule source list.

---

## Technical detail

1. **Cause (confirmed on the start point, head 3fbb9da5):** `Modules/Drainage/Services/PitScheduleXrefDiscoveryService.cs`, `ReadContext.ReadProjectRecord` returned the remembered snapshot by FingerprintGuid before reading the second Database.
2. **Fix:** new internal `XrefRecordCache<TDatabase,TValue>` in the same file. Switch ON: identity key is identity plus normalised path (upper-case, forward slashes turned to back slashes); no known path means no identity shortcut, each Database read once on its own. Switch OFF: identity-only key, same as before. Empty identity never shared. Read-only.
3. **Tests:** new `Modules/Drainage.Tests/Services/Bug788XrefRecordCacheTests.cs` (7 tests). With existing `PitScheduleXrefSaveAsCopyTests`: 10 passed. Filter `PitScheduleXref|Bj33SettingsPersistence`: 115 passed (net10, count not zero). Switch default is already pinned through settings in Bj33SettingsPersistenceTests and `SwitchOnByDefault`.
4. **Builds:** net10 test project build and run OK; Drainage net48 compile 0 errors. Isolation variables set and printed before each run; one test project per command with a filter; -m:2, below normal priority.
5. **Shared files:** no open PR touches PitScheduleXrefDiscoveryService.cs. CE_SHARED unchanged.
6. **Real-files listings** (names, sizes, times; files in %APPDATA%\TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS, CE_SUITE; 33384 lines before, 33387 after):
   1. **Settings files:** CD_Settings.json 15268 bytes 16:45:34 (same in both listings), CS_Settings.json (Structural) 35613 bytes 2026-10-30 19:54:14 and CE_CVL_SUITE\settings.json 672 bytes 2026-09-16 12:13:17 unchanged.
   2. **Differences between the two listings:** only live AutoCAD/Suite Manager housekeeping while your AutoCAD was running: CD_RecentValues.json (12220 bytes, 16:43:30 to 16:47:22), CE_Admin outbox machines files (2), four new CE_Admin\outbox\usage files (16:45 to 16:48), and CE_Admin sessions marks (2). My tests set TEMP and log folders to scratch, and the first listing was taken before any test ran; the usage files are written by the running plugin, not by my code.
   3. **Full listings** were kept in my scratch and removed with it; the differences above are the complete diff.
7. **C: free space:** 47.08 GB at start, 46.30 GB after cleaning my worktree (other jobs were building at the same time: f2, f3, w4).
8. **Cleanup:** worktree C:\CE_WORK\build\f4 cleaned (git clean -fdXq) and removed; scratch C:\CE_WORK\scratch\f4 removed after this report.
9. **Finished:** Saturday 31 Oct 2026, 16:51 Melbourne (clock reads AEST UTC+10 on this PC).
