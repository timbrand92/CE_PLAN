# Structural drawing journey — Tim's rulings, 14 September 2026 (copy for CE_PLAN)

**Why this copy exists:** the only record of these rulings was `docs/workflows/STRUCTURAL_DRAWING_JOURNEY_2026-09-14.md` in the plugin repo, reachable only at commit `3460f0c0` on branch `origin/codex/CIVIL3RESEARCH` (not on master or the Structural line). Copied here on 24 September 2026 so the rulings cannot be lost. The Structural D1 card (`STRUCTURAL_D1_CARD_DRAFT_2026-09-24.md`) relies on them.

**What changed from the source (DATA-01):** the real example job's name, street, suburb, job number and project folder paths are replaced with placeholders such as `<job>` and `<suburb>`. Everything else, including Tim's words and the order of the batches, is unchanged. The original with the real names stays in the plugin repo's history only.

---

## Status and purpose

User-confirmed product requirements from the Structural Control Room discussion. Development is paused for workflow planning. This record supplements existing ST-01–ST-09 approvals; it does not replace their settled rules, complete a new command review, authorise deployment, or establish native acceptance. Reuse working tools and shared owners. No product completion credit is awarded for this document.

End-product intent: CE assistance throughout drawing setup, ordinary drafting, structural work, details, updates, checking and issue. Assistance should understand drawing context; the exact automatic-action boundaries still need workflow review. Ask questions in batches following the real job sequence, not isolated tool lists.

## Batch 1 — drawing start and setup

| # | Tim's answer / agreed requirement | Planning consequence and remaining detail |
|---|---|---|
| 1 | Start with a template Xref drawing to prepare architectural backgrounds for the Xref layers folder. Templates are at `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Drawings Templates`. Once prepared, copy/Save As a drawing template from the same folder into the project folder, insert Xrefs with colour overrides for particular plans and levels, then supply the drawing to the engineer. | Preserve this two-stage architectural-background then project-drawing workflow. Exact template files, folder layout and colour override rules remain to be identified; do not infer a DWT extension from the word template. |
| 2 | CE should understand context from drawing contents and whether the Xref drawing is being updated. Drafting also involves entering Xrefs to edit/modify them. | Do not force a New/Continue choice as the settled design. Drawing detail alone is insufficient evidence of job stage. Recognise host/background editing context without silently resetting project state; detection and user correction behaviour remain to review. Existing Xref/REFEDIT protections continue to apply. |
| 3 | Automatically take job number and address from the project folder. Client is optional, with an insertion option. Enter drawn/designed/checked by once, with later modification available. | Folder naming/parsing examples and handling missing or ambiguous values remain to review. Shared project metadata must be reused, not independently duplicated by each area. |
| 4 | Prepare layers, text/dimension styles, units and scales. LU already does some of this and needs improvement. | Classify as Modify/reuse candidate: inspect existing LU before specifying a replacement. Accepted proposal includes previewing changes for an existing drawing. Exact LU shortcomings need examples. |
| 5 | Architectural input is DWG; clean it to suit CE drawings before proceeding. | Capture the actual cleanup sequence and retained content in the next batch. Do not assume PDF is the normal architectural-input route; PDF detail-library support is a separate approved requirement. |
| 6 | Help with background placement, scale, alignment and display, with users confirming alignment. | Preview and alignment confirmation required; exact controls and validation remain to review. |
| 7 | Single versus multiple DWGs depends on the project; previous jobs can establish the patterns. | Support both arrangements. No universal one-DWG rule. Identify representative jobs later under applicable source-access rules; none were inspected for this update. |
| 8 | Sheet setup evolves constantly as the job progresses and must remain manageable. | Support adding/reordering/changing sheets throughout drafting, rather than a one-time setup. Exact actions remain to review. |
| 9 | A job-type starting drawing list is acceptable if useful. | Retain as optional suggested sheet list, editable by the user; not a mandatory fixed set. |
| 10 | Constant drawing-register updates and each page's revision number and revision date are major repetitive tasks; there are other frustrations still to identify. | Prioritise coordinated register/sheet revision work with the existing Schedules & Sheets and Project-to-Issue owners. Revision triggers, per-sheet versus set-wide revisions, dates and issue approval are unanswered; do not automatically revise every sheet. |

## Detail-library decisions already agreed

Source collection: `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Standard Details`.

Prior directory-only inventory found 183 DWGs, 16 PDFs and 8 DXFs, including subfolders. These are file counts, not distinct detail counts or content/engineering review. No drawing contents were inspected in this planning update.

- Include editable DWG details and PDF references, clearly distinguished. Retain project/source references and thumbnails. DXF inventory does not itself establish an approved DXF import workflow.
- Tim estimates about 75% are suitable office standards; which items qualify is not recorded. Do not turn that estimate into individual approvals.
- Approved approach: catalogue everything, review on use, gradually grow the approved collection. Initial unrecorded approval status is **Not yet reviewed**, not a quality judgement. Using a project copy does not approve a library standard. Allow batch approval for recognised trusted groups; prioritise frequently used details.
- Statuses: Not yet reviewed / Approved office standard / Needs correction / Superseded. Proposed catalogue housekeeping: superseded hidden from ordinary results but available on request; omit backups/locks/temp files. Exact UI remains subject to workflow review.

