# DESIGN CARD BUG-246: Pit Schedule cells left old because their layer was locked (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** The fix is built and reviewed, and it waits on your yes to question 1, because it changes what Refresh does. It sits on top of the locked-layer fix for the Pit Schedule (BUG-232), which goes in first.

## What you would see in AutoCAD

1. You move pit P4 while the schedule layer is locked. CE leaves P4's drawn cells as they were and says so once on the command line. That part is in the BUG-232 fix.
2. Today, nothing reminds you later, and the Pit Schedule window still shows the schedule as up to date. With this fix the window shows OUT OF DATE. It names the first three cells (pit, column, locked layer) and says how many more.
3. You unlock the layer and press Refresh in the window. CE brings those cells up to date and says "2 drawn schedule cells brought up to date". One U undoes it.

## Questions

1. **May Refresh in the Pit Schedule window now change drawn schedule text?**
   - **Recommended:** yes, but only cells that are out of date, and U undoes them.
   - **Job:** Friday you moved P4 with the schedule layer locked. Monday you unlock it and press Refresh. P4's IL and depth cells update. If you say no, Refresh only reports them. They update the next time P4 is edited or the whole schedule is refreshed, as today.
2. **Should CE look at the drawn cells each time the window opens, or store a list in the drawing?**
   - **Recommended:** look each time. It still works after the drawing is closed and reopened, and nothing new is saved in the drawing.
   - **Job:** you close the drawing on Friday and open it on Monday. The window still says OUT OF DATE for P4. The cost is a slightly longer open on a very large schedule (not yet timed).

## What stays safe

1. Opening the window only reads the drawing. It never changes it.
2. Esc or closing the window changes nothing. One Refresh is one Undo.
3. A cell on a locked layer, in an Xref or in a reference edit is never unlocked or touched. It stays OUT OF DATE, named in plain words, until you unlock it.
4. CE warns and carries on. Nothing stops you working or plotting with old cells. No new numbers are added, so the Settings page is unchanged.

## Once you approve

1. **Builders:** merge the BUG-232 locked-layer fix first, then this one. They fix one small leftover from the review: after you tick Xref sources, the OUT OF DATE badge should clear.
2. **Test that proves it:** on a copy, lock the schedule layer and move P4 by 1 m. Unlock it and open the Pit Schedule window. The badge reads OUT OF DATE and names P4. Press Refresh: the cells update and the badge goes back to up to date. U puts the old cells back. Close, reopen, and the badge is the same as before closing.

---
For builders (Tim need not read): PR #658 (`claude/b03-bug246-skipped-cells-stale`, Opus MERGE @285f437f; 1 LOW: Xref-source early return at Data.cs:2430 must clear `_staleCellsLeftAsDrawn` and raise the three status notices; 1 NIT: `placed:false` test). Duplicate #657: close it. Depends on #423 (BUG-232, still OPEN 7 Oct). The design choice, a read-only re-scan with no saved record, is the builder's. Opus accepted it; it answers the carpark's "touches saved data" concern. Read: BUG_CARPARK BUG-246; REGRESSION_LOG BUG-246 entries 6(e) and 7 on that branch.
