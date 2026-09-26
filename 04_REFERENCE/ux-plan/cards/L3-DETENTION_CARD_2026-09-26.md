# L3-DETENTION workflow card — Level 3 proposal 3: detention and tank layout

**Job-mode refinement (UX-MODE-01..04, 26 Sep):** Civil job mode is set per job, suggested at setup, shown on
the CE panel and switchable; it never depends on the person's role. In **From markup / supplied design**,
detention and tank proposals follow the markup's instructions, while all options remain visible as suggestions.
Mark a conflicting option `differs from supplied design`; keep supplied sizes and layout until the particular
change is accepted. In **Design from scratch**, full detention proposals lead, with `Accept all` after preview.
From-markup changes are accepted individually, with no `Accept all`.
An extra drawn item is allowed and quietly listed as `Not in markup` (agree and remember, or remove). A late
markup offers a switch, keeps all drawn work and adds the QA list.

**APPROVED — plan only (26 Sep 2026).** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Level 3 proposal
3" territory — UX-L3-11..14 (detention/storage specifics), UX-L3-19 (visual proposals, "detention and storage
as well as the full design"), UX-L3-20 (chooser sketch approved) and UX-L3-21 (learned from previous jobs).
Read together with UX-L3-01/02 (scope and build order — this is build item (3), after L3-LEVELS and
L3-SOURCES, "after the approved calculations card") and the already-**APPROVED** D+F card
`04_REFERENCE\civil-D-F\DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md`, which this card builds on rather than
repeats. Remaining build details are OPEN. **IMPLEMENTATION CALL, not Tim's words:** “Draft” means the
calculation is not approved or not yet issued; show the reason plainly.

## 1. What Tim ruled, and what it builds on

1. **UX-L3-11 (options):** two or three storage options side by side, each with its storage, depth and the
   council rules checked (e.g. % underground); the user picks one, then adjusts.
2. **UX-L3-12 (location):** learned from past jobs, clash-checked against easements (including the implied
   1 m council-drain band, `UX-CR-03`), tree zones (`UX-SITE-01` TPZ/SRZ), footings and services — each clash
   shown.
3. **UX-L3-13 (complete system):** a complete system — orifice pit with its sized plate from the calculation
   (`CR-A3` round down, council minimum), overflow route and the OSD criteria block (`UX-CR-10`, always shows
   required and provided volume) — in one preview and one Undo.
4. **UX-L3-14 (unapproved calculation):** if the calculation is not approved, CE still proposes, with a "Draft:
   calculation not approved" banner in the preview and on the OSD block.
5. **UX-L3-19 (visual proposals), Tim verbatim: "can ce plugin show visual proposals for detention and storage
   as well as the full design".** For detention/storage (and the full layout, see `L3-NETWORK_CARD_2026-09-26.md`):
   the chooser shows each option as a picture of the plan (a small drawing of that option, with its key
   figures) side by side; selecting an option shows it as a full-size ghost in the real drawing (tank/pipes,
   orifice pit, overflow, labels); switching options swaps the ghost; differences are highlighted; nothing is
   drawn until Accept; one Undo.
6. **UX-L3-20 (chooser sketch approved), Tim: "Yes, that's it".** The approved reference look is
   [`PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg`](../PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg) (synthetic figures):
   three option panels side by side, each with a plan picture, storage/depth figures, a difference line and a
   clash line where relevant (its own example: "Clash: tree zone T2"); the selected option's full-size ghost
   appears in a real-drawing panel beneath, ending in Cancel / "Accept [letter]".
7. **UX-L3-21 (learned), Tim verbatim: "you need to learn proposals of detention from previous jobs and the
   best layouts".** Options are learned from CE's own previous jobs (drawing-intelligence evidence, local
   only), weighted toward the best layouts.
8. **UX-L3-22 (what makes a layout "best"):** Tim ticked three signals — **council approved first time** (no
   council RFI on the drainage, via the separate council-RFI reader `UX-RFI-01..03`); **least pipe length,
   excavation depth and number of pits** for the storage met; and **issued without later drainage redraws**
   (compared across issues). Explicitly **not** ticked: "you or an engineer marks it" — no manual "good
   example" flag is used. Learning stays local-only, no identifying data leaves the office (DATA-01).
