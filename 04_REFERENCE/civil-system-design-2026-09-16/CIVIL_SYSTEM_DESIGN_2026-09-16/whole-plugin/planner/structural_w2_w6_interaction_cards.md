# Structural W2–W6 interaction cards — proposed review detail

> **Read with:** [Structural workflow cards](structural_workflow_cards.md) · [approved-card reconciliation](structural_approved_card_reconciliation.md) · [high-use action contract](structural_high_use_window_action_contract.md) · [retained-control ledger](structural_retained_control_ledger.md) · [whole-job journey](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). These are planning-only review cards. Source facts identify existing routes and controls; approved requirements govern the target; neither proves AutoCAD runtime behavior, an installed feature, or Tim acceptance.

Each group is a practical set of five to ten related familiar commands or controls. **Main** and **More** are proposed action prominence for review, not an implemented layout. A fictitious drawing is used in every scenario; no client material was inspected.

## W2 — backgrounds, layers, walls and site context

### W2-A. Inspect a drawing before changing it

**Grouped routes:** `LAYERMANAGER`, `LAYERMANAGERXREF`, `XRL`, `XRLFAST`, `CXREF`, `PXREF`, `FASTSAVE`, `CLEAN`.

| What the drafter sees / selects | Fields and evidence | Proposed action sequence and output |
|---|---|---|
| **Main: Drawing Layers** | Filter and one selected layer row: Name, Color, Linetype, Lineweight, On, Frozen, Locked, Plot, CE Std and Expected. These are current controls in [LayerManagerWindow.xaml:41](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/LayerManagerWindow.xaml:41>) and [LayerManagerWindow.xaml:55](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/LayerManagerWindow.xaml:55>). | Select a row; inspect actual versus expected appearance; choose Set Current or Save Layer Changes only after a visible selected-row comparison. The output is a local drawing-layer change or a saved row, never a finding that an Xref or locked layer is safe to rewrite. |
| **More: standards and defaults** | Audit Non-Standard Layers, Apply CE Standard Layers, Export Standards, text status and named standards/defaults are present in [LayerManagerWindow.xaml:70](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/LayerManagerWindow.xaml:70>) and [LayerManagerWindow.xaml:147](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/LayerManagerWindow.xaml:147>). Concrete/steel/masonry selectors and rebar/section lists are source controls, not selected engineering rules. | Audit first; show count and affected local layers; Preview applies only to selected allowed local content; Apply creates one reviewable drawing change. Save as Drawing Default is separate from drawing-layer Apply. Current source actions exist, but their runtime results are unproved. |
| **Main: attach/place Xref** | The approved contract requires attachment or overlay, original coordinates or explicit Pick location, units, Xclip and layer overrides to remain visible. [ST-05 supplement](structural_approved_card_reconciliation.md) governs `CXREF` → `PXREF`. | Choose source and insertion policy, inspect the drawing preview, then Apply the requested attachment/placement. Do not edit the source drawing or its internal layers. If insertion units/path/Xclip are Unknown, block only that change and state why. |
| **More: cleanup/save** | `FASTSAVE` and `CLEAN` are distinct approved routes. | FASTSAVE saves only. CLEAN is Audit → counted/selectable repair preview → explicit Apply → one Undo; it never forces a save. This is an approved target sequence, not a claim about the current command implementation. |

**Cancel, manual and revision contract.** Close/Cancel discards an un-applied layer/default draft; it does not reverse a direct current-source action already invoked. Locked/Xref/REFEDIT/foreign protections remain native gates. A manually chosen current layer or local override stays visible through review; a changed Xref is a review item, never an automatic update. Save/reopen must separately prove the drawing change, any drawing default and the Xref reference.

### W2-B. Interpret wall and batter evidence without designing from it

**Grouped routes:** `LBW`, wall/opening/void/setdown review, `BATTER`, `BATLINE`, local curve selection.

