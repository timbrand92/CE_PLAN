# FEDIT-OUTLINE-PICK (BUG-380 / BUG-355 item 1) - command card (4 Oct 2026)

Class: **Modify** (existing command FEDIT; nothing retired or hidden). Status: **card for the build; Tim's ruling is in; no code yet.**
Tim, Sun 4 Oct 2026 06:30 (INT-042), verbatim: "fedit yep click outlien edit". Desk reading: YES, a click on a pad/strip OUTLINE edits that pad/strip.

## Today (installed Structural 1.0.98)

1. FEDIT: "Select a footing to edit:". A click on the OUTLINE of a pad or a strip hits CE's generated outline piece and prints
   "[FEDIT] That is a CE outline, not a footing. Pick the pad (or its label) instead. Nothing changed." Found by Codex (verifyW3 W3-05, W2 first run),
   driver run 18 and 21: the engineer cannot pick the footing by its edge, which is what he sees.
2. Clicking the pad's label or inside works.

## Wanted

1. A click on a pad or strip OUTLINE (the generated outline or the footing's own line/polyline) selects THAT footing and opens the same editor as a pad click. Same result
   from the footing's own edge, its outline, its label.
2. Where CE cannot tell which footing owns the outline (an orphan outline, two footings sharing the edge, no record), FEDIT says so plainly
   ("CE cannot tell which footing this outline belongs to. Pick the pad or its label. Nothing changed.") and changes nothing. Never guess.
3. Native protections unchanged: a locked layer, an Xref, a REFEDIT or an unsupported object is never bypassed; one U per command; Cancel/Esc leave the drawing untouched
   (DBMOD unchanged); nothing is unlocked, detached, exploded.
4. No new Settings value. Plain words: "footing", "pad", "strip", "outline" (no entity/element/orphan/handle).

## Tests (before code)

1. Unit: the pick resolver maps a generated outline to its owning footing id (pad, strip, raft part); an orphan outline returns "unknown".
2. Unit: two footings sharing an edge -> unknown, no guess.
3. Wording: the "cannot tell" line is plain (the footing-words guard passes).
4. Source guard: FEDIT's refusal text for a resolvable outline is gone (the old "That is a CE outline, not a footing" only for the unknown case, reworded).

## What Codex checks in AutoCAD (after install)

1. DWG-S1 with a strip 50 mm from a pad (make it with LINE + FSF at y 500): FEDIT, click the strip near edge -> names SF1 and opens the editor; click the pad free edge -> PF1; Esc leaves DBMOD unchanged.
2. The shared corner (50 mm gap): the nearer footing wins or "cannot tell" - either is plain, never the wrong footing silently.
3. A locked footing layer: FEDIT on an outline still opens read-only or refuses in plain words; nothing unlocked.
4. One U after an edit puts the footing and its outline back together.

## Not changing

FSF/FPFC drawing, the Foundations manager, regeneration.
