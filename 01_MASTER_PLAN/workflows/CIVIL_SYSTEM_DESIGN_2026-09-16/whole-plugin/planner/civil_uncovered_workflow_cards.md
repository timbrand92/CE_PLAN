# Civil uncovered workflow cards — whole-plugin completion pass

**Scope.** These cards add the Civil routes that the earlier family cards did not describe at window/control level. They preserve current-source wording and entry paths before any redesign. They do not reopen approved Drainage Items, active CD/PIT work, CDWT ownership, or root-owned settings/help/project-QA/repair-host design.

- Route/control evidence: [civil_route_control_preservation_ledger.md](civil_route_control_preservation_ledger.md).
- Earlier end-to-end Civil intent: [../planner/workflow_cards.md](../../planner/workflow_cards.md), [../planner/specialist_workflow_details.md](../../planner/specialist_workflow_details.md), and [../planner/engineering_dependency_map.md](../../planner/engineering_dependency_map.md).
- **Status discipline:** “Keep/Modify” below is a planning proposal. Runtime, installed state, AutoCAD test and Tim acceptance are Unknown unless separately recorded.
- Common guard for every card: honour normal locked-layer, Xref, REFEDIT and unsupported-object protections. Review is read-only until user confirms a previewed drawing change. Cancel/Escape must not create quiet data changes; drawing output must have one understood Undo and save/reopen evidence.

## C1. Survey, consultant import, source evidence and triage

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal.** Preserve CDSURVEY, CDIMPORTXCIVIL, CDIMPORTLANDXML, CDIMPORTCOMPARE, CDEXPORTCORPUS, CDTRIAGE, CDSOURCE and CDTAG. |
| Current source evidence | CDSURVEY selects a survey Xref; it can continue with stored spot levels when optional TIN input is skipped and can present raw 3D survey selection. Import commands are declared in LinkCommands.ImportXcivil; source code creates file selection routes. CDTAG selects a source block then offers tag action and label display choice. |
| What must stay distinct | Project-folder/document discovery; source candidate; source selected for review; source explicitly adopted; source tag on drawing; manual input. Newer date never means automatic adoption. |
| Intended result | From the job doorway, show discovered evidence with source page/document preview while reviewing, provenance/date/status/conflict, and the selected source scope. Keep direct survey/import routes for a user who knows what they are bringing in. |
| Trigger / selection | CDDESIGN-style job review or explicit CDSURVEY/import/source command. Select survey Xref, raw source, file/folder or existing tagged block only after the route states scope. |
| Preview / visible action | Parse/compare is read-only first. “Use for review”, “adopt confirmed value”, “keep manual value”, “tag source”, “open drawing evidence”, “cancel”. Import replacement must name prior import and proposed impact. |
| Cancel, Undo, save/reopen | Cancel at any picker/prompt leaves source/adoption record and drawing unchanged. A confirmed tag/import has its own drawing Undo plus saved source/provenance record. Reopen shows candidate versus adopted status, not merely the newest file. |
| Dependencies / performance | Survey transform, spot levels/TIN availability, Xref state, source file reachability, source revision metadata and offline state. Scan only relevant job folders; never rely on sheet-scan exclusions for report discovery. |
| Representative acceptance | Synthetic job: choose Xref, skip optional TIN, compare two source candidates, retain an explicitly manual governing value, tag one source block, cancel an alternate import. Reopen proves no cancelled/advisory source became governing. |

