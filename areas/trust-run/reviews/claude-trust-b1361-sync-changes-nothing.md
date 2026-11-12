# Review: PR 2071 `claude/trust-b1361-sync-changes-nothing` (BUG-1361: a bracing table sync with no edits must change nothing in the drawing)

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:18 PC clock. Read only. **Head reviewed:** `a8ef1ec9`, one own commit on the installed Structural `8de95c34` (base `claude/trust04-base-struc-1.0.126`, checked). **Read against:** the BUG-1361 carpark entry (with its 04:19 note) and the installed code at `C:\CE_WORK\scratch\audit_struc` (`Services\ScheduleService.cs`, `Services\ProjectDataService.cs`). **Four states:** Built yes (lane). Tested unit only (lane, 540 schedule and bracing tests). Installed no. Accepted no.

---

## FOR TIM

1. A sync with no edits now writes nothing: a brace drawn flat and then turned with ROTATE is not turned again, and lengths and angles keep their exact values instead of being rounded to two decimals. That is what the bug asks.
2. But "only the cells the drafter edited are written" is not true when a brace was changed in the drawing after the table was made or last refreshed: a later sync (for example to push one typed edit on another row) still writes the table's older length or angle back into that brace, without a word. Today's build does the same; the fix does not make it worse, but the PR and the change log say it cannot happen.
3. What an edited ROTATION cell should mean for a brace turned with ROTATE is honestly listed as yours to decide and is not changed.

**Verdict: FIX FIRST** (two items, both small). GO would mean fit for testing on copies, never to merge or install.

---

## FIX FIRST

1. **A table older than the drawing still overwrites braces nobody edited in the table.** "Edited" is decided by comparing each cell with the brace as it is NOW (`Services\BracingTableSyncPlan.cs` 35-62, called from `Services\ScheduleService.cs` 741-746), not with what the table showed when it was made. So after STRSCHEDCREATE or STRSCHEDREFRESH, a brace stretched with a grip, given a new length in Properties, or re-angled by its rotation grip has a cell that no longer matches; the next STRSCHEDSYNC writes the old table figure back over it (`ScheduleService.cs` 751-760). That is a silent change to a bracing length or angle that the bug's expected result rules out ("A sync changes only the cells the drafter edited"). The installed build does the same, so this is not new harm, but the PR description, the change log item 2 and the carpark note all say it is now so. Fix, one of:
   1. keep what each row showed when the table was last written (the table already carries its own record, `ScheduleMap`, `ScheduleService.cs` 21-33, written at create time 249 and refreshable like the pier record 661-667), and treat a cell as edited only if it differs from that; where the brace has also changed since, write nothing for that row and print one plain line naming it; or
   2. at the least, list it for Tim as a decision and say it plainly in the change log and the PR ("if you changed a brace in the drawing after the table was made, refresh the table before you sync, or the sync puts the table's figure back").
2. **Assumption (c) does not match the code.** The PR and the change log say "a typed number that rounds to the same value is not an edit". The comparison is by text (`BracingTableSyncPlan.cs` 46-60): typing "2700.0" or "2,700" over a cell that shows "2700" (or "90.0" over "90") counts as an edit and rewrites a 2699.996 brace as 2700 (or an 89.9973 angle as 90). Either compare the numbers (equal when they show the same at two decimals) or reword (c) to say what the code does.

## Sound (by reading)

1. **No edit, no write:** each row's brace is read with the same reader the table is built from (`ProjectDataService.ReadBracing`, 316-338, the same values written into the cells at `ScheduleService.cs` 409-410 and 693-694 with the same "0.##" wording), so an untouched row compares equal and none of the three writes runs. The flat-then-ROTATEd brace shows the object's own turn (the reader falls back to it, 325-326), the cell matches, and the angle is not applied again: the bug's trigger is closed.
2. **Edited cells behave as today:** length and angle are written to the same block values as before (751-760). The type cell is still written as text only, as today; BUG-1435 is PR 2072's.
3. **A blank type is no longer filled in:** the reader shows a blank type as "A" (319-320), so the cell matches and the attribute stays blank, where the installed sync wrote "A" into it. A small improvement, not a change to any total.
4. **No total, length or angle is changed by the fix** except by not writing: every write that remains was there before.
5. **Nothing unlocked or bypassed;** no new prompt; the one transaction and the single command are unchanged, so one U still takes the whole sync back.
6. **Tim's item listed, not built in:** (b) the edited ROTATION cell on a ROTATEd brace still adds to the object's turn exactly as today, said as undecided.

## Tests

Do they fail without the change through the real code path? Partly. The decision (`BracingTableSyncPlan.ForRow`) is real code and is what the sync calls; its cases would not even build on the installed code. That the sync reads first, calls the plan, and has no write-every-cell code left is a text search of `ScheduleService.cs` (`Bug1361BracingSyncChangesNothingTests.cs` 80-100). `SyncBracingTable` itself never runs. The test named `TheOldBehaviour_WouldHaveWrittenEverythingOnANoEditSync_SoThisCheckCanFail` only checks the new plan; the name overclaims.

## Worth knowing

1. The sync still opens every brace for writing before deciding (`ScheduleService.cs` 735), so a no-edit sync with one brace on a locked layer still stops with AutoCAD's own error (STRSCHEDSYNC has no start-up check and no error catch: `Commands\UtilityCommands.cs` 92-96, `ScheduleService.cs` 349-380). Same as today; nothing is unlocked. Opening for read and upgrading only rows the plan writes (as PR 2074 does for CLEAN) would make a no-edit sync touch nothing at all.
2. The table is still one row short on today's build (BUG-497, PR 2044); 2071 is not stacked on 2044.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD; whether opening a brace for writing with no change marks the drawing changed was not measured.
3. Braces with separate LENGTH_A and LENGTH_B values (the reader takes the first it finds; the writer sets all three names, as today).
4. No client name, street, suburb or job number in the diff (checked).
