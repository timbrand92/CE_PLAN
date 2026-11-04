# BUGFIX w1080 report (5 Nov 2026) - BUG-1080

## FOR TIM
1. **PR:** #2027 (draft, B-209), on claude/rel-20261112a. Civil only.
2. **In AutoCAD terms:** CDREFRESHBLOCKS no longer redraws RISER, DROPPER, PIT LABEL or PIT LABEL 2 if any copy (also inside another symbol) is on a locked layer, in an Xref, unreadable, or REFEDIT is open. It says which symbol and layer it left alone. Other symbols still refresh. Nothing is unlocked. Switch: checks.refreshBlocksSkipsProtectedCopies, ON; OFF = old behaviour.
3. **Built:** net10 tests project and net48 compile of Drainage, 0 errors.
4. **Tested:** 397 focused tests pass (new Bug1080 tests plus the new-switch-defaults classes, both start-up reads, switch off control). Not run in AutoCAD.
5. **NOT proven:** the real drawing scan (copies inside other symbols, dynamic copies, REFEDIT) has never run in AutoCAD. Pit block migration (PIT BLOCK 3) in the same command is not covered. A frozen or off layer is not treated as protected.
6. **Own mistakes:** (a) my first test run failed on a quoting slip in my own script (wasted about 10 minutes); (b) the 0-byte CE_TRANSFORM_2027.arx placeholder had to be created; (c) my before/after listing of real AppData shows two real files changed during the run (CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json and CE_CVL_SUITE\logs): my tests ran with CE_LOG_DIR_OVERRIDE, TEMP and TMP set, so I believe Tim's own AutoCAD or other jobs wrote them, but I cannot prove it. Listings: C:\CE_WORK\scratch\w1080\listing_before.txt and listing_after.txt.
7. **Robot case:** B209_refresh_locked: copy a drawing with a RISER on a locked layer, type CDREFRESHBLOCKS, check the command line names RISER and the layer and the symbol geometry is unchanged; then set the switch off, run again, check it changes (control).

## Detail
Files: Modules/Drainage/Commands/RefreshBlocksCommand.cs, Rules/RefreshBlocksProtectionRule.cs (new), Models/UserSettings.cs, Drainage.Tests/Commands/Bug1080RefreshBlocksProtectedCopiesTests.cs (new), REGRESSION_LOG.md. CE_SHARED untouched. C: free space about 61 GB before and after (worktree removed; scratch kept for the listings).
