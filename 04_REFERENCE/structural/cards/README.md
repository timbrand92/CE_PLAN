# Structural workflow cards — index

Draft command/workflow cards for the AGENTS.md "Mandatory AutoCAD command/workflow review gate"
(`C:\Lisp Files\CE_ACAD_PLUGIN\AGENTS.md`). Each card records what works today, what needs to change, what is
missing, Tim's intended result in his own words, a Keep/Modify/Rebuild/Retire/Missing call per step, the full
AutoCAD experience, an example test drawing, automated guards versus Tim's AutoCAD checklist, build slices
smallest-first, and any genuinely open questions with a recommendation. **Nothing in this folder is built.** No
code starts on any card until Tim approves it in AutoCAD/workflow terms.

Written 26 Sep 2026 from `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, `areas\structural.md`,
`04_REFERENCE\structural\STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, and the command registry
(`Modules/Structural/Assets/Config/command-registry.json`) read from the shipping Structural branch
(`origin/claude/struc-d1-prep`, not `master` — Structural ships from `struc-d1-prep`).

## Cards

1. **[STRUC-RIBBON_CARD_2026-09-26.md](STRUC-RIBBON_CARD_2026-09-26.md)** — Structural ribbon: families with
   drop-downs (Beam, Text, Tag, a Hatch picture gallery), duplicate commands merged to one real command each,
   the 29 "Legacy" utilities sorted into proper families, diagnostics hidden. Status: **DRAFT**, workflow not
   yet fully approved — Tim confirmed 25 Sep 2026 that the shortest, most AutoCAD-style code wins each duplicate
   group (the "over"/left-right groups and hiding CEMARKUPBENCH were not put to him separately and stay open,
   unconfirmed recommendations), plus the Hatch gallery layout, the one Text size/compass button and smart
   tagging (UX-STRUC-07 to 09, plus the learning extension UX-STRUC-09b) and the office hatch-code convention
   ("colour then type then h", e.g. 21H, 21DH). **CESTRUC's launcher role is also retired 25 Sep 2026
   (UX-STRUC-10, closing UX-RIBBON-04 OPEN 2)** — its 109 buttons were checked against the registry and all but
   one ("Create schedule template") already have an existing ribbon or Admin Hub home. Also records what the
   shared ribbon code (`CE_SHARED`) can and cannot do yet for drop-downs and galleries, and why.
2. **[STRUC-MARKUP-QA_CARD_2026-09-26.md](STRUC-MARKUP-QA_CARD_2026-09-26.md)** — QA against the engineer's
   markup: CE reads the markup by AI vision and proposes items, a faded overlay of the markup under the drawing
   with a docked item list, four item states (To do / Drafted / Needs clarification / Checked), markup rounds,
   a clarification-PDF export, and comparing engineer-drafted changes drawing-to-drawing. Status:
   **APPROVED-IN-PRINCIPLE** — Tim settled the whole workflow 25 Sep 2026 (UX-QA-01 to 08); only build-level
   details remain open.
3. **[STRUC-REGISTER-ISSUE_CARD_2026-09-26.md](STRUC-REGISTER-ISSUE_CARD_2026-09-26.md)** — one shared drawing
   register, suggested affected sheets, one combined PDF per issue, revision clouds/triangles after Revision A
   showing only the current changes. Status: **APPROVED** — Tim settled the workflow 25-26 Sep
   2026 (UX-REG-01 to 15, including the refined Civil set and Check plot); build-level details remain open. Civil
   has no register or notes page; the Structural register lists Civil sheets on combined jobs, with separate
   revision sequences. Records
   that CE Sheets is already a mature, mostly-working system for scan/register/closed-sheet writes/publish — this
   card is mostly about the gaps (job-wide combined PDF, affected-sheet suggestions, revision clouds), not a
   rebuild.
4. **[STRUC-ARCH-BACKGROUND_CARD_2026-09-26.md](STRUC-ARCH-BACKGROUND_CARD_2026-09-26.md)** — shared Civil +
   Structural background preparation, including a separate Civil colour/visibility preset, changed-Xref
   comparison and relative-path repair.
   Status: **PLANNING ONLY** — blocked on an evidence gate: real prepared Xrefs from two to three more
   representative jobs must be read (read-only, headless, SHA256-verified, never a real client file copied into
   a repo) before the cleanup/alignment/colour-override rules can be specified, let alone built. One example job
   was read 14 Sep 2026; the record is explicit that one example is not enough to generalise from.
