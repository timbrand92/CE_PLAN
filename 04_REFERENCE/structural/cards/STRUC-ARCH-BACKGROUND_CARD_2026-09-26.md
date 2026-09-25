# Shared Civil + Structural architectural background preparation — command card (draft, 26 Sep 2026)

**Shared Civil + Structural scope, UX-XREF-01..03 (Tim, 26 Sep 2026).** Both disciplines prepare an architectural
Xref through this workflow. Civil has its own colour/visibility preset, to be learned from past Civil drawings.
Changed backgrounds are offered for comparison in both disciplines; broken paths are offered for repair on
opening. The evidence gate below now includes Civil jobs. Only generic findings may enter this repository
(DATA-01).

Tim's answers: UX-XREF-01 *"Notice and offer compare (Recommended)"*; UX-XREF-02 *"Same workflow
(Recommended)"*; UX-XREF-03 *"Offer to repair (Recommended)"*.

**Status:** DRAFT — **planning only; real prepared Xrefs must be studied before any behaviour in this card is
built.** Priority set by Tim 25 Sep 2026 (UX-STRUC-06: background preparation is the third drawing-journey stage
tackled after D1, after QA against the markup and register/revisions/issue). Behaviour framed by the 14 Sep 2026
rulings (`STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, "Batch 1", "Batch 2", "Detail-library decisions",
"Representative completed job", "Direct DWG inspection" and "Xref placement follow-up" sections), plus a second,
filesystem-level-only reading of three more completed jobs on 25 Sep 2026 under Tim's explicit permission
(`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural cards": *"Pick recent completed jobs"*) — see
section 4 items 6-9. **Nothing here is built.** No code starts until Tim approves this card, and this card
itself says plainly that its own approval cannot authorise any general behaviour until the evidence gate's
DWG-content half (item 9) is also satisfied. This is journey stage 2 of 7 (`areas\structural.md` UX plan note).
**Read from:** `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`,
`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, and the shipping code on `claude/struc-d1-prep`
(`Modules/Structural/Commands/ArchitecturalChangeReviewCommands.cs`,
`Modules/Structural/Services/DrawingIntelligence/ArchitecturalChangeReviewCommandRunner.cs`).

---

## FOR TIM

### 1. What this card covers

1. **The start of a Civil or Structural job:** turn the architect's DWG into a clean, aligned, correctly
   coloured Xref background before drawing pits, beams or other discipline work.
2. **Why this is last of the three priority stages, not first:** the 14 Sep record is explicit that the exact
   cleanup rules, level-separation rules and colour-override rules **must be learned from actual prepared
   Xrefs**, not invented from a general description. One example job was read once, read-only, on 14 Sep — that
   is not enough evidence to build a general rule from, and this card says so rather than guessing.
3. **What this card asks for before code:** which further real, representative job folders can be read the same
   safe, read-only way, so the cleanup and alignment rules are learned from your actual jobs rather than assumed.

### 2. What works today, in drawing terms

1. **LU already sets up some layers.** It is your existing tool for preparing a new drawing's layers, and the
   14 Sep record already flags it as a Modify/reuse candidate needing improvement — not something this card
   replaces.
2. **CEARCHREVIEW exists, but it is a narrow research probe, not a working tool.** Reading its own code
   comment: *"the flow has no selection, discovery or persistence route: exact locators can arrive only through
   the drawing-external receipt boundary."* In plain terms: it can only check one Xref occurrence someone has
   already told it about by hand, against a saved reference — you cannot point it at a drawing and ask "how is
   this Xref set up." It does not select, discover or remember anything, and makes no drawing changes. It is the
   first slice of a much later, governed capability, not today's background-prep tool.
3. **Nothing else exists yet:** no template/background two-stage workflow, no automatic job-number/address pickup
   from the project folder, no cleanup pass on the incoming architectural DWG, no placement/alignment preview,
   no colour-override or level-separation logic, no whole-plan-movement command.
4. **What has been learned, from exactly one job, read-only, 14 Sep 2026** (kept here for reference, not as a
   rule to build from): that job used **six separate Xref overlay insertions** of the same one source Xref file
   (Site, Ground Over, Ground Under, First Over, Roof, and a plain unnamed one), each with its own clip and its
   own host-layer colour overrides on four architectural layers, plus one additional linked detail Xref. Paired
   overlay insertions sat 50,000 drawing units apart on the Y axis. This is **one job's pattern, not a confirmed
   office convention** — the record is explicit that a single example cannot establish a universal rule.

### 3. Tim's intended result, in his own words and rulings — 14 September 2026

1. *"Start with a template Xref drawing to prepare architectural backgrounds... Once prepared, copy/Save As a
   drawing template from the same folder into the project folder, insert Xrefs with colour overrides for
   particular plans and levels, then supply the drawing to the engineer."* A two-stage workflow: prepare the
   background once, then bring it into the live project drawing.
2. CE should understand context from the drawing's contents and whether the Xref drawing is being updated or
   drafted directly — never forcing a rigid New/Continue choice, and never silently resetting project state.
3. Job number and address come automatically from the project folder; client is optional; drawn/designed/checked
   by is entered once with later editing available. Shared project metadata, reused from the one shared
   authority — never a second, Structural-only copy.
4. Prepare layers, text/dimension styles, units and scales — LU already does some of this and needs improving
   (not rebuilding from nothing).
5. **Architectural input is a DWG; clean it to suit CE drawings before proceeding.** PDF is not the normal
   architectural-input route.
6. Help with background placement, scale and alignment, with you confirming alignment — never an unconfirmed
   automatic placement.
7. Both single-DWG and multiple-DWG job arrangements must be supported — no universal one-DWG rule.
8. Sheet setup evolves constantly through the job; support adding, reordering and changing sheets throughout,
   not a one-time setup screen.
9. A job-type starting sheet list is fine as an optional, editable suggestion — never a mandatory fixed set.
10. **Constant register updates and each page's revision/date are a major repetitive frustration** (this hands
    straight to the register/issue card — the two stages meet here).
11. Remove architectural content not needed for engineering, but keep walls, stairs, shower bases, bathtubs,
    landscaping, fences, windows and doors — *"Tim asks for review of actual Xrefs to understand the rules."*
    This retained-content list is illustrative, not a permission to auto-delete every other category.
12. Level separation, and plan/level colour overrides, **must be learned from how actual drawings are set up**
    — never assumed to be separate files, separate regions, or any one convention.
13. Supply the engineer with a plotted PDF of the full current plan set (not just the active sheet); the engineer
    returns marked-up or sketched PDFs, or sometimes drafts directly — both input paths must be supported.
14. Revised architectural backgrounds are overlaid and compared, adjusted, or rebuilt from scratch, **depending
    on the extent of change** — no automatic threshold decides which.
15. Alignment reference may be a building corner, grid intersection or boundary — any of these is valid, not one
    mandated type.
16. Repositioning the whole plan should offer to move both backgrounds and the associated structural drafting
    together — an explicit whole-plan operation, not silent propagation of every individual edit.
17. Replacing a revised background previews the alignment against the existing version before applying it, with
    your confirmation.
18. Whole-plan movement, once triggered, includes backgrounds, structural objects, labels, dimensions, the plan
    title **and hatches** together, with preview and editable inclusion.

### 4. The evidence gate — what has to happen before this card can leave "planning only"

**Civil included (UX-XREF-02, 26 Sep):** the example-job study must include prepared backgrounds used by
Civil drawings as well as Structural drawings. Learn the Civil colour/visibility preset from those examples;
do not copy the Structural preset by assumption. Read-only study only, generic findings here, no client
name, site address, job identifier or private drawing content in this repository (DATA-01).

This is the one thing this card asks Tim to help move, not a normal Open question — it blocks everything else in
section 6.

1. **What is needed:** two to three more representative, already-completed Structural project folders (in
   addition to the one already read 14 Sep), each containing — as a minimum — a prepared architectural Xref DWG,
   the host Structural drawing that references it (to see the colour overrides and viewport setup in place), and
   ideally the original, unprepared architectural DWG the Xref was cleaned from. A plotted plan-set PDF from each
   job, if available, helps confirm what "ready for the engineer" looks like.
2. **How it gets read, safely:** exactly the same way the one 14 Sep example was read — read-only, headless (no
   AutoCAD launch, no drawing save), via the already-installed ACadSharp library or `accoreconsole`, with a
   SHA256 check before and after confirming nothing changed. No new script, project or build is authorised by
   this card; if the existing read-only approach needs changing, that itself needs Tim's approval first (per the
   AGENTS.md build-script rule).
3. **Where the job folders live:** Tim's own OneDrive project structure, already mapped in memory
   (`office-folder-map.md`) — real client folders, never copied into a repo, never opened in a way that writes
   anything back. The project folder path, job number and site address stay local-only (DATA-01); only the
   anonymised pattern (layer names, overlay counts, colour numbers, relative folder structure) is recorded here
   or in any workflow card.
4. **What each new example should confirm or correct:** whether the "six overlay variants of one source Xref"
   pattern from the first job is common office practice or specific to that job; what the level-separation rule
   actually is (separate files? separate regions in one file? something else?); what triggers a colour override
   on a given layer; and what the retained/removed content list (item 3.11) actually looks like once someone who
   knows architectural cleanup reviews real examples against it.
5. **Until this is done:** this card can be approved as a *plan* — the shape of the workflow, the Keep/Modify/
   Missing classification, the full-experience walk-through below — but the cleanup, alignment and colour-
   override *rules* inside it stay Unknown, not zero, and no code implementing them may start.

**Second reading — 25 September 2026** (Tim's permission, `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`,
"Structural cards": *"Pick recent completed jobs"*). Three more completed Structural jobs were read the same
safe way as the 14 Sep example — read-only, no AutoCAD launch, no drawing save, nothing copied into any
repository — but this round stayed at the **filesystem level only**: folder listing, filenames, sizes and dates.
No DWG was opened or parsed this round. Job identities, folder paths, addresses and job numbers stay local-only
(DATA-01); only the anonymised pattern below is recorded.

6. **What the three jobs were, in general shape (no identifying detail kept):** one single-dwelling job using
   one host Structural drawing with a single combined Xref file, carried through six formal revisions to a fully
   issued state and quiet for roughly ten months since; one mixed Civil-and-Structural job using one host drawing
   per discipline (not per sheet), reaching a "CONSTRUCTION ISSUE" revision and quiet for about two months; and
   one staged multi-dwelling job using one Structural drawing **per sheet** (three separate sheet files) plus its
   own title-block reference drawing, reaching a later lettered revision under an explicit "STAGE 1" label and
   quiet for about five weeks. All three show no activity since their last issue — the same completion signal the
   14 Sep example used.
7. **What this confirms or corrects about the 14 Sep pattern:** the "one source Xref file inserted six times with
   six clips/colour overrides" pattern from the 14 Sep job was **not** seen in any of these three. Each used
   either one single combined Xref file for the whole job, or — in a handful of other, still-active (not yet
   completed) job folders skimmed for comparison only, not counted among the three completed examples — **several
   separate Xref files, one per architectural level or plan type** (a ground-floor file, a first-floor file, a
   roof file, a site file, kept as distinct DWGs in the same Xref folder rather than one file referenced multiple
   times). **This settles the card's own first evidence question in part:** the six-overlay-of-one-file pattern is
   confirmed as one job's own arrangement, not a universal office convention — but it also shows there are at
   least **two** different real conventions in use (one combined file; several per-level files), not one single
   alternative to swap in its place. Which convention a given job uses did not correlate obviously with
   single-DWG-vs-multi-DWG structural drafting in this small sample (the completed single-DWG jobs used one
   combined file; the still-active multi-DWG jobs skimmed for comparison used several per-level files) — too
   small a sample to call that a rule either way.
8. **What else this reading found, unprompted:**
   - **The "Architectural" handoff folder is not a one-time drop.** On every job read this round it held a
     *sequence of dated subfolders* spanning the life of the job (an initial pricing/quote set, then a CAD issue,
     then one or more markup or "updated" packages, sometimes a late-stage detail package) — confirming Tim's 14
     Sep point that revised backgrounds arrive over time, and showing concretely that "arrives over time" means a
     growing dated history sitting beside the live Xref, not a single overwritten file.
   - **A "Superseded" folder (structural output) and a separate "Superseeded Xrefs" folder (inside Xref) both
     exist on every job, but are not both used on every job.** Two of the three completed jobs never populated
     "Superseeded Xrefs" at all — the background was prepared once and never replaced for the life of the job.
     The third had used it once, with the *entire* prior Xref file (and its own backup) moved there wholesale
     when a later background replaced it — a whole-file swap, not a partial or diffed update.
   - **CE's own title-block drawing is itself kept as an Xref**, sitting in the same Xref folder as the
     architectural background on at least one job — the folder is not purely "architectural content," and any
     future cleanup/organisation rule needs to tell CE's own reference drawings apart from the architect's.
   - **The Xref folder is not always purpose-pure.** On one job it also held unrelated reference material dropped
     in alongside the actual background file — a council standard-detail PDF and a couple of screen captures. A
     build should not assume every file inside "Xref" is the background.
   - **A small sidecar checklist file from an existing office tool** was found alongside one job's Xref DWG. Its
     recorded checklist categories are: **"XREF Creation", "Double Storey", "Double Storey with Basement",
     "Civil", "Civil Basement".** This is a genuine finding worth its own follow-up: an **existing, named "XREF
     Creation" checklist type already exists in office tooling**, and on the job read it had not been opened (no
     checklist type was selected). Before specifying this card's cleanup rules from scratch, a builder should
     locate and read that existing checklist template — it may already encode office knowledge this card is
     trying to rebuild.
9. **Is the evidence gate satisfied yet? No — only partially.** This reading answers the **organisational** half
   of item 4 above (single file vs several per-level files; how the architectural handoff arrives over time; how
   superseding actually happens on disk) from real, generic, filesystem-level evidence across three more completed
   jobs, on top of the one from 14 Sep. It does **not** answer the **content** half — the actual colour-override
   values, which layers get overridden and why, the real level-separation mechanism inside a multi-insertion or
   multi-file DWG, or the retained/removed content list (item 3.11) — because that needs the DWG's own internal
   structure read, the same ACadSharp-based method item 2 above describes, which this round's scope deliberately
   did not use (list-only, no DWG content parsing). **What is still needed:** one more read at the same depth as
   14 Sep's (headless, SHA256-verified, ACadSharp or `accoreconsole`) against at least one of the "several
   separate Xref files" jobs, to see whether that convention still uses per-layer colour overrides the way the 14
   Sep job did, or something else — and, separately, someone who knows architectural cleanup reviewing real
   drawings against the retained/removed content list (item 3.11), which a folder listing alone cannot settle.

### 5. Keep / Modify / Rebuild / Missing

1. **LU (layer/style/unit/scale setup) — Modify.** Reuse and extend; do not replace. Exact shortcomings still
   need real examples (item 4 above) before the extension is specified.
2. **CEARCHREVIEW — Keep as the first governed slice; not this card's tool.** It stays exactly as the narrow,
   read-only, receipt-based probe it is today. This card's background-prep workflow is a separate, much larger
   piece of work that may eventually share its underlying safe-read approach, but CEARCHREVIEW itself is not
   rebuilt or extended by this card.
3. **Two-stage template-then-project workflow — Missing.** New, and blocked on the evidence gate (section 4).
4. **Job metadata auto-fill from the project folder — Missing.** New; likely shares the same "one shared project
   authority" the register/issue card already reads from CE Sheets — confirm the owner before building a second
   metadata reader.
5. **DWG cleanup pass — Missing.** New, and squarely blocked on the evidence gate: the retained/removed content
   list (item 3.11) is explicitly illustrative, not a spec, until real examples confirm it.
6. **Placement, alignment and preview — Missing.** New; the alignment-reference flexibility (item 3.15) and
   whole-plan-movement scope (items 3.16-3.18) are already ruled, so this piece can be designed now even though
   it cannot be built until the cleanup rules it sits alongside are evidenced.
7. **Colour-override and level-separation logic — Missing, and explicitly not to be generalised from one
   example.** This is the piece most directly blocked by section 4.
8. **Engineer handoff (plotted full-set PDF out; markup PDF or direct draft back in) — Missing**, but shares
   infrastructure with the register/issue card's combined-PDF work and the Markup QA card's markup-reading and
   drawing-to-drawing compare work — sequence with both rather than building a third PDF/compare path.
9. **Revised-background overlay/compare/rebuild — Missing.** New; depends on the same comparison thinking as the
   Markup QA card's UX-QA-08 (drawing-to-drawing compare) — likely the same underlying engine applied to
   backgrounds instead of structural content.
10. **Civil colour and visibility preset — Missing.** Learn it from past Civil drawings under DATA-01, confirm
    the generic pattern and hold editable values in Settings (R-00). The Structural preset is not assumed to
    work for Civil.
11. **Changed Xref notice and impact compare — Missing.** When an architectural background changes, offer
    comparison with its previous version in Civil and Structural drawings. Highlight changed areas and their
    possible effects on pits, beams and levels; ask for review. Nothing moves on its own (UX-XREF-01).
12. **Broken-path repair — Missing.** On opening a drawing after a folder move, list broken Xref paths and
    preview each proposed relative path. One click applies only the confirmed repairs (UX-XREF-03).

### 6. The full experience (design only — build waits on section 4)

1. **Where you start:** a new or continuing Civil or Structural job; CE reads the drawing's own contents to tell whether
   this is a fresh background-preparation pass or continued work on an existing one, rather than asking you to
   choose New/Continue up front.
2. **Trigger:** part of job setup, alongside the job-metadata auto-fill; not yet assigned a ribbon location in
   this card (see Open question 2).
3. **Prompts:** confirm the auto-filled job number/address; confirm which architectural DWG to prepare from;
   confirm the alignment reference point (corner, grid intersection or boundary — your choice, not CE's).
4. **Selection:** the architectural DWG(s) to bring in; single or multiple, per your job's own arrangement.
5. **Preview:** the cleaned background shown against the project drawing before anything is placed; alignment
   preview before a revised background replaces an earlier one.
6. **Drawing output:** the prepared Xref insertion(s), with their colour overrides and clips, on the project
   drawing — exact mechanics depend on the evidence gate.
7. **Cancel / Escape:** leaves the project drawing unchanged; a cancelled cleanup pass touches nothing.
8. **One Undo:** placing or replacing a background, and any whole-plan move that follows it, is one Undo step
   (consistent with the 14 Sep whole-plan-proposal rule).
9. **Save/reopen:** the prepared background, its alignment and its source reference survive a reopen, exactly as
   any other Xref does today, plus whatever CE-specific override/clip record this card adds.
10. **Settings:** the retained/removed content categories and any office-wide colour-override convention belong
    on the Settings page once they are confirmed by real examples (R-00) — never hard-coded ahead of that
    confirmation.
11. **Discovery:** part of job setup, so it should be hard to miss at the start of a job — exact ribbon/menu
    placement is Open question 2.
12. **Changed or broken Xref:** on opening, show a quiet notice of the changed background or broken path.
    **Compare** highlights old versus new and names affected pits, beams and levels in the current discipline;
    no drawing object moves. **Repair paths** previews every old and proposed relative path, then applies the
    confirmed set with one click. Cancel/Escape leaves paths and the drawing as they were; save/reopen keeps
    the confirmed relative paths and reviewed comparison state.

### 7. Example drawings and checklist

1. **No real client Xref may be used as a fixture — ever.** Test material must be a fabricated example that
   mirrors the *pattern* learned from real jobs (once section 4's evidence gate has enough examples to describe
   a pattern) without containing any real address, job number or architect's actual drawing content.
2. **Test drawing set DWG-S4 (to be built once section 4 has enough evidence):** a made-up "architect's" DWG
   with walls, stairs, a window/door set, landscaping and fencing (the illustrative retained-content list, item
   3.11) plus some content that should be stripped, referenced from a made-up host drawing with at least two
   overlay uses and at least one deliberate colour override — enough to exercise the cleanup and alignment logic
   without being any real job.
3. **Automated guard (once buildable):** the cleanup pass keeps every item on the confirmed retained-content list
   and removes only what real-example review confirms should go — tested against the fabricated fixture, not a
   real drawing.
4. **Automated guard:** placement/alignment never proceeds without your explicit confirmation step — a headless
   test can assert the command halts and asks, it cannot assert the alignment "looks right" (that stays a human
   check).
5. **Tim's AutoCAD checklist, once built:** deferred until section 4's evidence gate is satisfied and section 6
   has moved from design to a real build — this card does not hand you a checklist for work that cannot start
   yet.

### 8. Slices, smallest first

1. **Slice 0 — the evidence gate itself (section 4).** Not code: reading two to three more real project folders
   read-only, and writing what is learned back into this card (or a successor) as confirmed pattern, separated
   plainly from the one-job pattern already on record. Nothing else in this card can start before this.
2. **Slice 1 — job metadata auto-fill**, once the shared-project-authority question (section 5, item 4) is
   answered; the least dependent on the evidence gate, since it reads folder/job data, not architectural
   content.
3. **Slice 2 — placement, alignment and preview**, using the alignment-reference and whole-plan-movement rules
   already settled 14 Sep (items 3.15-3.18) — buildable once slice 0 confirms enough about typical Xref
   structure to know what is being aligned.
4. **Slice 3 — the cleanup pass**, once slice 0's evidence confirms the retained/removed content rules.
5. **Slice 4 — colour-override and level-separation logic**, the most evidence-dependent piece; last.
6. **Slice 5 — engineer handoff and revised-background compare**, sequenced with the register/issue card's
   combined-PDF work and the Markup QA card's compare engine (section 5, items 8-9).
7. **Slice 6 — Civil preset and shared change notice.** Add Civil examples to the read-only study, derive a
   separate editable Civil colour/visibility preset, then offer old/new comparison in either discipline with
   pit, beam and level impacts named; no automatic move.
8. **Slice 7 — path repair.** Detect broken paths on open, preview each proposed relative path, apply confirmed
   repairs with one click, and preserve them after reopen.

### Open questions

1. **Which specific project folders should be read next for the evidence gate, and how many is "enough" before
   a pattern counts as a confirmed office convention rather than one more example? PARTIALLY ANSWERED 25 Sep
   2026.** Three more completed jobs (one single-DWG, one multi-discipline single-DWG-per-discipline, one
   multi-DWG per-sheet) were read at filesystem level — see section 4 items 6-9. They confirm both single-DWG
   and multi-DWG jobs exist, and that a "combined Xref file per job" organisation is real on completed jobs of
   both shapes, while other (still-active) jobs skimmed for comparison show a genuinely different "several Xref
   files, one per level" convention — so at least two conventions are real, not one to swap in place of the 14
   Sep job's pattern. *Still open: whether "several files per level" is itself a completed-job norm or an
   in-progress-only pattern, and the DWG-content-level questions (colour-override triggers, level-separation
   mechanism) item 9 above says are not yet answered — recommended next step is one ACadSharp-depth read of a
   "several files per level" job, per item 9.*
2. **Where does background preparation sit in the ribbon/command flow — its own command, or folded into job
   setup alongside CESETTINGS/CEPROPS?** *Recommended: folded into job setup, since item 3.2 explicitly wants CE
   to read context rather than make you choose a separate command, and a first-time drafter is unlikely to know
   to look for a standalone "prepare background" command.*
3. **Does the cleanup pass ever run again later in the job** (for a revised background, item 3.14), or is
   cleanup a one-time step and only alignment/compare repeats? *Recommended: cleanup runs again only when a
   background is rebuilt from scratch (the "extent of change" threshold in item 3.14); an overlaid/compared
   update reuses the already-cleaned background and only re-aligns, so the same content is not re-cleaned and
   potentially re-stripped every time.*

---

*Everything below this line is for the builder. Nothing below needs Tim to read, decide or do anything.*

---

## For the builder

### Pinned source (read 26 Sep 2026)

1. **Shipping Structural line:** `origin/claude/struc-d1-prep`, tip `0945bdf6`.
2. **CEARCHREVIEW:** `Modules/Structural/Commands/ArchitecturalChangeReviewCommands.cs`,
   `Modules/Structural/Services/DrawingIntelligence/ArchitecturalChangeReviewCommandRunner.cs` — confirmed by
   direct read: `Execute` has exactly four outcomes (`Observed`, `Unknown`, `Refused`, `Cancelled`), no
   selection, no discovery, no persistence; `Read` only runs against a pre-supplied, already-approved external
   receipt (`GetApprovedReceipt`); the class's own comment names it "the first governed CEARCHREVIEW slice."
   Registered in the command registry with an empty group/subgroup (falls into the ungrouped 27, per the ribbon
   card's section "For the builder" item 8).
3. **14 Sep evidence source:** `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, "Representative completed job — first
   bounded review" and "Direct DWG inspection — 14 September follow-on" sections. The DWG read there used
   ACadSharp 3.4.29 in memory via PowerShell, SHA256-verified before/after, no AutoCAD, no drawing save, and
   produced private local evidence (`dwg-structure.json`, `xref-clips.json`, `viewport-colour-records.json`,
   `viewport-handles.json`) kept out of any repository. Reuse this exact method for the evidence gate (section
   4) unless Tim approves a different one.
4. **LU:** not separately re-read for this card; `areas\structural.md` item under "Items and status" already
   names it a needs-improvement candidate — read its current source before specifying the extension in slice 1.
5. **Shared-owner question (section 5, item 4):** the 14 Sep "Area ownership" table names "Job Coordination" as
   the owner of "project folder identity and editable project metadata through existing shared project
   authority" — confirm which module/service that is today (likely the same one the register/issue card's CE
   Sheets manifest reads job number/address from) before building a second reader in this card.

