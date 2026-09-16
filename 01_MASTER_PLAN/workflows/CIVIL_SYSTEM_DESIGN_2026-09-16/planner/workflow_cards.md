# Civil workflow review cards

**Use:** These are small, grouped review cards for Tim before implementation. “Existing” means only what the named planning/test record supports. A blank/Unknown field is not a fault claim and must not be filled from source-reading guesses.

## How to read the cards

| Mark | Meaning |
|---|---|
| Keep | Preserve a supported route/behaviour while its replacement is tested. |
| Modify | A supported route needs a reviewed change. |
| Rebuild | A supported current route is inadequate and needs a replacement before retirement. |
| Retire | Only Tim can approve permanent removal. None is proposed below. |
| Missing | The required experience has no supported complete route. |

Every card below is **Proposed, not yet Tim-approved**, unless it explicitly quotes an earlier approved direction. No card claims Built, Tested, Installed or Tim-accepted.

## Batch 1 — start a project, evidence and requirements

### A1 — Project recognition and document review (`CDDESIGN`)

| Field | Review card |
|---|---|
| Classification | **Modify** existing CDDESIGN direction; the full integrated route is not verified. |
| Current works | The planning record supports three groups: Discharge, Design criteria and Catchments. Report families and page evidence are approved planning inputs. |
| Wrong / missing | Test Day says current CDDESIGN is command-line-led, searches too narrowly, has malformed prompts and fails to progress after council uncertainty. Integrated automatic project recognition is not verified. |
| Intended result | From an empty base drawing, show the likely project, documents found across the job folders, duplicate/copy status, source page preview and one next action. Let the engineer **Select / change documents**; never force a folder-link wizard. |
| Trigger | `CDDESIGN`, Civil ribbon, or a Design/Review entry point. |
| Prompts / selection | Only ask to resolve a genuinely ambiguous project, choose governing document/value, or add a missing source. Newer file is not selected automatically. |
| Preview / output | Source page when reviewing evidence; job overview and actual drawing later. Save selected-document identities, page/revision/status and governing decisions; no drawing output merely from discovery. |
| Cancel / Escape / Undo / reopen | Cancel discovery or document review without changing the loaded/guiding set. Reopen shows what was reviewed versus confirmed. Changing loaded documents is a recorded project decision, not an Undoable drawing edit. |
| Dependencies / performance / discovery | Project context may produce a candidate only; a current path helper's fallback directory cannot prove job identity, and sheet-scan exclusions must not suppress relevant report folders. Use safe recursive discovery, duplicate comparison, report readers and a progress/cancel state. Discovery must not block normal drafting. |
| Evidence and acceptance | Use a synthetic multi-folder job with an exact duplicate, a dated draft and an image-only report. Tim opens CDDESIGN, sees documents and page evidence, changes only the loaded document choice, then closes/reopens and sees the same governing choice. |

### A2 — Requirements, council and rainfall

| Field | Review card |
|---|---|
| Classification | **Modify** criteria entry; **Missing** confirmed current IFD-block acquisition route. |
| Current works | Settings-first and per-council provenance are binding. Council behaviour has three modes: Published, Council-issued and Compute-to-ARR. Existing record says a one-location Melbourne curve exists; no silent all-job fallback is permitted. |
| Wrong / missing | Council rules historically land in warnings; not every required field is represented and the council integration record says nothing there is built. Blue Factor identifies municipality rather than a rainfall station. How a new coefficient block is fitted/obtained is Unknown. |
| Intended result | CDDESIGN proposes document-derived requirements, labels each as sourced/assumed/office/manual, and asks for confirmation before design impact. Each job carries its own IFD coefficient block, location and source. |
| Trigger | Design criteria section; Settings route for standard/council maintenance. |
| Prompts / selection | Confirm governing council edition/requirement; paste/select a job IFD block when missing; record a reason for manual or pinned choice. Do not ask users to retype extracted values. |
| Preview / output | Source-page highlight and concise comparison. Output is a confirmed criteria record, not a generated drawing note. |
| Cancel / Escape / Undo / reopen | Cancel retains the prior governing criteria; inspection does not pin a value. Reopen shows source, date/edition and any override. |
| Dependencies / performance / discovery | Council rulebook schema, per-job coefficient storage, source extraction and Settings. No external data fitting process is assumed. |
| Evidence and acceptance | Tim opens a synthetic job with two conflicting criteria documents and no job curve, sees both sources and a clear Not set curve state, chooses one criterion and supplies one block; calculation stays clearly blocked/warned until the selection is made. |

