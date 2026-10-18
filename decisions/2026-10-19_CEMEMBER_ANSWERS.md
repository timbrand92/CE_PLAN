# CEMEMBER: Tim's answers, 19 Oct 2026

Tim answered the ten questions the design chat sent him on 18 Oct. His words are in quotes. Companion to `decisions/2026-10-18_CEMEMBER_DESIGN.md` (written by the desk chat); this file adds to it and does not replace it. Nothing is built, installed or tested in AutoCAD.

1. **DIMSCALE/LTSCALE check: warn or stop?** Tim: "yes as per recommeneded". DECISION: warn and carry on, and record a line in the log.
2. **Purlin lips in the elevations?** Tim: "yes". DECISION: the elevations show the lips.
3. **C purlin like a PFC?** Tim: "kind of, it shows flange and flange lip if that makes sense?" DECISION: the C purlin elevations show the flange line AND the flange lip line. Line positions CONFIRMED by Tim on 19 Oct 2026 from a picture: "Yes, the lip picture is right: flange line one thickness in, lip line one lip depth in, 18cont toward and 18hidden away."
4. **Z purlin side elevation?** Tim: "kin dof but same as per q3". DECISION: the Z purlin side elevation shows the flange line and the flange lip line, same as the C purlin.
5. **Tees and bars in CEMEMBER at the start?** Tim: "not for now". DECISION: not in the first release. The data is kept apart in `04_REFERENCE/section_data_2026-10-18/section-catalogue_DEFERRED_tees_and_bars.json`.
6. **Buy the paid ASI tables? Top hats?** Tim: "nope we can get from elsewhere". DECISION: do not buy the ASI tables. Tim will source hollow-section properties and top hat data from elsewhere. Open until he sends them.
7. **Who checks the section numbers?** Tim: "look good" (the plan was: Tim checks ten rows he knows by heart: 310UB32.0, 250UC72.9, 380PFC, 230PFC, 100x100x6 EA, 100x100x6 SHS, 200x100x6 RHS, 114.3 CHS, Z15015, 900WB282). The check has NOT been done yet.
8. **Add the hollow sizes InfraBuild stocks but the list lacks?** Tim: "yes". DONE in the draft: 8 SHS and 23 RHS added, properties calculated.
9. **Supplier names with decimals (530UB92.4, 310UB32.0)?** Tim: "yep why not". DECISION: yes.
10. **Approve the CEMEMBER card?** Tim: "yes". DECISION: the card (`areas/release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md`) is approved by Tim on 19 Oct 2026. The lip line positions in 3 and 4 are confirmed. No code has started. The Tim AutoCAD checklist is still to be written and agreed before code starts.
