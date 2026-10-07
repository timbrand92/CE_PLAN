# CARD UX-FRM-05 (with UX-SUB-03): roof area setout, rafter arrow or truss arrow (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** Roof first in the roof-down order (UX-STRUC-13). Class: **Missing** (the drawing logic is built and tested, no command uses it).
Tim's words: UX-FRM-05 "Yes, by area (Recommended)"; UX-SUB-03 "Trusses by others, CE shows layout".

1. **Before:** on the roof plan you draw each rafter run and each truss direction by hand: a line, an arrow head, text typed "R1 @ 900 CTS" or "RT".
2. **After:** you pick a roof area (two corners). CE asks "Rafters or trusses?" and draws ONE arrow across the area, tagged. Rafters: a two-headed span arrow, "R1 @ 900 CTS". Trusses: one single-headed direction line, "RT" (or "RT (Manufacturer)" if the job names one). CE does not draw every rafter and does not size trusses.
3. **Girder trusses:** pick the girder line and CE gives it the next free mark, GT1, GT2. It never reuses a gap after a delete.
4. **Command and prompts (proposed name CSROOFSETOUT):** "Pick first corner of roof area:", "Pick opposite corner:", "Rafters or Trusses <Rafters>:", "Direction (pick two points or Enter for the long side):", "Mark <R1>:", "Spacing <450>:". Then a preview, then Enter to accept.
5. **Cancel and Undo:** Esc at any prompt or at the preview draws nothing. One accepted setout is one U. If you move the area later, the arrow does not follow (it is a plain drawing, not a tracked item) and CE says so once.
6. **Native protection:** drawn only on the roof framing layer. If that layer is locked, CE says "Layer is locked, nothing drawn" and stops. It never unlocks, and never works inside an Xref or REFEDIT.
7. **Settings values (R-00):** default rafter spacing (450, 600 or 900 by rafter type), the "CTS" wording, the layer names, the RT wording, the GT prefix.
8. **Tested without AutoCAD:** where the arrow lies in a rectangle, the tag wording, the girder numbering, a locked layer refused.
9. **Only Codex in AutoCAD can see:** the arrow looks right at 1:100 and 1:50, the preview, Esc, one U, a roof area on a rotated plan.
10. **Questions for Tim (typed):**
    1. **Is a roof area always a rectangle you pick?** Rec: yes for the first version; an L-shaped roof is two picks, two arrows. Job example: a hip roof over a rear extension gets R1 over the main part and R2 over the extension.
    2. **Do girder trusses take GT, or another prefix?** Rec: GT, a Settings value. Job example: GT1 and GT2 either side of a hallway opening.
    3. **Should spacing come from RJSET (the rafter and joist settings you already have)?** Rec: yes, one place to change it. Job example: you set rafters to 600 once and every arrow says "R1 @ 600 CTS".