| Step | Selection, current evidence and proposed result |
|---|---|
| 1 — choose evidence | `LBW` currently prompts for wall start then end points ([LoadBearingWallCommands.cs:50](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LoadBearingWallCommands.cs:50>) and [:60](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LoadBearingWallCommands.cs:60>)) and has a context-validation branch. Select a local wall/line only; an Xref wall can be inspected but not altered by inference. |
| 2 — read the interpretation | **Main** shows selected geometry, level/source, opening/void/setdown/elevation evidence and confidence as separate fields. Bearing, load path, support, depth and adequacy remain Confirmed/Manual/Assumed/Unknown rather than being inferred from linework. |
| 3 — compare before output | **More** exposes the context finding and source note. Preview the proposed local annotation/mark and its target layer. Apply is available only for a reviewed local drawing mark; it does not convert a background wall into an engineering fact. |
| 4 — batter linework | `BATTER`/`BATLINE` currently select top and bottom curves ([BatterCommands.cs:59](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BatterCommands.cs:59>) and [:62](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BatterCommands.cs:62>)). Show selected curves and any resulting local linework preview. Do not prescribe spacing or a slope value here. |

**Partial/cancel/revision.** Escape before Apply leaves no proposed wall/batter annotation. If current source has already committed a direct route, that is an observed boundary to be tested separately, not silently rolled back by the new review. Missing elevation, conflicting notes or a void/setdown with no confirmed information remains Unknown; an existing manual interpretation is preserved and any later source difference is a review flag.

**Fictitious drawing scenario.** On a sketch with a locked attached background wall, a local wall line, an opening symbol and two selected batter curves: inspect both walls; create no mark for the background; preview one local annotation; Escape; then run one reviewed local batter action and Undo it. Reopen and check that local interpretation, source evidence and manual note remain distinguishable.

## W3 — beam placement, settings and local edits

### W3-A. Place a beam assembly before editing it

**Grouped routes:** `1`, `2`, `4`, `5`, `BDL`, `8`, `BSET`, `BSETRESET`, `BSETLIST`.

| Job sequence | Field source / selection / output |
|---|---|
| 1 — choose familiar beam route | **Main** retains `1`, `2`, `4`, `5` and `BDL`. Current source declares the five commands at [BeamPlacementCommands.cs:44](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BeamPlacementCommands.cs:44>) through [:68](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BeamPlacementCommands.cs:68>). `5` remains a separate offset-beam route and `BDL` remains the approved paired assembly; do not collapse them into a generic beam. |
| 2 — select/prompt | Preselection validation comes before support/line/point prompts under the approved ST-01 contract. Current source prompts for start/end, type/shortening/text as route-specific input; these source defaults are not new engineering defaults. The selected source, level and any manual choice must be visible before final placement. |
| 3 — preview | Preview beam geometry, actual offset side for `5`, labels, paired `BDL` members, and explicit confirmed support links. A nearby support or label does not become linked by proximity. The approved full decision remains in [ST-01](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-01_BEAMS_LINKS.md>). |
| 4 — Apply | One accepted assembly produces the beam geometry plus its owned label; `BDL` has stable pair identity and two outside labels. A quiet QA mismatch can remain when Edit-this-only deliberately leaves related work unchanged. |
| 5 — More/settings | Beam Settings currently shows placement/text offset, Xref context, tolerance/search, remembered-choice, support OSMODE and support-preview fields ([BeamSettingsDialog.xaml:73](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml:73>)–[:126](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml:126>)). Source validates entries before Save and Cancel closes the dialog ([BeamSettingsDialog.xaml.cs:144](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml.cs:144>) and [:250](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml.cs:250>)). Units and suitable values are not established by this source pass. |

**Lifecycle contract.** Cancel/Escape before final placement removes the pending preview only. A settings Cancel leaves the current persisted settings untouched; Reset Remembered Choices is a distinct source action and must receive its own before/after confirmation. Accepted placement, a beam-only edit and a linked edit each require their own one-Undo proof. Save/reopen must prove beam/pair identity, owned-label position, selected source and manual choice—not merely visible text.

### W3-B. Edit only the selected beam, label or confirmed connection

**Grouped routes:** `BEXT`/`BEXTEND`, `BTX`, `BMT2TXT`/`BTXT2MT`, beam endpoint/body/label/support grips, beam-only COPY.