### A3 — Legal point of discharge / outfall

| Field | Review card |
|---|---|
| Classification | **Modify** existing CDLPD marker/note workflow. |
| Current works | CDLPD marker exists in plan records; LPD concept requires position, level, denotation and typical note. Test Day found missing connection choice and wrong note/leader behaviour. |
| Wrong / missing | Full authority connection evidence, uncertain outlet invert and generated note workflow remain incomplete. |
| Intended result | One LPD record used by CDDESIGN and Drainage Items. It holds connection type, position, optional level, source evidence and a normal CE drawing note; missing invert produces no fake number. |
| Trigger | CDDESIGN discharge row, CDLPD, or Drainage Items LPD option. |
| Prompts / selection | Place/select marker; choose supported connection type; enter/confirm level only if known; inspect source qualification. |
| Preview / output | Actual plan preview and MLeader-style note preview. Output is marker/note presentation linked to the single LPD record. |
| Cancel / Escape / Undo / reopen | Placement is one drawing operation/Undo. Escape removes temporary placement. Reopen preserves Not set rather than zero. |
| Dependencies / performance / discovery | Existing LPD behaviour contract, note style, protected-object checks, CDDESIGN record door. |
| Evidence and acceptance | On a clean drawing, place LPD without level and confirm the note omits the IL clause; set a level, confirm two-decimal wording and MLeader placement; reopen and check identity/level/source remain. |

## Batch 2 — survey, surfaces and catchments

### B1 — Survey / consultant import and existing levels

| Field | Review card |
|---|---|
| Classification | **Modify** partial CDIMPORT route; full unified import is **Missing**. |
| Current works | Source-observed routes are CDSURVEY (Xref/raw survey, spot levels/TIN and transform), CDIMPORTXCIVIL, CDIMPORTLANDXML and CDIMPORTCOMPARE. Their command-line/file-picker flows, reports and replace choice are retained routes. |
| Wrong / missing | A unified reviewed user experience and its update reconciliation are not proven. Source observation does not establish runtime behaviour, supported project recovery or AutoCAD acceptance. |
| Intended result | Read external survey/consultant/context data, show proposed changes and provenance, then allow selected safe adoption. Existing/proposed RLs stay distinguished from a manually adopted design level. |
| Trigger | `CDIMPORT` / Survey entry from CDDESIGN or review. |
| Prompts / selection | Select source and map/confirm items; do not auto-change existing drawing geometry. |
| Preview / output | Source/change-list preview and actual drawing overlay. Output is accepted project evidence and/or selected drawing changes. |
| Cancel / Escape / Undo / reopen | Scan is read-only. A chosen import is previewed then one accepted operation/Undo; reopening records source and accepted revision. |
| Dependencies / performance / discovery | Format adapters, coordinate/units checks, drawing-protection gate, source ledger. Long imports show progress and can stop safely. |
| Evidence and acceptance | Synthetic survey with altered RLs and a locked/Xref item: Tim can inspect all, adopt one permitted change, see locked/Xref as read-only and Undo the accepted drawing change. |

### B2 — Site extent, surfaces and hydraulic catchments

