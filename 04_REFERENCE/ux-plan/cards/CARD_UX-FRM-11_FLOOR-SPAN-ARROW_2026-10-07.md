# CARD UX-FRM-11: floor joist span arrow, upper floors (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** Upper floors come straight after the roof. Class: **Missing** (the span-arrow drawing logic exists for roofs and is built to be reused for floors; no floor command exists).
Tim's words: UX-FRM-11 (one arrow per area, not every joist); UX-FRM-05 "Yes, by area (Recommended)"; tag "FJ" for floor joists (confirmed 26 Sep).

1. **Before:** on the first floor plan you draw the joist direction by hand for each bay and type "FJ1 @ 450 CTS" yourself. Floor Joist Marker [FJ1] places a tag; nothing shows the span direction.
2. **After:** you pick a floor bay (two corners). CE draws ONE double-headed arrow across the bay in the joist direction, tagged "FJ1 @ 450 CTS". Subfloor bearers and joists (BR, GFJ) use the same command with their own marks.
3. **Command and prompts (proposed name CSFLOORSETOUT):** "Pick first corner of floor bay:", "Pick opposite corner:", "Joists, Bearers or Deck <Joists>:", "Direction (two points, or Enter for the short span):", "Mark <FJ1>:", "Spacing <450>:". Preview, then Enter.
4. **Where the arrow goes:** across the middle of the bay, clipped to the bay edges. If a beam tag is in the way CE shifts the arrow along the bay and says so.
5. **Cancel and Undo:** Esc draws nothing; one accepted bay is one U.
6. **Native protection:** a locked framing layer means nothing is drawn and a plain message; never unlocked; no work inside an Xref or REFEDIT.
7. **Settings values:** default joist spacing per type, the "CTS" wording, layer, arrow size from the plan scale (not a fixed number).
8. **Tested without AutoCAD:** arrow position and clipping, tag text, spacing from Settings, locked layer refused.
9. **Only Codex in AutoCAD can see:** the arrow reads clearly on a crowded first floor, preview, Esc, one U, a bay on a rotated plan.
10. **Questions for Tim (typed):**
    1. **One arrow per bay, or one per run of same-direction bays?** Rec: per bay, simplest, and what the roof does. Job example: a long floor with three bays all running north-south gets three arrows.
    2. **Do subfloor bearers and joists go through this same command?** Rec: yes, same arrow, marks BR and GFJ. Job example: a timber subfloor job gets BR1 @ 1800 CTS and GFJ1 @ 450 CTS.
    3. **Is the spacing one value for the job, or per bay?** Rec: one job value, changeable per bay in the prompt. Job example: a deck at 300 CTS while the house floor is 450.
