# Review: draft PR 2046, `claude/trust04-s-b498-stale-rows` (BUG-498 Structural, card TRUST-04 Structural item 3)

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 00:57 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff 8de95c34...origin/claude/trust04-s-b498-stale-rows` at head `49f30cf2` (two commits: the lifted B-216 fix `504695ca` and the review change `49f30cf2`; 4 files), PR 2046's description, my earlier review `reviews\claude-b216-bug498-sched-stale-rows.md`, and `Modules/Structural/Services/ScheduleService.cs` at the head. PR base `claude/trust04-base-struc-1.0.126` = `8de95c34`, the installed Structural 1.0.126 (checked).

---

# FOR TIM

1. **Refresh Schedule (STRSCHEDREFRESH) now blanks the rows left over after you erase a brace or bored pier,** so an erased brace can no longer stay listed and overstate the bracing.
2. **Both things the last review asked for are done:** no off switch, and a test that fails if either table loses the fix.
3. **To see it in AutoCAD it must be tested together with the BUG-497 fix,** because on today's build the schedule cannot be made with four braces in the first place.

**Verdict: GO** for the robot and Codex on copies (built together with PR 2044). Not a merge or install decision. Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: Structural tests filtered "Schedule" 469 of 469; the five BUG-498 tests pass; broken twin with the bracing call removed, 1 of 5 failed, then restored; not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items

1. **Off switch removed: DONE.** The branch does not touch `Models/UserSettings.cs`; `RefreshBlanksLeftoverRows` appears nowhere in the diff. The rule `ScheduleStaleRows.RowsToBlank` (`Core/Schedules/ScheduleStaleRows.cs` 14-20) has no switch, and the change log lists "no off switch" as a DRAFT default for Tim.
2. **A test that fails if the fix is undone: DONE.**
   1. `B216ScheduleStaleRowsTests.BothRefreshes_BlankTheLeftoverRows_AfterWritingTheirOwn` has one case per table. Each takes the text of `UpdateBracingTable` or `UpdateBoredPierTable` up to the next method and requires `BlankLeftoverRows(table, row);` in it.
   2. I checked the cut by reading: the bracing method's text runs to the declaration of `BlankLeftoverRows` (`ScheduleService.cs` 705), whose comment does not contain the call; the pier method's text runs to `SyncBracingTable` (738). So deleting the call at 700 or at 735 makes that case fail.
   3. The row rule itself has three cases (one erased, none erased, all erased; headings never touched).
   4. The card's robot case (four braces, make the schedule, erase one, refresh, three rows filled) is written in the change log, item 6. It still needs AutoCAD.

## 2. Checked and sound

1. **The fix is right.** Refresh re-reads the drawing first (`ScheduleService.cs` 303 and 333), writes the braces or piers that are on the plan from row 2 down, then blanks every cell from the next row to the bottom (700, 735; `BlankLeftoverRows` 705-710). Rows 0 (title) and 1 (headings) are never touched. No totals row exists in either table, so nothing else is wiped.
2. **Both refresh paths get it:** STRSCHEDREFRESH (`RefreshSelectedSchedule`, 283-321) and the automatic refresh when STRSCHEDCREATE is run again with "update existing" on (`RefreshScheduleById`, called at 205 and 214). One code path.
3. **A blanked row is never read back as a brace or pier.** Bracing sync skips a row with an empty handle cell (742-743); the pier sync reads the table's own row record, which is padded with blanks for surplus rows (`RecordPierRowLinks`, 664).
4. **Nothing else changes:** no prompt, so Cancel and Escape are as before; a table on a locked layer is refused as before (it was already opened for writing); no Xref or REFEDIT path; no units; no new drafter words; `Shared\CE_SHARED` untouched; no existing test changed.
5. **No real job data** in the change, the tests or the change log.

## 3. Worth knowing (not blocking)

1. **Anything typed by hand below the last brace or pier is now cleared on refresh** (a note row, for example), the same as the tie-down schedule has always done. Codex's look should check a table with one hand-typed row under it.
2. **Blanked rows stay as empty rows at the foot of the printed schedule** (blanked, not deleted). The bug allowed either.
3. **Test it with PR 2044.** On `8de95c34` alone, STRSCHEDCREATE with four braces stops at the last row (BUG-497), so the change log's steps need both fixes in one build. The PR's pointer to `PENDING_TESTS.md` section "TRUST-04 core safety fixes" still points at a section that is not in `PENDING_TESTS.md` on `main` (checked 00:56).
4. **Combining with PR 2044:** the only shared file is `REGRESSION_LOG.md`.
5. **Still on the printed bracing schedule, not this fix:** LAYER and HANDLE columns (BUG-503 item 1).

## 4. Not checked

1. Did not build or run tests; the lane's counts are its own.
2. Nothing run in AutoCAD: the refresh on a real table, an office table style with extra rows, a table someone has resized by hand.
3. AutoCAD 2022 to 2024.
