# BUGFIX w498 report, 5 Nov 2026 (BUG-498, B-216)

## FOR TIM
1. **PR:** 2030 (draft, B-216), base claude/rel-20261026s, one commit.
2. **In AutoCAD terms:** draw four braces, erase one, run STRSCHEDREFRESH on the Bracing Schedule: it should now show three rows, the old fourth row blank (before: four). Same for the Bored Pier Schedule. Switch Schedule set "RefreshBlanksLeftoverRows", on by default, off gives the old behaviour.
3. **Built and tested:** net10 focused tests 10 of 10 pass (6 new plus the S-45 switch-default tests); net48 compile of the plugin had no code errors.
4. **NOT proven:** nothing was run in AutoCAD; the actual blanking of table cells is not unit tested (only the which-rows rule and the switch defaults). No Settings page row (window change, Codex-owned). Rows are blanked, not deleted, same as the tie-down schedule.
5. **My own mistakes:** a stray empty python call hung 2 minutes. The net48 post-build identity check failed with exit 9009 (powershell not found in my isolated PATH), so that gate did not run.
6. **Real files:** the before/after listing shows two real files changed: CE_STRUC_SUITE\logs\ce_struc_suite.log and CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json. My runs used APPDATA, TEMP and CE_LOG_DIR_OVERRIDE under C:\CE_WORK\scratch\w498; Tim's acad.exe was running and writes both, so I believe they are not mine, but cannot prove it. Listings: C:\CE_WORK\scratch\w498\before.txt and after.txt (37,022 files each).
7. **Overlap:** PR 2028 (B-215, BUG-497) also edits Services\ScheduleService.cs; I did not stack on it; expect a possible merge conflict.

## Technical
- Fault confirmed on base: UpdateBracingTable and UpdateBoredPierTable never cleared rows past the last item; UpdateTieDownTable did.
- Fix: ScheduleService.BlankLeftoverRows plus Core/Schedules/ScheduleStaleRows.RowsToBlank (pure). Pier row record already pads blank entries for surplus rows.
- Robot case proposed: B216_sched_stale: draw 4 AB braces, STRSCHEDCREATE, erase one, STRSCHEDREFRESH, read bracing table row 5 cell 0 (blank ON, old type OFF).
- Tests: Modules\Structural.Tests\Models\B216ScheduleStaleRowsTests.cs. REGRESSION_LOG.md entry added. CE_SHARED untouched.
- Cleanup: git clean -fdXq run in the worktree; worktree and scratch left in place so the listings stay readable.