## C2. Calculation tabs, confirmed basis and output boundaries

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal.** Retain CDCALC, CDRUNSOLVE, CDLPD/CDLPDRESET, CalculationsDialog and CalculationsV2Dialog tabs. |
| Current source controls | V2 exposes detention, longitudinal, pipe flow, Boyd’s, charged system, pump system, catchments, WSUD and print. Existing editable groups include detention/TWL/baffle/orifice controls, longitudinal datum/scales/preview exaggeration, pipe properties, Boyd’s areas/PSD/coefficient, charged inputs, pump inputs, catchment rows/manual intensity and WSUD areas/coefficients/treatment selections. Existing actions include Find, Add from drawing, Remove, Refresh, Add Extra, criteria insertion, Swap, print/export selection and Close. |
| What is preserved | Calculation route and tab vocabulary, values versus results, visible Auto/manual toggles, drawing-find/add/refresh actions and print selection. This does not preserve an unapproved numerical basis or a current curve as a silent job default. |
| Intended result | Propose/extract/measure first, then show source/basis/units/reference level and require the user to confirm governing values before calculation/drawing impact. Alternative systems appear only where chosen for that job. Calculation result state remains distinct: Needs review, Numerically out of date after confirmed governing input, and Cannot calculate. |
| LPD scope | One shared LPD record **per selected outlet**. Jobs can have multiple outlets; selected catchments/calculations/requirements cannot mix across outlets. A DP has one destination, although unequal portions may be allocated. |
| Preview / output | Input-side preview explains source, confirmed/pinned/manual state and dependency changes. Drawing-side preview names proposed criteria/detail/profile/schedule output. A report result must state whether it is an assessment, calculator result, or a missing capability. |
| Cancel, Undo, save/reopen | Editing a calculation draft has local Cancel/working-state protection. A drawing insertion/export requires its own confirmation and drawing Undo. Reopen retains source/basis/override and stale state. Retaining a pinned basis can be Needs review after measured evidence changes without automatically becoming numerically out of date. |
| Dependencies | The earlier dependency map governs gravity, detention, roof/reuse allocations, WSUD, soakage, pumps, overland, profiles/schedules. Do not derive values or council policy in this card. |
| Representative acceptance | Select two outlets, retain separate LPD records, change a measured roof while its governing area remains pinned, confirm review is required but recorded calculation inputs have not silently changed. Try a missing rainfall/source and show Cannot calculate without invented fallback. |

## C3. Profiles, pit schedules, labels and generated output

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal** for CDPROFILE, PITSCHEDULE, CDLABELSTYLE and CDEXPORTENTITIES. Active pipe/pit edit controls remain with the CD/PIT owner. |
| Current source evidence | CDPROFILE selects an upstream pit then an insertion point. PITSCHEDULE opens PitScheduleDialog. The dialog has current-drawing/Xref scope, Full Schedule / Changes Only / Place-update steps, set assignment, depth and warning controls, inlet/outlet highlights, row/cell restore, row override enable/revert, group movement/hide and source-state/override columns. |
| Intended result | Retain a large drawing/profile preview while working, then explicit review of source scope, schedule set, calculated versus manually overridden fields, warnings and output placement. Use one source of truth for schedule/profile data; do not invent a second schedule window. |
| Trigger / selection | Explicit profile start pit; explicit schedule source scope; selected rows/groups only for row-level operations. Show which source drawing/Xref participates. |
| Preview / visible actions | Refresh, relink/recalculate, inspect source, review changes, place/update, highlight inlet/outlet, restore cell/row, enable/revert override, show blockers, Cancel. Label style remains a linked presentation choice; it cannot silently change engineering data. |
| Cancel, Undo, save/reopen | Refresh/review is read-only until place/update. Placement needs a drawing preview, explicit overwrite/update scope, one Undo and reopen evidence. Cancelling row/group edits leaves the prior stored override. |
| Dependencies | Selected outlet, current network identity, link health, source/Xref status, profile datum/sales, annotations and output templates. Issue/computations-sheet disposition is root-owned; do not silently resolve the existing F-Q2/F-Q3 questions by generic issue gate text. |
| Representative acceptance | A two-outlet synthetic drawing with one Xref network: create a profile from the selected upstream pit, limit schedule scope, make a row override, view Changes Only, cancel placement, reopen, then place/update and Undo. A missing source drawing remains a visible blocker. |