9. **UX-L3-23 (options are combinations), Tim verbatim: "might be one detention pipe between p1 and p2 and
   then another between p2 and p3 or something like that and including pit detention".** A single option is not
   limited to one archetype: it can combine storage pipes across several pit-to-pit runs (sizes may differ)
   with detention-pit storage and tanks, totalled against the required storage. Each option card lists every
   piece — run, size, length, volume — and every pit counted as storage.

## 2. What works today — Keep / Modify / Missing

Read from `origin/master` at `bde0c9a9` in `C:\Lisp Files\CE_ACAD_PLUGIN` (26 Sep 2026). No client drawing,
client name or site address was opened.

1. **Two of the storage archetypes already exist as separate, working paths — Keep, the raw material for
   "options."** `Modules/Drainage/Commands/WaterTankCommand.cs` (`CDWT`) already places a water tank — Adopt or
   Insert from the master library, tank/tag/label/connection/riser/dropper written in one transaction, one
   Undo (CV4-11/CV4-15, 13 Sep 2026 ruling, "water tanks ONLY"). Separately, `DETENTION-PIT-ANNOTATE_CARD_2026-09-25.md`
   already describes giving an existing **pit** a real detention record so it counts toward the Pit Schedule
   and the OSD criteria block, reading storage from the pit's own footprint/levels via the already-wired
   `PitScheduleBuilder`/`DetentionTwlService`. UX-L3-11's "two or three options side by side" is these same
   archetypes (tank, pit-based storage, and a detention-pipe run) **proposed and compared before either
   existing command runs** — it does not replace CDWT or the pit-detention card; it chooses between them.
