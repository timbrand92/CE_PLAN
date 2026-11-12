# Review: claude/b216-bug498-sched-stale-rows (BUG-498, Structural)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:05. Read only. Nothing built, run or installed.
**Base checked:** branch sits on `8de95c34` (installed Structural 1.0.126); its own change is one commit, `9341c350`, plus a merge of the base. Diffed with `git diff 8de95c34...origin/claude/b216-bug498-sched-stale-rows`.
**Card:** TRUST-04, Structural item 3. **Bug:** BUG-498 (found by reading code, never seen in AutoCAD).
**Where it already is:** PR #2030 was MERGED on 5 Nov into `claude/rel-20261026s`, the held S-46 line (Structural 1.0.127, merge `3ce4712d`). S-46 is not installed. The FIX FIRST items below go on a new branch cut from `8de95c34`, per card TRUST-04.

---

# FOR TIM

1. **What it does on a drawing:** after you erase a brace or bored pier, Refresh Schedule (STRSCHEDREFRESH) now blanks the left-over bottom row instead of still listing the erased item. Bracing can no longer be overstated that way.
2. **The fix is right and copies what the tie-down schedule already did.** The blanked row stays as an empty row at the bottom of the table.
3. **Verdict: FIX FIRST** (the same two small things as BUG-497: no off switch, and a test that catches the fix being undone).

---

## Findings

1. **The fix is correct (checked against the code).** `Modules/Structural/Services/ScheduleService.cs` on the branch: Refresh re-reads the drawing first (`ProjectDataService.ScanFromDrawing`, line 303), writes the current braces or piers from row 2 down, then `BlankLeftoverRows` (705-711) empties every cell below the last one written (called at 700 for bracing and 736 for piers). The heading rows are never touched (`ScheduleStaleRows.RowsToBlank` starts at row 2 at the lowest).
2. **The table-to-drawing sync is safe with blank rows.** `SyncBracingTable` skips a row with an empty handle cell; the pier sync reads the row record, which `RecordPierRowLinks` pads with blanks for surplus rows. So a blanked row is never read back as a brace or pier.
3. **FIX FIRST: an off switch the card rules out.** `ScheduleSet.RefreshBlanksLeftoverRows` (`Models/UserSettings.cs` 2146, default on). Off brings back the overstated schedule. Card TRUST-04 section 2, item 2 says a fix to a wrong result gets no off switch. Remove it, or the controller changes the card.
4. **FIX FIRST: the test does not catch the fix being undone.** `Modules/Structural.Tests/Models/B216ScheduleStaleRowsTests.cs` checks only the row-number rule. Removing either `BlankLeftoverRows` call still passes. Add a source-text pin on both calls and write the card's robot case: four braces, create, erase one, refresh, three filled rows; broken twin = no blanking, which must fail.
5. **Combining with BUG-497 conflicts** in `Models/UserSettings.cs` and `REGRESSION_LOG.md` (dry merge). Trivial, resolve by hand at the lift.
6. **Worth a look by Codex, not a fault:** blanked rows stay as empty rows at the foot of a printed schedule (rows are blanked, not deleted, same as tie-downs today). The bug allowed either.
7. **Checked and fine:** no prompt changed, so Cancel and Escape behave as before; a table on a locked layer behaves exactly as before (the table was already opened for writing); no Xref or REFEDIT path touched; nothing written outside the picked table; no units involved; no new drafter-visible text; no existing test changed; `Shared\CE_SHARED` untouched.

## What I did not check

1. Nothing was built or run; never seen in AutoCAD.
2. `RefreshScheduleById` (an automatic refresh path) also blanks rows now; I did not trace who calls it.
3. AutoCAD 2022 to 2024.
