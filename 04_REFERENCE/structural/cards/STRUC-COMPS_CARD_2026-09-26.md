# Structural computations from the drawing — workflow card (26 Sep 2026)

**Status: DRAFT PLAN.** Tim's UX-SCALC-01..08 settle the intended workflow and family order. Engineering
methods, numerical design rules and code clauses remain OPEN where this repository has no verified rule;
engineer sign-off is needed before a calculated size can be presented as suitable. Nothing in this card is
built, tested in AutoCAD, installed or Tim-accepted. This is the Structural module's future computations work,
not a separate CE_COMPSHEET product (`IDEAS_INBOX.md`, Tim, 20 Sep 2026).

**Decision authority:** `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural computations in the
plugin" and "Structural computations, inputs" (26 Sep 2026); D1 choice 11 and UX-STRUC-11 in the same file;
`04_REFERENCE/structural/STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, "Architectural context and load paths";
`04_REFERENCE/civil-D-F/DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md`, especially §2.9 and UX-CALC-03.

---

## FOR TIM

### 1. What you will do

1. **Start at the member.** Select a beam or footing in the drawing and choose **Design this member**. Tim:
   *"From the drawing (Recommended)"* (UX-SCALC-01). CE proposes the span, supports, tributary width and
   levels it can prove from the drawing. For a footing, it proposes the supported member and available ground
   evidence. Missing or conflicting facts say **Unknown**; they are not silently filled.
2. **Check the load path.** CE traces the roof or floor area carried, any post landing and the support path
   down through members to foundations, as ruled on 14 Sep. Every proposed load names its source (drawing,
   job document, confirmed Settings value or manual entry). You check and adjust each one (UX-SCALC-08).
   An architectural wall by itself is not proof that it is loadbearing or of a load magnitude.
3. **Confirm wind and ground.** CE proposes a wind class from site region plus terrain, shielding and
   topography, shows that basis and asks you to confirm it (UX-SCALC-06). It reads a geotechnical report from
   the job folder where present, proposes site class and allowable bearing with page references, and asks you
   to confirm them (UX-SCALC-07). With no report, those fields stay **Unknown**. No private report content or
   job identity is copied into this repository (DATA-01).
4. **Review the design and drawing change.** The result shows its inputs, calculations, sources, warnings and
   proposed size. Tim: *"Preview, then update (Recommended)"* (UX-SCALC-04). A size change previews the member,
   label and schedule row together. Any CE user may apply the reviewed change; the user and time are recorded.
   One **U** restores the drawing state before that acceptance. Cancel or Escape leaves it unchanged.
5. **Issue the computation.** Use the **same CE-branded computations sheet format as Civil**, with the
   responsible engineer, revision, date and visible source trail (UX-SCALC-02). Tim's UX-CALC-03 answer was
   *"Anyone, names the engineer (Recommended)"*: any CE user may press Issue, must name the responsible
   engineer, and CE records who issued and when. Until issue, the sheet says **DRAFT — NOT FOR CONSTRUCTION**.
   A sheet does not imply an engineer has signed off an OPEN method.
6. **Cover all four families.** Tim chose timber beams/lintels, footings/slabs, steel beams/columns, and
   bracing/tie-downs (UX-SCALC-03). His build order is *"Timber, footings, steel, bracing (Recommended)"*
   (UX-SCALC-05). Slice 1 below is timber beams and lintels.

### 2. What works today and what changes

1. **Member placement and connected drafting — Keep.** The shipping Structural line proposes beam locations
   from walls and supports and has preview/atomic commit paths for connected beam edits. This is drawing
   geometry, not proof of adequacy. It supplies a starting member and drawing context; do not replace working
   placement or support-link behaviour.
2. **Drawing intake for calculations — Modify / Missing.** Beam span and support geometry can be read, but
   **Design this member** does not yet gather a complete, source-labelled tributary width, load path and
   engineering basis. Add confirmation for every derived or typed input. Do not repurpose a placement rule as
   a structural design rule.
