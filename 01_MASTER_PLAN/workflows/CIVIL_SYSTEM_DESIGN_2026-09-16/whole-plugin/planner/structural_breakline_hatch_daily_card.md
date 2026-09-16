# Structural daily breakline and hatch card — one visible result, then controlled conversion

**Latest planning checkpoint:** 2026-09-17T02:08:55.4640633+10:00. This W7 companion covers normal `BL` breakline placement, ordinary structural hatch placement, and the higher-risk `H2A` associative conversion. It inherits [ST-03 Annotation and dimensions](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md>) ST3-11/13/14 and [ST-05 Hatching, utilities and Xrefs](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-05_HATCHING_UTILITIES_XREFS.md>) ST5-1–10, as reconciled in [Structural approved cards](structural_approved_card_reconciliation.md). It supplies no hatch pattern, scale, angle, material/property or engineering value.

> **Current-source observation:** `BL` obtains first/second points in [BreaklineCommands.cs:36](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BreaklineCommands.cs:36>)–[:46](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BreaklineCommands.cs:46>). Hatch routes and `H2A` are declared in [HatchCommands.cs:179](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/HatchCommands.cs:179>)–[:234](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/HatchCommands.cs:234>). Current H2A source moves discovered boundary objects and erases the old hatch before it enumerates a replacement ([HatchCommands.cs:466](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/HatchCommands.cs:466>)–[:518](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/HatchCommands.cs:518>)). That conflicts with approved ST5 replacement-before-erasure and is **not** presented as a target or runtime result. Main/More interaction below is **Proposed** except for explicit approved decisions.

## Ordinary breakline — keep the two-point gesture

| Step | Drafter action | Approved/proposed outcome |
|---|---|---|
| **1. Start `BL`** | Pick first endpoint, then second endpoint in the current model/paper space and UCS. | Keep the simple familiar workflow. Header names drawing/layout/current space/UCS and plotted-scale basis; it does not manufacture a zigzag size. |
| **2. Review one live breakline** | Preview a single clean polyline to cursor, with current plotted-scale sizing and the two selected endpoints. | Preview and final result match. Xref, locked layer, REFEDIT and unsupported-object protections remain; no source geometry is changed. |
| **3. Apply / normal edit** | Apply one breakline. Normal MOVE, COPY and STRETCH remain available on the selected native output. | One intended Undo; no forced save. A manual position/edit is retained, and a copied breakline is a new selected object—not a hidden link to another view or calculation. |

## Ordinary hatch — inspect all visible properties before Apply

| Step | Drafter action | Proposed output / safety boundary |
|---|---|---|
| **1. Choose a retained hatch route and local input method** | Select eligible local boundary/object scope or internal point method where the route permits it. | Header lists actual selected scope, hatch route, pattern/gradient type if supplied, layer, colour, plotted density, angle, scale, origin, background, transparency, draw order and associative state. Each familiar alias remains reachable as a catalogue preset, including the frequently used structural conventions `LBH`, `LBUH` and `BLH`: only individually Approved presets are defaults; Candidate presets are Preview-only. These are review inputs; this card does not set them. |
| **2. Inspect preview** | Preview hatch boundary, fill, full properties and plotted-scale context against the working drawing. During preview, adjust **Scale / Angle / Origin**; `R` rotates and `O` sets origin; `WH` visibly previews its waffle origin before Apply. | A failed/unresolved boundary is shown and left untouched. Preserve islands, openings, boundary selection and draw order; multiple enclosed regions remain independently editable unless deliberately combined. A nearby closed shape, Xref edge or protected object is never silently substituted or unlocked. |
| **3. Apply a new hatch** | Apply creates the named new hatch only after the previewed property/scope review. | Receipt distinguishes hatch geometry, boundary relationship and property result. It is one intended Undo and not a drawing-save or issue receipt. |
| **4. Edit ordinary presentation** | Select the actual hatch and use normal `HATCHEDIT`, grips, Properties or MOVE as applicable. | A CE-owned hatch records an explicit CE-object relationship; a general material hatch remains independent. Proximity never creates ownership. A manual presentation edit does not infer material, source or engineering outcome. Any boundary/property change needing a calculation/design review is shown as such; it is not assumed by a pattern name. |

## `H2A` conversion — replacement proof before touching an original

| Phase | Approved target interaction | Current-source boundary / receipt |
|---|---|---|
| **Select and classify** | More: select existing non-associative hatch candidates. Preview each candidate’s identity, boundary availability, full existing properties and whether protected/unresolved. | Current source’s candidate conditions are observations only. Target keeps unresolved/protected originals untouched and does not promise every selected hatch is convertible. |
| **Preview replacement** | For each eligible candidate, preview the exact proposed associative replacement beside its original: boundary, pattern/gradient, layer, colour, angle, scale, origin, islands/openings, background, transparency, draw order and association state. | Do not erase, move boundary objects or change layer while previewing. Mark each row Ready / Unresolved / Protected / Unknown with a reason. |
| **Apply verified eligible rows** | Apply only rows whose replacement is proven. The receipt pairs original identity with replacement identity and properties, then retires the original in the same reviewed action. | This is the approved ST5 requirement. The current source path that erases before new-hatch proof is an implementation gap, not an accepted shortcut. Complete means every eligible selected row has replacement proof; skipped/unresolved rows remain original and keep their own receipt. |
| **Stop, Cancel, retry** | Stop/Escape before Apply changes no selected hatch/boundary. During an eligible batch, completed rows retain truthful receipts while pending rows stay unchanged; Undo scope is the completed reviewed batch only. | Before retry, read back original/replacement/boundary state. Failed or Unknown rows require verified absence or safe resume; never repeat by status label where partial geometry may exist. |

## Fictitious daily drawing example

On a synthetic section layout, the drafter runs `BL`, picks two points in a rotated UCS, sees one plotted-scale preview and Applies. They STRETCH the selected breakline once; it stays a normal drawing object.

They then hatch a selected local boundary after inspecting pattern, layer, scale, angle and associative state. A second candidate has an unresolved Xref boundary and remains untouched. Finally they choose H2A for two existing hatches: one preview proves an associative replacement, while the other is Unresolved. Apply replaces only the first and pairs the receipt; the second original remains. They Stop the batch, read both rows back and use one Undo for the completed conversion scope. No source boundary is moved, original erased or hatch duplicated merely because another candidate was nearby.

## Future representative acceptance

Use a synthetic model/paper-space, rotated-UCS drawing with local closed boundary, unresolved boundary, Xref boundary, locked content, associative and non-associative hatches. Inspect: BL first/second point, preview/final match, plotted-scale/current-space behaviour, normal MOVE/COPY/STRETCH; hatch full-property preview; no protected/unresolved mutation; H2A per-row original/replacement pairing; replacement proof before original retirement; Stop/Escape, completed versus pending receipts, one Undo, partial readback/retry and save/reopen. Inspect actual drawing output before reporting Tested or Tim-accepted.

**Outstanding Tim choices:** none created. Main/More placement and receipt layout are **Proposed**. The standard hatch conventions, associative replacement safety, native protection and normal breakline editing are approved. Actual hatch engine behavior, batch Undo, save/reopen and H2A migration implementation are future evidence gates.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.



