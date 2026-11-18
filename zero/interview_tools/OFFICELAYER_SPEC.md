# OFFICELAYER / OL ("put on office layer"): what it does, from Tim's answers

**Revision:** 1 (Wed 18 Nov 2026, late afternoon, Melbourne time). IDs: OL-01 onwards, never reused.
**Sources:** TA-029, TA-126 to TA-130 in `interview_tools\ANSWERS.md`.
**Status:** planning only, in words. No picture until the approved style arrives (D-286). A new tool in the first release (D-209).

## What it does

1. **OL-01 Typed OFFICELAYER or OL** (TA-126). You pick objects, then OL shows the office layer list.
2. **OL-02 The list:** office layers by what they are for (slab edge, boundary, existing drain, 25TEXT...), grouped, with a search box, like OH (TA-127).
   - **Suggestion:** OL puts the most likely layer first, from what the objects look like, for example 2.5 mm text suggests 25TEXT.
   - **Choice:** the person always picks. Software suggests; the person decides (screen rule 26).
3. **OL-03 What changes:** the layer, and colour, linetype and lineweight go to ByLayer, so pasted work looks like office work. The linetype scale comes from DIMSCALE (TA-128).
4. **OL-04 Consultant layers remembered:**
   - **What it keeps:** a list of matches, for example "A-SITE goes to BOUNDARY".
   - **Next time:** when a drawing from that consultant arrives, OL suggests all the matches at once.
   - **Applying:** only when Tim ticks "apply". Never automatic (TA-129).
   - **Ownership:** the list is an office list, edited by Tim (MG-03).
5. **OL-05 One undo step** per use.

## The list behind it (OL-06)

1. **Work still to do (TA-130):** the master drawing's 189 layers are to be sorted by what each is for, using the 21 old jobs, the same way as the hatches.
   - **Overlaps:** shown to Tim to settle.
   - **Result:** a layer-by-function list that OL, CLEAN's protected layers (TA-077) and the other tools all read.
2. **Not started.** It is the next piece of work in this lane, if the planning chat agrees.

## Still open

1. **The layer-by-function list** (OL-06).
2. **The window's look:** waits for the approved style.
3. **Where the consultant match list is kept:** in the office IT folder with the other office lists (MS-07) is assumed. Not asked.