| Field | Review card |
|---|---|
| Classification | **Modify** any retained coordinated foundation; **Missing** integrated persisted allocation experience pending command/data inventory. |
| Current works | Existing outlines/plans, report values and geometry measurement can be proposed. The record strongly requires site extent, surface class and hydraulic catchment to remain separate. |
| Wrong / missing | No accepted complete impervious take-off; unclassified remainder cannot default to pervious; automatic native-DWG recognition is not proved. |
| Intended result | Look for an existing catchment plan first. For each row, engineer can accept source proposal, adjust, select outline, draw boundary or manually enter an area; then separately classify surface and allocate runoff/treatment. |
| Trigger | CDDESIGN Catchments, selected existing catchment plan, DP allocation or Project Review stale warning. |
| Prompts / selection | Confirm each governing boundary/value only where evidence differs or is missing. Provide split/join and intentional-overlap reason. |
| Preview / output | Actual drawing/area overlay while working; source page while checking evidence. Temporary overlays are non-printing and clear on Escape/hide/close/drawing change. |
| Cancel / Escape / Undo / reopen | Proposals and overlays disappear on cancel. Accepted boundary change is one Undoable drawing action; a manual number does not alter geometry. Reopen shows measured, report and governing values. |
| Dependencies / performance / discovery | Outline recognition, measurement units, classification suggestions, overlap/unallocated checks, locked/Xref/foreign guard and catchment record. |
| Evidence and acceptance | Synthetic roof, driveway and garden outlines plus a pre-drawn catchment plan. Tim sees the existing plan first, selects it, splits a roof across two DPs with unequal confirmed portions, and sees no double count or automatic pervious remainder. |

### B3 — Downpipes and Drainage Items

| Field | Review card |
|---|---|
| Classification | **Keep/Modify** the approved Drainage Items concept; retained command mapping must be preserved. |
| Current works | Item choices/content and command preselection are settled in the 15 Sep handover. DP allocation rules are settled. |
| Wrong / missing | The completed persisted roof-to-DP allocation integration is not established. Existing “Roof Drain” source identity needs deliberate reconciliation. |
| Intended result | One item window with item first and pipe connection later. DP can opt into a confirmed catchment portion; a DP label can hide without losing engineering identity. |
| Trigger | Existing DP/IO/GIO/FW/TG/AGI/OF and More-item commands; selected plan item. |
| Prompts / selection | Type preselected; only ask for optional engineering fields that apply. DP uses existing project catchment/pick outline/manual entry and confirms allocation. |
| Preview / output | Large actual-plan preview; item symbol/label as presentation. |
| Cancel / Escape / Undo / reopen | Escape cancels placement; accepted placement one Undo. Reopen shows explicit versus inherited item value, allocation and unassigned remainder. |
| Dependencies / performance / discovery | Existing command mapping, item identity, connection protections, catchment-record door, drafting settings. |
| Evidence and acceptance | Place two DPs on a 200 m² confirmed roof, assign 120 and 80 m², check project total remains 200 m² and each DP retains its own contribution after reopen. |

## Batch 3 — physical drainage and civil surfaces

### E1 — Pipes, pits, grades, labels and topology

| Field | Review card |
|---|---|
| Classification | **Modify** active core workflows; do not retire any working path. |
| Current works | Pipe/pit/edit routes, topology principles, pit drop, label authority and normal AutoCAD edit protections are documented. Test Day confirms several real failures/untested changes. |
| Wrong / missing | Split timing/text/vertices, invert edit, pit resize/pipe-end adjustment, object conversion and some selection/connection behaviours require active remediation. This card does not duplicate that implementation work. |
| Intended result | Familiar drafting with stable Civil identity, local reassessment, direct connection review and truthful warnings. Exact touch may connect; crossing/proximity never does. Editing presentation never changes engineering inadvertently. |
| Trigger | CD, CDEDIT/PIPEEDIT/PITEDIT, grips, normal MOVE/STRETCH, CDCHECK and context routes. |
| Prompts / selection | Select actual object/endpoint; ask only for tolerance/ambiguous connections or a requested engineering choice. |
| Preview / output | Actual plan preview and selected-object highlight. Labels/annotation place from real object geometry. |
| Cancel / Escape / Undo / reopen | Reversible editor preview where safe; one accepted edit one Undo; local reassessment only; reopen preserves identity, topology and explicit overrides. |
| Dependencies / performance / discovery | Native Civil object compatibility, link/cache service, annotation rules, protected-object guard, editor contract. |
| Evidence and acceptance | Representative pipe through pits, branch touching a main, crossing pipe, pit resize and manual invert: Tim sees exact links retain/adjust correctly, crossing stay unconnected, labels remain clear, and Undo/reopen preserve result. |

