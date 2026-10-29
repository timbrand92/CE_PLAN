# CE V3 — Overall Plan and Questionnaire Map

**6 September 2026 — CE drawing-production scope approved:** [shared delivery plan](DRAWING_PRODUCTION_PLAN.md), [all 44 audit items](DRAFTING_DELIVERY_REGISTER.md) and [Manager plan](MANAGER_PRODUCT_PLAN.md). Tim's objective is established CE drawings, faster production, better coordination and less user effort. Civil and Structural extensions now give implementation approach and acceptance. Reuse existing evidence and previous answers first; see the shared plan for the newer recorded 31-project/300-roster evidence position and scoped local-access clearance. Scope inclusion is not runtime completion.

**Structural Level 3 direction — 5 September 2026:** [Project understanding with the speed of 2D](STRUCTURAL_LEVEL3_PLAN.md).
Tim approved completing/publishing this Revit-inspired planning extension: connections, sections, engineering
proposals, presentation, revisions and plotting. Detailed defaults/questions remain labelled; Civil + Manager
delivery stays first. This is separate from Civil C6 and the existing Structural S1–S3 pilot.

**Start here, Tim / Claude / Codex.** This is the whole-program overview: what we are building,
how the questionnaire decisions fit together, and which documents contain the exact answers.

**Looking for the screens? Jump to the [consolidated UI plan, window map and visual references](#ui-plan).**

**Reconciled:** 4 September 2026, from repository `master` at
`bd81ae6993e169c84dccde73277daa12b13dfd43` and its linked approved records.
This overview adds no engineering decisions, implementation permission or acceptance claims.
It summarises the sources; it does not replace or rewrite their original answers/refinements.

## 1. The result we are building

**One professional CE AutoCAD product for Civil, Structural and shared work — preserving sound
tools, fixing their shared foundations, and progressing toward coordinated design and drawing
proposals that engineers check before issue.** This is much more than a new ribbon or prettier dialogs.

```text
Project inputs + approved engineering rules + approved CE standards
                              |
              One trusted drawing/project model
                              |
       Civil workflows + Structural workflows + clear editors
                              |
          Coordinated plans, details, schedules and checks
                              |
       Evidence-backed proposals -> engineer review -> issue

Throughout: familiar AutoCAD, no noticeable lag, reversible changes,
            protected client data, exact release identity.
```

| Part | What staff should experience |
|---|---|
| One product | One installation, coordinated Civil/Structural/Tools navigation, one controlled release system. Most users have both disciplines. |
| Reliable drafting | Keep working commands and muscle memory. Geometry, owned labels and relationships stay coordinated through edit, copy, erase, Undo and reopen. |
| Engineering truth | One sourced/versioned rulebook and shared calculation authorities; missing or conflicting evidence stays Unknown, not a guessed Pass. |
| Clear editing | Actual engineering and its drawing presentation are distinct. Safe live preview, explicit commit, exact Cancel recovery and clear read-only states. |
| Whole-project coordination | Plans, details, schedules, calculations and issue requirements agree; changed inputs make affected results visibly stale. |
| Useful intelligence | Understand verified connections and project context; show ranked options rather than forcing a guessed answer. |
| Less repetitive testing | Automate repeatable checks; Tim reviews meaningful exceptions and the final representative AutoCAD experience. |
| Controlled growth | New automation earns approval and evidence. Nothing silently retrains office behaviour, changes engineering rules or deploys itself. |

**Scope distinction:** the September Civil V3 release targets reliable tools, drawing relationships,
review and assisted proposals. Full coordinated automatic drafting remains a later, evidence-gated
ambition, not a promise that every part ships in the current Civil release.

## 2. Which document answers which question?

| Question | Read this |
|---|---|
| What is the complete plan? | **This overview**, then the linked decision records below. |
| What did the original ten planning rounds decide? | [Clean-Slate Rebuild](CLEAN_SLATE_REBUILD.md), Rounds 0–9 and the permanent command-review gate. |
| Where are all the detailed questionnaire answers? | [39-card index](CARDS/INDEX.md); every card is also linked in section 4 here. Read the approval/refinements as well as the proposed decisions. |
| What is the current Civil delivery plan? | [Civil V3 reconciled plan](V3_0_PLAN.md), not an archived UI/research draft. |
| What did Tim decide most recently? | [4 September reconciliation / D1–D10](PLAN_RECONCILIATION_2026-09-04.md). |
| How should Civil editors and intelligence behave? | [31 August editor brief](CE_CIVIL_EDITOR_UI_UX_BRIEF.md) and [Drawing Intelligence brief](CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md), subject to newer explicit rulings. |
| Where is the UI plan and what will each window become? | [Consolidated UI section below](#ui-plan), with the full window map, runtime tiers, ribbon stages, saved visuals and draft/approval boundaries. |
| Where do engineering answers live? | [Engineering Rulebook](ENGINEERING_RULEBOOK.md), CV-02 and approved project/council records. The rulebook contains draft material AND dated resolved rulings; do not approve the draft wholesale. [PR #48](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/48) is the dated record of Tim's 4 September 2026 rulings (open at this reconciliation). |
| Were earlier engineering questions answered? | [Engineer questions / recorded answers](ENGINEER_QUESTIONS_PENDING.md) and [original review questions](ENGINEER_QUESTIONS_FOR_REVIEW.md). Historical questions below answered sections are not automatically still open. |
| How do commands map to decisions? | [Command-to-card coverage](CARDS/COMMAND_TO_CARD_COVERAGE.md), with its dated evidence and unresolved mappings. |
| What is actually built, tested, installed or accepted now? | [WHERE WE ARE #24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24), the [delivery board](https://github.com/users/timbrand92/projects/2), and exact-build test/deployment/acceptance evidence. |
| Where are the earlier plans and design drafts? | [Preserved planning inputs](planning-evidence/2026-09-04/README.md). They remain evidence, not competing active plans. |

### Authority — do not let a summary overrule an answer

1. Tim's explicit current decisions and approved engineering/workflow cards govern behaviour.
2. Original approval refinements are part of the decision, not optional commentary.
3. The September Civil plan governs current delivery order; the clean-slate plan retains enduring architecture/safety.
4. The board reports delivery status; it cannot change engineering truth or turn a failed test into acceptance.
5. This overview is a reading map. If it conflicts with the approved source, use the source and correct the overview.
6. Research, unapproved visuals, historical progress paragraphs and AI memory do not grant authority.

Planning approval, code written, tests passed, package installed and Tim acceptance are **five separate facts**.
Thirty-nine approved cards does not mean thirty-nine finished tools. This document does not claim a product
completion percentage or independently remeasure a live AutoCAD installation.

## 3. The original overall question rounds — all retained

All ten rounds are in [Clean-Slate Rebuild](CLEAN_SLATE_REBUILD.md). Some old section titles still say
OPEN/IN PROGRESS even though a later outcome in that same round records the locked decision.

| Round | Agreed outcome | Exact source section |
|---|---|---|
| 0 — Direction | Clean-slate design, incremental migration in this repository; keep working code; no big-bang rewrite. | Round 0 — DECIDED |
| 1 — Reuse and failure audit | Reuse sound parts. Fix duplicated behaviour/data authority, unsafe drawing events, inconsistent units/rounding, weak diagnostics and unproven tests. | Round 1, §§6.9–6.11; the 12 design rules in §6.10 |
| 2 — Product architecture | One product, discipline-aware navigation; stage/object grouping, large everyday actions and discoverable long-tail tools; shared engineering-focused Ask CE. Identity renames require controlled migration. | §§10.3–10.6 and Tim's recorded Round 2 answers |
| 3 — Version management | One deliberate unified-product version plus exact build/commit/hash identity. Promote the same tested package through Tim Test, Pilot and Staff Stable. | §12, including 3.1–3.6 and display/recovery rulings |
| 4 — Tools and AI connection | One Tool Register feeds commands, ribbon, Help, permissions and AI. Vetted tools only; local permissioned bridge; contextual discovery; no arbitrary command/code execution. | §13 |
| 5 — Coordination | One lead/board, bounded file ownership, controlled integration and one deployment authority; independent work only where safe. Current ownership is in section 6 below. | §14; current AGENTS.md coordination rules |
| 6 — Testing | Logic plus drawing-output evidence, Cancel/Undo/save/reopen/protection/performance checks, supported AutoCAD versions, then Tim and real-work pilot acceptance. | §15 |
| 7 — Build and deployment | Build away from live AutoCAD; signed immutable packages, verified staging/install, recoverable rollback, after-close updates and feature disable. | §16, B1–B30 |
| 8 — Help and memory | One visual contextual offline Help Centre; separate Rulebook, Project Memory, Active Register, Release Register and preserved history. Repository records outlive chats. | §17, H1–H30 |
| 9 — Migration | Inventory every legacy destination; preserve drawings/settings; isolated reversible cutover; Tim daily use, selected staff pilot, small waves, delayed legacy retirement. | §18, X1–X30 |

### Permanent rules carried across every workstream

- Review each user-facing workflow as **Keep / Modify / Rebuild / Retire / Missing** before implementation.
- Keep the working path until the replacement passes its actual AutoCAD test.
- **Working rule 7 — full-function preservation:** before any existing window or command is replaced, every current button, field, grip, prompt, right-click route, double-click route and saved behaviour is listed with one outcome **Kept / Moved / Combined / Replaced / Retired**; **Retired only with Tim's explicit approval**; visual tidying alone never removes a capability. Approved 4 September 2026 on [#24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24#issuecomment-5534983308).
- One implementation per behaviour; one drawing-data authority, with rebuildable caches rather than rival truths.
- Preserve immutable standard masters; cleanup mirrors creation; unit/coordinate conversion happens once at the boundary.
- Use one rounding policy; visible failures and safe defaults; safe drawing-event/UI handling; bounded maintainable code and real regression tests.
- Respect locked layers, XREFs, REFEDIT and unsupported objects. Never silently bypass AutoCAD protections.
- For an ordinary accepted single-DWG edit: preview, explicit commit, one Undo; Cancel leaves no partial change.
- **Cross-DWG exception is explicit:** CV-01J has per-DWG Undo groups and durable recovery journals, not a fictional global AutoCAD Undo/transaction.
- No normal startup/drafting dependency on AI or network availability; no whole-drawing scan during cursor movement.
- No new build/deploy/helper scripts without approval. Every later build/test keeps the mandatory safety flags in CLAUDE.md.
- Only the authorised deployment lane may deploy, after Tim says **“AutoCAD is closed, deploy”**, process checks and hash verification.

## 4. Every approved workflow questionnaire — 39 source records

These are **approved planning outcomes**, not current implementation-status claims. Each link opens the
original batch and refinements. Canonical IDs are retained; old FND/SH filenames are aliases, not extra cards.

### Foundation, shared tools, settings, assets and privacy — 11 cards

| Card / source | Agreed outcome and important boundary |
|---|---|
| [SH-01 — Product shell](workflows/SH-01_PRODUCT_SHELL_REVIEW.md) | Manager owns product health/support/recovery; one coherent CE navigation system; isolate module failure, no startup popup/network wait. Added startup target ≤0.5 s, hard p95 ceiling ≤1.0 s on agreed hardware. |
| [FND-01 — Foundation gates](workflows/FND-01_FOUNDATION_REVIEW.md) | Tool Register, ribbon, Help and shipped commands must agree; unfinished tools hidden; synthetic disposable tests and consolidated Tim acceptance. |
| [CT-01 — Command truth](workflows/FND-001_COMMAND_TRUTH_REVIEW.md) | Permanent tool IDs, one owner and global alias rules; compare compiled commands outside AutoCAD. Report and reconcile the legacy baseline before permanently blocking unexplained drift. |
| [TH-01 — Test evidence](workflows/FND-002_003_TEST_EVIDENCE_REVIEW.md) | Separate Test-only package, exact artifact/fixture hashes, disposable copies; unknown steps/no assertions cannot pass. Headless tests wait/skip if AutoCAD is open; never close it. |
| [RS-01 — Release safety](workflows/FND-004_RELEASE_SAFETY_REVIEW.md) | Build cannot write live bundles; verified signed staging/install with preserved prior bundle and automatic recovery. Promote unchanged artifacts; no hot-swap or forced restart. |
| [PD-01 — Performance/diagnostics](workflows/FND-005_006_PERFORMANCE_DIAGNOSTICS_REVIEW.md) | Measure real drafting impact; Manager reports actual loaded identity. One capped log/support path and run-specific crash evidence; unfinished session alone is not a crash. |
| [TF-01 — Move/Copy Rotate](workflows/SH-05_SHARED_TRANSFORM_REVIEW.md) | Preserve proven MR/CR feel and LISP reference; one Shared owner. CE releases `C` to Tim's native COPY alias; Escape rolls back, Enter/0° can finish without rotation. |
| [SH-04 — Settings/standards](CARDS/SH-04_SETTINGS_STANDARDS.md) | Personal, project and firm tiers. Projects retain their rulebook version; settings changes do not rewrite existing objects. Adopting new rules/resetting project settings is explicit and reversible. |
| [AS-01 — Standards catalogue](CARDS/AS-01_STANDARDS_ASSET_CATALOGUE.md) | One governed catalogue for blocks, styles, notes, details/templates and palettes; individually approved read-only DWG masters, fixed versioned project copies, intelligent objects preserved. Baseline Candidate is not blanket asset approval. |
| [AI-01 — Ask CE/bridge](CARDS/AI-01_ASK_CE_MCP_AUTOMATION.md) | One shared Ask CE, frozen read-only snapshots, local paired bridge and enforced read/write permissions. Writes require preview/approval; AI explains engineering but cannot approve it. Separate provider clearance remains required. |
| [DATA-01 — Privacy](CARDS/DATA-01_CORPUS_PRIVACY.md) | Synthetic by default; de-identify text, metadata and location/geometry; restrict real inputs and history; provider/purpose-specific clearance. Broad corpus/AI access remains blocked until evidenced clearance. |

### Civil, schedules and issue readiness — 11 cards

| Card / source | Agreed outcome and important boundary |
|---|---|
| [CV-01 — Drainage network](CARDS/CV-01_DRAINAGE_NETWORK.md) | Preserve CD/PIT/CDEDIT and coordinate geometry, labels, relationships and engineering data through one shared change path. Fixed/design sources and Unknown remain explicit; no nearest-outlet guessing. Later draw-first, redesign and multiple-LPD records are retained; design-impact has a stale card-status conflict noted in section 7. |
| [CV-01J — Multi-level continuations](CARDS/CV-01J_MULTI_LEVEL_CONTINUATIONS.md) | Separated plan fragments represent one logical pipe with proved/declared total length. `CD-S01` is a display/mapping link, not a fake pit/riser/extra pipe. Explicit mappings, compatibility mode, paired-write recovery and separate gravity/rising-main rules. |
| [CV-02 — Hydraulic behaviour and values](CARDS/CV-02_HYDRAULIC_DESIGN.md) | Both HD1–HD15 and HV1–HV15 are retained. One versioned engine across drawing/calculator tools; fixed levels win; Unknown/Advisory propagate. Numeric approval caveats and standards/council/approved-job validation remain gates before live compliance claims. |
| [CV-03 — Drainage sources](CARDS/CV-03_SOURCE_BLOCKS.md) | One source-placement path with local updates and fresh non-recycled identities; distinguish source engineering types even where graphics are shared. Copy must not inherit the original identity. |
| [CV-04 — Surface drainage](CARDS/CV-04_SURFACE_DRAINAGE.md) | Surface assets are real asset types, not fake pits; shared placement foundation, owned tank/AGI compounds and shipped CE assets. Preserve the card's specific floor-waste/drafting rulings and offset regression. |
| [CV-05 — Slab/site layout](CARDS/CV-05_SLAB_SITE_LAYOUT.md) | One managed slab with permanent owned children; missing FSL is Unknown, never zero. Pit-level suggestions require confirmation; joint mechanics do not approve unconfirmed engineering spacing rules. |
| [CV-06 — Review/calculation](CARDS/CV-06_REVIEW_CALCULATION.md) | One review experience consuming the existing schedule, hydraulic and QA authorities; no fourth engine/dashboard. Read-only opening, persistent calculations, branch-aware profiles and honest selected export scope. |
| [CV-07 — Survey/import](CARDS/CV-07_SURVEY_IMPORT.md) | Governed intake, source revisions/units/transforms and visible conflicts; safe re-import preserves deliberate overrides. **September D9 supersedes the old LandXML-network-authority wording: DWG geometry remains the model.** |
| [CV-08 — Repair/migration](CARDS/CV-08_REPAIR_MIGRATION.md) | Audit is physically non-writing; repair is separately previewed/approved. Stable identity outranks proximity; unresolved items quarantined, not deleted; newer data remains protected in older CE. No guessed invert order/default pipe size. |
| [PS-01 — Pit schedules](CARDS/PS-01_PIT_SCHEDULES.md) | Linked view of authoritative pit/pipe data, read-only opening, update in place and explicit override scope. Preserve PS16–PS22: stale checks, identity-safe renumbering, placed-instance authority, close protection, XREF sourcing and close-after-placement. |
| [QA-01 — Ready to Issue](CARDS/QA-01_READY_TO_ISSUE.md) | One project QA authority with six gates: Data, Engineering Design, Plan Presentation, Details/Notes, Schedules, Issue Readiness. Missing/skipped checks are Unknown; no engineering Fix All. Ready requires current dependencies/fingerprints, no blockers and recorded evidence. |

### Structural — 9 cards

| Card / source | Agreed outcome and important boundary |
|---|---|
| [ST-01 — Beams/links](CARDS/ST-01_BEAMS_LINKS.md) | Keep numbered beam workflows; beam owns geometry/label, supports remain shared. One placement resolver for preview/final, fresh copied identities, no forced save. Inside/outside-house automation remains a separately gated idea. |
| [ST-02 — Supports/bracing/joists](CARDS/ST-02_SUPPORTS_BRACING_JOISTS.md) | Footprint-proven support links, centre/rotation/mark/label preservation during switches; visible joist/rafter boundaries and preview. P1 remains hidden pending its lap rule. |
| [ST-03 — Annotation/dimensions](CARDS/ST-03_ANNOTATION_DIMENSIONS.md) | Keep native associative dimensions/leaders native; linked level/section compounds; recognised-object-only level editing, no false zero. Use approved CE graphics, not approximated replacement art. |
| [ST-04 — Text placement](CARDS/ST-04_TEXT_PLACEMENT.md) | One placement path with familiar aliases and approved native text/styles; explicit ownership. Footing geometry stays in ST-06, not a hidden text-command side effect. |
| [ST-05 — Hatching/utilities/XREFs](CARDS/ST-05_HATCHING_UTILITIES_XREFS.md) | One native associative hatch engine, real plotted scale, preserve heavily used LBH/LBUH/BLH. Preview XREF/cleanup changes; never edit foreign source DWGs; FASTSAVE stays save-only. |
| [ST-06 — Foundations/rebar](CARDS/ST-06_FOUNDATIONS_REBAR.md) | Explicit foundation host and authoritative CE record; safe adoption/deletion choices; approved assets required. STR/BWT remain retired; schedule export belongs to ST-07. |
| [ST-07 — Schedules/sheets/Excel](CARDS/ST-07_SCHEDULES_SHEETS_EXCEL.md) | One schedule authority, trace imported cells/revisions, distinguish Second Floor from Mezzanine; no silent cross-job learning. QA-gated verified publishing, no silent overwrite of issued PDFs. |
| [ST-08 — Sections/details](CARDS/ST-08_SECTIONS_DETAILS.md) | Retain useful section engines, link managed details to actual member/calculation/schedule authority, copy fixed approved standard details. Undesigned placeholder commands remain hidden. |
| [ST-09 — Markups/checklists/notes/time](CARDS/ST-09_MARKUP_CHECKLIST_NOTES_TIME.md) | One coordination workspace; deterministic markup extraction first, engineering notes become decisions not automatic edits. Exact-batch Undo, one checklist authority, note conflict handling and append-only time records. |

### Evidence, learning and record preservation — 8 cards

| Card / source | Agreed outcome and important boundary |
|---|---|
| [EV-01 — Whole-practice evidence scope](CARDS/EV-01_SCOPE.md) | Link inputs, calculations, markups and verified issued outputs; understand relationships, not just entity counts. Progress toward complete proposals while rules remain engineering authority. |
| [EV-02 — Acceptance gates](CARDS/EV-02_ACCEPTANCE_GATES.md) | Bounded study: at least 300 verified projects, 20%/minimum 60 untouched project holdouts, separate relationship/placement/engineering gates. Failed contexts get a bounded gap report and Preview/Unknown, not endless research. |
| [EV-03 — Evidence model](CARDS/EV-03_EVIDENCE_MODEL.md) | Read-only project/scene records with source revisions, transforms, ownership, cross-sheet context and instructed markup corrections; no proximity-only ownership or leaked raw client text. |
| [EV-04 — Drafting Pattern Atlas](CARDS/EV-04_PATTERN_ATLAS.md) | Explainable contextual placement, plotted readability, hard constraints and ranked alternatives. Preserve deliberate manual positions; flag hard conflicts rather than snapping back or silently accepting them. |
| [EV-05 — Engineering Context Map](CARDS/EV-05_ENGINEERING_CONTEXT_MAP.md) | Connect existing engineering authorities and downstream dependencies, not a new calculator. Trace every value; propagate staleness, not silent redesign; corpus frequency cannot establish engineering truth. |
| [EV-06 — Gold Benchmark](CARDS/EV-06_GOLD_BENCHMARK.md) | Whole-project reproduction and command-lifecycle lanes. Never feed the final as an input; accept legitimate drafting alternatives; source-less numbers fail. Tim reviews up to 30 meaningful visual exceptions per batch. |
| [EV-07 — Automation Register](CARDS/EV-07_AUTOMATION_REGISTER.md) | Rank opportunities by value/evidence/risk; improve or merge before adding commands. Observe → Suggest → Preview → Approved Apply → Coordinated Draft; Tim approves each capability/maturity increase. |
| [PC-01 — Planning records](CARDS/PC-01_PLANNING_RECORD.md) | Preserve original approval wording/refinements, canonical IDs, command coverage and dependencies. Separate approval from completion; do not reconstruct missing decisions from code or memory. |

**Count check:** 11 foundation/shared + 11 Civil/QA + 9 Structural + 8 evidence/planning = **39**.
CV-02 contains two question batches; PS-01 has later additions; one card does not necessarily equal 15 questions.
Rounds 0–9, older engineering answers, the August briefs and September D1–D10 are additional sources,
not missing cards or reasons to repeat the questionnaires.

## 5. Later approved Civil workshops — keep these refinements

### 31 August: editors

Source: [CE Civil Editor UI/UX Brief](CE_CIVIL_EDITOR_UI_UX_BRIEF.md).

- CDEDIT is the editing doorway: preselection/prompted selection, owned annotation routing and same-type batches.
- Separate actual engineering from presentation. Hiding an invert label does not remove the invert;
  a display override does not alter the engineering grade.
- Preserve Simple Pipe / Simple Pipe + Arrow as first-class presentation setups, not separate engineering types.
- Popups highlight/focus the object, allow Inspect Drawing, safe unsaved preview, Save and Close and exact Cancel.
- Batch fields require explicit selection; blank does not erase; avoid casual batch changes to individual levels/flow/connections.
- Pipe flow reversal does not silently swap/recalculate ILs; the arrow follows real flow. Level requirements depend on the workflow, not a universal gravity-pipe assumption.
- Pit bottom IL is distinct from connected pipe-end ILs. Detail-specific rules govern automatic bottom/sump behaviour; cover/lid/surface remain understandable and editable where permitted.
- Manual annotation positions persist; Reset Positions restores the standard. Protected/XREF objects are inspectable but read-only.
- PR #20 infrastructure is reusable, not blanket approval of its initial UI. Avoid competing Apply/Update/OK actions and unnecessary source badges/review rails.

### 31 August: drawing intelligence

Source: [CE Civil Drawing Intelligence Brief](CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md).

- Connectivity is independent of having invert levels. Exact/proven endpoint contact can establish a connection;
  proximity-only candidates ask; crossing alone is not a connection; multiple legitimate candidates are unresolved.
- Keep explicit Connect/Disconnect/Ignore intent. Geometry changes trigger local reassessment; stale/ambiguous links remain visible.
- CDCHECK gives categorized results, counts, zoom/highlight and useful resolution actions, not command-line-only findings.
- CE-aware trim/extend/break/join/move preserve or deliberately resolve identity and topology. Normal COPY creates fresh identities.
- A branch can connect to the middle of one main pipe; never manufacture a pit or split the logical main merely to encode it.
- Surface/detail/roof-catchment assistance is contextual and deliberate, not a heavy automatic scan on every DWG open.
- Shared learning may use an interchangeable OneDrive storage route initially; project truth stays project-specific.
  Approved examples → candidate model → validation → approval/versioned release/rollback; no overnight silent behaviour change.
- The shared evidence service is intended for reuse by the AutoCAD Plugin and separate Job Manager through their own adapters;
  do not build rival corpora or move plugin runtime assets into Job Manager's AutoCAD Link.

The last point is also recorded in [AS-01 approval refinements](CARDS/AS-01_STANDARDS_ASSET_CATALOGUE.md)
and [EV-05](CARDS/EV-05_ENGINEERING_CONTEXT_MAP.md). Broad real-data access still requires DATA-01 clearance.

### 4 September: D1–D10

Source: [verbatim choices and boundaries](PLAN_RECONCILIATION_2026-09-04.md).

| Answer | Current ruling |
|---|---|
| D1 | Store centreline geometry; derive all six named lengths from it, without competing length truths. |
| D2 | Explicit per-object upgrade; never automatic-on-open conversion. Reversibility and old-version preservation must be proved. |
| D3 | Main stays one logical pipe with an internal branch node. |
| D4 | Relevant edits mark results Stale; deliberate re-check, never silent fixing. |
| D5 | Project Explorer + Prospector + Vistas are review-workspace design references, not a Civil 3D dependency. |
| D6 | Catchment field set: boundary, runoff coefficient, most-distant point, flow path, Tc, linked structure and a Stale-capable source-geometry link. |
| D7 | AS/NZS 3500.3 + Rational Method + council matrix supply calculation authority; this does not approve every guessed/default value. |
| D8 | Catalogue-size grip, consistent action-shape language and Reset Position approved; visible working AutoCAD behaviour still gates acceptance. |
| D9 | **Keep DWG geometry as the model.** Reject LandXML-authoritative replacement. Supplementary use needs a reviewed field-level reconciliation/preview contract. |
| D10 | Replace the invalid LandXML fixture; keep it as a negative test. Bounded test approval, not corpus/provider clearance. |

<a id="ui-plan"></a>

### Consolidated UI plan — all screens, ribbon and saved visuals

**This is the UI part of the same overall plan, not a second programme.** The approved workflow cards
and August editor brief govern behaviour. The September [UI master brief](design/V3_UI/00_MASTER_BRIEF.md)
and [detailed ribbon design](design/V3_UI/windows/01_RIBBON.md) supply a preserved design proposal;
their headings saying “design authority” do not override the September reconciliation's draft boundary.
Read the [editor workshop context](CE_CIVIL_EDITOR_WORKSHOP_CONTEXT.md) for the original workshop,
but use section 6 below for the newer ownership split.

#### A. The screen family

```text
                         AutoCAD drawing
                               |
             typed command / ribbon / selected CE object
                               |
    +--------------------------+--------------------------+
    |                          |                          |
Draw repeatedly          Edit an object            Review a project
small step card          floating editor          shared workspace
cursor preview           engineering first        Checks | Calculations
few relevant prompts     then presentation        Profiles | Proposals
    |                          |                          |
    +--------------------------+--------------------------+
                               |
          one underlying object/engineering/QA authority

Supporting surfaces: Civil Properties | Settings | Repair | Help | Manager
```

The step-card/workspace packaging is the saved design direction, not permission to replace any
unreviewed command. Single-object editors retain the approved Save and Close / Cancel contract;
creation, schedule placement, batch changes and Settings retain their own appropriate action wording.
Do not force every workflow into a universal Save and Close button.

| How often | Proposed surface | Practical result |
|---|---|---|
| Constant — drawing pipes, pits and sources | Small floating step card and cursor preview | Familiar command prompts, remembered choices, no compulsory full-screen wizard before ordinary drawing. |
| Frequent — editing pipes/pits, batch edits, schedules | Floating editor or focused results popup | Identity first, practical fields, Inspect Drawing / Focus, safe preview and explicit commit. |
| Per project — calculations, profiles, proposals, site/import work | Larger review workspace | See related information together; deliberate calculations and approvals, no hidden repair on opening. |
| Occasional — settings, repair, support | Options-style pages or findings view | Search/navigation, understandable ownership and safe scoped changes. Ask CE remains its separately approved dockable non-blocking palette. |

#### B. Complete Civil window map

This consolidates all Areas 0–8 from the September Civil plan and its design brief. “Combine” is the
target experience; working screens/aliases remain until the approved replacement is accepted.
Detailed missing screen specifications do not become approved merely by appearing in this map.

| Area / window | What comes together | Delivery / boundary |
|---|---|---|
| 0 — CE shell and ribbon | Familiar AutoCAD frame, product status, common window conventions and tool discovery | Existing Civil navigation first; single discipline-aware CE ribbon after office pilot. |
| 1 — Pipe: New / Edit | CD creation and PIPEEDIT use consistent fields/layout; proposed New flow has three stages | C2. Preserve draw-first, Simple Pipe/Arrow, Recall Last, physical-end IL ownership and separate presentation. |
| 2 — Pit: New / Edit | PIT, PITEDIT and pit presets use one coherent window; PP remains the everyday shortcut | C2. Keep standard/detail context, editable cover/lid, distinct pit-bottom and pipe-end levels. |
| 3 — CDEDIT and batch | Geometry/text ownership routing, same-type batch and drawing-position controls | C2/C3. Explicitly enabled safe batch fields; mixed pit/pipe selection is rejected/explained, not silently batch-processed. |
| 3 — Civil Properties / Inspector | Selected-object information and quiet health status in a docked palette | C2/C3. Shared authority with editors; any new direct editing needs its approved contract. Native AutoCAD Properties remains informational for CE-controlled data. |
| 4 — Sources | One placement foundation/type-specific step card for downpipes, openings, overflow and related sources | C3. Typed command preselects the type; do not merge distinct engineering types merely because graphics look alike. |
| 4 — Water Tank and devices | CDWT and its owned callout/connection information | C3 as scoped. Future OSD/pump/wet-well modes are not automatically approved by a draft's mode list. |
| 5 — Slab System | New/adopt/edit slab, levels, spoons, joints and tree-zone access | C5. Preserve slab/child ownership; unapproved joint engineering remains gated. |
| 6 — Project Review: Checks | Existing dashboard/health/QA entry points and CDCHECK's fast popup | C4. One findings authority and zoom/highlight navigation; no rival checker or silent repair. |
| 6 — Project Review: Calculations / Profiles | Existing calculation dialogs and longitudinal-profile workflow | C4. Reuse one hydraulic engine; source/version/Unknown visible; profile asks at ambiguous branches. |
| 6 — Project Review: Proposals | Civil Hub, design-impact, discharge/redesign and change previews | C6, reusing earlier approved slices. Ranked options with explicit approval; read-only impact view is not a new writer. |
| 6 — Pit Schedule | One PITSCHEDULE editor, whole schedule, linked changes, overrides and place/update | C2 editor within PS-01/C4 coordination. Twenty-row/no-scroll aim; preserve cancel-point return and close after successful placement. |
| 7 — Import | Survey, consultant DWG, X-Civil, LandXML and comparison entry points | C5. D9: DWG geometry remains the model; defective/unapproved import paths stay gated. |
| 8 — Settings | Civil defaults, labels, OSNAP, survey, project/firm rules and advanced/admin pages | C5 under SH-04 shared ownership. Personal/project/firm tiers; no retroactive drawing changes. |
| 8 — Repair & Upgrade | Findings, evidence, repair choices, link/override actions and explicit upgrade | C5. Non-writing audit first, bounded preview/apply and recovery; no automatic-on-open upgrade. |
| 0 — Help, Ask CE, Manager and feedback | Common Help/discovery, assistant, version/health/update/recovery, What's New and reporting | M1/C6 as scoped. These are related shared services, not one giant combined drafting dialog. |

Structural's nine approved workflow families remain in section 4. The Civil UI pack does **not** authorise
a Structural-window redesign; S1–S3/M1 adopt approved common conventions under their own work orders.

#### C. Appearance, usability and AutoCAD versions

**Approved editor structure:** medium-width stacked Windows-style layout, object identity, Engineering,
Connections, Presentation and Schedule only where relevant. One unsaved-preview banner, local Was/Now,
plain drafting words, restrained status indicators and strong object highlighting in the drawing.

**Saved design-pack direction:** warm graphite with restrained CE gold, clear drafting-style icons,
Segoe UI/Bahnschrift-style typography, dark proof plus light-theme proof, and compact controls.
Exact colours, font sizes, decorative groups and pixel dimensions in the draft are design specifications
to reconcile against the approved visuals/accessibility requirements—not fresh engineering or UI approval.

| Requirement | Keep in the final design |
|---|---|
| Drawing context | Inspect Drawing preserves unsaved work; Focus restores the useful object view. Windows must not hide the object being edited. |
| Status | Words plus icon/colour; never colour alone. Unknown, read-only, stale and blocking states remain distinct. |
| Positioning | Authored label positions persist; Slide/Offset/Flip/Reset concepts do not invent separate engineering data. |
| Keyboard | Visible focus, logical Tab order, scoped Enter/Escape, contextual Help; never let Escape partially commit. |
| Fit and scaling | No-scroll everyday-editor and twenty-row schedule aims must be proven at actual work-area/DPI sizes; never achieve them by hiding required fields or making text unreadable. |
| Accessibility | Preserve approved Settings contrast/click-target requirements and schedule/Hub 40–44 px control targets; the draft's 26 px controls are not a universal override. |
| Settings | Save changes / Cancel, scoped reset, project preview/apply/Undo and rulebook-version visibility; no global destructive reset. |

The approved [whole-plugin UI/runtime plan](workflows/SH-04_WPF_SURFACE_REVIEW_PLAN.md) covers the
historical 73-window inventory (24 Civil, 47 Structural, 2 Manager), not 73 newly approved redesigns:

| AutoCAD | Presentation tier | Behaviour boundary |
|---|---|---|
| 2022–2024 | CE Legacy — simpler native Windows controls | Same engineering, information, validation and keyboard workflow. |
| 2025–2026 | CE Modern — richer controls after isolated compatibility proof | No new calculation/data path just for appearance. |
| 2027 | CE Fluent — window-scoped modern styling after proof | No competing global themes or assumed library compatibility. |

The earlier UI-01–UI-06 review batches remain discovery/grouping history: navigation/settings;
Civil create/edit; Civil review/output; Structural drafting; Structural production; shared support.
They are not the same ID system as September C0–C6 or the design pack's numbered window files.

#### D. Ribbon — staged plan, not an immediate replacement

1. **Existing-product stage:** preserve the accepted/current CE Civil, CE Structural and CE Tools paths;
   improve Civil grouping/PP discovery only within approved current contracts and exact work orders.
2. **After office pilot:** target one discipline-aware CE ribbon with shared Help/Manager/Settings,
   workflow panels and contextual object actions. It needs its own detailed approval and runtime proof.

The [preserved ribbon draft](design/V3_UI/windows/01_RIBBON.md) contains the complete button tables,
Civil/Structural/contextual wireframes, tooltips, keyboard shortcuts and narrow-window collapse proposals.
Its Civil sketch groups CE / Draw / Sources / Edit / Review / Site / Import / Shared / Settings.
It proposes stable button faces, preset galleries and selected-object Pipe/Pit/Source/Slab/Schedule tabs.
These details remain draft where they conflict with approved cards or await Tim's visual choice.

The [July ribbon review](workflows/SH-01_RIBBON_VISUAL_REVIEW.md) explicitly approved three tabs.
September retains that incremental work and places the single-ribbon migration later; do not use a
draft's “can ship now” or “bug closed” phrase as approval, implementation evidence or permission to retire a path.

#### E. Saved UI documents and pictures — nothing lost

| Saved source | What it provides / status boundary |
|---|---|
| [September UI master brief](design/V3_UI/00_MASTER_BRIEF.md) | Full proposed window family, interaction tiers, styling and prototype assembly contract; preserved design draft. |
| [September ribbon design](design/V3_UI/windows/01_RIBBON.md) | Detailed ribbon wireframes/buttons/states; draft, not a finished clickable mockup or blanket approval. |
| [Original UI plan](planning-evidence/2026-09-04/V3_UI_ORIGINAL.md) | Preserved earlier narrative; C5-after-C6 and claimed prototype paths are superseded/corrected here. |
| [UI styling kit](design/V3_UI/kit/ce-ui-kit.css) / [interaction kit](design/V3_UI/kit/ce-ui-kit.js) | Saved prototype building blocks; not proof that all windows or the assembled demo exist. |
| [Settings implementation/visual plan](workflows/SH-04_SETTINGS_UI_IMPLEMENTATION_PLAN.md) | Approved planning direction, page tree, ownership, accessibility and staged migration. |
| [Earlier Pit review](workflows/UI-02_CIVIL_PIT_VISUAL_REVIEW.md) / [picture](image/CV-01/ui-02-pit-level-assistant-mockup.png) | Approved July Pit Level Assistant visual/source work; later August editor layout/commit wording wins where different. |
| [Earlier Pit Schedule review](workflows/UI-03_PITSCHEDULE_VISUAL_REVIEW.md) / [picture](image/PS-01/ui-03-pitschedule-mockup.png) | Approved schedule/change-review/placement flow; source evidence is not live acceptance. |
| [Earlier Civil Hub review](workflows/NH-01B_CIVIL_HUB_VISUAL_REVIEW.md) / [picture](image/NH-01/nh-01b-civil-hub-mockup.png) | Approved read-only findings/focus/navigation foundation; retain useful work within the later shared Review design. |
| [Design-impact plan](workflows/CV-01G_DESIGN_CHANGE_IMPACT_PREVIEW_PLAN.md) / [picture](image/CV-01/cv-01g-design-impact-preview-mockup.png) | Explanation-only preview; dedicated plan records source completion, despite stale CV-01 wording. |
| [Relocated-discharge plan](workflows/CV-01H_NETWORK_REDESIGN_RELOCATED_LPD_PLAN.md) / [picture](image/CV-01/cv-01h-relocated-lpd-redesign-mockup.png) | Retained reviewed network-redesign work; latest sub-slice and release gates still apply. |
| [Multiple-discharge plan](workflows/CV-01H5_MULTIPLE_LPD_AUTHORITY_PLAN.md) / [drawing](image/CV-01/cv-01h5-multiple-lpd-mockup.svg) | Retained authority-set work and proposed management screen; do not infer every UI/writer gate passed. |
| [Annotation tidy-up plan](workflows/CV-01I_SMART_ANNOTATION_TIDY_UP_PLAN.md) / [picture](image/CV-01/cv-01i-smart-annotation-tidy-up-mockup.png) | Hardened visual pack remains approval-gated; not a shipped screen. |
| [Assisted-sizing plan](workflows/CV-02A_ASSISTED_PIPE_SIZING_PLAN.md) / [picture](image/CV-02/cv-02a-assisted-pipe-sizing-mockup.png) | Advisory design/readiness visuals; rule authority, production Apply and specific visual approval gates remain. |
| [XREF watcher plan](workflows/PS-01E_XREF_NETWORK_WATCHER_PLAN.md) / [picture](image/PS-01/ps-01e-xref-network-watcher-mockup.png) | Retained schedule-source watcher design; read-only foundation is separate from remaining UI/live evidence. |
| [Schedule readiness/reasons plan](workflows/PS-01F1_PLACEMENT_READINESS_REASONS_PLAN.md) | Planning-only follow-on; not silently approved by PS-01's earlier acceptance. |

**Prototype inventory verified in this checkout on 4 September:** `docs/design/V3_UI/` contains only
the master brief, ribbon specification and two kit files. The advertised `CE_V3_UI_DESIGN_PACK.html`,
shell/ribbon HTML mockups and individual window files `02`–`16` are not present in that saved snapshot.
That does not prove another working branch has no work; check the owning session before recreating anything.
The linked earlier PNG/SVG pictures exist, but are not a completed September all-window demo.

#### F. Draft conflicts to resolve before building a screen

| Draft wording or omission | Governing boundary |
|---|---|
| Mixed pit/pipe selection becomes groups | August CDEDIT brief requires clear rejection of mixed selection with odd objects highlighted. |
| Reverse Flow changes ILs; pipe Pit Label / Include in Schedule toggles | No silent swapping/recalculation of ILs; arrows follow actual flow. Do not invent pipe record/schedule fields without an approved destination. |
| MR/CR described as Manager-owned | TF-01 assigns one Shared behaviour owner; Manager assembling the ribbon does not transfer command ownership. |
| Unknown never blocks anything; all write buttons dimmed for an entire drawing | Unknown must block dependent unsafe engineering writes; protected objects are read-only at the correct scope. A single locked object does not justify disabling unrelated writable work. |
| Every launcher opens Settings, versus a Health launcher in the same draft | Internal design inconsistency; validate each approved destination through the Tool Register, not guessed button wiring. |
| All typed commands live forever / unreviewed joints and imports exposed | Preserve working access during migration, but honour explicit retirement/hidden/permission gates and defined alias transitions. |
| Raw 26 px controls and fixed no-scroll sizes everywhere | Prove readability, keyboard/DPI and the already-approved per-surface accessibility requirements. |
| Unanswered ribbon choices | Pit face default, Solve Run location, Water Tank location, switch visibility and contextual-tab auto-activation are listed in the draft; check for later recorded answers before asking again. PP placement also remains governed by its current work order. |

**Next UI deliverable, when separately commissioned:** finish the missing per-window designs and one
clickable demonstration using the existing kit and approved fictional/synthetic content; verify the normal,
Unknown, stale, read-only, blocked, Cancel/Undo and DPI states; obtain the remaining visual approvals before
runtime implementation. This consolidation does not build that demo, start C2 or authorise deployment.

## 6. Current delivery route and ownership

This is the September route in [Civil V3](V3_0_PLAN.md), not a new sequence invented here.
The older P0–P6 [Implementation Roadmap](IMPLEMENTATION_ROADMAP.md) remains the architectural framework,
not an instruction to repeat completed foundations or merge the ribbon early.

```text
C0 -> C1 + C2 -> C3 -> C4 -> C5 -> C6
                                      |
                          Structural pilot -> office pilot
                                                  |
                                   single discipline-aware CE ribbon

M1: independent Manager/release work; required before S3.
```

| Chunk | Purpose | Completion boundary |
|---|---|---|
| C0 | Reliable grips/selection | Tim accepts the latest exact combined build, not only an earlier grip implementation. |
| C1 | Shared identity/relationships, explicit upgrade, CDCHECK | Reversible persistent state, fresh copy identity and final integrated acceptance. |
| C2 | Pipe/pit/schedule editors | Approved UI and shared interface; may start against frozen C1 contract, cannot ship on unaccepted integration. |
| C3 | Sources and CE-aware edits/connection repair | Reviewed object lifecycle, drawing result and protected-content handling. |
| C4 | Review workspace and sourced rulebook | Full intended review/rule scope, not merely the first pit-drop setting/check. |
| C5 | Slabs, DWG-led import, repair/settings | Correct governed intake/migration; Level 2 is not finished with C5 outstanding. |
| C6 | Ranked proposals, shared learning, read-only bridge first | Cleared data/provider access, evidence gates and explicit permission/approval. |
| S1–S3 | Structural adoption, colleague workflows, pilot | Existing Structural card gates and current work orders; no completion inferred from source on another branch. |
| M1 | Manager/version truth, safe updates/rollback | Independent of Civil; required for S3. |

**Ownership (superseded 29 Oct 2026; was: Claude owns behaviour/shared spine/deployment, Codex owns windows):** Any builder can build any item, windows included; acceptance rules and who deploys are unchanged (Tim, 29 Oct 2026: "lets remove the codex or claude ownship rubbish, add cemember to build list"; decisions/2026-10-29_TIM_ANSWERS.md item 67).
This supersedes the August briefs' earlier Claude-UI/Codex-intelligence assignment. Work orders still require
bounded file ownership, reviewed interfaces and the single authorised deployment lane.

**Evidence-study dependencies:** EV records contain an earlier ST-03+ pause. Later AS-01/ST-03 refinements
allow approved standards-first work and ST-04 to proceed without waiting for W04 or the entire historical corpus.
Do not reinstate a blanket pause, and do not waive evidence gates for corpus-derived defaults/suggestions.
If an individual work order does not resolve its evidence dependency, stop that slice—not the whole programme.

**Release ladder:** automated checks → drawing-output evidence → Tim acceptance → real-work Pilot → Staff Stable.
The original migration gates retain five working days of Tim daily use, selected 2–3-user/ten-working-day Pilot,
and recoverable legacy packages for at least 30 days plus two successful Stable releases, unless explicitly revised.
The current Civil `3.0.0` label is not proof of acceptance and is not the old unified-product `1.0.0` office-cutover gate.

## 7. What is not finished or must not be guessed

This is a **dated hold-point summary**, not a newly verified runtime audit. The September reconciliation
records implementation and partial exact-build AutoCAD acceptance; older card status cells often describe
their historical slice. Consult the live board and exact evidence before starting or claiming completion.

| Item | Required treatment |
|---|---|
| C1 upgrade/rollback | Prove object IDs and project-record IDs recover together, including save/reopen and failure between writes. |
| COPY identity / record store | Immediate fresh identity and the dormant record store's authority/round-trip need evidence; no second data truth. |
| C4 pit-drop checks | **Pairing DECIDED, 4 September 2026:** lowest incoming pipe governs the outlet invert (outlet = lowest inlet minus the drop); with two outlets the rule applies to the main outlet only, and the overflow or bypass is shown but never drop-checked. The pairing is no longer an engineering hold-point. Stable relationship ownership and invalid-value handling remain implementation/evidence hold-points. Sources: [#25 ruling](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/25#issuecomment-5535015017), [#30 record](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/30#issuecomment-5535015239). |
| Hydraulic compliance | Preserve approved HD/HV decisions and their caveats. HV4 is an office advisory until validated; standard/council/rule-pack and approved-job proof remain required. Tim's week-2 rulings **R-00 to R-08**, summarised below, are recorded on [#25](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/25#issuecomment-5535108587) and in [Engineering Rulebook](ENGINEERING_RULEBOOK.md) via [PR #48](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/48) (open at this reconciliation). HD/HV approvals and standards validation still gate live compliance claims. |
| Import | D9 is settled; parser correctness is not. Wrong units, dummy pits and missing ends are not excused by changing LandXML's role. |
| Privacy | DATA-01 remains blocked for broad client/corpus/AI use. History remediation/access restriction needs a separately authorised operation. |
| UI and proposals | Unfinished screen drafts and unapproved visuals are not coding approval. CV-01I, CV-02A and PS-01F1 have specific approval/gate discrepancies or pending records to reconcile before implementation. |
| Structural/asset holds | P1 lap rule, joint engineering, banked inside/outside-house logic, placeholder details and master DWG/DXF reconciliation stay scoped holds unless later explicit evidence resolves them. |
| Runtime coverage | Passing focused tests, skipped unavailable tests, source review or a signed package do not prove all-version live acceptance. |

### Tim's 4 September 2026 week-2 rulings — R-00 to R-08

These are recorded Tim rulings, not new engineering decisions or proof of implementation/compliance.
Source: [#25 dated rulings](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/25#issuecomment-5535108587) and [PR #48](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/48).

| Ruling | Recorded decision |
|---|---|
| R-00 — Settings-first | Every engineering value and decision, and every council value, lives on the Settings page: office standard + reasoned project override + council data. Nothing is hard-coded; the values below are settings seeds. |
| R-01 — Scour caps | UPVC **3.0** / concrete **6.0** / metal **4.0** / unknown **6.0 m/s**, as a **house rule**. |
| R-02 — Self-cleansing | **0.6 m/s** minimum. |
| R-03 — Grade | The **AS/NZS per-diameter grade ladder governs**; project **1:200 is a warning only**, not engineering pass/fail. |
| R-04 — Cover | A setting seeded **450 mm**; council wins when present. |
| R-05 — Orifice | Snaps **up to the next standard plate**, never below the council minimum; **Co 0.6**. |
| R-06 — Detention | **40 m** preferred maximum run, diameters **225 to 600 mm**, TWL at the **highest obvert**, **150 mm** freeboard below cover. |
| R-07 — Pipe defaults | **100 mm** default pipe diameter; per-type defaults read from the data model. |
| R-08 — Pit drop | **20 mm default, adjustable per project**; lowest incoming pipe governs; main outlet only, with overflow/bypass shown but never drop-checked. |

### Linked ideas, dependency and research — 4 September 2026

- Idea [#45 — CDDESIGN detention window](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/45), created 4 September 2026; recorded idea, not implementation approval.
- Idea [#46 — CDJOINT Joint Assistant](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/46), created 4 September 2026; preview only, not approval of joint-engineering values.
- [#40 — supplementary LandXML contract](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/40) is parked until C5 starts.
- Bug [#42 — Plastic Pit ribbon entry](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/42) blocks the merge of [CI #41](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/41).
- [docs/research/civil3d](https://github.com/timbrand92/CE_ACAD_PLUGIN/tree/claude/civil3d-research-agents-67138e/docs/research/civil3d) on branch `claude/civil3d-research-agents-67138e` is evidence only; D9 rejected its LandXML-first recommendation.

### Known wording conflicts — resolution or boundary

| Older wording | How to read it now |
|---|---|
| V3_0_PLAN is a May stub | That was the stale local `e51ee3e9` copy. September PR #44 replaced it with the reconciled Civil plan; it must now be included. |
| 38 cards / implementation 0% / AutoCAD 0% | Historical July statements, not current whole-program status. Index now records 39; September evidence records partial implementation/acceptance. |
| CV-01 card says CV-01G is unapproved/no code | Its [dedicated design-impact plan](workflows/CV-01G_DESIGN_CHANGE_IMPACT_PREVIEW_PLAN.md) and index instead record G1/G2/G3 complete with independent PASS. Preserve that later evidence; the preview remains explanation-only with no writer/Apply button and no deployment approval. Do not restart it from the stale card paragraph. |
| LandXML owns network; DWG is background | Superseded in current C5 scope by D9: DWG geometry is the model. Other intake safety/source-traceability rules survive. |
| C6 before C5 / unify ribbon immediately | Superseded by September route: C5 before C6; single ribbon after office pilot. |
| Display only achieved grade / edit CE text directly | Read alongside the newer editor brief: separate engineering from Actual/Design/Custom display choices; owned-text interaction routes through the CE editor. No silent engineering rewrite. |
| July 5 mm pit-drop default versus September 0/20/50 mm setting | **RESOLVED, 4 September 2026:** one number, **20 mm default, adjustable per project**. The **5 mm default** and separate **“20 mm minimum outlet drop”** wording are superseded. Sources: [#25 ruling](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/25#issuecomment-5534983502), [PR #48](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/48). |
| Every old “nothing starts” / “next batch” paragraph | Historical task boundaries preserved verbatim; not instructions to undo later approvals or restart completed planning. |
| Proposed permanent CDASK alias versus approved one-release redirect | AI-01 contains a later “I'd lean” preference, not an unambiguous replacement ruling. Preserve it as a small alias-lifetime clarification when that migration is implemented. |

These are narrow hold-points, not a new questionnaire backlog. First check for an already-recorded later answer.

## 8. Claude / Codex handoff — use the plan without reopening it

```text
Repository: C:\Lisp Files\CE_ACAD_PLUGIN
Start with docs/V3_OVERALL_PLAN.md.

Read AGENTS.md and CLAUDE.md for current working/build/deployment rules.
Read the ten locked rounds in docs/CLEAN_SLATE_REBUILD.md.
Follow every one of the 39 card links in section 4 of the overview;
read original decisions AND approval refinements, not just summary tables.
Then read docs/V3_0_PLAN.md, docs/PLAN_RECONCILIATION_2026-09-04.md,
and both 31 August Civil briefs linked in section 5.
Section 5 also consolidates the complete UI/window/ribbon plan and links the
saved designs and pictures. Those draft details do not override approved
behaviour; do not claim the missing all-window clickable demo is finished.
For any engineering value, follow its exact sourced/versioned authority.

Treat current approved decisions as authoritative, the board as delivery
status, and archived research/UI as evidence only. Preserve D1-D10,
especially D9 (DWG geometry remains the model) and C5 before C6.
(Superseded 29 Oct 2026; was: Claude owns behaviour/spine/deploys, Codex owns windows.) Any builder can build any item, windows included; acceptance rules and who deploys are unchanged (Tim, 29 Oct 2026: "lets remove the codex or claude ownship rubbish, add cemember to build list"; decisions/2026-10-29_TIM_ANSWERS.md item 67).

Do not re-ask settled questionnaires, invent missing approvals, infer
completion from code/test counts, or replace sound workflows merely because
they are old. Do not inspect restricted corpus/client inputs/history.
Reading this plan is not permission to code, build, deploy or delete.

Before a new implementation slice: state its approved card, exact scope,
dependencies, reused existing work, remaining hold-points and consolidated
AutoCAD acceptance. Ask only for genuinely missing decisions/authority.
```

## 9. Document maintenance and check

- Keep this as the single whole-program **overview**, the Civil V3 document as the current **delivery plan**,
  and the cards as the detailed **decision records**. Link, do not create competing copies of the answers.
- New rulings go in their source record with date/approval; update the relevant overview link/summary.
- Delivery evidence belongs to its exact branch/commit/build/hash and acceptance record, not an invented percentage here.
- Documentation guard: all 39 canonical records linked, Rounds 0–9 and D1–D10 covered, local links valid,
  no original questionnaire text changed, no runtime/build/deploy/corpus files changed.
- UI guard: all Areas 0–8 and saved UI source families mapped; prototype availability checked separately
  from draft claims; older accepted visuals distinguished from newer unapproved details.
- **AutoCAD test for this document: none.** Existing consolidated runtime acceptance remains pending with its owner.
