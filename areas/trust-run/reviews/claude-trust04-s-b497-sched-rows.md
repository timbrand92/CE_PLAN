# Review: draft PR 2044, `claude/trust04-s-b497-sched-rows` (BUG-497 Structural, card TRUST-04 Structural item 3)

**Reviewer:** lane trust-review (fourth run), Fri 13 Nov 2026, 00:00 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff 8de95c34...origin/claude/trust04-s-b497-sched-rows` at head `87c29f01` (two commits: the B-215 fix `27b39b05` and the review change `87c29f01`; 3 files), PR 2044's description, my earlier review `reviews\claude-b215-w497-schedule-rows.md`, and `Modules/Structural/Services/ScheduleService.cs` at the head. PR base `claude/trust04-base-struc-1.0.126` = `8de95c34`, the installed Structural 1.0.126 (checked).

---

# FOR TIM

1. **Create Schedule (STRSCHEDCREATE) now makes the bracing, bored pier and tie-down tables one row taller,** so the last brace, pier or tie-down gets its own row instead of AutoCAD stopping with an error.
2. **Both things the last review asked for are done:** the off switch that brought the fault back is gone, and each of the three tables has a test that fails if its fix is undone.
3. **Nobody has run it in AutoCAD yet;** one brace, one pier and one tie-down on a copy will show it.

**Verdict: GO** (for the robot and Codex on copies; not a merge or install decision). Built yes. Tested unit only (by its lane: net48 and net10 0 errors; Structural tests filtered "Schedule" 470 of 470; broken twin on the bracing table, 1 of 470 failed, then restored; not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items

1. **Off switch removed: DONE.** `ScheduleTablesHaveTitleAndHeadingRows` appears nowhere on the branch (searched the whole Modules folder at the head), and `Models/UserSettings.cs` is not touched. The three tables are sized by one rule, `TableRowCount` (`ScheduleService.cs` 384), with no switch. Recorded in the change log as a DRAFT default for Tim to confirm.
2. **A test on each table builder that fails if its fix is undone: DONE.**
   1. `ScheduleTableRowCountTests.EachScheduleBuilder_SizesItsTableWithTheTestedCount` has one case per builder (bracing, bored pier, tie-down). Each reads that builder's own source and requires its size line to call `TableRowCount(...)` with that table's item count, and forbids the old "Count + 1)".
   2. I checked by script that, at the head, each builder's checked text holds its call and no "Count + 1)", so all three cases pass now. Putting any one builder back to `Math.Max(2, x.Count + 1)` removes its call and brings back "Count + 1)", so that builder's case fails. The lane ran that broken twin for the bracing table (1 of 470 failed).

## 2. Checked and sound

1. **The fix is right in all three tables.** Row 0 is the title, row 1 the headings, items start at row 2 (bracing 388 to 409, bored pier 426 to 462, tie-down 576 to 599). Items + 2 rows gives every item a row. With no items the table is 2 rows, as before.
2. **Nothing else changes:** STRSCHEDREFRESH (BUG-498), tables already on drawings, prompts, Cancel and Escape, layers and Xrefs are untouched. No units involved. `Shared\CE_SHARED` untouched.
3. **Tests kept off Tim's files:** the lane pointed `CE_STRUC_SUITE_APPDATA_ROOT` at a scratch folder and reports Tim's `CS_Settings.json` unchanged.
4. **No real job data** in the change, the tests or the change log.

## 3. Worth knowing (not blocking)

1. **The test reads the size line, not the place the size is used.** For the bored pier table the line that sets the table size (`table.SetSize(rows, columns)`, 445) is past the 900 characters the test reads, so a change made only there would not be caught. The size line itself is guarded, which is what "undo the fix" means here.
2. **The robot steps the PR points to are not there yet.** PR 2044 (and PR 2042) say the AutoCAD steps are in `PENDING_TESTS.md`, section "TRUST-04 core safety fixes", rows 6 and 3. At 00:00 on 13 Nov that section is not in `PENDING_TESTS.md` on `main`, and the trust-safety-fixes lane has no status file in `areas\trust-run\`. Run rule 11 needs the rows; the change log's own steps (one brace, one pier, one tie-down; then four braces on a fresh copy) are the right content.
3. **Combining with the BUG-498 lift:** this branch no longer touches `UserSettings.cs`, so the only overlap left with a BUG-498 branch is `REGRESSION_LOG.md`.
4. **Still on the printed bracing schedule, not this fix:** LAYER and HANDLE columns (software words on a printed sheet). A switch for the pier table exists, off.

## 4. Not checked

1. Did not build or run tests; the counts are the lane's.
2. Nothing run in AutoCAD: whether the old size really stopped STRSCHEDCREATE with an error (the bug was found by reading code), and whether an office table style adds rows of its own.
3. AutoCAD 2022 to 2024.
