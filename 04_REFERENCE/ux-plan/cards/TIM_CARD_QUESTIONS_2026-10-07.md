# Five draft cards: questions for Tim (7 Oct 2026)

Each card is still a draft. Nothing is built until you approve it. Roof first, then upper floors.

## A. Roof area setout (UX-FRM-05, with UX-SUB-03)
1. You pick two corners of a roof area and choose rafters or trusses. CE draws one tagged arrow across it.
2. Rafters get a two-headed span arrow tagged like "R1 @ 900 CTS". Trusses get one direction line tagged "RT". CE does not size trusses.
3. Girder trusses get the next free mark (GT1, GT2). Esc draws nothing, one accepted setout is one Undo, a locked layer stops it.

A1. **Is a roof area always a rectangle you pick?** Recommend yes. Job: a hip roof over a rear extension gets R1 over the main part and R2 over the extension.
A2. **Do girder trusses take GT, or another prefix?** Recommend GT, changeable in Settings. Job: GT1 and GT2 either side of a hallway opening.
A3. **Should spacing come from the rafter and joist settings you already have?** Recommend yes, one place to change it. Job: set rafters to 600 once and every arrow reads "R1 @ 600 CTS".

## B. Floor joist span arrow (UX-FRM-11)
1. You pick a floor bay by two corners. CE draws one double-headed arrow across it in the joist direction, tagged like "FJ1 @ 450 CTS".
2. Subfloor bearers and joists use the same arrow with their own marks (BR, GFJ). The arrow sits across the middle of the bay and steps aside if a beam tag is in the way.
3. Esc draws nothing, one accepted bay is one Undo, a locked layer stops it with a plain message.

B1. **One arrow per bay, or one per run of same-direction bays?** Recommend per bay, as the roof does. Job: a long floor with three north-south bays gets three arrows.
B2. **Do subfloor bearers and joists go through this same command?** Recommend yes, marks BR and GFJ. Job: a timber subfloor job gets BR1 @ 1800 CTS and GFJ1 @ 450 CTS.
B3. **Is joist spacing one value for the job, or per bay?** Recommend one job value, changeable per bay when you draw. Job: a deck at 300 CTS while the house floor is 450.

## C. Framing plan legend (UX-FRM-01)
1. You pick a spot once. CE reads the framing plan and lists only the symbols actually on it, in the office "DENOTES ..." wording.
2. Run it again after changes and it updates the same legend in place. Missing lines are added. Lines for symbols no longer on the plan are only dropped after CE asks you.
3. Wording you edited by hand is never overwritten. Esc or No changes nothing, one accepted run is one Undo.

C1. **Same box style as the footing legend?** Recommend yes, so the office sees one look. Job: swatch on the left, "DENOTES ..." on the right, like the slab legend.
C2. **Does the legend repeat on every framing sheet, or once per job?** Recommend once per sheet, each showing only its own symbols. Job: the roof sheet shows trusses and bracing, the first floor shows stud walls and posts.
C3. **Where does the bracing line come from?** Recommend from the bracing symbols on the plan. Job: a plan with only Type B ply walls shows only the Type B line.

## D. Propose lintels and supports (UX-FRM-04 and 06)
1. CE finds openings in walls you marked loadbearing and shows a grey proposed lintel over each, tagged L1, L2, with size "Unknown". You accept or skip each.
2. Where a beam ends on a stud wall with nothing under it, CE proposes a double or triple stud (DS1, TS1) in the same list. You confirm each.
3. Sizes are never invented. Walls CE cannot read (Xref, locked layer) are listed as skipped with the reason. Esc or No draws nothing, one batch is one Undo.

D1. **What counts as an opening?** Recommend a gap in a loadbearing wall wider than a Settings value (start 600 mm). Job: a 900 mm window gets L1, a 450 mm service hatch does not.
D2. **One lintel mark for matching openings?** Recommend no, each lintel its own mark, as you ruled for beams. Job: two identical 1800 openings are L2 and L3.
D3. **Propose supports in the same command?** Recommend yes, one pass and one list. Job: one list shows 5 lintels and 2 double studs.

## E. Show level above and below as (O) and (U) (UX-LEVEL-02)
1. On a plan whose level is set, CE reads the level above and draws its columns and loadbearing walls here as red (O) items in the office look. Items below come as (U) only if you opt in.
2. Run it again and the copies follow changes. A copy you moved or retyped is left alone and CE tells you. A copy you erased comes back.
3. The other drawing is only read, never changed. If it cannot be found, nothing is added or removed and CE says why. Esc or No changes nothing, one run is one Undo.

E1. **Are the levels drawn on the same coordinates?** Recommend yes, offset 0, changeable in Settings. Job: roof and first floor both start at the same corner of the house.
E2. **Should (U) be on by default?** Recommend no, (O) only until you ask. Job: the ground floor shows first floor posts, and footings (last) turn on (U) later.
E3. **When is the other level read: on run only, or each time the drawing opens?** Recommend on run only, with a one-line note when the other level has changed. Job: roof edited Tuesday, first floor opened Wednesday shows "Roof changed since last carry".

Reply: approve A to E, or approve with the changes you list