| Selection and visible action | Proposed review behavior |
|---|---|
| **Main: selected beam** | Show mark, size text, level, source/Manual/Unknown state, owned label and explicitly linked supports. **Edit this only** changes the selected beam or label and preserves any relationship for later QA; it never stretches a support or auto-catches-up another member. |
| **More: connection** | **Edit together** is available only after the preview names every confirmed affected beam/support and the explicit connection change. If a candidate connection is ambiguous, leave it unlinked/Needs review. |
| **Main: endpoint/body/label grips** | Endpoint preview identifies affected confirmed connection; body move carries the owned label; label move is independent and remembered. These are approved target semantics; a custom-grip runtime route is not established by the bounded source scan. |
| **More: text conversion/extend** | `BEXT` uses the owned label rather than nearest text and `BTX` preserves visual centre/rotation/style/text/ownership under ST-01. Treat converted text and labels as a selected compound, not free nearby text. |
| **COPY** | Beam-only COPY yields a fresh beam and copied label with **unconnected** supports until an explicit connection is confirmed. It does not clone a load path or an engineering decision. |

**Partial outcome.** If geometry changes but label/link update cannot be evidenced, show Partial and keep the unresolved relationship for review; do not retry over an already changed beam. If selection becomes Xref/locked/unsupported, retain normal native protection and explain the inability to modify. A source change after a manual beam decision is visible as a difference, not an automatic member replacement.

**Fictitious drawing scenario.** Place a regular beam, an offset beam and a BDL pair on a local sketch; preview a candidate support relationship but leave it unresolved; move endpoint, body, label and support separately; COPY the beam; reopen and verify the copied label follows only its copied beam while supports remain unconnected.

## W4 — supports, bracing and comparison proposals

### W4-A. Place/select a support without guessing a relationship

**Grouped routes:** `DS`, `DS1`, `TS1`, `C1`, `C2`, `SDS`, `SDS1`, `STS1`, `SC1`, `SC2`, `SUPTEXTAUTO`.

| Job sequence | Field/selection/action contract |
|---|---|
| 1 — choose type | **Main** retains the direct support commands and their switch family. Current declarations map these identities to insert/switch implementations ([SupportBlockCommands.cs:109](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SupportBlockCommands.cs:109>)–[:119](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SupportBlockCommands.cs:119>)). Type is a drafting choice, not proof of adequacy. |
| 2 — select or place | Place uses an insertion-point prompt; switch uses selected/preselected support. Current source has a C2 visibility choice and a support-text side prompt ([SupportBlockCommands.cs:219](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SupportBlockCommands.cs:219>) and [:913](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SupportBlockCommands.cs:913>)). Show selected block, type, centre, rotation, mark/label and confirmed link state. |
| 3 — preview | Preview block face/orientation, label side and every beam end that truly touches the support footprint. Ambiguous wall/corner direction requires manual orientation or confirmation; proximity/crossing never creates a link. |
| 4 — apply/output | A support with label is one block/data/label compound. Switching retains centre, rotation, mark, label and confirmed links; Apply changes only the selected support scope. |
| 5 — More | Auto text and visibility choices appear only when relevant; diagnostic/advanced choices stay out of ordinary placement. No new support offset, OSMODE or rotation default is proposed. |

**Cancel/Undo/save/reopen/partial.** A cancelled point, visibility or text-side prompt must leave no pending support; current source has transaction abort/commit branches, but runtime result needs proof. An accepted support action is one Undo target. If block placement succeeds but text/link outcome fails, report Partial and do not search nearest text or nearest beam to fill the gap. Save/reopen must retain the compound identity and manual orientation separately from source evidence.

### W4-B. Bracing, joist markers and expert comparison

**Grouped routes:** `AB`, `BB`, `BT1`, `ABS`/`ABSWITCH`, `ABFLIPAUTO`, `R1`, `FJ1`, `P1`, `CEAUTOSUPPORT`, reference/clear expert routes.

