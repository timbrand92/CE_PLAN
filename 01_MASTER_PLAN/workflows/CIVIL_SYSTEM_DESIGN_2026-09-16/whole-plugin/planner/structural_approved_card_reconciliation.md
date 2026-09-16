# Structural approved-card reconciliation supplement

**Planning-only supplement.** This records approved Structural requirements that source route inventory alone must not flatten into generic “Keep/Modify” language. It does not claim implementation, testing, installation or Tim acceptance. Source locations identify current route evidence only; the listed approved cards govern intended behaviour.
## Canonical full-decision authority

This supplement is compressed navigation only. The complete approved decisions, refinements and examples remain authoritative and override any shortened row here:

- [ST-01 — Beams and explicit links](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-01_BEAMS_LINKS.md>)
- [ST-02 — Supports, bracing and joist markers](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-02_SUPPORTS_BRACING_JOISTS.md>)
- [ST-03 — Annotation and dimensions](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md>)
- [ST-04 — Text placement](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-04_TEXT_PLACEMENT.md>)
- [ST-05 — Hatching, utilities and Xrefs](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-05_HATCHING_UTILITIES_XREFS.md>)
- [ST-06 — Foundations and reinforcement](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-06_FOUNDATIONS_REBAR.md>)
- [ST-07 — Schedules, Sheets and Excel](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-07_SCHEDULES_SHEETS_EXCEL.md>)
- [ST-08 — Sections and details](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-08_SECTIONS_DETAILS.md>)
- [ST-09 — Markup, checklist, notes and time](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-09_MARKUP_CHECKLIST_NOTES_TIME.md>)

“Full-decision inheritance” means these records retain their exact conditions even if a command appears in a grouped ledger: for example `BDL` is one paired assembly with fixed separation and two outside labels, command `5` previews actual offset side, and copied section marks receive a fresh internal identity while a duplicate section reference is flagged for confirmation.

## W0 / ST-09 — Coordination, notes and time

| Retained route | Approved end-user contract | Source/status boundary |
|---|---|---|
| `CEMARKUP` and `CEMARKUPDWGEXPORT` | Intake order is **Bluebeam FDF/XML**, then local PDF text/geometry, then provider-neutral visual interpretation only where separately approved. Before an external provider receives pages, show file/pages/provider/transmission warning and Upload / local only / Cancel. Match exact DWG/layout with **two or more** known alignment points; Unknown sheet/scale/rotation/revision cannot Apply. Classify engineering text as a decision/check item, never an automatic drawing change. | `ST9-3–8` approved. Existing source routes are not proof that this safe path is built. External COM, Python/pyAutoCAD, LISP/scripts, blind command strings and arbitrary actions remain prohibited. |
| `CECHECKLIST` | Becomes the visible face of one deterministic `QA-01` checklist, with Civil, Structural, Coordination and Issue sections. Automatic Fail/Unknown cannot be changed manually to Pass; N/A needs a reason. | `ST9-9–10` approved. Retain the older route until transition acceptance; shared QA semantics stay with root. |
| `CENOTES` / note placement | Classify the note; retain links to project/drawing/layout/element/calculation/schedule/markup. For concurrent changes show **Keep mine / Keep shared / Merge / Cancel**. Drawn note placement selects an approved style, previews native annotation and retains the relationship without overwriting either record. | `ST9-11–12` approved. Current last-save-wins source is not accepted behaviour. |
| `JOBTIMEREDIT`, `JOBTIMERDEBUG` | Use stable project identity; unknown drawings are Unassigned/not billable. After five inactive minutes pause/exclude idle and offer a visible restoration choice on return. Store corrections as append-only adjustments, retaining active time, excluded idle, manual adjustments, user/project/drawing/session and reason. | `ST9-13–15` approved. Debug remains expert-only. Time data must not be flattened into “save/reopen unchanged”. |
| `CETOOLS`, `CEMARKUP`, `CENOTES`, `CECHECKLIST` transition | Familiar commands remain while they transition to CE Manager **Coordination**; older palettes/windows retire only after transition acceptance. | `ST9-1–2`; Manager surface ownership remains root-owned. |

## W7 / ST-03 and ST-04 — drafting semantics that must stay exact