### Automated guards to write with this card

1. **Slice 0 only:** the read-only evidence pass leaves every inspected DWG's SHA256 unchanged (already the
   established pattern; re-run for each new example folder, not a new guard to invent).
2. **From slice 1 on:** every guard listed in sections 6-8 above depends on the evidence gate; do not write a
   guard that encodes a rule from the single 14 Sep example as if it were confirmed office-wide.
3. **Fixture discipline:** any automated test fixture for this card is built from the fabricated DWG-S4 pattern
   (section 7), never copied or derived from a real project folder's actual geometry.

### Open dependencies before a builder starts

1. The filesystem-level half of Open question 1 is now done (three more jobs read 25 Sep 2026, section 4 items
   6-9, under Tim's standing permission to pick the jobs). Still needed: one ACadSharp-depth (DWG-content) read
   of a "several Xref files per level" job (section 4 item 9), and someone who knows architectural cleanup
   available to review what comes back (section 4, item 4 — content classification is a drafting judgement call,
   not something a read-only DWG parse alone can settle).
2. The shared job-metadata authority question (section 5, item 4) — needed before slice 1.
3. The Markup QA card's drawing-to-drawing compare engine (UX-QA-08) landing before this card's slice 5.
4. The register/issue card's combined-PDF and engineer-handoff work, sequenced alongside this card's slice 5
   rather than duplicated.