| Action prominence | Proposed reviewable sequence |
|---|---|
| **Main: AB/BB/BT1** | Select first end → live completed preview → select second end → inspect flip/orientation → Apply once. Current source starts with a first-point prompt for AB/BB ([BracingCommands.cs:33](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BracingCommands.cs:33>) and [:141](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BracingCommands.cs:141>)); ST-02 governs the target. The AB cap/`MAX` behavior stays as exact approved ST-02 behavior, not a newly chosen number. |
| **Main: switch, don’t redraw** | `ABS`/`ABSWITCH` changes A/B through explicit selected objects without moving/resizing/reflipping them. `F` remains a visible manual override for initial auto-flip. |
| **Main: R1/FJ1** | Select two boundaries, show the in-bay marker preview, then place/tag. Four-point entry is fallback only. `P1` stays hidden pending its lap-rule approval. |
| **More: Auto Support comparison** | CEAUTOSUPPORT/reference/clear remains hidden expert review. It can show selected-evidence comparison markers and reference snapshot, never place real supports or alter originals. |

**Revision and failure contract.** A source/revision change affects only the reviewed selected brace/support relationship. Cancel removes temporary preview and reference markers; Clear removes comparison material only after its scope is shown. If a two-boundary marker cannot resolve the selected boundaries, it remains Unknown rather than using a nearby line. One accepted brace/marker/switch action has one Undo target; cross-drawing/Xref behavior needs native acceptance proof.

**Fictitious drawing scenario.** In a local framing bay with two plausible wall directions, preview AB and choose a manual flip; switch a selected brace without moving it; create one R1 marker from two boundaries; leave P1 unavailable; run expert comparison and Clear it. Undo one accepted brace and confirm no nearby beam/support link appears.

## W5 — foundation systems, size library and regeneration

### W5-A. Size library versus live foundation system

**Grouped routes:** `FST`, `FEDIT`, `BP`, `SCREWPILE`, `STUMPFOOTING`, size-library Add/Delete/Sort/Save, `FADOPT`.

| What is selected | Source field/action evidence | Proposed end-user result |
|---|---|---|
| **Main: Size Library** | Current rows expose Key plus type-specific size fields; source labels include X/Y/Depth, Width/Depth or Diameter/Depth ([FstManagerWindow.xaml:68](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml:68>) through [:257](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml:257>)). Units are not established by this XAML review and no value is approved here. | Select one foundation type and row; show its current/proposed fields, source/Manual/Unknown status and use scope. Add/Delete/Sort remains a library draft; Save Size Library is the explicit draft-save boundary. |
| **Main: place/adopt** | Retain familiar foundation entry identities, but no manager row supplies an engineering value automatically. `SCREWPILE` must block placement if its approved asset is missing; it cannot draw an approximation under ST-06. | Select local geometry/support evidence; preview proposed foundation/detail output, source/Manual/Unknown state and any required asset. Apply only after confirmed scope. |
| **More: FADOPT and library review** | Adoption/relink semantics need selected system/element identity, not a nearest object rule. | Preview existing/proposed object relationship and manual overrides. Confirm only selected element/system scope; no automatic propagation across unrelated foundation records. |

**Boundary already observed.** Size-library cell edits are a draft class: Save calls commit; Cancel closes. That does **not** describe manager operations. The current manager’s immediate actions are separately recorded in [approved-card reconciliation](structural_approved_card_reconciliation.md). Save/reopen acceptance must distinguish library storage from drawing/system state.

### W5-B. Review regeneration, rename, delete and orphan handling before impact

**Grouped routes:** Regenerate Selected, Regenerate All, Rename System, Delete Selected Element, Delete System, Re-link Orphan, Remove Orphan, `FREGEN`, `FREGENALL`, `FDELETE`, `FSTEXPORT`.