Tim explicitly answered yes to all eight detail-browser proposals:

| # | Approved intended behaviour |
|---|---|
| 1 | Dockable browser beside the drawing with thumbnails and search. |
| 2 | Search both plain descriptions and detail numbers. |
| 3 | Show individual details separately when a DWG contains several, retaining the source drawing reference. Extraction boundaries/method remain to establish. |
| 4 | Offer optional relevant-detail suggestions when selecting a recognised beam, footing or other object. Suggestions do not establish engineering suitability. |
| 5 | Preview insertion position and scale; remember project settings. |
| 6 | Insert an editable project copy, keeping the library original intact and its source traceable. |
| 7 | Notify and compare when the library original changes; user chooses whether to apply updates. |
| 8 | Submit useful project-modified details back to the library initially as Not yet reviewed. |

## Batch 2 — architectural preparation and engineer handoff

Tim supplied these answers after the first record was saved. They refine the earlier setup requirements; do not re-ask questions that actual examples should resolve.

| # | Confirmed current practice | Next evidence / planning action |
|---|---|---|
| 1 | Remove architectural content not needed for engineering. Retain walls, stairs, shower bases, bathtubs, landscaping, fences, windows and doors. Tim asks for review of actual Xrefs to understand the rules. | This is an illustrative retained-content list, not permission to delete every other category automatically. Review representative prepared Xrefs and, where available, their original architect DWGs. |
| 2 | Level separation must be learned from actual Xrefs. | Do not assume separate files or separate regions. Inspect representative examples before proposing behaviour. |
| 3 | Plan/level colour overrides must be learned from how actual drawings are set up. | Review the project host drawing together with its referenced backgrounds; isolated Xrefs cannot establish all host/viewport overrides. |
| 4 | LU adds all the required layers; that is its current role in Tim's workflow. | Preserve and reuse layer creation. Do not credit LU with verified styles, scales, units or background preparation. Additional setup assistance remains to specify. |
| 5 | Supply the engineer with a plotted PDF of all plans. | Engineer handoff must cover the current plan set, not merely the active sheet. Plot/issue details remain for the later review batch. |
| 6 | Engineer returns marked-up PDFs or sketched PDFs; sometimes engineers draft themselves. | Support both PDF-instruction and directly drafted input paths. Do not force one return format or assume all engineer edits are approved for issue. |
| 7 | Revised architectural backgrounds are overlaid, compared and adjusted, or rebuilt from scratch depending on the extent of change. | Support both comparison/update and replacement workflows. The choice depends on change extent; no automatic threshold or replacement decision has been approved. |

Next step: obtain a representative project folder containing a prepared architectural Xref, its host drawing showing colour overrides, and preferably an original architectural DWG and plotted plan PDF. Tim explicitly requested this bounded example review. No project location has yet been nominated here; the previously supplied template and standard-detail directories are not substitutes for real project examples. Review read-only with available supported tools, state DWG inspection limitations, and preserve applicable source-access requirements. No drawing-content inspection has yet occurred in this task.

## Representative completed job — first bounded review

**Tim's clarification:** The nominated example job is relatively typical, but projects do not always follow this exact arrangement or sequence. Use it to understand common practices, not as a mandatory project template. CE must accommodate varying drawing/file arrangements, sheet sets, engineer handoffs and revision paths. Separate reusable office conventions from job-specific choices; suggest settings from available context and allow correction. No fixed sheet count, filename pattern, stage sequence or issue authority may be inferred universally from this example. Exact variation controls remain for workflow review.

Tim nominated that job and confirmed drafting is completed, with the full process available in its project folder. Its project folder path is held locally only (DATA-01: it carries the job number and site address).

Read-only first pass on 14 September: directory/file inventory; text/page counts from setup, dated P3 and one engineer markup PDF; visual inspection of setup page 1 and markup page 1. No source file changed. This is representative workflow evidence, not a full drawing or engineering audit. DWG contents, Xref graph, layer names/colours, level arrangement and viewport overrides are not yet inspected or verified.

