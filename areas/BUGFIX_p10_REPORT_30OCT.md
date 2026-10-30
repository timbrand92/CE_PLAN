# BUGFIX p10 report, Fri 30 Oct 2026: BUG-1141 (draft PR #1892)

## ANSWER FIRST

1. **PR:** draft #1892, branch `fb/bug-1141-unreadable-pit-record-link-cache`, base `claude/rel-20261102a`. No B number was in BUILD_REGISTER for BUG-1141, so the title starts "BUG-1141" and CE 01 renames it.
2. **What a drafter sees differently:** open a drawing (or press U) where one pit or pipe has a damaged CE record. Before: CE remembered no pit's links, MOVE of a good pit left its pipes behind, nothing was said. Now: one line on the command line, "[CE] The CE link record on one pit (drawing handle 2A4, at 1250.5, 8000) could not be read, so CE skipped it and loaded the rest. That pit may not drag its pipes when it is moved; its record has been left as it is.", and every other pit still drags its pipes. The damaged record is only read, never written, erased or unlocked.
3. **My own mistakes first:** (a) my first test run never started because the Bash tool has no powershell.exe, and I waited on a log that could not appear (about 25 minutes lost); (b) my first build failed on the missing placeholder arx (known trap, memory note); (c) I missed one of the five reads (the member-owner pipe read in the incremental refresh) until my own source-guard test caught it; (d) I changed two existing source-pinning tests (`LinkServiceIdleCacheRefreshContractTests`, `PipeOwnershipHighlightContractTests`) so they follow the renamed read; the checks they make are unchanged.
4. **NOT proven:** nothing was opened in AutoCAD. The real case (a drawing with one damaged record) is not unit-testable: the tests pin the parse, the words, the switch and source guards. The pit is named by drawing handle and position, not by pit number, on purpose: at open the project record may not be the drawing's own yet (B-055/BUG-1240 territory), and a wrong name is worse than a handle. A pit with a damaged record is still not dragged by MOVE itself (its own reader still throws in the move path, unchanged); this fix only stops it poisoning the other pits.

## Cause (confirmed by reading the code on the 1102a line)

1. `LinkService.Cache.cs` `RebuildRuntimeCaches` clears all link memory, then `CacheExistingPitPositions` and `CacheExistingSourcePositions` call `CachePitCacheEntry` / `CacheSourceCacheEntry`, each reading the record with `ReadPitLinkData` (`LinkService.Persistence.cs`), which does `JsonConvert.DeserializeObject` with no catch. One bad record throws out of the whole scan. The pipe pass (`CacheExistingBreaklineAnchors`) reads `ReadPipeLinkData` the same way (its outer catch only logs and abandons the pass). The idle incremental refresh (`TryRebuildRuntimeCachesIncremental`) has the same three reads.
2. Old line numbers in the carpark (759, 527-555) had moved; confirmed on the newest line.

## Fix