| Main/More action | Existing source fact | Approved/proposed target contract |
|---|---|---|
| **Main: selected system/element** | Current manager shows systems (name/kind/elements/issues/orphans), elements (label/kind/driver handle/override/orphan), issues and orphans ([FstManagerWindow.xaml:284](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml:284>)–[:359](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml:359>)). | Select exactly one system or element; show source/revision, manual label override, issues/orphans and proposed affected counts before any operation. |
| **Main: regenerate selected** | Current source directly calls regeneration and refreshes ([FstManagerWindow.xaml.cs:376](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml.cs:376>)–[:384](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml.cs:384>)). | Proposed target is Preview affected elements, changed geometry/labels/annotations, retained manual/pinned values and action-level Undo before Apply. This is not a claim that current Regenerate is draft or safe whole-job update. |
| **More: regenerate all / rename** | Regenerate All and Rename System invoke services immediately after source flow/prompt ([FstManagerWindow.xaml.cs:386](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml.cs:386>) and [:455](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml.cs:455>)). | Require selected/all scope and exact count, then preview. Rename shows old/new identity and revision impact. Partial result identifies which systems changed; it never retries already changed systems silently. |
| **More: delete/orphans** | Current Delete System warns that it cannot be undone ([FstManagerWindow.xaml.cs:505](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml.cs:505>)–[:520](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/FstManagerWindow.xaml.cs:520>)). | ST6-9 replaces broad `FDELETE` with Element only / Entire system choice and exact counts before Apply. Orphan re-link/removal identifies only the selected record; no nearest-geometry relink. |
| **More: schedule handoff** | `FSTEXPORT` remains a source identity. | Redirect to the one ST-07 schedule engine; it does not create another daily schedule or issue output. |

**Cancel, Undo and partial outcomes.** Cancel after editing a size row closes the draft; it does not undo an earlier immediate regenerate/rename/delete source action. Target destructive/rebuild flows need a visible pre-Apply Cancel and one action-level Undo when implemented. If regeneration makes some output but cannot refresh all records, report Complete/Partial/Failed/Unknown by selected system/element, preserve manual values and return to Review—not automatic rebuild. Save/reopen reads drawing compound, system identity, orphan state and library separately.

**Fictitious drawing scenario.** Use a local slab edge, one confirmed support, a missing-depth note, one manual footing label and an Xref edge. Edit a library row then Cancel and reopen; preview a selected-system regeneration with one retained manual label; reject it; rename then Cancel before Apply; compare Element only versus Entire system deletion counts; leave an orphan unresolved; send no schedule until the ST-07 review route is selected.

## W6 — sections, RC and steel detail selection

### W6-A. Select a section/detail from evidence, not from an inferred member

**Grouped routes:** `SBEAM`, `SPEDITSECTION`, `RCBEAM`, `RCRECTCOL`, `RCCIRCCOL`, `CE_SECTIONMARK`.

| Job sequence | Fields, selection and output |
|---|---|
| 1 — start with member or Manual | **Main** starts with a selected existing local drawing element **where possible**, showing linked calculation/source/revision. It also provides visible **Manual creation** for a detail with no selected member; that result is labelled Manual/Unknown and unverified. ST-08 forbids silently treating a drawing as a calculator or inventing a member identity. |
| 2 — choose steel/timber section | Current picker has family/section selection, timber width/depth entry, preview canvas, section properties, display/view orientation, flange direction and scale choices ([SteelSectionPickerDialog.xaml:58](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml:58>)–[:317](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml:317>)). Catalogue presence is not suitability. No picker value/scale becomes an approved default here. |
| 3 — choose RC form | RC Beam picker has Beam Types/Ligature Types and a selection summary ([RCBeamPickerDialog.xaml:64](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml:64>)–[:103](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml:103>)); RC rectangle/circle commands prompt an insertion point only after dialog confirmation ([ColumnDetailCommands.cs:25](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/ColumnDetailCommands.cs:25>) and [:167](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/ColumnDetailCommands.cs:167>)). This is current picker evidence. The approved ST8-5 target replaces **RCBEAM’s** two blind dialogs with **one visual RCBEAM preview**; it does not merge the rectangle/circle routes into that target. Do not mistake the present separate dialogs for the approved RCBEAM result. |
| 4 — preview and place | Preview compound native detail, selected member relationship, inserted/project-copy source version, drawing scale and label/section mark. Missing approved asset blocks placement rather than drawing an approximation. Apply emits one plottable detail compound, one Undo target and a traceable relationship. |
| 5 — copy/edit | Before COPY choose another view of same member, new member, or independent detail. A copied visible mark never silently shares the wrong identity. Section-marker copy receives a fresh internal identity; duplicate reference is flagged for confirmation. |