| Evidence (relative to project folder) | Observed fact / implication |
|---|---|
| `Xref\Xref_<job>.dwg` and root Structural P3 DWG | Prepared Xref and host candidates exist. Presence does not prove attachment relationships. |
| `Architectural` dated subfolders from May through August | Multiple background deliveries are retained; filenames include separate ground/first/roof files. Prepared Xref internal level arrangement remains unknown. |
| `<job>_STR_set up.pdf` | 3 pages, titled Ground Floor Footing Plan (S03), First Floor Framing Plan (S07), Roof Framing Plan (S13). Page 1 visually retains architectural/site context, a plan legend and populated title block before detailed Structural drafting. |
| `Engineering\Markups\<dated P2 markup folder>\<job>_mark ups for P2s.pdf` | 4 pages; no extracted text. Page 1 visually contains handwritten changes alongside roof framing, a member schedule and connection details. Text-only processing would miss this instruction source. |
| `Electronic Issue\<dated STR REV P3 folder>\<job>_STR_<site>_P3.pdf` | 12 pages by PDF count; extracted titles cover general notes, footing plan/details, remedial details, first-floor framing plan/details, roof framing and bracing. Extracted sheet IDs skip S11/S12: never assume page position equals sheet number or automatically close numbering gaps. Title-block text says Preliminary Issue, P3, dated 28/08/26. Tim's drafting-completed statement does not by itself mean construction/final issue approval. |
| Root Electronic Issue P3 PDF versus dated P3 PDF | Same revision-like filename appears in more than one location with differing file sizes. Filename alone cannot establish the authoritative issue set. No content equivalence/difference claim was made. |

Planning consequences to review with Tim: evolving plan/detail sheet sets; linked markup completion across plans/schedules/details; explicit source/issue authority; image-based PDF markup handling; distinct drafting completion and issue status. These are proposals inferred from the example, not approved automatic edits. Continue with bounded drawing inspection where supported, then ask the remaining workflow questions rather than guessing Xref colour/level rules.

## Direct DWG inspection — 14 September follow-on

Tim explicitly requested direct inspection of Xref structure, level arrangement and colour overrides. Read the nominated root P3 host and `Xref\Xref_<job>.dwg` using the already installed ACadSharp 3.4.29 library, in memory through PowerShell. No new script/project, plugin build, AutoCAD launch, deployment or drawing save. SHA256 before/after matches for both source files. This is saved-file evidence from a third-party parser, not live AutoCAD acceptance or a guarantee of full renderer/proxy fidelity.

Private local evidence directory (path held locally only) — `dwg-structure.json` (hashes, layers, references, placements, text and viewports), `xref-clips.json`, `viewport-colour-records.json`, `viewport-handles.json`. Raw project geometry was not added to the repository.

### Confirmed saved structure

**Tim's follow-on confirmation and alignment clarification:** Tim confirmed the reported DWG findings and highlighted Ground Under and First Over/plan being placed on top of each other. Treat this as coordinated level overlays occupying the same host plan area, not separate unrelated plan placements. Different insertion coordinates are compatible with aligned visible geometry because level geometry occupies different coordinates in the shared source drawing. Do not infer visual misalignment from insertion coordinates alone. CE setup should support selecting the intended source level/region and its under/over role, aligning corresponding building reference points in the target plan, and applying each overlay's own clip/colour/visibility. User confirmation of alignment remains required. Shared movement, background replacement and adjustment behaviour still need workflow approval; do not automatically move both overlays when one is edited merely from this clarification.

- Six separate overlay definitions point to the same relative source `.\Xref\Xref_<job>.dwg`: `Xref_<job>_Gorund over` (source spelling), `Xref_<job>_Site`, `Xref_<job>_Ground Under`, `Xref_<job>_First Over`, `Xref_<job>_Roof`, and `Xref_<job>`. Each has a model-space insertion on layer XREF and a spatial clipping record. They are not six different background files.
- One additional overlay, `CE Remedial Details`, points outside the project to `Standard Details\Footing Details\Overhang Details\CE Remedial Details.dwg` through a relative path. It also has a clipping record. Referenced detail content was not opened. Existing linked-detail usage must be reconciled with the newly approved editable-project-copy option before changing behaviour; do not silently break existing links.
- Source Xref returned no further external-reference definitions. Its geometry is reused through differently positioned/clipped host insertions. Paired insertion Y coordinates differ by 50,000 drawing units (Site/Gorund over; Ground Under/First Over; Roof/unnamed variant). These are observed placements, not a universal project spacing rule. Complete semantic labelling of every source-region boundary remains unconfirmed.
- Host plan titles and layout viewport centres establish separate model-space plan regions: S03 footing centre `(20400,13100)`, S07 first-floor framing `(20400,-26900)`, S13 roof framing `(20400,-66900)`, each main viewport ViewHeight 26200. All three main viewports returned zero frozen layers. The host contains layouts S01–S14 even though the sampled dated P3 PDF includes only twelve sheets. Do not assume all layouts belong in every issue.

### Confirmed colour/visibility differences

| Layer / setting | Source Xref | Host variants |
|---|---|---|
| A-WALL | Indexed colour 47 | Ground Under and Roof use 6; other four use 47. |
| A-WINDOW & DOOR | Indexed colour 9 | All six use 9. |
| A-WALL HATCH | Indexed colour 11 | All six use 11. |
| A-ROOF HATCH | Indexed colour 41, not frozen | First Over is frozen; other five not frozen. |