### E2 — Surface drains, slab systems and site grades

| Field | Review card |
|---|---|
| Classification | **Modify** known partial slab/surface routes; grade/overland route status is **Unknown**. |
| Current works | Source-observed: CDSTRIP point/MLINE route, CDSPOON closed route, CDTG placement/direction/length/width/style/class/cover-level prompts, CDAGI, and CDSLAB/CDSLABIMPORT/CDSLABEDIT/CDSLABEREGEN. Slab screens expose name, surface, control-point FSL/source, falls/regeneration and outlet-pit checks. |
| Wrong / missing | Complete insertion/regeneration correctness and the scope/behaviour of an overland/flood workflow are not proven. No dedicated CDOVERLAND command was observed in the bounded command scan. |
| Intended result | Draw/edit physical strip drains, trench grates, AGIs, slab drains and site-grade/flow evidence through dedicated routes. Keep treatment/network inference explicit. |
| Trigger | Drainage Items, CDSLAB/surface-drain command, selected object or CDDESIGN review warning. |
| Prompts / selection | Draw/select route, choose relevant type/detail, set applicable dimensions/levels; no AGI engineering diameter/grade/level fields by default. |
| Preview / output | Actual plan route/detail preview, with temporary flow/surface overlay where reviewed. |
| Cancel / Escape / Undo / reopen | Temporary route/overlay clears; accepted geometry one Undo; regenerate must not overwrite manual/pinned changes. |
| Dependencies / performance / discovery | Standard detail library, surface/catchment record, grade/level evidence, protected geometry controls. |
| Evidence and acceptance | Draw a strip drain route with width and a TG with level/invert; inspect an AGI as line-only; regenerate an approved slab detail and confirm manual presentation override is retained. |

## Batch 4 — calculations, treatment and storage

### F1 — CDCALC, detention, TWL and OSD output

| Field | Review card |
|---|---|
| Classification | **Modify** existing calculation foundations; **Missing** accepted output/issue experience. |
| Current works | Boyd’s sweep chain, distinct calculated/nominated/adopted discharge concepts, storage/drawn comparison direction and three-output single-record intent are supported. |
| Wrong / missing | Test Day reports unusable computations-sheet output, missing/incorrect detention inputs, typed-TWL refusal and incomplete storage collection. Current record linkage is not verified. |
| Intended result | Calculate from confirmed criteria/catchments/physical storage, show inputs and provenance, present TWL candidates including higher governing elements, permit a recorded typed choice, and compare designed vs provided storage. |
| Trigger | CDDESIGN Calculate, CDCALC, detention/TWL review and Project Review stale flag. |
| Prompts / selection | Resolve changed or Unknown input; choose/enter governing TWL with reason; do not make a floor level the TWL. |
| Preview / output | Actual drawing storage/network evidence plus results table; reviewed source record generates sheet, OSD criteria and detail. |
| Cancel / Escape / Undo / reopen | Calculation preview is non-destructive. Selecting an approved application is explicit and one Undo where it changes drawing output; reopen identifies result/version and stale state. |
| Dependencies / performance / discovery | Per-job IFD, council criteria, catchment provenance, detention branch collection, existing Design Package/Impact concepts (inputs, branches/results/details, stable identities, directed links and status), calculation output generator, Water Tank interface. Do not create a duplicate package without first confirming the existing record link. |
| Evidence and acceptance | Synthetic job with one higher trench-grate candidate and changed catchment: Tim can choose a typed TWL, see rationale/provenance, generate a formatted preview (not Notes list), change a catchment and see output marked stale without its old values disappearing. |

