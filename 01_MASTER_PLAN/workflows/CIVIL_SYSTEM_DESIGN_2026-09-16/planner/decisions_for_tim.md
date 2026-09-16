# Decisions for Tim — Civil planning bank

**Only questions the current records do not settle.** No answer is needed overnight. The first four affect the safe calculation path. The lower rows are kept concise because they need their specialised workflow cards before implementation.

| Priority | Decision | What is known | Recommendation | What each choice means on a job |
|---|---|---|---|---|
| 1 | **Which soft-ground runoff coefficient applies to this calculation purpose?** | The current records distinguish a pervious-surface figure from a whole-site pre-development figure, and existing CE paths use both. | Do not let CE select either figure as an office default. Show the purpose, council/source basis and calculation use, then let you settle whether the two meanings remain separate. | **Separate basis:** a garden surface and pre-development site can use their documented meanings. **Single basis:** simpler entry, but it may depart from the source basis for a particular council/job. |
| 2 | **What is the governing discharge-coefficient basis for each council/orifice shape?** | Council evidence genuinely differs and the coefficient directly changes the outlet size. | Keep the council/source/shape basis explicit. Do not recommend or silently apply one numerical office default while the source conflict remains unresolved. | **Source-specific basis:** the output shows the council rule and shape used. **One office basis:** it would need an explicit Tim ruling because it can differ from a published council method. |
| 3 | **How should CE round an orifice size when the calculated result falls between market sizes?** | Maroondah example rounds a calculated 42 mm down to 40Ø; Manningham says nearest within ±2 mm; earlier CE answer was up to the next size. | Choose a council-aware rule with the adopted diameter and resulting discharge shown for review. | **Council-aware:** CE uses the local rule and flags a non-compliant option. **Always up:** a larger opening allows more discharge at the same head/coefficient, so it can exceed a permitted discharge and contradict a stated adopted size. |
| 4 | **How should CE obtain a new job’s 7 × 7 rainfall coefficient block?** | Tim settled per-job storage. The old spreadsheet imported a manually prepared block, but the method that fitted it from Bureau data is not recorded. Blue Factor does not supply a rainfall station. | Keep manual paste/import first, with location/source beside it. Do not invent the fitting method. | **Manual block:** you paste approved job data and CE remembers it. **Automated fitting later:** CE prepares a block only after its engineering method is separately checked. |
| 5 | **When a report proposes connected roof → treatment → reuse information, should you approve the whole linked arrangement or each value separately?** | The record explicitly leaves this unanswered. Dependencies and no mixed-version substitution are settled. | Start with a linked arrangement review that still lets you open/change an individual value. | **Linked arrangement:** avoids accidental mix-and-match. **Individual values:** allows fine control but CE must warn before a mixed source set is used. |
| 6 | **What is the intended reference for the new computations sheet’s visual layout?** | Tim rejected the current output because it renders everything as `Note:` lines, has a blank old cover and no CE presentation. The D+F record leaves “current CE layout” versus “clean V3 layout” open. | Use a clean CE-branded V3 sheet, but first review it against one approved current sheet so the usual council-facing order and figures are retained. | **Matched layout:** familiar to office/council. **Clean V3 layout:** clearer, provided the same engineering content/order is reviewed. |

## Not questions — already settled

- CDDESIGN recognises project folders/discovers documents automatically; only **Select / change documents** is exposed.
- There is no compulsory stage selector or wizard. CDDESIGN works from empty drawing through revision/issue.
- Confirm governing values before calculation/drawing effect; newer is not automatically approved.
- Site extent, surface/imperviousness and hydraulic catchments stay separate. No automatic equal DP split, double count, or unclassified-pervious remainder.
- Existing catchment-plan evidence is reviewed before redraw.
- Water Tank is last, and the temporary CDWT window ownership override remains Claude-only.
- A trench grate/higher candidate can govern TWL; floor level does not set TWL.

## Deferred but still genuinely open

The council record retains standards edition, twin-pipe clear gap, basement-pump path, pit-lid selection by location, AGI bypass of detention, and Whitehorse’s unverified 90 mm orifice. They need their own specialist workflow-card review before an implementation decision, so they are deliberately not turned into overnight design assumptions here.

---

## Technical appendix

Questions 1–3 and the deferred list are council-rule questions recorded as unanswered. Questions 4–5 are direct gaps in rainfall/design evidence. Question 6 comes from the D+F plan and Test Day result. None is answered by source code or historical examples, so this planner leaves them with Tim.