These are confirmed host Xref-layer differences from the saved source, independent of viewport overrides. Preserve both layer overrides and clipping when maintaining backgrounds.

Separate saved viewport colour-override Xrecords exist on local layers HATCH 51, HATCH 21, HATCH 11 and HATCH EARTH. Raw packed colour values and viewport references are retained in the evidence; no guessed RGB/ACI decoding was used. HATCH EARTH references viewport 607218 (S11 main viewport); HATCH 11 references 1262292 (S01 paper viewport ID 1). The parser groups colour and reference entries, so do not claim fully validated per-viewport effective plotting from raw record presence. No Xref-layer colour-override Xrecords were returned in this read; this is not a universal claim that viewport overrides are absent or unsupported in other jobs.

Planning consequence: model one background file separately from each named use, its placement/clip, host layer settings and sheet viewport settings. Offer reusable setup presets with project adjustments; preserve the observed six-variant arrangement as an example, not a mandatory template. No automatic replacement/normalisation is approved by this inspection.

## Xref placement follow-up — Tim's approved answers

1. Alignment reference may be a building corner, grid intersection or boundary; any of these is valid. Do not mandate one reference type.
2. When repositioning the whole plan, CE should offer to move both backgrounds and associated structural drafting together. This is an explicit whole-plan operation/offer, not permission to automatically propagate every individual object edit. Exact inclusion (labels, dimensions, schedules, detail references, viewports), selection/preview, protection handling and Undo remain for workflow review.
3. When replacing a revised background, CE should preview alignment against the existing version before applying it. Existing user confirmation of alignment remains required. Source replacement, preserved clips/overrides and rollback details remain to review.

These answers approve the intended workflow; implementation remains paused pending completion of the relevant command/workflow card. No drawing was moved or replaced.

## Engineer instructions, initial drafting and QA — approved follow-ups

Tim's answers to the drafting batch and subsequent clarification:

- Show engineer PDF beside the drawing and help navigate to the corresponding plan area. Tim asked how: proposed sheet matching plus user-confirmed reference-point alignment, with manual alignment for scanned/rotated/cropped sketches. This mechanism remains a proposal to validate, not an implemented capability or approved accuracy claim.
- Whole-plan movement includes backgrounds, structural objects, labels, dimensions, plan title **and hatches**, with preview and editable inclusion. Exact ownership/protection/Undo handling remains for the command card.
- Assist placement of beams, supports and footings from engineer markups; user confirms interpreted marks, sizes and positions before drawing.
- When an engineer changes a member size/mark, show affected labels, schedules and details together for review.
- Main time costs: QA, schedules and drafting the entire job from scratch. Tim clarified QA primarily means going through the markup versus what is drawn to ensure everything is present, including labels and marks. Prioritise instruction-to-drawing coverage and consistency, not merely graphic/layer cleanup.
- **Schedules should update automatically from confirmed drawing changes, with changes highlighted for review.** Do not automatically apply uncertain interpretations or invent missing engineering data. Exact schedule update/Undo and issue behaviour remains to review.
- **Initial drafting should propose one whole plan for review**, rather than requiring the user to work through separate footing/beam/support batches. A coherent whole-plan preview is the requested user experience; it does not authorise unreviewed engineering decisions or automatic final acceptance.
- **Optional instruction tracking is approved if it requires almost no duplicate entry.** Tim initially challenged its burden and agreed after clarification. Do not require ticking every action or maintaining a second manual checklist. Suggested states To do / Drafted / Needs clarification / Checked remain a UI proposal; checked is distinct from drafted and requires deliberate review.

Next questions should resolve markup comparison presentation, incomplete/ambiguous instruction handling and schedule change review. Reuse the whole-plan and optional-tracking decisions instead of reopening them. Implementation remains paused for workflow planning; new experience needs the complete workflow card and representative acceptance scenario.

## Whole-plan review and QA presentation — all six approved

Tim resolved the shifted numbering in his response with **"ALL YOUR ANSWERS ARE APPROVED"**. This confirms all six proposals in the immediately preceding review batch, not blanket approval of future workflow details or deployment.

1. Highlight a possible mismatch in the drawing and show its corresponding engineer markup beside it.
2. Continue with the remainder of the plan when handwriting, size or location is unclear; flag the uncertain item for clarification without guessing.
3. Allow acceptance of clear portions and adjustment/rejection of others within the same whole-plan preview.
4. Distinguish **Missing / Different from markup / Unable to verify**. Uncertainty must not be represented as a proven error or a pass.
5. Record an intentional departure agreed with the engineer once, so the same agreed change is not repeatedly flagged. Scope/revalidation when instructions later change remains to define; this is not a permanent blanket suppression.
6. Highlight schedule changes during review, but keep review highlighting off issued sheets. This does not remove intentional issue annotations such as approved revision clouds.

All six intended behaviours are approved. Implementation remains paused while the drawing-to-issue workflow is completed; full command-card safeguards and AutoCAD acceptance remain required. Next batch: drawing register, revisions, dates, sheet selection and issue preparation.

