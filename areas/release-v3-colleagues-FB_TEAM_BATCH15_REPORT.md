# Team fix batch 15: carpark BUG-1085, BUG-1086, BUG-1087 (Sat 24 Oct 2026, 3:56 to 6:05 am Melbourne)

Headless Team job, desk plan/03. Base `origin/claude/rel-20261023m` @ `f7f7d551` (Civil 3.0.72 / Manager 1.1.72), fetched at the start. Nothing installed, AutoCAD/Codex/accoreconsole not started, no settings file, bundle, ProgramData or CE_SHARED touched. No bug marked FIXED, no PR closed, no branch deleted. DESK_LOG, QUEUE and BUG_CARPARK not edited.

## ANSWER FIRST

1. **BUG-1085 (CEMANAGER leaves its own Undo step): fixed in draft PR #1730**, head `c9b41484`, branch `fb/b15-bug1085-bug1086-no-undo-step`. Shared with BUG-1086, as the carpark entry asked.
   - **What Tim will see:** look at Manager, close it, press U: the U takes back your last real edit (for example the circle), not "CEMANAGER".
   - **Tests:** new `Bug1085Bug1086LookOnlyNoUndoStepTests` (4). Red on the base: 3 failed, 1 passed. Manager.Tests net10: 935 passed, 1 skipped, 0 failed of 936. Civil net10 full run: 19,526 passed, 22 skipped, 0 failed of 19,548. Manager project 0 errors, 0 warnings on net48, net8 and net10.
   - **Real-AutoCAD check:** blank drawing copy. CIRCLE, CEMANAGER, click only the title bar, close with X, U. Right: the U echoes CIRCLE and the circle goes. Then CIRCLE, U, CEMANAGER, close, REDO. Right: the circle comes back. No zoom or other command between the close and the U.
2. **BUG-1086 (CE_VERSION leaves its own Undo step): fixed in the same draft PR #1730**, head `c9b41484`.
   - **What Tim will see:** open About CE Suite, Close, U: the U takes back your last edit, not "CE_VERSION".
   - **Tests:** as item 1 (one test class covers both).
   - **Real-AutoCAD check:** CIRCLE, CE_VERSION, Close, U. Right: the U echoes CIRCLE and the circle goes.
3. **BUG-1087 (About CE Suite heading white on near-white): fixed in draft PR #1733**, head `02508426`, branch `fb/b15-bug1087-about-heading`.
   - **What Tim will see:** "CE SUITE" in dark grey on the pale band, readable at a glance.
   - **Tests:** new `Bug1087AboutHeadingContrastTests` (3). Red on the base: the heading test failed ("White"); the two palette contrast checks would also pass on the base (palette unchanged), they guard the pair. Manager.Tests net10: 934 passed, 1 skipped, 0 failed of 935. Civil net10 full run: 19,525 passed, 22 skipped, 1 failed of 19,548. The one failure, `LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile`, is a 5-second log-flush wait with the PC loaded by other sessions' builds; re-run alone 6 of 6 passed, and it passed in #1730's full run on the same base. Manager project 0 errors, 0 warnings on net48, net8 and net10.
   - **Real-AutoCAD check:** type CE_VERSION and look at the heading. Right: dark text clearly readable on the pale band; "Loaded CE versions" under it unchanged. Needs a Codex look (a visible change).
4. **What I did NOT test:** nothing was run in AutoCAD. REDO after a look-only command is not proven (AutoCAD's own Undo engine). No picture of the About window was taken. The dark theme of the About window was not looked at (the window loads the light theme file itself). net48 test lanes were not run (they do not load on this PC); net48 was compiled only.

## Duplicate check (done before any code)

1. `gh pr list --state all --search` for BUG-1085, BUG-1086, BUG-1087, "CEMANAGER undo", "CE_VERSION", "About heading", "undo step": no PR fixes any of the three. Related, not duplicates: #1671 (BUG-817 Pit Schedule), #1636 (BUG-1030 CDCALC), #1493/#1503 (BUG-852, CE_VERSION moved into Manager, already on the base).
2. `git ls-remote origin cx4/*`: fa01 to fa07. The seven `CODEX_FIXAUDIT_FA*_23OCT.md` reports mention CEMANAGER/CE_VERSION only as places to look (FA03, FA04, FA06), never these faults.

## Cause, checked in the code on the base

1. **BUG-1085 and BUG-1086:** `Modules/Manager/Commands/PluginManagerCommands.cs` registered CEMANAGER and CE_VERSION as plain `CommandFlags.Modal`, so AutoCAD gave each an Undo step of its own. Neither command body, the About window code nor the Manager window files hold any drawing write (searched for transactions, ForWrite, UpgradeOpen, SetSystemVariable, LockDocument, SendStringToExecute). Fix: `CommandFlags.Modal | CommandFlags.NoUndoMarker`, the flag CDCHECKIGNORE's read-only list already uses on this line. A different shape from the BUG-817 and BUG-1030 fixes, which stopped a real record write on Close; here there was no write, only the automatic marker. Installed Structural (S-39) no longer registers CE_VERSION, so the Manager one is what drafters run; the base's Structural source copy still has the old attribute (BUG-852 transition, guarded by CrossModuleGuardTests) and was not touched.
2. **BUG-1087:** `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml` heading `Foreground="White"` on `UiHeroHeaderBrush`, which is #F5F5F1 in the light theme (about 1.1 to 1). Fix: `{DynamicResource UiHeroHeaderTextBrush}` (#242B31, about 13 to 1), the brush the Manager and Admin headings use. No Settings-page or design decision needed: it matches the existing approved headings.

## Settings switches (R-00, R-27)

1. None added. All three are bug fixes where the old behaviour is the bug; a command flag cannot be switched at run time, and a colour fix has nothing to switch.

## Left for others

1. CESURVEYREVIEW, CEMANAGERUPDATES, CEMANAGERADMIN and CEBLOCKS open the same kind of window and probably leave the same Undo step. Not reported, not verified in AutoCAD, not changed. Worth a Codex look before anyone files them.
2. Both PRs touch the top of REGRESSION_LOG.md; whoever merges the second keeps both entries.
3. #1730 touches the Undo area: needs an Opus review (model routing rule).

## Environment notes

1. Private worktrees `C:\ce-fx\b15u` and `C:\ce-fx\b15h`, removed at the end; scratch runner and logs in `C:\ce-fx\b15tmp` (outside every repo). C: free space 18 to 22 GB before every build. Every build/test passed `-p:SkipDevBundle=true -nr:false --disable-build-servers` with the C-62 report's AutoCAD refs.
2. The shared `build.lock` was held open by another process all night (dated 23 Oct 8:24 pm) and could not be read or taken; builds ran Below Normal without it. Other sessions' dotnet processes were running at the same time.
3. Manager tests need TEMP and CE_LOG_DIR_OVERRIDE as backslash Windows paths: with forward slashes five Bug842CeBlocksSettingsFileTests fail their own path guard (my runner's fault, fixed, re-run green).
4. The Civil test project needs the Manager DLL built first in a fresh worktree (MSB3030 otherwise).
