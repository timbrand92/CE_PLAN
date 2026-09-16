# Structural steel/timber section detail — daily first-use card

**Planning-only.** This turns the retained W6 `SBEAM` / `SPEDITSECTION` section-detail route into a reviewable daily sequence. It does not choose a catalogue section, grade, connection, member size, source, drawing scale, calculation result or engineering adequacy.

> **Read with:** [workflow W6](structural_workflow_cards.md), [W6 interaction records](structural_w2_w6_interaction_cards.md), [source command/window ledger](structural_source_command_window_ledger.md), [ST8-4 SBEAM workflow](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-08_SECTIONS_DETAILS.md:84>), [ST8-8 section graphics](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-08_SECTIONS_DETAILS.md:158>), [standard-detail library card](structural_standard_detail_library_daily_card.md), [RC member card](structural_rc_member_section_daily_card.md) and [approved reconciliation](structural_approved_card_reconciliation.md). The current ledger records `SBEAM` at `SectionDetailCommands.cs:26`, `SPEDITSECTION` in the W6 section route, and `SteelSectionPickerDialog` as a source-opened dialog. These observations are not runtime proof or an approved catalogue choice.

## Retained route and picker boundary

| Route / surface | Existing planner-record evidence | Planning boundary |
|---|---|---|
| `SBEAM` | W6 records current `SteelSectionPickerDialog` fields: family/section selection, timber width/depth entry, preview canvas, section properties, display/view orientation, flange direction and scale choices, plus drawing-scale output and insertion point. | Keep the familiar direct route; current picker controls are source evidence, not an automatic approved target layout. Catalogue presence is not engineering adequacy, source approval or automatic member selection. |
| `SPEDITSECTION` | W6 records a steel/timber section edit route beside `SBEAM`. | Edit starts from a deliberately selected recognised local section detail. A nearby text label, line, Xref or same-looking section on another level is not selected. |
| Catalogue/source information | Existing records establish type/catalogue selection, stored section identity and drawing output, but do not establish an authority that selects a catalogue entry. | Show the selected candidate’s source/version/approval state where recorded. Candidate, Manual, Assumed and Unknown remain distinct; no silent “latest” or popular-section replacement. |

## One ordinary section detail from direct route to output

The familiar alias remains retained. Current picker controls are source evidence; the proposed review can use an owner-reviewed retained surface, direct prompts and transient drawing preview without adding a compulsory setup window. This card does not declare a replacement layout approved.

| Step | Drafter action | Proposed visible result and limit |
|---|---|---|
| **1. Start with an explicit relationship** | Start `SBEAM`. Select a recognised local member where available, or choose approved **Manual detail** creation. | Show drawing/layout/view/level, selected member or Manual identity, stored/current source state and intended insertion point. The drawing does not become a calculator and no nearby graphics create a member identity. |
| **2. Choose view, then confirm supplied detail information** | Follow ST8-4: choose **section or elevation view**, then confirm supplied size, scale and orientation. Current picker evidence retains family/section, timber width/depth, section properties, display/view orientation, flange direction and scale choices; the proposed review shows supplied type/catalogue and available source/version/suitability beside those fields. | Show candidate versus current selection and all Unknowns. Visible candidate prefills/suggestions may assist the drafter when they show their source/status and receive explicit review; no drawing context, historical use or saved preference silently adopts a governing section, grade or connection. |
| **3. Preview one complete plottable detail** | Follow ST8-4: preview **all lines, hatch, label and dimensions** before picking position. Show stored section identity, chosen section/elevation view, drawing-scale basis, family/section or timber-width/depth information, view/flange orientation and selected/Manual relationship. Preserve the proven break-line option. | Apply the ST8-8 graphics conventions where the selected known section calls for them: continuous visible outline; hidden geometry; two hidden web lines where required; coordinated flange orientation; SHS/RHS/CHS inner walls; and solid timber unless its approved standard says otherwise. If an input required to derive the intended detail is Unknown, state **Cannot confirm complete detail — required input Unknown** and offer Park/Cancel. Do not substitute a generic profile or incomplete graphic as an approved detail. |
| **4. Confirm one local output** | The confirming picker/native placement action names the route, selected candidate, output location, relationship and source/Manual/Unknown state. | Proposed target creates one native plottable section-detail compound with a scoped Undo boundary. It does not change a member, calculation, connection, schedule, sheet or issue state. Current runtime behavior remains untested. |
| **5. Edit selected output later** | Start `SPEDITSECTION` from one selected recognised section detail. Show Before / Current / Pending section identity, source/version, label/presentation, scale basis and relationship. | Keep presentation move/format distinct from a section identity/value change. A changed candidate requires an explicit review; it never silently replaces an Accepted/Manual selection. |