## Drawing register, revisions and issue — Tim's eight answers

1. Maintain one shared sheet list; update the drawing register when sheets are added, renamed, reordered or removed.
2. CE suggests sheets affected by an issue/change; the user confirms which receive a new revision.
3. Unchanged sheets retain their existing revision and date.
4. Apply the confirmed revision/date to affected title blocks and register together, through the existing shared sheet/issue authority.
5. Preliminary revisions typically progress P1, P2, P3 and then A, but the sequence depends on the job and number of revisions. Some jobs include **T1, T2, etc. for tender issue before A**. Do not hard-code a mandatory P-to-T-to-A sequence or fixed number of preliminary/tender issues. Exact issue-stage transitions and later construction revisions remain configurable workflow details to review.
6. Before plotting, show an issue preview listing sheets, revisions, dates and unresolved QA items.
7. **Always a combined PDF** for this confirmed Structural issue workflow; individual-sheet PDFs are not the requested default output.
8. Prepare the PDF filename and dated issue folder automatically, with preview and editable naming.

These answers establish intended issue behaviour, not deployment or permission to issue a real project. Remaining issue decisions include combined-PDF sheet membership, issue descriptions, revision clouds, failed/cancelled plotting and unresolved-QA handling. Unchanged sheet dates must not be overwritten by a set-wide issue date. Keep one shared register/issue owner and avoid duplicating services across Structural areas.

## Issue completion — Tim's six answers

1. Combined PDF normally includes the full current drawing set, including unchanged sheets; allow selection of a smaller set when needed.
2. Suggest revision descriptions from confirmed changes, with user editing/approval of wording.
3. Add revision clouds and triangles **after Revision A**, showing what changed between A, B and subsequent revisions. Whether previous clouds/triangles remain or are replaced is unanswered; do not infer cumulative versus current-revision-only display. This answer does not require clouds on preliminary/tender issues.
4. Clearly present unresolved QA and require an explicit decision before proceeding. Tim additionally requires **learning from decisions**. The desired outcome is confirmed, but learning scope, reuse, correction and approval rules remain to review. Do not silently generalise a project-specific engineering departure into an office standard or treat prior acceptance as permission to suppress new/different issues.
5. Failed/cancelled plotting leaves the issue unfinalised, preserves drafting work and allows retry without advancing revisions again.
6. Following successful issue, retain the exact sheets, revisions, date and issued PDF for later reference/comparison. Successful plotting versus issue finalisation boundaries remain to specify; this planning approval does not authorise transmitting documents.

Next focused questions: handling old clouds/triangles and the scope/control of learning from QA decisions. Reuse all approved issue answers; do not reopen the full batch.

## Revision history and remembered decisions — four approved answers

1. When issuing C, show only B-to-C changes, replacing previous revision clouds and triangles. Previous issued PDFs retain the history. Generalise this to the current revision's changes, while preserving the already-approved rule that clouds/triangles start after A. Exact revision preparation/rollback behaviour remains part of the implementation card.
2. Remember an agreed QA decision for the relevant item on that job; ask again when its relevant drawing or instruction changes. Do not carry stale acceptance forward automatically.
3. Repeated decisions across jobs may become a proposed office preference, but **Tim must approve before broader application**. Repetition alone does not establish an engineering standard.
4. Provide a simple **Remembered decisions** list where the user can see, correct or remove learned decisions.

This resolves the immediately preceding cloud-history and learning-scope questions. User-confirmed behaviour is now recorded from setup through issue at product-intent level. Complete command cards, source reconciliation, interaction examples and acceptance checks remain before implementing new workflows. No blanket implementation/deployment approval is inferred from these answers.

## Whole-plan proposal — six approved answers

Tim answered YES to all six proposals:

1. Before proposing the plan, show the architectural background and engineer markup versions to be used; user confirms those versions.
2. Where structural drafting already exists, propose additions/changes around it and explicitly preview any replacement. Do not silently discard working drafting.
3. Include labels, marks, hatches and the associated member schedule in one coordinated plan proposal.
4. Suggest suitable library details alongside the plan; user confirms suitability before placement.
5. Accepted output remains editable with normal AutoCAD commands while CE maintains confirmed relationships. Existing approved COPY/ownership/protection rules remain authoritative; this does not authorise guessing relationships.
6. Accepting a proposal is one Undo operation, returning the drawing to its pre-acceptance state when undone. Exact transaction, partial acceptance, cancellation and failure checks must demonstrate this before native acceptance.

The whole-plan proposal batch is complete. Next planning action is consolidation of the approved end-to-end journey, separation of existing tools to reuse from new work, and identification of only material unanswered workflow details. No broad repeat questionnaire is required. Product-intent approval does not prove feasibility, implementation or native acceptance.

## Hands-on drafting and architectural context — follow-on requirements