| Family | Approved retained behaviour |
|---|---|
| Dimensions/leaders | `AD`/`LD` retain native associative dimensions and their normal prompt flow; `Q`/`QD` retain native editable leader/text. `MLL`/`MLR` preview full leader/text/arrow; `F` flips side. `RD` refuses unsupported geometry. Styles are local/portable and previous layer/style/snaps restore. (`ST3-1–6`) |
| Levels/sections/breaklines | `FFL`/`RL`/`SSL`/`NGL` use trusted source or Manual/Unknown, never `0.000`; whole compound previews and `F` flips. `LMU` targets recognised CE level marks only, then Preview → Apply → one Undo. Section marks preview both bubbles/hatch direction/reference; copy gives a fresh internal identity while preserving visible identifier, and a duplicate section reference is flagged for confirmation rather than silently renumbered. `BL` is current space/UCS-aware and plotted-scale sized. (`ST3-7–13`) |
| Text and tags | All familiar aliases map to one visible preset: role/prefix/layer/**plotted** height/justification/preferred side/rotation. `F` flips, `R` changes reference/alignment, Tab cycles ranked alternatives. A full prefix result previews without double-prefixing. Text↔MText preserves link; manual label position is retained; last-used text is session/drawing visible default only. (`ST4-2–14`) |
| Repair/conversion | `DSET`/`DSET1`/`DUP` consolidate to selected scope + existing/proposed style/scale preview + Apply + one Undo; never force save. `R2LTXT` only recognises eligible text and previews selected count. (`ST3-12`; `ST4-11`) |

## W2 / W7 / ST-05 — exact utilities and Xref contract

| Route | Approved retained behaviour |
|---|---|
| Hatches including `H2A` | Keep the frequently used structural hatch conventions and native associative result. `H2A` proves a replacement before erasing its old hatch; unresolved boundaries remain untouched. Full hatch properties and plotted scale remain review inputs. (`ST5-1–10`) |
| `CXREF` → `PXREF` | Preview preserves attachment/overlay choice, original coordinates or explicit Pick location, units, Xclip and layer overrides. Never edit source DWGs or their internal layers. (`ST5-11–12`) |
| `FASTSAVE` / `CLEAN` | `FASTSAVE` saves only. `CLEAN` is audit → counted/selectable repairs → preview → explicit Apply → one Undo; it never forces `QSAVE`. (`ST5-13–14`) |

## W5 — FST manager action boundary correction

The previous high-use contract incorrectly treated all manager actions as draft edits controlled by **Save Size Library / Cancel**. Source shows a split:

| Current action | Observed source effect | Required planning treatment |
|---|---|---|
| Size-library row edits | `FstManagerWindow.xaml.cs:230–264,648`; Save calls `CommitAllEdits()` at `:524–529`; Cancel only closes at `:531–534`. | Retain draft separation for **size-library edits only**. A row is project information, not engineering approval (`ST6-3`). Acceptance: edit row → Cancel → reopen shows no persisted draft; Save → reopen shows saved location. |
| Regenerate selected/all | `:376–386` invokes `FoundationService.RegenerateSystemFromUi` immediately and refreshes. | Existing action is immediate, not draft. Targeted reviewed replacement needs scope/count preview, retained manual/pinned values and a defined action-level Undo before changing it (`ST6-9–10`). |
| Rename system | `:455–466` prompts then immediately invokes `RenameSystemFromUi`. | Existing action is immediate. Retain source/identity/revision evidence; target preview/confirmation must not be misrepresented as existing. |
| Delete element/system | `:426–443` and `:505–521` confirm then invoke deletion immediately. System dialog says “This cannot be undone.” | Existing deletion is immediate. `ST6-9` requires **Element only / Entire system**, exact counts before Apply. Acceptance must cover rename/delete → Cancel close → reopen separately from size-library Cancel, and prove defined Undo/backup only when implemented. |

## Representative acceptance additions

1. Bluebeam markup → local-PDF fallback → two alignment points → overlay preview → one drafting correction → exact batch Undo; then a changed revision refuses stale Apply.
2. Concurrent note edit: preserve both versions through Keep mine/Keep shared/Merge/Cancel; place a linked drawing note with preview.
3. Start time in a registered drawing, switch projects, leave idle, return and choose treatment; manually adjust once and verify an additive ledger entry rather than a rewrite.
4. `H2A`: a mix of convertible and unresolved hatches retains unresolved originals; Undo restores converted ones. `CXREF/PXREF` retains overlay/attachment, units, Xclip and overrides.
5. FST: change one library row then Cancel/reopen; separately regenerate, rename and delete with their immediate current effects recorded. Future replacement must prove the approved scoped preview/Undo before old behaviour can retire.
## W3/W4 / ST-01 and ST-02 — framing, links, supports and bracing

| Family | Approved retained behaviour |
|---|---|
| Beams and copied assemblies | Retain `1`, `2`, `4`, `5`, `8`, `BDL`, `BEXT`, `BTX`; do not revive `1A/2A/4A`. A beam owns geometry + label, while supports are shared linked objects. Valid preselection precedes support/line/point prompts. One side/clearance resolver must give identical preview and final placement, with 45 mm base label offset and 70 mm suffix lift. Command `5` stays distinct because it offsets beam geometry and previews actual offset side. `BDL` is one paired assembly with stable pair identity, fixed separation and two outside labels. `BEXT` uses owned label, not nearest text; `BTX` preserves visual centre/rotation/style/text/ownership. Beam-only COPY creates fresh beam + copied label and **unconnected** supports until explicitly connected. No forced `QSAVE`; touched links update once at command end. (`ST1-1–15`, including Tim’s 12 Sep 2026 beam-only COPY refinement) |
| Supports | Retain `DS`/`DS1`/`TS1`/`C1`/`C2`; switching routes change type through selected/preselected support and retain centre/rotation/mark/label/link relations. A label-bearing support is block + data + label compound. It centres by physical block centre and, where clear, within the wall; otherwise preview + `R` controls orientation. It highlights every beam end that truly touches the footprint; ambiguity needs confirmation. Never find a label or beam by nearest/proximity sweep. (`ST2-1–10`) |
| Bracing and joists | `AB`/`BB` retain first-end → live completed-preview → second-end flow. AB visibly caps at 2700 mm with `MAX`; BB/BT do not. `F` flips initial auto-flip; `ABS` switches A/B without moving/resizing/reflipping. `R1`/`FJ1` become two-boundary selection → visible in-bay marker placement → tag; four points are fallback only. `P1` stays hidden until its lap rule is approved. Esc leaves nothing and each route is one Undo. (`ST2-11–15`) |

## W8 / ST-07 — schedules, spreadsheets, Sheets and issue interface

| Family | Approved retained behaviour |
|---|---|
| One schedule model | One semantic structural schedule with stable row identity, element links, value/source/revision/approval/staleness. Calculation/workbook remains engineering authority; schedule is a coordinated view. A disagreement shows both values as a conflict. `FSTEXPORT` redirects here; no second schedule engine. (`ST7-1,3,5–6`) |
| Import and mapping | Every imported value retains workbook/worksheet/cell-or-named-result/revision-hash/import time, without paths in sanitised support logs. Mezzanine and Second Floor are distinct identities unless project mapping deliberately combines display. Existing learned answers are Candidate suggestions only. `XCLMTXT`: source → detected worksheet/profile → rows/Unknowns → sections → actual preview → Apply → one Undo. (`ST7-4,7–9`) |
| Refresh and sheets | Refresh is normally authoritative-elements/calculations → schedule. Engineering-cell edit produces a linked-element preview; it does not write back immediately. MOVE preserves placed position; COPY creates a project-specific snapshot unless the user deliberately creates another linked view; ERASE removes the view only. `CESHEETS` is the canonical Sheets/Issue workspace; Classic routes transition after parity. Scans are read-only; Update Drawings lists each affected drawing/field. (`ST7-2,10–12`) |
| Issue boundary | The future approved `QA-01` gate governs formal publishing. Per the later approved [14 September Structural drawing journey](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/workflows/STRUCTURAL_DRAWING_JOURNEY_2026-09-14.md>), unresolved QA requires an explicit decision before proceeding, is remembered only for the relevant item/job, and is asked again after a relevant drawing or instruction change; mismatch notices stay quiet in QA. The [whole-job QA authority](../18_NETWORK_SOURCE_SURFACE_AND_QA_AUTHORITY.md) applies that boundary. This planner does **not** assert that current unresolved QA locks out every print/export route. Formal issue preview shows sheets/order/revision/paper/page setup/output and never overwrites issued PDF silently; it stays isolated from active drawing and finalises only after temporary output completion is verified. `XCLMTXTINDEX` remains hidden until a real corpus feature exists. (`ST7-2,13–15`) |

## W6 / ST-08 — sections and details

| Family | Approved retained behaviour |
|---|---|
| Actual member first | Start from selected drawing element and show linked calculation/source/revision or Manual/Unknown; the drawing never silently becomes a calculator. `SBEAM`/RC flows are visual previews of chosen input, not inferred engineering. (`ST8-3–7`) |
| Detail and graphic integrity | Produce native plottable compound detail linework with managed relationships. Approved section graphics, assets and standard-detail source/version govern output; missing Approved asset blocks placement rather than drawing an approximation. (`ST8-8–9,12–13`) |
| Edit/copy/cancel | COPY explicitly asks whether the copy is another view of the same member, a new member or an independent detail; never silently shares wrong identity. Edit preserves explicit relationship/manual choices; Cancel creates nothing and each accepted result is one Undo. Corpus may later recommend but cannot set standards or engineering values. Fake/placeholder commands stay hidden rather than pretending to be complete. (`ST8-10–11,14–15`) |
### ST-06 exact retirement and reinforcement boundary

`RebarCommands.cs:33–41` shows that `CE_STIRRUP`/`STR`/`STIRRUP` currently share one method and `CE_BARWEIGHT`/`BWT`/`BARWEIGHT` share another. The approved disposition is precise: **remove `STR` and `BWT` from ordinary command registration** (`ST6-14`), while preserving source/alias evidence for a controlled transition. This planner does not infer an unapproved daily disposition for the separately named `CE_STIRRUP` or `CE_BARWEIGHT` identities from that shared implementation.

`RBC` remains a compound route whose preview states bar size, count, zone, orientation and final label; its selected radius is explicitly the **bar-centre radius** (`ST6-13`). `SCREWPILE` blocks placement if the Approved asset is missing; it does not draw a substitute circle (`ST6-12`). `FDELETE` is replaced by Element-only / Entire-system with exact counts before Apply (`ST6-9`), and `FSTEXPORT` redirects to the one `ST-07` schedule engine (`ST6-14`).