3. **Wind and geotechnical input — Missing.** Add proposal, basis, user confirmation and Unknown handling as
   UX-SCALC-06/07 require. Read job documents in place; keep page references with the calculation record.
4. **Four calculation families — Missing.** No complete verified, governed numerical member-design workflow
   for these four families was found in the inspected shipping files. Each family needs its own approved
   method, source and engineer sign-off before sizing is offered as a design result.
5. **Schedule link — Modify.** XCLMTXT already creates a drawing-level member schedule snapshot by mark, and
   `MemberScheduleService` reads it. Keep the one schedule link while computation-derived sizes are introduced;
   update member, label and schedule together after preview (UX-STRUC-11: any CE user, recorded). D1 choice 11
   phases XCLMTXT out later as computations move into the plugin. Do not cut that working route early.
6. **Computation sheet and issue — Rebuild / Missing.** Reuse the Civil D+F sheet's CE presentation, draft
   marking, source labels, review and issue authority. Structural calculations and family-specific content
   need new work. A printable sheet must agree with the reviewed drawing and schedule values.

### 3. Full AutoCAD experience

1. **Ribbon/context trigger:** **Design this member** from a selected Structural member; a discoverable
   Structural calculation entry points to the same route. Keep existing typed commands working.
2. **Prompt and selection:** select one supported member, then show recognised supports, span, carried area,
   levels and sources. Unknown or ambiguous relationships require a user choice; a crossing alone proves no
   connection.
3. **Review:** one calm review shows input, source and proposed value side by side, including wind/geotech
   basis and each load path segment. User adjustments are marked manual. Show rule and clause references only
   when verified and approved; otherwise show **engineering method needs sign-off**.
4. **Preview and output:** show old/new member size, label and schedule row on the drawing. Apply only the
   accepted set. Show affected details for review, without silently changing them. Keep protected layers,
   Xrefs and REFEDIT protected.
5. **Cancel, Escape and Undo:** Cancel/Escape before acceptance makes no drawing change. One accepted update is
   one AutoCAD **U** covering member, label, linked schedule row and calculation record; an exported sheet is
   separately identified and is not presented as undone by U.
6. **Save/reopen:** keep confirmed inputs, manual changes, source/page references, responsible engineer and
   issue revision. On a changed drawing, report, wind basis, Settings value or design rule, mark the old result
   as needing review rather than silently calling it current.
7. **Issue and discovery:** the reviewed CE computations sheet uses Civil's Issue pattern. Any user names the
   engineer; the responsible engineer prints on the sheet and the issuing user/time stay in its record. The
   status is plainly Draft or Issued. Issue does not automatically apply a new member size.

### 4. Example drawings and guards

1. **Fabricated timber example:** one beam spanning two identified supports, with a roof area and a post
   landing shown in a made-up drawing. Show span, tributary width, each load source and the proposed load path.
   Remove the roof connection and check that it becomes Unknown rather than a zero load. No real job evidence
   enters this fixture.
2. **Automated guards to build:** missing geotech stays Unknown; unconfirmed wind remains Proposed; a changed
   source invalidates the prior preview; a manually adjusted load keeps its manual label; member, label,
   schedule and record change together or not at all; one U restores them; save/reopen preserves source and
   issue status; no OPEN engineering rule emits an apparently approved size.
3. **Tim's AutoCAD checklist once built:** select the fabricated timber beam, choose **Design this member**,
   check the two supports, span and roof/post sources, change one input, preview the member/label/schedule,
   Apply, press U once, then save and reopen. Right result: no unconfirmed drawing change, one complete Undo,
   and a sheet whose source and engineer match the reviewed design. Repeat with no geotech report: bearing
   remains Unknown.

### 5. Slices, smallest first

1. **Slice 1 — timber beams and lintels.** Read one selected member's geometry and confirmed load path;
   review wind and any ground inputs that apply; implement only an engineer-signed-off timber method; preview
   and atomically update member, label, schedule and record; produce the shared CE sheet in Draft/Issue states.