2. **A first-pass sizing orchestrator already exists — Keep, extend.** `Modules/Drainage/Services/AutoDesignService.cs`
   ("Pure, AutoCAD-free orchestrator for the end-to-end stormwater auto-design engine") already produces one
   complete first-pass `DesignProposal` (flows, storage, orifice, detention pipe, connection pipe) from site
   area, impervious area, council id and optional PSD, delegating to the same real services CV-02 already
   authorises — `RationalFlowService`, `DetentionSizingService` (Boyd's), `OrificeSizer`, `PipeSizingSolver`,
   `CouncilProfileService`. Today it names only two archetypes (`ArchetypeNoDetention`,
   `ArchetypeOsdWithOrifice`) and returns **one** proposal, not several side by side. UX-L3-11 needs this
   orchestrator extended to produce two-or-three archetype variants (e.g. storage-pipes / tank+pit / larger
   single pipe, matching the approved sketch's A/B/C) from the one set of inputs it already consumes — no new
   hydraulic engine, an extension of an existing one.
3. **% underground and other council storage rules are already Settings/council values — Keep.**
   `ENGINEERING_RULEBOOK.md` already carries a per-council "% underground" column (e.g. Glen Eira ≥50%,
   Boroondara 100%, Monash ≥60%, Mornington 50%, Casey/Frankston 50%) alongside PSD ARI, minimum orifice and
   pre-development C — this is exactly the "council rules checked" data UX-L3-11 needs, already sourced and
   already a Settings/council value under R-00. This card adds no new hard-coded percentage.
4. **Orifice rounding and the OSD criteria block are already correct and current — Keep.** `CR-A3` (25 Sep
   2026) already supersedes the old rounding direction: orifice plate size rounds **down** to the whole
   millimetre, never below the council minimum (`ENGINEERING_RULEBOOK.md` R-05/R-20). `UX-CR-10` (26 Sep 00:43)
   already rules the OSD criteria block **always** shows required and provided detention volume, from the same
   record as the computations sheet. UX-L3-13's "complete system" reuses both exactly as ruled — this card does
   not re-derive either number.
5. **The DF card's Apply-to-drawing preview is the right downstream step, already approved — Keep, sequencing
   note.** `DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md` §2.7 (Slice 3, APPROVED) already defines "one
   review shows before → after for every drawing object or new block... Apply to drawing runs only after this
   review, with one accepted operation giving one AutoCAD Undo" for a **single chosen** detention system.
   L3-DETENTION sits **upstream** of that: it chooses which system becomes the input to the DF card's own
   Apply preview. This card does not duplicate DF's Apply mechanism — once an option is Accepted here, it feeds
   the DF card's existing Apply path as the system reviewed there.
6. **Draft/unapproved-calculation wording already exists elsewhere in the same feature family — Keep the
   pattern, Missing the reuse.** The DF card §2.9 already puts **"DRAFT — NOT FOR CONSTRUCTION"** on the V3
   computations sheet until CDCALC's Issue step is pressed (`UX-CALC-03`, any CE user, named responsible
   engineer, recorded). UX-L3-14's "Draft: calculation not approved" banner is the same idea applied one step
   earlier, to this proposal's preview and the OSD block — reusing the DF card's existing draft-state wording
   convention rather than inventing new phrasing (see OPEN 4).
7. **Clash checking against easements and tree zones already exists as separate, approved warnings — Keep the
   pattern, Missing one combined check.** `UX-CR-03` (26 Sep 00:38) already rules a traced council drain gets a
   non-printing 1 m each-side "implied easement" band, and CE **already warns** if a footing, tank or pit sits
   inside it. `UX-SITE-01` (26 Sep 00:04) already has CE read the arborist PDF and list each tree's TPZ/SRZ
   radius, confirmed by the user. Neither exists today as one **combined** clash pass a detention-location
   proposal can run before showing an option — that combination, plus **footings and services** (for which no
   clash source or check exists in the codebase at all — confirmed: no `ClashCheck`/footing/service-clash
   service found), is genuinely **Missing**.
8. **The visual plan-picture chooser (UX-L3-19/20) — Missing, entirely new UI.** Nothing in the codebase
   renders a small "picture of the plan" per option today; `EditGhostPlan`'s existing dashed-ghost renderer
   (`GhostKind.Outline`/`Text`/`Leader`, 18 Sep 2026 ruling, used today only for pit-resize preview) is the
   right mechanism for the **full-size ghost in the real drawing** half of UX-L3-19 (switching options swaps
   the ghost), but the **side-by-side plan-picture panel** (the approved sketch's three boxes) is new — most
   plausibly a small isolated render of the same ghost geometry at panel scale, not a second drawing engine.
9. **Learning "best" from previous jobs — Missing, now scored by three named signals (UX-L3-22).** As with
   every Level 3 proposal, `SuggestionLedgerService` records signals but nothing reads them back yet
   (`UX-LEARN-01_CARD_2026-09-25.md`). UX-L3-22's three signals each need their own evidence, none of it built
   today: **(a) "no council RFI"** depends entirely on the separate, also-not-yet-built council RFI reader
   (`UX-RFI-01..03`, 25 Sep 2026, "List every item as a to-do... CE finds it in the job folder... a tab in
   Project Review") — confirmed no RFI-reading code exists (`git grep -i "\bRFI\b"` on `origin/master` finds
   only unrelated matches). **(b) "least pipe length, excavation depth and pit count"** is directly computable
   from each option's own totals once UX-L3-23's per-piece listing exists (§2.10) — the cheapest of the three
   signals to build, no external dependency. **(c) "issued without later drainage redraws"** needs a
   drawing-revision history comparison across issues, which is new — the closest existing piece is the DF
   card's own issue-record concept (§2.6) but nothing today compares one issue's drainage geometry against a
   later one. See OPEN 1 (build order) and OPEN 5 (RFI dependency) below.
10. **Combination options (UX-L3-23) — Missing, a real extension to the sizing model.** Today's
    `AutoDesignService` (§2.2) and the pit-detention/CDWT paths (§2.1) each describe **one** storage mechanism
    per proposal. UX-L3-23 needs an option to be a **set** of pieces — one or more differently-sized detention-
    pipe runs between named pit pairs (e.g. P1-P2, P2-P3), plus detention pits, plus tanks — totalled against
    the required storage volume, with every piece listed on its option card (run, size, length, volume) and
    every contributing pit named. This is a genuine data-model extension, not a UI-only change: today nothing
    represents "one option = several storage contributors totalled together."

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Missing.** No entry point exists yet. Recommended: the same shared Level 3 Proposals
   surface proposed in `L3-SOURCES_CARD_2026-09-26.md` OPEN 4, offered once the D+F card's calculation exists
   for the job (draft or issued — UX-L3-14 explicitly allows a draft-calculation proposal).
2. **Prompts — Missing.** New: confirm the site/impervious inputs already used by `AutoDesignService`
   (site area, impervious area, council, optional PSD) if not already set from CDDESIGN/CDCALC.
3. **Selection — not applicable.** Whole-job scope, matching CDCALC's own scope.
4. **Preview — Missing, per the approved sketch, extended for combinations.** Three (or two) option panels side
   by side — plan picture, total storage, depth, the council check result, a highlighted difference line and a
   clash line where relevant (UX-L3-11/12/20) — then the picked option as a full-size ghost in the real drawing
   (tank/pipes, orifice pit, overflow, labels), switching options swaps the ghost, ending Cancel / "Accept
   [letter]" exactly as the sketch shows. Per UX-L3-23, an option's panel additionally lists every contributing
   piece (each pit-to-pit run with its own size/length/volume, each contributing pit, each tank) rather than one
   single figure, when the option is a combination.
5. **Drawing output — Missing new writer, Keep the underlying commands.** Once accepted, the chosen option
   writes through whichever existing command matches each of its pieces — `CDWT` for a tank piece, the pit-
   detention path for each contributing pit, the ordinary pipe-drawing path sized per run for each detention-
   pipe piece (sizes may differ run to run, UX-L3-23) — feeding the DF card's own Apply-to-drawing preview
   (§2.5) for the orifice pit/overflow/OSD-block half, not a new independent writer.
6. **Cancel — Keep, unchanged principle.** No drawing change; matches the sketch's Cancel button.
7. **Escape — Keep, unchanged principle.** Closes the chooser without writing anything.
8. **One Undo — Missing, to be built to this shape.** Accepting one option's complete system (tank/pipes +
   orifice pit + overflow + OSD block) applies as one transaction, one Undo — UX-L3-13's explicit requirement,
   consistent with every other Level 3 proposal in this batch.
9. **Save/reopen — not applicable.** Accepted objects are ordinary drawing data, already covered.
10. **Where values come from (Settings/council) — Keep, unchanged.** % underground and every other council
    storage rule (§2.3), the orifice rounding rule (§2.4) and the OSD block's required/provided figures (also
    §2.4) are all already Settings/council-sourced; this card introduces no new hard-coded value. The
    footing/service clash source (§2.7) will need a Settings-defined "what counts as a service/footing layer"
    entry, per R-00 (see OPEN 3).