Tim approved: (1) selecting an object shows relevant CE actions/properties; (2) remember manually adjusted label positions and avoid rearranging them during updates; (3) later engineer changes are presented as a preview of only what changed. His YES to a choice between framing, footings/slabs and sections/details did not select an area. Framing is the Control Room's proposed first walkthrough, not a user-selected priority.

Tim explicitly requires contextual understanding of **architectural plans and elevations, wall lines, voids, setdowns and the rest**. This is a core product requirement, not an assertion of existing recognition capability. It must support both assisted proposals and hands-on drafting.

Planning scope for architectural context:

- Identify drawing/view type, source/version, scale/orientation and represented level; associate corresponding plans and elevations (and sections where supplied). Distinguish explicit level/height evidence from assumptions.
- Interpret wall faces/thickness, openings such as doors/windows, stairs, voids, slab edges, setdowns/steps and other relevant architectural features. Retain site/boundary and roof context where relevant. The extended feature list is a scope proposal to refine through examples, not permission to infer structural design.
- Keep source geometry/annotation, interpretation, confidence/uncertainty and user confirmation distinct. Layer names, colours, blocks and geometry may contribute evidence; no single naming convention establishes meaning universally.
- Distinguish linework from engineering authority: an architectural wall is not automatically loadbearing; a void does not imply an approved framing solution; a setdown outline does not establish depth unless supported by explicit evidence. Mark conflicts between plans/elevations/instructions for review rather than silently resolving them.
- Relate each interpreted feature to its source objects/view and level, and to relevant proposed structural items. Respect separate source-Xref regions, under/over uses, host placement/clips and display overrides. Coincident lines from different levels must not be merged into one physical feature merely because they overlap in a host plan.
- Let users inspect/correct interpreted meaning; re-evaluate affected interpretations when relevant source geometry or instructions change, preserving unrelated confirmed decisions. Apply already-approved remembered-decision controls; office-wide reuse requires Tim's approval.

Acceptance planning must include representative annotated examples of walls versus openings, actual voids versus hatches, setdowns with known/unknown depths, matching/conflicting plan and elevation evidence, and revised backgrounds. Measure missed features, false identifications, correct level assignment and uncertainty handling. No whole-plan automation accuracy claim or release percentage follows from adding this requirement.

Ownership: architectural interpretation is one shared capability used by Drafting, Framing, Foundations and Sections & Details, coordinated with the existing Drawing Intelligence/evidence owner. Do not implement separate competing readers per area or start broad source collection from this scope statement. The nominated example job remains representative, not universal. Workflow/data contracts and bounded source permissions remain to reconcile before implementation.

## Elevations and load-path context — Tim's clarification

Tim endorsed the architectural-context approach and stated that elevations help understand loading and paths through the project. Relate plan/elevation/section evidence across levels to identify supported elements, vertical relationships and candidate load paths for review. Present a traceable path through relevant roof/floor elements, members, supports and foundations where evidence permits; flag missing or conflicting connections rather than invent them.

Architectural geometry alone does not establish structural connectivity, load magnitudes, bearing conditions or adequacy. Keep candidate interpretations separate from engineer-confirmed support/load-path intent. This requirement supports drafting and coordination; automatic structural analysis/design or numerical load calculation is not newly approved by this statement. Existing provenance and unknown-state rules remain authoritative.

## Framing walkthrough — six approved decisions

Tim approved the first-floor framing walkthrough choices:

1. Identify the plan using its sheet viewport where available, with model-space area selection as an alternative.
2. Distinguish proposed additions, changes and uncertain items visually during preview, with a simple legend. Apply normal CE drawing styles after acceptance; preview styling is not issued output.
3. If a beam mark/location can be interpreted but its size is unclear, show the proposed location and mark, flag the missing/uncertain size, and require the user's decision before committing that item. Do not invent the size or silently commit it as confirmed.
4. Selecting a proposed beam highlights its proposed supports, with source evidence available for review. Proposed connections remain distinct from confirmed structural relationships.
5. Initial label placement follows office conventions; preserve subsequent manual adjustments. Exact conventions must come from approved existing behaviour or reviewed examples, not a new arbitrary rule.
6. Insufficiently supported items remain in a visible **Needs clarification** list while clear portions may be accepted. Never silently omit an unresolved item or count it as complete.

This approves the six user-experience choices, not implementation or AutoCAD acceptance. Continue the framing review with manual beam/support edits, coordinated updates and exception handling, reusing ST-01/ST-02 rules (including beam-only COPY retaining its copied label and no support connections). Do not ask Tim to reapprove settled copy behaviour.

## Framing edits and contextual grips — approved answers

1. Selecting a beam shows mark, size, level, linked supports and source instruction in a compact panel. Tim additionally requires **grips like the pipes and pits in Civil**. Use that as the interaction reference; inspect the existing Civil behaviour before defining/reusing mechanisms. Exact Structural grip actions are not yet approved, and Civil connectivity rules must not be copied into Structural by assumption.
2. Direct beam-label edits may be interpreted as mark/size changes, but preview the interpretation before updating linked information.
3. A confirmed beam-size change updates its label and schedule and flags affected details; review details before modifying them.
4. A manual edit leaving a beam away from its confirmed support highlights the connection for review; never silently reconnect to nearby content.
5. When members share a mark and one member's size changes, ask whether the change applies to all or this member needs a different mark.
6. Provide access to the relevant markup from the beam's contextual panel where the source is recorded.