## Revision, copy and truthful lifecycle

| Event | Proposed outcome |
|---|---|
| Source/catalogue revision appears | Show prior/current/candidate selection, source/version/status, selected member or Manual relationship, and current detail graphic. Mark only the affected detail **Needs review**. A newer candidate can be compared but cannot replace a confirmed choice automatically. |
| COPY existing detail | Preview source/target drawing/view/level, fresh detail identity and relationship. Ask the approved same-member/new-member/independent-detail choice only for copying an existing detail. A first detail for a copied member binds that copied member or is explicitly Manual. |
| Manual section detail | Manual creation remains possible and visibly Manual/Unknown. It never gains a fake catalogue identity, member, calculation or source relationship. |
| Manual label/presentation move | Preserve it as presentation. A new Manual move stales only an open draft that consumed its old placement; it does not make a calculation numerically stale or reset the label. |
| Cancel/Escape | Before confirming native placement, no proposed section detail, relationship or source adoption is created. This does not claim rollback of any already-committed current source action. |
| Partial / retry | Read section graphics, stored identity, selected/Manual relationship, label/presentation, source/version and insertion state separately. Retry needs verified absence or safe resume; it never places a duplicate detail over a possible partial output. |
| Save/reopen | Future AutoCAD evidence must separately prove detail identity/geometry, selected catalogue/source state, relationship, drawing-scale/insertion state and Manual presentation. Visible text or outline alone is insufficient. |

## Fictitious before/after

On a synthetic Level 1 framing view, the drafter starts `SBEAM`, selects one recognised local member, chooses **section view**, then reviews a supplied section candidate, size, scale and orientation. The live preview shows all lines, hatch, label and dimensions, plus the retained break-line choice. An unrelated Level 2 lookalike and a nearby Xref line remain unselected. A required input is Unknown, so the preview carries **Cannot confirm complete detail** and is Parked. No generic section is placed.

After a supplied/reviewed input is available, the preview shows one local detail at the chosen insertion point. Visible/hidden lines, any required hidden web pair, coordinated flange orientation and applicable hollow-section inner walls follow ST8-8; the drafter confirms it, then moves its label manually. Later `SPEDITSECTION` opens only after selecting that recognisable detail; a newer catalogue candidate is visible for comparison but is left Needs review. Copying the detail creates a fresh detail identity and asks the relationship choice; it does not alter the original member or issue output.

## Future representative acceptance

In AutoCAD, use a synthetic two-level framing fixture to inspect: `SBEAM` discovery; explicit member versus Manual detail; chosen section/elevation view; supplied size/scale/orientation; candidate/source/Manual/Unknown display; live preview of all lines/hatch/label/dimensions; retained break-line option; ST8-8 visible/hidden/web/flange/inner-wall conventions; required-Unknown Park/Cancel; one local output and scoped Undo; `SPEDITSECTION` selected-only edit; source revision without auto replacement; Manual label move; copy relationship choices; partial/retry and save/reopen. Inspect real drawing output before calling it Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, provider/corpus access or client-project scan occurred.