## 4. Example drawings

1. **DWG-A or DWG-B (Civil) with a completed or draft D+F calculation**, enough site/impervious/council data
   for `AutoDesignService` to produce a first-pass design, to exercise the three-option chooser end to end.
2. **A variant with a tree's TPZ/SRZ overlapping one candidate location and a council drain's 1 m easement band
   overlapping another**, to exercise UX-L3-12's clash display (matching the sketch's own "Clash: tree zone
   T2" example) without inventing a fresh scenario.
3. **A variant where the D+F calculation is still Draft (not Issued)**, to exercise UX-L3-14's banner.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated (proposed, not run for this card):**
   - Extend `AutoDesignService`'s existing synthetic-input tests with a case asserting two-or-three distinct
     archetype proposals from the same inputs, each carrying its own storage/depth/council-check result.
   - A clash-check test combining the existing easement-band logic (`UX-CR-03`'s pattern) and TPZ/SRZ radii
     (`UX-SITE-01`'s pattern) against a synthetic footing/service layer, asserting each clash is named, not
     merely a pass/fail flag.
   - A `ChangePlan`-family test proving Accept writes tank/pipes + orifice pit + overflow + OSD block as one
     transaction, one Undo (shared test shape with the other Level 3 cards).
   - A combination-option test (UX-L3-23) proving two differently-sized pit-to-pit runs plus a detention pit
     total correctly against the required storage, and that every piece appears on the option card.
2. **Tim's AutoCAD checklist (nothing else proves this):**
   - Open DWG-A. Run the detention proposal. **Right result:** three option panels, each with a plan picture
     and its own storage/depth/council-check figures, matching the approved sketch's layout.
   - Select each option in turn. **Right result:** the real-drawing ghost swaps to match, nothing is drawn.
   - Open the clash variant. **Right result:** the option overlapping the tree zone or easement band shows its
     specific clash text (not a generic warning), consistent with UX-CR-03/UX-SITE-01's existing wording style.
   - Open the Draft-calculation variant. **Right result:** "Draft: calculation not approved" appears on the
     chooser and would appear on the resulting OSD block.
   - Accept one option, then Undo once. **Right result:** the tank/pipes, orifice pit, overflow and OSD block
     all revert together.

## 6. Slices — smallest first

1. **Slice 1 — multi-archetype sizing.** Extend `AutoDesignService` to return two-or-three archetype
   `DesignProposal`s from one input set, each carrying its own council-rule check (% underground etc.), no UI
   yet (UX-L3-11).
2. **Slice 2 — combined clash check.** One pass combining the existing easement-band and TPZ/SRZ checks plus a
   new footings/services check (Settings-defined layers, OPEN 3), returning named clashes per candidate
   location (UX-L3-12).
3. **Slice 3 — plan-picture + real-drawing ghost chooser.** Build the three-panel UI to the approved sketch,
   feeding `EditGhostPlan` for the real-drawing ghost and a panel-scale render of the same geometry for the
   plan picture (UX-L3-19/20).
4. **Slice 4 — complete-system Accept, one Undo.** Wire Accept to write the chosen archetype's tank/pipes plus
   feed the DF card's existing orifice-pit/overflow/OSD-block Apply preview, as one transaction (UX-L3-13).
5. **Slice 5 — Draft banner.** UX-L3-14's banner, reusing DF's existing wording (§2.6).
6. **Slice 6 — combination options.** Extend the option data model so one option totals several pit-to-pit
   detention-pipe runs plus detention pits plus tanks, with every piece listed on the option card (UX-L3-23).
   Builds on Slices 1 and 4; needed before Slice 7's "least pipe/depth/pits" scoring can compute anything.
7. **Slice 7 — learned "best" weighting.** UX-L3-22's three signals, built in order of what they depend on:
   (b) least pipe/depth/pit-count first (computable from Slice 6's own data, no external dependency); then
   (c) issued-without-redraws (needs the new revision comparison, OPEN 4); (a) no-council-RFI last, since it
   depends entirely on the separate, also-unbuilt council RFI reader (OPEN 5).

## 7. OPEN questions, each with a recommended answer

1. **OPEN — build-order dependency, not a ruling gap.** UX-L3-22 has now answered "how is best judged" (three
   ticked signals, §1.8) — this replaces the card's earlier OPEN question. What remains open is sequencing:
   Slices 1-6 need no "best" ranking at all (every option is shown, the user picks), so *recommended:* build
   the chooser and combination model first and add the three scoring signals in Slice 7, in the dependency
   order set out there — not because the rule is unsettled, but because two of the three signals need data
   this card doesn't otherwise produce (OPEN 4, OPEN 5).
2. **OPEN — which two-or-three archetypes does `AutoDesignService` propose for a given site?** Today it names
   only `ArchetypeNoDetention`/`ArchetypeOsdWithOrifice`; the approved sketch shows three (storage pipes / tank
   + pit / larger pipe). *Recommended:* seed a fixed short list (pipe-based, tank-based, pit-based) and let each
   candidate's own feasibility (space, council %, clash) decide which two-or-three actually appear for that
   site, rather than always showing the same three regardless of fit.
3. **OPEN — what counts as a "service" or "footing" for the new clash check?** No such classification exists
   in the codebase today. *Recommended:* a Settings-held list of recognised layer/block-name patterns (footing
   outlines, service trenches/pits from a services background), confirmed per job the same way `UX-SITE-04`
   already confirms background-derived slab outlines — consistent with R-00, not a fixed guess.
4. **IMPLEMENTATION CALL — Draft state.** “Draft” means not approved or not issued. Reuse the D+F sheet's
   **DRAFT — NOT FOR CONSTRUCTION** wording and say which state is missing; do not imply an issued sheet is
   engineer-approved merely because someone pressed Issue.
5. **OPEN — what does "issued without later drainage redraws" (UX-L3-22, signal c) actually compare?** No
   revision-to-revision drainage-geometry comparison exists today. *Recommended:* compare each issued
   revision's stored drainage geometry (pipes/pits/detention) against the next issued revision for the same
   job — a redraw is any material geometry change between two Issue events (reusing the DF card's own Issue
   record, §2.6) — never a comparison against an un-issued working draft, which would unfairly penalise normal
   in-progress editing.
6. **OPEN — UX-L3-22's "no council RFI" signal depends on a separate, also-unbuilt feature (the council RFI
   reader, `UX-RFI-01..03`).** This card cannot deliver that signal on its own. *Recommended:* build Slice 7's
   scoring in the order given (pipe/depth/pits first, redraws second, RFI last) so this card's own value does
   not wait on the RFI reader's build; when the RFI reader lands, wire it in as an additive fourth-priority
   signal rather than blocking this card until then.