Next bounded review: define endpoint/body/label/support grip actions, selection preview, confirmation and Undo, while preserving existing ST-01/ST-02 ownership, COPY and native protection rules. This is approval of intended interaction, not a claim of installed grip functionality.

## Structural grip actions — all six approved

Tim approved all six proposed actions with "YEP ALL OF THAT IS GREAT":

1. Beam endpoint grip adjusts that end with live preview and flags any affected support connection.
2. Beam body grip moves the beam and its owned label together; supports remain in place and affected connections are reviewed.
3. Label grip repositions the label independently and remembers its placement.
4. Support grip previews movement and highlights every connected beam affected; it does not silently stretch those beams.
5. Explicit connection action selects/changes a support and highlights the proposed relationship before confirmation.
6. Escape leaves the drawing unchanged; accepting a grip operation is one Undo step.

These approved actions refine the previous grip-intent section. Reconcile them with existing ST-01/ST-02 rules before implementation, preserving normal AutoCAD protections and the approved beam-only COPY rule. Grip preview/Cancel/Undo and relationship changes require representative native acceptance; no implementation or acceptance credit is claimed here.

## Foundations and freedom to edit — approved answers and core constraint

Tim approved all six foundation proposals:

1. Footings/slab regions have contextual panels and editing grips with relevant properties and source instructions.
2. Propose outlines from architectural walls/edges/voids/setdowns together with engineer markup; flag conflicting or missing instructions.
3. Selecting a footing highlights confirmed supported walls/columns; uncertain relationships are shown separately.
4. Slab-boundary changes preview affected hatches, edge beams, thickenings and annotations before coordinated changes are applied.
5. Missing setdown depth/slab thickness is flagged without choosing a default.
6. Confirmed footing marks/sizes feed the footing schedule automatically, with changes highlighted for review.

Tim additionally states commands must not feel **sticky**: users must be able to edit/modify/use objects independently without affecting other things, as well as use coordinated behaviour. This is a core constraint across all Structural workflows, refining previous automatic-update and relationship-maintenance requirements.

Required outcome: support both coordinated and independent edits. Relationships must not trap the user into propagation, snapping back or unnecessary prompts. Independent edits must not silently alter related geometry, labels, schedules or details. Preserve traceability and expose resulting discrepancies for later review rather than pretending dependent information is current. Do not interpret independent editing as permission to bypass locked layers, Xrefs or other native protections.

Proposed interaction for review: normal coordinated behaviour with a readily available **Edit this only** choice before committing an edit; remember the user's preference if approved. Independent action need not permanently disconnect objects. Whether relationships remain for later reconciliation, how users choose the mode (context action/key/global preference), and how long the choice persists remain unanswered. Do not implement a sticky global mode, auto-reconnect or permanent unlinking by assumption. Existing automatic schedule updates apply to coordinated confirmed changes; independent-mode handling must honour this latest user constraint.

## Independent editing controls — all three approved

Tim answered YES to all three follow-ups:

1. **Edit this only / Edit together** is readily available beside grips and in the right-click menu.
2. Independent edits retain relationships for later review unless the user explicitly chooses **Disconnect**. Retaining a relationship does not authorise propagation or establish that it is still geometrically valid; discrepancies remain visible for QA. No automatic catch-up update on returning to coordinated editing is approved.
3. Mismatch notices remain quiet during drafting and appear in the QA panel, rather than interrupting with pop-ups. The previously approved explicit issue-time unresolved-QA decision remains in force.

These resolve control location, relationship retention and notice presentation. Default mode and how long an edit-mode choice persists remain to specify; do not infer approval of a persistent global toggle. Normal AutoCAD protections still apply. This refines earlier automatic-update requirements: **Edit this only** changes only the selected object, while coordinated updates follow **Edit together** and the applicable approved workflow.

## Edit-mode duration — approved

Tim selected **the current operation, with its mode clearly shown before committing**. Edit this only / Edit together is an operation-scoped choice, not a persistent global toggle. End the temporary choice on completion or cancellation; do not silently carry it into later operations. The starting mode for each command remains to reconcile with its approved behaviour; this answer resolves duration and visibility, not an unasked universal default.

## Shared beam feedback implementation scope and support-rotation idea

Tim explicitly instructed implementing live placement feedback for **all commands 1, 2, 4 and 5 through one shared engine with slight command-specific tweaks**. This supersedes the earlier option-A-only implementation sequence. Preserve regular/lower/special/offset semantics, familiar prompts and label rules. Share support capture, feedback evaluation, final-position recheck, refusal/unknown handling and clean cancellation. Command 5 checks its actual final offset geometry. Green means the stated geometric check passed, not structural adequacy. No invented bearing/span limits; unknown authority remains Unknown.