**Cancel and partial outcomes.** Current SBEAM/RC source returns on Cancelled dialog or insertion prompt ([SectionDetailCommands.cs:36](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SectionDetailCommands.cs:36>) and [:411](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SectionDetailCommands.cs:411>)); this is source flow, not runtime proof. Target Cancel creates no detail. If output geometry appears but relationship/source receipt does not, show Partial and do not duplicate placement on retry. Save/reopen must prove the selected member identity and source/revision separately from graphics.

### W6-B. Reinforcement and steel-detail choices stay explicit

**Grouped routes:** `CE_REBARLINE`, `CE_REBARCIRCLE`/`RBC`, `CE_STIRRUP`, `CE_BARWEIGHT`, `STR`, `BWT`, `RCLIG`, `COLTIES`, `WALLREO`, `STLCONN*`/`PORTAL`/`TRUSS`/`PURLINS`/`BOLTS`.

| Review area | Field source and approved/proposed result |
|---|---|
| **Main: RC member fields** | Current RC member dialog displays width/depth or diameter, bar size/count, ties/stirrups, cover, optional slab/upstand/rebate fields, preview canvas and warnings ([RCMemberDialog.xaml:60](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/RCMemberDialog.xaml:60>)–[:282](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/RCMemberDialog.xaml:282>)). Literal source textbox values are not adopted engineering defaults. Each entered value must display its source as Confirmed/Manual/Assumed/Unknown before placement. |
| **Main: ligature choice** | Current dialog exposes stirrup bar, top/side/bottom cover and top/bottom bar choices, then an OK to pick beam points ([RCLigDialog.xaml:66](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/RCLigDialog.xaml:66>)–[:158](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/RCLigDialog.xaml:158>)). Preview fields and warnings are review inputs, not automatic structural design. |
| **More: bar circle/line and labels** | `RBC` preview must state bar size, count, zone, orientation, final label and **bar-centre radius** under ST6-13. It does not derive a radius. Selected local geometry and source/version stay visible. |
| **More: aliases/retirement** | `STR` and `BWT` have approved removal from ordinary registration. This does not automatically approve or retire `CE_STIRRUP`/`CE_BARWEIGHT`, whose current source methods are shared; preserve transition evidence and do not expose a speculative replacement. |
| **More: steel detail library** | Steel connection/detail family selects an approved source/version and suitability confirmation before placement. Missing approved asset means no approximation; placeholder/phase routes remain hidden or clearly Missing rather than presenting a finished tool. |

**Manual/revision/failure contract.** A manual/pinned reinforcement choice stays visible beside changed source evidence. A changed library/source makes the affected detail Needs review; it does not change bars, detail geometry or schedule silently. Cancel discards picker/member draft and places nothing. Apply produces one compound/one Undo target. If an asset, selected member or relationship is missing, state Missing/Unknown and block only that placement; do not use nearby geometry or a numeric substitute.

**Fictitious drawing scenario.** On a local beam/column sketch with one selected member, choose a steel section and Cancel at insertion; choose an RC beam then leave one value Manual with a reason; preview an RBC using a stated bar-centre radius; attempt a missing library detail and see no approximation; COPY a section mark and choose new-member identity; save/reopen and inspect source/revision/manual labels.

## Audit-depth completion — UX03 to UX06 proposals

These additions are proposals that make the approved workflow reviewable. They do not alter an active owner, establish runtime behavior or choose structural values.

### UX03 — mixed-eligibility foundation regeneration

**Entry:** select one foundation system in the existing manager. The preview lists every requested element under one of four visible headings: **Eligible**, **Blocked**, **Already current** and **Needs review**. Each row shows selected element identity, requested result, manual/pinned label status, source/revision state and the reason for its category. The manager already exposes system/element/issue/orphan rows; this proposal adds no new engineering rule to them.