### F2 — WSUD, treatment, pumps, soakage and overland safety

| Field | Review card |
|---|---|
| Classification | **Missing** integrated review workflow; individual device routes require inventory. |
| Current works | Source-observed: CDRG/GIO placement, raingarden project-data mutations, a CDCALC WSUD tab, a Pump System calculation tab, PumpSizing/SoakageSizing services, SPS models/detail generation and rising-main schedule recognition. |
| Wrong / missing | No CDPUMP/CDSOAK/CDWSUD/CDOVERLAND command declaration was observed in the bounded command scan. That does not prove absence elsewhere, but a full device placement/editor, ground-condition, treatment-train and flood/surcharge workflow is not established by this evidence. |
| Intended result | Each treatment/device is placed or selected explicitly, carries its own engineering and source basis, and exposes dependencies to its catchment/physical network/calculation. Overland path is safety evidence, never inferred from plan crossings. |
| Trigger | CDDESIGN treatment row, Drainage Items Raingarden, a specialised device command or Review warning. |
| Prompts / selection | Select/draw device outline/route, confirm association/destination and source assumptions. Unknown capacity/ground conditions remain Unknown. |
| Preview / output | Actual plan/device and temporary non-printing catchment/overflow overlays. |
| Cancel / Escape / Undo / reopen | Clear temporary evidence; chosen geometry one Undo; reopen preserves source, association, exclusions and stale state. |
| Dependencies / performance / discovery | Device catalogue/details, physical connection model, catchment/calculation contract, geotechnical/source evidence, protected-object guard. |
| Evidence and acceptance | To be specified after command/inventory evidence. Tim must first review which device families are retained and their real standard details. |

## Batch 5 — outputs, review, repair and support

### L1 — Profiles, schedules, details, notes and issue QA

| Field | Review card |
|---|---|
| Classification | **Modify** partial foundations; profile/drawing insertion is incomplete. |
| Current works | Source-observed CDPROFILE selects a pit/path and insertion point; Calculations V2 also has Longitudinal path/datum/scale/preview/export/update controls. PITSCHEDULE opens a staged source/review/place workflow with Xref/current-drawing choice, row overrides, sets, warnings and CSV export. |
| Wrong / missing | Exact profile/drawing output correctness and a single issue-ready output contract are not established. Test Day proves the computation PDF cannot be accepted on text tests alone. |
| Intended result | Generate and update profile, schedules, criteria blocks, details and notes from selected reviewed records; keep plan label authority and presentation overrides. Issue review compares generated output against current design/drawing state. |
| Trigger | CDPROFILE, schedule/detail commands, CDDESIGN output door, Project Review issue check. |
| Prompts / selection | Choose route/scope/insertion point/revision output; confirm any stale calculation/source before regenerate or issue. |
| Preview / output | Actual plan/profile/schedule/detail and rendered PDF/XLSX page where applicable. |
| Cancel / Escape / Undo / reopen | Preview must render real artefact. Insertion/update one Undo; save/reopen preserves source-result link and manual display override. |
| Dependencies / performance / discovery | Calculation result contract, drawing object topology, standard detail assets, issue/revision ledger, renderer. |
| Evidence and acceptance | Generate profile/schedule/detail/PDF from synthetic system, open each artefact, update one pipe/catchment and see all affected outputs flagged before deliberate regeneration. |

### L2 — Project Review, revisions and issue