1. New switch `linking.unreadableLinkRecordSkippedOnOpen` (`UserSettings.cs`, "Default: on.", settings file only, no Settings page row, like the C-75 switches). Rule file `Rules/UnreadableLinkRecordRule.cs` (switch read, the words). Unreadable settings read ON.
2. `LinkService.Persistence.cs`: `ReadPitLinkDataForCache` (reuses BUG-1142's `ReadPitLinkDataForScan`), `ReadPipeLinkDataForCache` (catches only the bad-text error), `NameUnreadableCacheRecord` (once per drawing per record; one CE log line; command line only). Switch OFF: the old throwing reads, exactly.
3. `LinkService.Cache.cs`: the five reads (pit, source, pipe in the full rebuild; pit, pipe and member-owner pipe in the incremental refresh) go through them.

## Clashes seen

1. **BUG-1142 (#1752):** based on the older `rel-20261024m`, but its reader and naming code are already in the 1102a base; I reused `ReadPitLinkDataForScan` and did not touch `RemovePipeLinksFromAllOwners`.
2. **B-055 (#1866, BUG-1251):** files `ProjectDataService.cs`, `ChecksResultReader.cs`, `CdCheckProjectSourceRule.cs`, `UserSettings.cs`, `REGRESSION_LOG.md`. I touch only `UserSettings.cs` (one new property after `RaingardenLabelWithoutNumber`) and `REGRESSION_LOG.md` (new entry at the top): a textual conflict is possible there, resolve by keeping both sides.
3. **p2 (BUG-1240, B-059):** report and file list not yet written when I looked; I avoided `ProjectDataService` entirely. Not verified further.

## Tests

1. New `Bug1141UnreadableLinkRecordTests` (switch ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes; typed false changes only itself; ten records with one damaged load nine; old read still throws so switch OFF returns the old behaviour; the words; the rebuild uses only the tolerant reads; the skip writes nothing).
2. Civil net10 focused: 41 of 41 then 213 of 213 after the guard fix. Full suite (Debug): 21,575 tests, 21,540 passed, 32 skipped, 3 failed: `ExistingCivilPipePass_PrewarmsGripCacheBeforeFirstSelection` (mine, fixed), and two compiled-IL tests (`FinalLandingProducerCollapsesOnly...`, `RefusedNativeCallbackInvalidates...`) that read Release code. A Release rerun of those plus mine and the idle-refresh tests: 75 of 75 pass. The full suite was not re-run after the one-line guard fix (the Release rerun covers it). net48 build of Drainage: 0 errors.

## Robot case that proves it (needs a damaged record, with a switch-off control)

1. **Name:** `N41_pit_record_skip` (twin `N41_pit_record_skip_off`).
2. **Setup:** a copy of a drawing with ten pits joined by pipes; before opening, replace pit 5's `PIT_LINK` record text with a truncated string (cut it mid-way) using the case's file edit step. Settings: switch ON for N41, `linking.unreadableLinkRecordSkippedOnOpen:false` for the twin.
3. **Types:** open the copy, then `MOVE`, pick a good pit (not pit 5), base point 0,0, second point 1000,0.
4. **Checks (ON):** command line holds one line starting "[CE] The CE link record on one pit (drawing handle" and ending "left as it is."; the pipes of the moved good pit end 1000 mm further east; pit 5's record text is byte-identical to what was written; the CE log has one "BUG-1141" warning line.
5. **Checks (twin, OFF):** no "[CE] The CE link record" line, and the good pit's pipes do not follow (old behaviour). A PASS on N41 with a FAIL-shaped twin is the evidence.

## Settings listings (names, times, sizes only)

Before and after were identical (no real settings file changed). Listing (both times):

1. `CE_STRUC_SUITE\CS_Settings.json` 2026-10-30 19:54:14, 35613 bytes (changed at 19:54, before this job started at about 21:05; not by my tests); `CS_Settings.json.PRE_TIM_YES_20261020.bak` 2026-10-18 10:00:24, 34858 bytes.
2. `CE_CVL_SUITE\settings.json` 2026-09-16 12:13:17, 672 bytes; `settings.PRE_WORKSHOP_20260916.json.bak` 2026-09-16 11:55:58, 672 bytes.
3. `CE_SUITE`: folder not present.
4. `TIM_CE_CADTOOLS\CD_Settings.json` 2026-10-04 08:22:30, 15270 bytes; `.bak-2026-06-12` 2026-06-12 10:04:31, 6944 bytes; `.PRE_WORKSHOP_20260916_121735.bak` 2026-09-16 09:32:03, 8795 bytes; `CS_Settings.json` 2026-03-31 13:18:00, 351713 bytes.

## For CE 05

BUG-1141: cause above, PR #1892 (draft). Not FIXED; needs the N41 case. Related and still open: BUG-1154 (what truncates the record), and the move path's own throwing reader (not in scope).
