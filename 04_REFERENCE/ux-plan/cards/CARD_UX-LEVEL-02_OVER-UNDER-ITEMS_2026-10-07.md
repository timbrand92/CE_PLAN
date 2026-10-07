# CARD UX-LEVEL-02: show the level above and below as (O) and (U) (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** Upper floors down to ground. Class: **Missing** (the engine and its saved record are built, switched off; no command draws anything).
Tim's words: UX-LEVEL-02 "Auto from level above, office style"; "(O)" over, "(U)" under, plain is this level (UX-NOTES-09). Roof and floors are separate drawings (INT-062), so the other level is read from its own drawing.

1. **Before:** on the first floor plan you copy the roof posts across as red "C1(O)" squares by hand, and the ground floor walls as "(U)". When the roof changes, the copies go stale.
2. **After:** you run one command on a plan whose level is set (CSPLANLEVEL). CE reads the level above and draws its columns and loadbearing walls here as red (O) items in the office look. If you opt in, items below come as (U). Run again and they follow changes.
3. **Your edits win:** a copy you moved or re-typed is left alone and CE says "C1 changed on the level above, but you changed C1(O) here, so CE left yours". A copy you erased comes back on the next run.
4. **Command and prompts (proposed name CSLEVELCARRY):** "Carry from level above (First):", then a preview of what will be added, moved or removed, "Accept? [Yes/No] <Yes>". Option "Below" adds (U).
5. **If the other level cannot be read:** nothing is added or removed and CE says why (drawing not found). If the other level has no columns, CE warns before removing old copies.
6. **Cancel and Undo:** Esc or No changes nothing. One accepted run is one U.
7. **Native protection:** the other drawing is only read, never changed. Locked layers on this plan: reported and skipped, never unlocked. Nothing exploded, no Xref or REFEDIT work.
8. **Settings values (already built):** the on switch (starts OFF), the five office layers (column over, its text, column under, loadbearing wall over and under), the level list, the offset between levels (start 0), "from below" (starts off).
9. **Tested without AutoCAD:** which copies are added, moved, removed; your edits kept; a damaged record read as empty; a copy from two levels away not carried on.
10. **Only Codex in AutoCAD can see:** reading a second drawing, the red look, a changed roof drawing flowing to the floor, save and reopen, one U.
11. **Questions for Tim (typed):**
    1. **Are the levels drawn on the same coordinates?** Rec: yes, offset 0, with the offset a Settings value. Job example: roof and first floor both start at the same corner of the house.
    2. **Should "(U)" be on by default?** Rec: no, "(O)" only until you ask. Job example: the ground floor shows first floor posts; footings (last) turn on "(U)" later.
    3. **When is the other level read: on run only, or each time the drawing opens?** Rec: on run only, with a one-line note when the other level has changed since. Job example: roof edited Tuesday, first floor opened Wednesday: "Roof changed since last carry, run CSLEVELCARRY to update".