5. **[STRUC-COMPS_CARD_2026-09-26.md](STRUC-COMPS_CARD_2026-09-26.md)** — Design this member from drawing
   evidence, traced loads, confirmed wind/geotech basis, previewed size/schedule change and the shared CE
   computations sheet. **DRAFT PLAN**; numerical design methods and clauses need engineer sign-off. Build order:
   timber beams/lintels, footings/slabs, steel, bracing/tie-downs.

## Reading order

Priority set by Tim, 25 Sep 2026 (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural drawing
journey — priority after D1"): after the D1 beam/column card, the order is **QA against the markup**, then
**register, revisions and issue**, then **architectural background preparation**. The ribbon card runs alongside
these on its own track (it changes discovery and presentation, not drawing behaviour, so it does not block or
get blocked by the other three). The detail browser (journey stage 5) was not ticked as a near-term priority and
has no card here yet.

## Open questions across the original four cards, with recommendations

Compact list; each card carries the full reasoning for its own items. Items Tim has since answered (25 Sep
2026) are marked **ANSWERED** and kept here for traceability rather than deleted; each card itself has already
moved the answered item out of its own "Open questions" section.

1. **Ribbon — which name wins in each of the 27 duplicate command groups? ANSWERED.** Tim, 25 Sep 2026:
   *"Shortest code (Recommended)".* The shortest, AutoCAD-style code in each row wins; every other name keeps
   working typed.
2. **Ribbon — are the footing/slab "over" and left/right variant groups genuine duplicates or different drawn
   results?** Not put to Tim separately; still open. *Recommended: treat as different tools until someone who
   knows footing/slab detailing confirms otherwise.*
3. **Ribbon — hide CEMARKUPBENCH alongside CEDEBUG/JOBTIMERDEBUG?** Not put to Tim separately; still open.
   *Recommended: yes.*
4. **Ribbon — exact target list for "about 40 tools shown"?** *Recommended: leave the precise count to the
   builder once the family/duplicate merges are built.*
5. **Markup QA — what happens when a title block cannot be blanked before sending a page image? ANSWERED.**
   Tim, 25 Sep 2026: *"Don't send; say so (Recommended)".* CE does not send that page to Claude and tells the
   user to tag that page's marks by hand.
6. **Markup QA — what counts as "the same item" across markup rounds for supersede-tagging?** *Recommended:
   position plus read content; anything uncertain becomes a new item, never a guessed supersede.*
7. **Markup QA — which "last version" does the engineer-drafted-changes compare use?** *Recommended: CE's own
   last stored comparison snapshot, falling back to the last issued revision, stated plainly either way.*
8. **Markup QA — does DATA-01's Gate 0 privacy block touch this card's AI-provider permission?**
   *Recommended: no — DATA-01 concerns the historical corpus, not a fresh page sent live under Tim's narrow,
   explicit, non-training UX-QA-05 permission; a builder should confirm this reading before building the send
   path.*
9. **Register/issue — does "one combined PDF" mean truly one PDF across every DWG in a multi-DWG job?
   ANSWERED.** Tim, 25 Sep 2026: *"One PDF, register order (Recommended)".* One combined PDF across the whole
   issue, sheets in register order.
10. **Register/issue — what counts as "a confirmed change" for revision-cloud placement?** *Recommended: any
    geometry/annotation change since the sheet's last issued snapshot, not limited to CE-made edits.*
11. **Register/issue — where does the office's revision-sequence convention (P/A vs a T-series) get set?**
    *Recommended: a Settings default, overridable once per job at first issue, then locked for that job.*
12. **Architectural background — which project folders should be read next for the evidence gate, and how many
    examples are enough?** Tim gave explicit permission 25 Sep 2026 for this chat to pick 2-3 recently completed
    jobs itself (*"Pick recent completed jobs"*); see the STRUC-ARCH-BACKGROUND card for the study this
    permission covered. *Recommended: two to three more jobs, spanning at least one single-DWG and one multi-DWG
    job; disagreement between examples is itself useful evidence, not something to resolve by picking one.*
13. **Architectural background — where does background preparation sit in the command flow?** *Recommended:
    folded into job setup, not a separate command a first-time drafter would have to know to look for.*
14. **Architectural background — does the cleanup pass re-run on every revised background, or only on a
    from-scratch rebuild?** *Recommended: only on a from-scratch rebuild; an overlaid/compared update re-aligns
    the already-cleaned background without re-stripping it.*