Implementation is assigned in isolated `codex/structural-beam-feedback-12345` from master `0006eb316ca8259a590a6962cc1889231e853ef1`; no deployment or AutoCAD acceptance authorised. Civil preview reference exists on colleague integration, not this master; no Civil modifications. One Astra/high worker is used for Autodesk/Structural complexity. Existing fleet fixes must be preserved/reused. Initial estimate 30–60 minutes for bounded implementation plus review, low confidence because legacy early-write flow requires cancellation work; no additional parallel builder. Usage read at dispatch: 66% weekly used; no credit/reset requested or consumed.

**Separate idea banked, not yet implemented:** placing a support should infer its rotation from nearby wall lines, similar to Tim's ABB/BB experience. Inspect existing bracing/wall-reference behaviour before introducing another resolver. In master, BB derives rotation from two picked points and uses contextual auto-flip; do not equate this with an already available automatic nearest-wall rotation service. Review wall evidence/level selection, ambiguous corners or competing directions, manual override, preview and settings before coding. This idea remains parked while the shared beam feedback task runs. No automatic support rotation code is authorised by the beam work order.

### Support-rotation follow-up approved

Tim confirmed: **Yes—preview, manual override, no guessing.** For the banked support-rotation idea, preview alignment with the relevant wall, permit manual rotation, and leave the angle to the user when corners or competing walls make direction unclear. This resolves that behavioural choice; source wall/level qualification, exact settings and complete command-card checks remain before support-rotation implementation. Beam feedback work continues first.

### ObjectARX direction — shared native core approved

Survey, staged ownership and all-area coverage: [ST-NATIVE-01 shared Structural core](ST-NATIVE-01_SHARED_STRUCTURAL_CORE.md). Verified beam source is held for reconciliation/review in [PR #73](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/73).

Tim explicitly selected **Shared native core across Structural (recommended)**. Use one native ObjectARX core for drawing interactions across the Structural areas, retaining working managed settings, schedules and QA. A complete C++ rewrite is not selected. The current beam-feedback slice remains managed AutoCAD code; do not report it as native C++.

Approved sequence: reconcile the current live/unmerged Structural baseline; survey existing native transform/grip work and reuse its proven boundaries; record a cross-Structural interaction contract; implement one representative beam/support workflow; verify preview, independent/coordinated edits, Cancel, Undo and save/reopen; extend the same engine by reviewed command families. Preserve familiar commands and working behaviour until replacements pass AutoCAD acceptance. Reuse existing native projects first; obtain explicit approval if a new project or build/deployment script is necessary. Deployment still requires Tim's separate closed-AutoCAD authorisation. GitHub plan PR #72 records this direction.

Existing native reuse evidence: `Modules/Shared.Transform.Native2027` and `docs/workflows/TF-01_OBJECTARX_COPY_MOVE_ROTATE.md`; the latter records a later combined source than the local native README. Exact current native source/owner and acceptance must be reconciled before reuse. Do not duplicate the transform owner or deploy independently. The shared beam-feedback source/checks are complete; reconcile and review them before staged native migration. Wall-based support rotation remains a separate approved-preview idea awaiting its evidence review.

## Area ownership and next review batches

| Area | Journey responsibilities |
|---|---|
| Drafting | Template/background preparation, LU improvement, Xref display/alignment, ordinary drafting assistance. |
| Job Coordination | Project folder identity and editable project metadata through existing shared project authority. |
| Framing / Foundations | Engineer-to-drafter structural workflow and edits; existing approved beam-only COPY rule remains unchanged. |
| Sections & Details | Search, preview, project copies, review-on-use and source/version tracking. |
| Schedules & Sheets | Evolving sheet set, register, per-sheet revisions/dates, coordinated checking and issue through existing shared owner. |

Next batches: (1) actual architectural cleanup and engineer handoff; (2) engineer instructions and structural drafting; (3) detail placement/annotation; (4) design changes and revised architectural backgrounds; (5) register, revisions, checking and issue. Reuse these answers rather than re-asking them. Obtain missing examples and review complete prompts/selection/preview/output/Cancel/Escape/Undo/save-reopen/performance before implementation.

## Verification / acceptance

Documentation check: all ten setup answers and eight detail-browser approvals are recorded, source paths preserved, confirmed intent distinguished from unresolved behaviour, and entry-point links checked. No code, build, deployment, drawing edits or corpus extraction. No AutoCAD test is required for this documentation update. Future implementation requires consolidated representative AutoCAD scenarios; do not hand Tim a separate historical backlog.

The existing 135-item evidence denominator remains unchanged: 1 complete, 110 partial, 24 unverified. New journey scope must be reconciled into workflow cards and the release denominator before claiming an expanded-product percentage. Structural colleague package remains unmeasured.