## C4. Slab, site levels, falls and site-surface drainage

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal.** Preserve CDSLABIMPORT, CDSLAB, CDSLABEDIT, CDSLABEREGEN, CDSL, CDFALL, CDJOINT/CDCJ/CDSC and the SlabDialog/SlabEditDialog routes. |
| Current source evidence | Import selects a closed polyline and cancels non-polylines, open boundaries and fewer-than-three-vertex boundaries. New/edit workflows select an existing boundary or collect points with Close/Undo/Cancel branches; source opens SlabDialog and SlabEditDialog. SlabEdit has Geometry, Falls and Drainage tabs, FSL/source columns, regenerate-falls action, achieved/required grade display and OK/Cancel. |
| What must stay distinct | Site extent, surface impermeability and hydraulic catchments; existing survey/evidence, manually entered level and calculated/achieved fall; slab boundary and fall-symbol selection. |
| Intended result | Recognise a usable existing slab/site plan before asking redraw. Let user accept, adjust, select, draw or manually enter. Show physical drawing preview while editing boundaries/falls, and retain every source state. |
| Trigger / selection | Slab boundary or fall symbol; source polyline must be eligible/closed for the explicit import route. Surface-drain commands remain separately reachable; no generic slab action claims to create drainage. |
| Preview / visible actions | Geometry points and source, fall triangles/status, drainage relationship, regenerate preview, select/draw/manual entry, Keep manual, Cancel. A mismatch remains visible; it is not silently “fixed”. |
| Cancel, Undo, save/reopen | Point collection Undo affects the in-progress geometry; Cancel exits without partial entity. Confirmed regenerate/placement needs drawing Undo. Reopen restores manual/source state and does not overwrite it with changed survey evidence. |
| Representative acceptance | Existing closed slab boundary with two survey-derived levels, one manual FSL and a changed background: select it rather than redraw, alter one point, preview falls, Cancel then reopen. Regenerate only after confirmation, Undo it, and verify the manual FSL remains manual. |

## C5. Surface drains, source items, raingardens and specialized site marks

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal.** Preserve CDSTRIP, CDSPOON, CDFW, CDTG/TG, CDAGI, CDRG, DP/IO/OF/FO/GIO and CDSOURCE. Drainage Items stay in their approved Main/More composition. |
| Current source evidence | CDSTRIP and CDSPOON collect vertices with Close/Undo/Cancel; strip drain asks justification. CDTG uses insertion point, jig/preview, width, style, class and optional cover-level prompts. CDRG collects a boundary through jig points with Close/Undo, then can optionally place GIO. Source-block commands supply distinct entry commands for DP/IO/OF/FO/GIO; generic CDSOURCE prompts for a source ID. |
| Intended result | Keep direct familiar drafting shortcuts and map them to grouped “Surface & site”/More actions without hiding geometry differences. Actual drawing preview remains large; a selected source item can retain tag/provenance/manual override. |
| Trigger / selection | Explicit point path, block insertion point, boundary, selected source block, or user-chosen item type. No inferred hydraulic connection from crossing/proximity. |
| Preview / visible actions | Start point/next point/Close/Undo, style/class/cover only where the specific command requires it, optional related marker, preview, Place, Cancel. For treatment, distinguish a reported assessment from model/calculation capability. |
| Cancel, Undo, save/reopen | Per-point Undo removes only in-progress point. Cancel ends command without committing geometry. Confirmed entity placement has drawing Undo. Reopen retains original source/tag/override and does not auto-connect a nearby pipe. |
| Representative acceptance | Draw strip, spoon and raingarden boundaries with one Undo each; cancel a trench-grate jig; insert a DP and select its sole destination; add an optional GIO separately; reopen and prove no proximity-created link or duplicate catchment allocation. |

