# Re-review: PR 2071 `claude/trust-b1361-sync-changes-nothing` (BUG-1361: a bracing schedule sync changes only what you edited)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 07:03 PC clock. **Head reviewed:** `514f8334` (one commit since `a8ef1ec9`, pushed 06:46; base `8de95c34`). **Against:** the FIX FIRST list in `reviews\claude-trust-b1361-sync-changes-nothing.md` and the brief (a sync must never overwrite a brace from a table cell the drafter did not edit; the edit check compares numbers at the table's rounding). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. STRSCHEDSYNC now judges each cell against what the table showed when it was made or last refreshed, not against the brace as it is now. So a brace you stretched or turned in the drawing after making the table keeps its new length or angle, and CE says how many such braces it left as drawn.
2. Typing "2700.0" over "2700" is no longer an edit; only a real change of number is written.
3. A bracing table made by today's build has no record of what it showed, so the first sync on it changes nothing and says "run STRSCHEDREFRESH first"; after one refresh, syncs work as above.

**Verdict: GO** for the robot on copies (with PR 2072, which is now re-stacked on this head). Three small items.

---

## The two FIX FIRST items

1. **A table older than the drawing overwrote braces nobody edited: FIXED.** The table now keeps, for each brace, the type, length and angle text it showed (`Modules\Structural\Services\ScheduleService.cs`, `BuildBracingMap` and `RecordBracingAsBuilt`, written at STRSCHEDCREATE and at both STRSCHEDREFRESH paths). A cell counts as edited only when it differs from that record (`Services\BracingTableSyncPlan.cs` 58-80); it is never compared with the brace as it is now. A brace changed in the drawing since is left alone and counted, with one plain line telling you to refresh (50-52, 87-90; `ScheduleService.cs` 761-837). A table with no record writes nothing for its rows and says why (83-85).
2. **"A number that rounds the same is not an edit" did not match the code: FIXED.** Cells and the record are compared as numbers at the table's own two-decimal wording (`BracingTableSyncPlan.cs` 40-47), so "2700.0", "2700" and "2,700" are the same.

## Still true

1. An untouched table writes nothing; the flat-then-ROTATEd brace is not turned again; one U.
2. Nothing unlocked.

## Small items

1. **The "left as drawn" line can be wrong for one brace.** It counts every brace changed in the drawing since the table was made, including one whose cell you then edited. That brace is NOT left as drawn: your typed value is written over the drawing change (right, it is your edit), but the line says it was left as drawn. Count only braces changed since AND not edited.
2. **If the record cannot be updated after a write, a later sync can repeat the old edit.** After writing an edited cell the sync updates the table's record in place only (`ScheduleService.cs` 831); unlike the refresh path it has no fallback write. If that fails, the record still holds the old text, so the next sync treats your earlier edit as a new one and writes it again, over any drawing change made in between. Add the same fallback the refresh uses, or say so on the command line.
3. **Every existing table needs one refresh before its first sync does anything** (item 3 for Tim). Safe direction, and said plainly; the robot should see it: a table made with the installed build, sync (nothing changed, the line), refresh, sync after an edit (written).

## Worth knowing (as before)

1. Every brace in the table is still opened for writing even when nothing will be written (`ScheduleService.cs` 781), so one brace on a locked layer still stops a sync with AutoCAD's own error, as today.

## What I did not check

1. Nothing run.
2. That the table cells and the new record are always written with the same wording from the same list in the same order (by reading they use the same "show" function on the same brace list).
3. PR 2072's new head `0f7ca816` (merge of this fix plus its own two small items): moved, not re-reviewed in this run.