| Field | Review card |
|---|---|
| Classification | **Modify** partial review foundations; **Missing** unified review workspace. |
| Current works | Source-observed Civil Hub is a read-only check with Show on plan/Edit doors; CDDASHBOARD lists/filter/navigates findings and offers explicit propose-fix/audit/export/repair actions. Master calls for review/issue readiness and CDDESIGN direction requires comparison of requirements/calculated/provided values. |
| Wrong / missing | A single source/evidence/calculation/drawing revision workspace and issue gate are not established. Source observation does not verify the current review routes in AutoCAD. |
| Intended result | A clear list of unresolved inputs, conflicts, explicit overrides, stale calculations, drawing/capacity differences and output readiness. Jump from a row to the source page or real plan item. Issue is a review decision, not the meaning of Save. |
| Trigger | Project Review command, CDDESIGN next action, pre-issue output route. |
| Prompts / selection | Filter, inspect, resolve/acknowledge with reason, reopen owner workflow. Never auto-resolve a conflict from date alone. |
| Preview / output | Source/page comparison or actual drawing preview. Output is revision/issue evidence; no automatic issue stamp. |
| Cancel / Escape / Undo / reopen | Inspection changes nothing. Recorded resolution/reason is explicit and preserved; drawing edits occur only in owner workflow. |
| Dependencies / performance / discovery | Revision ledger, stale dependency graph, Focus/Show Where service, output contract. |
| Evidence and acceptance | Change a source, boundary and pipe in a synthetic job; Tim sees three affected items, jumps to each, records one intentional exception and confirms no drawing changed merely by reviewing. |

### M1 — Settings, assets, repair and help

| Field | Review card |
|---|---|
| Classification | **Modify** partial repair/settings foundations; Help is **Missing**. |
| Current works | Settings-first is binding. Source-observed CDREPAIR exposes ordered Sync/Rebuild/Recover then heavy repair/relink/register/upgrade/audit/triage, with status links. CDHELP has context tracking and a modern embedded-guide / older-lane browser fallback; CDDIAG is command-line counts plus Repair Audit direction. |
| Wrong / missing | A unified accepted repair, asset diagnostic and plain-English help/error experience is not established. The repair screen’s declared actions must be inventoried/reviewed before simplification, not treated as disposable. |
| Intended result | Settings visibly hold engineering/council values and sources. Repair scans first, shows a safe preview and offers selected repair. Help explains what user can do next in drawing terms, and diagnostics preserve safe support evidence. |
| Trigger | Settings, CDREPAIR, Help, or a clear “why can’t I edit this?” link. |
| Prompts / selection | Choose only reviewed setting/repair target; distinguish project value from office standard; never modify locked/Xref/foreign content automatically. |
| Preview / output | Read-only diagnostic/repair change list; actual target focus. |
| Cancel / Escape / Undo / reopen | Scan/help no write; accepted repair one Undo and recorded before/after; reopen retains repair status/log. |
| Dependencies / performance / discovery | Settings ownership/provenance, Civil identity scan, asset registry, protected-object detection, support-safe logging. |
| Evidence and acceptance | Synthetic legacy drawing with one repairable Civil identity issue and one Xref object: Tim sees both, repairs only the permitted item, Undo/reopen confirms it, and Help explains why the Xref was not editable. |

## Batch 6 — Water Tank (last)

### G1 — Water Tank

| Field | Review card |
|---|---|
| Classification | **Defer last** — no new design classification in this planning block. |
| Current works | CDWT exists in master history. Test Day identifies window/order/type/dimension/list failures. Tank detention/reuse and physical storage have separate required identities. |
| Wrong / missing | The temporary CDWT ownership override says Claude builds its window. This planner will not duplicate or reassign the work. |
| Intended result | To be reviewed after all prior family cards and under Claude’s scoped ownership. |
| Evidence and acceptance | Use the existing CDWT task/records; do not reopen settled or active work here. |

---

## Cross-card acceptance guard

For every future build, Tim’s representative acceptance must cover: entry command/ribbon/context route; prompt and selection clarity; actual preview; action/cancel/Escape; one Undo; save/reopen; locked/Xref/REFEDIT/foreign content; required source evidence; performance on an ordinary drawing; and how the user finds the workflow again. A card is not accepted because its source test is green.