## C6. Network review, diagnostics, repair, propagation and revisions

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal** for CDHUB, CDINSPECTOR, CDDASHBOARD, CDREPAIR, CDREBUILDLINKS, CDLINKDANGLINGPIPES, CDLEGACYAUDIT, CDSTARTUPAUDIT, CDFOCUS, CDAUDIT, CDGRAPH, CDPROPAGATE, CDAUDITDETAIL, CDIMPORTAUDIT, CDTRENCHGRATEAUDIT, CDDEBUG, CDRECOVERINVERTS and CDUPGRADE. Shared settings/help/project-QA/repair-host design remains root-owned. |
| Current source controls | Civil Hub offers network health, pit schedule, long profile, plan-versus-schedule, Xref networks, design impact and network redesign. Inspector exposes Properties/Diagnostics plus Edit/Zoom/Schedule/Repair/Label Styles/Refresh/Copy report. Dashboard has Navigate, Propose fix and Export CSV. Proposal/propagation previews show old/new values and Apply/Cancel. CDREPAIR and CDLINK expose Sync, rebuild/recover, links/overrides and Close. |
| Ownership boundary | Active CD/PIT preview/selection/drag/dry-run and CD/PIT workshop changes are not redesigned here. The approved migration applies on existing-job open and every pipe open/edit, after required readers/enabler, with first backup, one Undo and one count/backup line. Do not replace it with “manual only” or invent recovery trigger. |
| Intended result | Scan and explain first. Keep diagnostic state, proposed changes, conflicts and override/reset path visible. Repair must never quietly overwrite sources or protected content. Use root shared host for ordinary repair/help decisions, while retaining named Civil command entrypoints. |
| Trigger / selection | Hub/Inspector/dashboard selection; source/audit scope; explicit selected entity/row. Propagation/repair needs a proposal list with each source/old/new/reason, not an implied global action. |
| Preview / visible actions | Show on plan, check again, navigate, read-only scan, proposal preview, select/deselect, Apply selected, Cancel, copy evidence, help. Existing repair/link menu actions remain preserved for review, not blanket approved. |
| Cancel, Undo, save/reopen | Diagnostics stay read-only. A confirmed repair/proposal receives a bounded single action Undo and before/after evidence. Migration follows the approved trigger/backup/Undo/count conditions. Reopen reveals repair/migration log, links, conflicts and retained manual override. |
| Representative acceptance | Synthetic drawing includes a repairable Civil item, a protected Xref, a dangling/manual link, changed imported source and an approved migration candidate. Show impact, cancel a proposal, apply one permitted change, Undo, reopen, then verify protected/Xref content and manual link were not touched. |

## C7. TPZ and SRZ protection marks

| Review field | Card |
|---|---|
| Classification | **Keep/Modify proposal.** Preserve CDTPZ and CDSRZ. |
| Current source evidence | Each command prompts for a centre point then radius and creates its own drawing mark in a transaction. |
| Intended result | Keep small direct routes for landscape/protection notation. Make their intent, source/manual basis and selected drawing context visible, without claiming they establish arborist approval or constrain unrelated Civil design automatically. |
| Trigger / selection | Centre point then radius, or future selected existing mark edit if separately approved. |
| Preview / visible actions | Crosshair/temporary circle preview, label/source/manual-basis indication, Place, Cancel. |
| Cancel, Undo, save/reopen | Cancel before placement makes no mark; committed mark has drawing Undo. Reopen retains its recorded manual/source status. |
| Representative acceptance | Place TPZ and SRZ on distinct layers in a synthetic drawing, cancel one before placement, undo the other, reopen and confirm neither changed hydraulic catchments or automatic network links. |

## C8. Water Tank — last, owner-preservation only

| Review field | Card |
|---|---|
| Classification | **Defer last.** No redesign, control proposal or ownership reassignment. |
| Current source evidence | CDWT is declared in WaterTankCommand with pickset; source contains selection and placement prompts. |
| Owner boundary | TEST_DAY_RESULTS scoped ownership remains: Claude builds CDWT. The planner preserves the interface only and does not reopen its settled design decisions. |
| Future acceptance | Use the active CDWT owner records. Any Water Tank handoff must retain separate detention/reuse/storage identities, explicit placement/callout choices, Cancel/Escape/Undo/save-reopen and source/revision evidence. |

## Cross-card acceptance batch

For every card, future acceptance must explicitly prove the entry command/ribbon/context route; source/selection scope; visible preview; action plus Cancel/Escape; one Undo; save/reopen; locked/Xref/REFEDIT/unsupported-object handling; manual/pinned override; performance on ordinary drawing; and rediscovery route. No item is **Built**, **Tested**, **Installed**, or **Tim-accepted** because it appears in this planning document.