| Proposed action | Visible outcome |
|---|---|
| **Preview selected system** | Count and list Eligible, Blocked, Already current and Needs review separately. Xref/locked/unsupported object, missing asset, Unknown depth/source, unresolved orphan or conflicted manual override stays out of Eligible with a specific reason. |
| **Apply eligible only** | A prominent confirmation names the selected system and exact eligible count. Blocked/Needs review rows remain unchanged and visible after the operation. The action does not silently widen to all systems. |
| **Cancel before Apply** | Leaves all drawing/system rows unchanged; existing source regeneration is immediate, so this is a target pre-Apply Cancel requirement rather than a claim about current behavior. |
| **Stop / Escape during progress** | Stops launching later eligible elements and returns a Partial receipt naming completed, failed, skipped and unstarted rows. Completed bounded work remains visible; it is not silently rolled back. Offer one action-level Undo only if its implemented scope explicitly names those completed results; otherwise Review is the recovery route. |
| **Progress and completion** | Progress identifies the element currently processed and yields a receipt per element: Complete, Failed, Skipped or Unknown. The **eligible operation** is Complete only when every requested eligible element is Complete; any Failed, Skipped or Unknown result makes that operation Partial/Incomplete. Whole-system readiness is reported separately: it remains unresolved while any Blocked or Needs review row exists, even if the eligible operation completed. A receipt alone never makes either state Complete. |
| **Retry** | Review Partial first. **Both Failed and Unknown rows require drawing/readback evidence of Absent, or a separately qualified safe-resume boundary, before retry** because either may already have geometry. It never reruns Complete rows or creates duplicate geometry. A changed manual/source condition sends the row back to Needs review. |

**Fictitious drawing:** one system contains two eligible local footings, one Xref edge, one missing approved asset and one manual label. Preview shows two Eligible, two Blocked and one Needs review; Apply eligible only; one completes and one fails; retry offers only the failed local footing after review. No Xref, manual label or blocked row changes.

### UX04 — positive background interpretation without false certainty

**Entry:** select a local background candidate or inspect a protected background as evidence. The review header always shows **drawing/view**, **level**, **selected evidence identity** and current interpretation status before any wall/opening/void action. This extends the W2 positive path; it does not make `LBW` source behavior a proven reviewed feature.

| Proposed decision | Preview and result |
|---|---|
| **Confirm wall evidence** | Show selected line/face, drawing/view and level, plus the exact source note/page where present. Apply records an interpretation as Confirmed evidence only; it does not assert bearing, support, member size or adequacy. |
| **Confirm opening** | Select the opening boundary/mark and preview it as an opening associated with the selected wall evidence. It cannot become a void merely because it resembles one. |
| **Correct false void** | Select the previously interpreted void; preview **Not a void** or **Unknown** and the affected interpretation only. Apply clears that interpretation without deleting the underlying background geometry or inventing a replacement depth. |
| **Leave depth Unknown** | Preview carries level/view/evidence and explicit Unknown depth through to the local review output. No nearby elevation, hatch or wall thickness fills the field. |
| **New revision/evidence** | Show prior interpretation beside new evidence; status becomes Needs review. Confirming changed evidence is explicit, while an unchanged manual interpretation remains visible and unmodified. |

**Cancel/Undo/save-reopen:** Cancel/Escape leaves the existing interpretation and background intact. An accepted local interpretation/correction is one Undo target when implemented. Reopen must show level/view/evidence, interpretation status and revision separately; a deleted/missing reference is Missing, never an inferred wall depth or bearing decision.

### UX05 — ambiguous endpoint/support connection and repeated marks

**Entry:** select one beam endpoint and one support footprint or selected support block. The preview shows both selected identities **with drawing/view and level**, their exact endpoint/footprint relation, existing confirmed links and all other nearby candidates as **not selected**. It never scans proximity to make a connection.