2. **Slice 2 — footings and slabs.** Add confirmed support/load transfer and geotech page-backed site class and
   allowable bearing. Unknown ground evidence stays visible. Add signed-off footing/slab rules and reuse the
   same preview, schedule and sheet route.
3. **Slice 3 — steel beams and columns.** Reuse the traced load path and issue route; add verified steel
   section/design methods and the existing member-mark schedule link.
4. **Slice 4 — bracing and tie-downs.** Reuse the confirmed wind basis, trace the full roof-to-foundation path,
   then add signed-off bracing and tie-down rules without inventing a capacity or connection.
5. **Slice 5 — retire XCLMTXT as the primary schedule intake only after the computation-owned schedule has
   passed representative AutoCAD checks.** Keep its typed alias and a safe route for older drawings, in line
   with D1 choice 11 and UX-NAMES-01.

### 6. OPEN questions, each with a recommended answer

1. **OPEN — timber design method, Australian Standard edition, material/grade and serviceability limits.**
   No complete approved rule or clause was established in the inspected repo/plan sources. *Recommended: the
   responsible engineer supplies and signs off the exact method, clauses and office values in Settings before
   Slice 1 offers a calculated timber size; engineer sign-off needed.*
2. **OPEN — footing/slab, steel and bracing/tie-down methods and clauses.** No verified family-wide numerical
   basis is recorded here. *Recommended: approve each family's applicable Australian Standards, edition,
   load combinations, material data and limits before its slice; engineer sign-off needed.*
3. **OPEN — what proves tributary width and supports when the drawing is incomplete?** The 14 Sep load-path
   ruling allows candidate paths for review but does not prove structural connectivity. *Recommended: show the
   proposed geometry and each source, leave uncertainty Unknown, and require the user to confirm or adjust
   before calculating; engineer sign-off needed for any design assumption.*
4. **OPEN — how is the wind proposal calculated and which source governs region/terrain/shielding/topography?**
   UX-SCALC-06 sets the confirmation experience, not a numerical classification rule. *Recommended: use a
   verified, cited current method held in Settings, show each factor and source, and leave the class Proposed
   until confirmed; engineer sign-off needed.*
5. **OPEN — which geotechnical report is current if several exist, or page text conflicts?** UX-SCALC-07
   requires reading with page references but does not choose between revisions. *Recommended: show report
   dates/revisions and cited pages for user selection; unresolved values stay Unknown; engineer sign-off
   needed before relying on a bearing value.*
6. **OPEN — what is the responsible engineer's design approval before Issue?** UX-SCALC-02/UX-CALC-03 allow
   anyone to issue while naming the engineer; they do not define engineering approval of a new numerical
   method or an individual member. *Recommended: keep method sign-off and member review visibly separate
   from the act of pressing Issue, with named engineer and revision recorded; engineer sign-off needed.*

---

## For the builder — source and gate

1. **Read-only shipping source:** `git -C "C:\Lisp Files\CE_ACAD_PLUGIN" show
   origin/claude/struc-d1-prep:<path>` on 26 Sep 2026. `Modules/Structural.DesignCore/BeamProposalEngine.cs`
   proposes beam *locations* from supports/walls; it is not a capacity calculation.
   `Modules/Structural/Services/MemberScheduleService.cs` stores/reads XCLMTXT's schedule rows by mark.
   `Modules/Structural/Models/ConnectedDesign/SelectedBeamInspectorModels.cs` carries selected-beam and
   linked-component status. `Modules/Structural/Services/ConnectedDesign/Commit/AutoCadBeamAtomicWriteGateway.cs`
   shows an existing atomic beam-write boundary to assess for reuse. A targeted search for “computations
   sheet”, “Design this member”, “allowable bearing”, “wind class” and “tributary width” found no matching
   Structural source on this shipping line. This is source inspection, not an AutoCAD result.
2. **Review gate:** Keep/Modify/Rebuild/Missing and the full experience above follow the plugin AGENTS.md
   command/workflow gate. Before code, confirm a fabricated example, engineering methods, automated guards and
   Tim's actual AutoCAD checklist for the first family. No numerical value or code clause is invented here.
