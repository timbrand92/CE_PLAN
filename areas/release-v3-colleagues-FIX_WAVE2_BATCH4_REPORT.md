# Fix wave 2, batch 4 of 5: ledger top-25 fixes 16 to 20 (Fri 23 Oct 2026, 08:20 to 09:17 Melbourne)

## ANSWER FIRST

All five were real on the base (`origin/claude/rel-20261022m`, head 40ee0a36). All five are fixed in draft PRs, each with a test that fails before and passes after. Nothing is marked FIXED, nothing was opened in AutoCAD, nothing was deployed. No switch on any of them (all are bug fixes that are simply on).

1. **#16 BUG-1017** (Manager buttons type their command into a running command): PR #1613, head f514c8ef, branch `fw2/bug-1017-manager-buttons-busy-command`. Tests: 5 new cases plus 2 older source guards updated; Manager net10 861 of 861 (the Manager project's full size); Manager net48 builds. All five send places (Open Repair, hub, help, settings fallbacks, Load Now, CE Blocks tile) now go through one sender that cancels first, the same text the ribbon sends.
2. **#17 BUG-892** (Inspector zero count takes a lock and transaction): PR #1609, head 498f0f7a, branch `fw2/bug-892-inspector-empty-count`. Tests: 2 new, red before, green after. Civil net10 19156 total, 2 red (the known BackTest_GlenEira24115 and the PDF-render flake LoadAsync_ValidSinglePagePdf, which passed in the other runs). net48 builds.
3. **#18 BUG-957** (Enter in Settings search saves and closes): PR #1610, head 78a2303f, branch `fw2/bug-957-settings-search-enter`. Tests: 4 new (they did not compile before). Civil net10 19158 total, 1 red (known BackTest_GlenEira24115). net48 builds.
4. **#19 BUG-987** (CDSYNC swaps a nearby pit's lid, remarks, tick): PR #1611, head 5ca3f08f, branch `fw2/bug-987-cdsync-identity-first`. Tests: 2 new, red before, green after. Civil net10 19156 total, 1 red (known BackTest_GlenEira24115). net48 builds.
5. **#20 BUG-1011** (typed Depth lost): PR #1612, head 27b35e16, branch `fw2/bug-1011-typed-depth`. Tests: 3 new, 1 red before. Civil net10 19157 total in the full run, 2 red: the known BackTest_GlenEira24115 and one of my own new assertions that was wrong (I expected the row not to become an override; the new invert is a pending change like any typed invert, same as typing an invert by hand). I corrected the test and re-ran 42 of 42 narrow tests green; I did NOT re-run the whole 19157 after that one test edit.

**Skipped:** none.

**Not done inside these (needs Tim or another bug):**
1. **BUG-987 nearness distance.** The ledger also asks for the position tolerance to follow the drawing's units through a Setting. It is still a fixed 200 drawing units. Options: (a) leave it (a metre drawing then means 200 m, which is only a risk for pits with no record of their own); (b) tie it to the drawing units with a new Setting, default 200 mm. Recommend (b) later, with Tim's word on the unit rule. The identity-first change removes the swap the ledger described either way.
2. **F-228 (BUG-1022)** was named "in the same pass" for BUG-987. It is a different bug with its own number (schedule override not following a recovered pit handle) and a different code area, so it is not in this change.

## Checks, in the order I made them

1. **Cause verified in the code first, all five.**
   1. BUG-1017: five direct `SendStringToExecute` calls in Manager with no cancel; the ribbon fix (BUG-828) never reached them. Verified at the base.
   2. BUG-892: `ShowEntitiesByHandles` opened `LockDocument` and a normal `StartTransaction` before looking at whether the list was empty.
   3. BUG-957: the search box handled Enter only when there were results; with none, Enter fell through to the Save button (`IsDefault`).
   4. BUG-987: `RestorePitUserData` matched pit by pit; a pit with a weak default record of its own was allowed to take a nearby pit's stronger record before that pit had been matched.
   5. BUG-1011: `TrackOverriddenField` (which lists Depth) promoted the row to an override in the same pass, then the `!row.IsLinkedOverride` guard skipped the typed-depth solve. Same pattern as BUG-193 (PitSize).
2. **Open PRs for the same bug:** `gh pr list --state open --search BUG-nnn` for all five. None for 1017, 892, 957, 1011. For 987 three PRs (#1313, #667, #687) mention the number in text only; none touch `ProjectDataRecoveryGuardService.cs`.
3. **Environment:** private worktrees under `C:\ce-fx` (w892, w957, w987, w1011, w1017), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD refs from the C-57 report, 0-byte `CE_TRANSFORM_2027.arx` placeholder per worktree (the build stops without it), fresh TEMP, build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (I waited for another job's lock first). Worktrees removed at the end; branches kept; the lock is gone.
4. **Tim's settings, installed bundles, ProgramData:** not touched. Not run: AutoCAD, Codex, accoreconsole, Structural, Installer.Tests, Civil net48 test project.
5. **Source-guard honesty:** the BUG-892 and BUG-1017 tests are partly source-order guards (the empty check comes before the lock; no direct send remains). They prove the shape, not that AutoCAD keeps REDO. The REDO loss itself was read from the code, not seen.

## What Tim will see (plain), per fix

1. **BUG-1017.** Start TEXT, leave CE Manager open, click Open Repair: before, "CDREPAIR" was written into your text; now the text command is cancelled and Repair opens. Same for the CE Blocks tiles.
2. **BUG-892.** Click an Inspector count that shows 0: before, it could use up your next U or lose your REDO; now it just says nothing was found.
3. **BUG-957.** In Settings, change a value, search for nonsense, press Enter: before, the change was saved and Settings closed; now it stays open and unsaved.
4. **BUG-987.** Two pits 10 m apart, one Class D with a remark and out of the schedule, one plain: before CDSYNC they could swap; now each keeps its own.
5. **BUG-1011.** Pit Schedule, Auto-calculate depth off, type a depth: before nothing changed in the pit; now the pit's invert changes and the status line says by how much.

## Left for the next sessions

1. Opus review of all five (each PR is titled "needs Opus review"; 987 touches a record-restore path, 1011 touches the Pit Schedule edit order).
2. Codex pass in real AutoCAD on Tim's PC (copies only), steps are in each REGRESSION_LOG entry.
3. Rerun the full Civil suite once on the merged train, because 1011's last test edit was only re-run narrowly.

## One-line note on the helper I used

A throwaway runner `fw2b4-run.sh` in `C:\ce-fx` wrapped the build lock and the dotnet command. It was outside every repo, not a build script for the product, and I deleted it at the end.
