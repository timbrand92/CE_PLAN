# Review: claude/b215-w497-schedule-rows (BUG-497, Structural, PR #2028)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:05. Read only. Nothing built, run or installed.
**Base checked:** branch sits on `8de95c34` (installed Structural 1.0.126); its own change is one commit, `f2841ae4`, plus a merge of the base. Diffed with `git diff 8de95c34...origin/claude/b215-w497-schedule-rows`.
**Card:** TRUST-04, Structural item 3. **Bug:** BUG-497 (found by reading code, never seen in AutoCAD).
**Where it already is:** PR #2028 was MERGED on 5 Nov into `claude/rel-20261026s`, the held S-46 line (Structural 1.0.127, merge `df4a7638`). S-46 is not installed. Card TRUST-04 lifts fixes out of the held builds one at a time, so the FIX FIRST items below go on a new branch cut from `8de95c34`.

---

# FOR TIM

1. **What it does on a drawing:** Create Schedule (STRSCHEDCREATE) makes the bracing, bored pier and tie-down tables one row taller, so the last brace, pier or tie-down gets a row instead of AutoCAD stopping with an error.
2. **The fix itself is right.** The table really is title row, heading row, then one row per item, and the old size was one short.
3. **Verdict: FIX FIRST** (two small things: take out the off switch the card says it must not have, and make the test catch the fix being undone).

---

## Findings

1. **The fix is correct (checked against the code).** `Modules/Structural/Services/ScheduleService.cs` on the branch: row 0 is the title (line 406), row 1 the headings (410-414), items start at row 2 (416). Old size `Math.Max(2, count + 1)` left no row for the last item; new `TableRowCount` (390-391) gives `count + 2`. All three tables use it (395, 433, 583). With no items the size is 2 either way, so empty schedules are unchanged.
2. **FIX FIRST: an off switch the card rules out.** `ScheduleSet.ScheduleTablesHaveTitleAndHeadingRows` (`Models/UserSettings.cs` 2146, default on). Off gives back the one-row-short table, which is the error the bug describes. Card TRUST-04 section 2, item 2: "No new switches for the other fixes. A fix to a wrong result does not get an off switch." Remove the switch, or the controller changes the card. It is not on the Settings page, so a drafter cannot reach it anyway.
3. **FIX FIRST: the test does not catch the fix being undone.** `Modules/Structural.Tests/Services/ScheduleTableRowCountTests.cs` only checks the arithmetic in `TableRowCount`. If any of the three table builders went back to `count + 1`, every test still passes. Add a source-text pin that each builder calls `TableRowCount` (the repo already uses such pins), and write the card's robot case: one brace on a copy, STRSCHEDCREATE, three tables with the brace listed; broken twin = the old size, which must fail.
4. **Combining with BUG-498 conflicts in two files.** A dry merge of this branch with `claude/b216-bug498-sched-stale-rows` conflicts in `Models/UserSettings.cs` (both add a line at 2146) and `REGRESSION_LOG.md`. Both are trivial, but the lift must resolve them by hand.
5. **Checked and fine:** no prompt changes, so Cancel and Escape behave as before; no layer, Xref or REFEDIT handling touched; nothing written outside the new table; row counts do not depend on drawing units; no software words added to anything a drafter sees; no existing test changed; `Shared\CE_SHARED` untouched.
6. **Not part of this fix, noted only:** the bracing table still prints LAYER and HANDLE columns on the sheet (software words on a printed schedule). A separate switch for the pier table already exists, off.

## What I did not check

1. Nothing was built or run; the error is still a reading of the code, never seen in AutoCAD.
2. Whether AutoCAD's table style adds its own title or heading rows on some drawings (would change the count). A robot run on a copy settles it.
3. AutoCAD 2022 to 2024.