| Proposed action | Scope and visible result |
|---|---|
| **Connect selected endpoint** | Enabled only when the user selected both the beam endpoint and support. Preview highlights exactly that endpoint/support pair and names any link that will be replaced. Apply changes only the confirmed pair. |
| **Leave unconnected / Needs review** | Keeps both objects intact and records the unresolved relation. This is the default where more than one candidate is plausible. |
| **Replace existing confirmed link** | Requires a preview of old pair → new pair and explicit confirmation. Unrelated endpoints/other supports remain untouched. |
| **Edit a repeated mark or label** | The selected repeated mark/label has a **mark scope** of that one drawn compound. It is separate from **connected-object scope**, which lists actual linked beams/supports. Editing a repeated mark does not propagate to connected objects; Edit together requires a separate explicit connection scope and preview. |
| **Cancel / partial** | Cancel retains selected objects and links. If a mark move succeeds but link receipt fails, show Partial: mark scope completed; connection unchanged/Unknown. No nearest-object repair or automatic retry. |

**Fictitious drawing:** two support blocks sit near one beam end and two repeated labels exist on different levels. Select one endpoint and one support explicitly, choose Leave unconnected, move one repeated mark, then inspect that neither support link nor the second-level mark changed. Repeat with an explicit Connect selected endpoint and Undo only that connection action.

### UX06 — actual member to detail picker mismatch and copy choices

**Entry:** where possible, the user selects a local actual member before opening steel/RC/detail picker. The equally visible alternative is **Manual creation**, which starts without a fabricated member identity and is labelled Manual/Unknown and unverified. The review header keeps the selected member identity or Manual state, source/revision and selected detail family visible while picker values change. **For RCBEAM only**, the approved target is one visual RCBEAM preview, distinct from current separate picker evidence; the rectangle/circle target surface remains Proposed/owner review.

| Mismatch or copy decision | Proposed visible outcome |
|---|---|
| **Picker selection does not match selected member evidence** | Show a plain mismatch banner naming the member identity and selected detail family/value without declaring engineering inadequacy. Actions are **Choose another member**, **Return to picker**, **Create independent detail**, and **Cancel**. No automatic substitution or hidden reassignment occurs. |
| **Another view of same member** | Preview creates a new placed view linked to the same selected member identity. The original member/data remain unchanged; source/revision is shared visibly, and view-specific label position stays manual/presentation-only. |
| **New member** | Require explicit selection or creation of a new member identity before placement. The copy has its own source/Manual/Unknown status and never inherits a calculation/approval merely from the first member. |
| **Independent detail** | Preview has no member relationship and displays Independent detail. It does not later become linked just because it is near a member. |
| **Cancel after COPY choice** | If the user is still in the proposed pre-Apply copy preview, no copied view/detail or identity relation is created. **Ordinary native COPY already completed is separate:** the copied graphic remains, its member/detail relation is unresolved/Needs review, and Cancel in the later review does not advertise undoing that earlier COPY. |
| **Partial placement/readback** | Receipt separates compound graphics, selected member relationship and source/version record. On Partial, avoid automatic retry over placed graphics; return to the same selected member/picker review with the exact missing receipt. |

**Fictitious drawing:** select one manual beam, open a steel picker whose selection conflicts with the recorded source, Return to picker, then choose independent detail and Cancel at insertion. Copy an existing section mark as another view, Cancel before Apply, and confirm no new view or identity exists. Repeat choosing New member and verify the second member has its own Manual/Unknown state.
## Reclassified presentation details and next planner group

The cards propose familiar Main/More grouping and explicit review doors. They do **not** require Tim to design each button. The formerly labelled Tim-only items are **Proposed owner presentation choices**: wording/icon for Edit together versus Edit this only, inline result versus compact dialog for W2 audit, and initial expansion for a foundation partial receipt. [Choice-authority review](structural_choice_authority_review.md) preserves them while distinguishing them from an engineering decision. **Recommendation:** retain the visible Main action and place diagnostics/all-systems/destructive actions in More with an explicit pre-Apply review.

The next useful planner group is W7–W11 interaction depth, beginning with annotations/sections/text and continuing to schedules/inspection/recovery. It is not undertaken by this card.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.

| 2026-09-17T00:14:34.2552926+10:00 | Proposed | structural_w2_w6_interaction_cards.md | Added five detailed W2–W6 job-sequence cards with grouped existing routes, source fields, Main/More proposals, selection/preview/apply/Cancel/Undo/manual/revision/partial contracts and fictitious acceptance scenarios. |







