# Whole-plugin coverage audit — open findings checkpoint

FOR TIM

The whole-plugin plan is **not yet ready to call complete**. Command/control inventories are useful, but several already approved drawing behaviours need explicit preservation. The bounded browser concept passed its separate recheck; that does not close these planning gaps.

- Preserve the approved text/hatch/cleanup workflows, not only their command names.
- Complete notes, checklist, markup and job-time behaviour.
- Define which manager actions save immediately, which remain drafts, and what Cancel/Undo actually means.

---

## Scope and evidence boundary

Independent Astra/medium planning audit. Checkpoint recorded 2026-09-16 22:59 Australia/Sydney (file creation timestamp is the precise receipt). Root00–11, Structural/Civil cards and action contracts were read; generated inventories were inspected as evidence indexes, not treated as proof that every handler has been reviewed. Approved canonical records were read for concrete findings below. No plugin build/test, source modification, live settings change, network call, AutoCAD action or corpus expansion occurred.

This is an **open findings checkpoint**, not a completed line-by-line audit of all39 approved cards. Discovery reconciliation and CDTAG/CDSOURCE analysis are separately in progress with the planner. Root is producing further shared action and Civil approval reconciliation records. Those deltas require independent review before closure.

## Findings

| ID / severity | Artifact / claim | Authority and actual evidence | Current truth / required change |
|---|---|---|---|
| COV-01 High | planner/structural_workflow_cards.md W2/W7/W11/W-legacy and field/command manifests preserve routes but lack approved decision inheritance | docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md ST3-1–7; ST-04_TEXT_PLACEMENT.md ST4-1–15; ST-05_HATCHING_UTILITIES_XREFS.md ST5-1–15. Manifest FASTSAVE describes cleanup+save, H2A generic hatch preset; W-legacy calls semantics Unknown. | Source facts are correctly labelled, but approved future semantics are not connected. Map exact canonical decisions to workflow/action contracts and later supersessions. Required examples: native linked level compounds; plotted scale/current space; text preset fields, full-prefix preview without duplication, F/R/Tab, session-only remembered marks, TEXT↔MTEXT ownership; H2A prove-before-replace preserving all properties; hatch islands/draw order/independence; CXREF/PXREF full fidelity + units; FASTSAVE save-only and CLEAN no forced save. Do not ask Tim to reapprove settled choices. |
| COV-02 High | Structural W0/W9 and root coordination coverage remain generic | ST-09_MARKUP_CHECKLIST_NOTES_TIME.md ST9-1–13 read directly. Approved one Coordination workspace; CECHECKLIST uses QA-01; Bluebeam/localPDF before permitted vision; >=2 known alignment points; traceable item; exact batch Undo; conflict-safe notes; stable project timer/Unassigned not billable. | New plan captures source surfaces but misses substantive approved modules. Add notes conflict Keep mine/Keep shared/Merge/Cancel, roles and linked drawn annotation; timer identity/idle/recovery; checklist N/A reason and automatic status protection; markup targeting/alignment and batch-specific Undo. Reconcile later rulings explicitly. Command discovery alone does not close this. |
| COV-03 High | planner/civil_uncovered_workflow_cards.md C1/C4/C7 and civil action contract | CV-07_SURVEY_IMPORT.md CV7-1–15; CV-05_SLAB_SITE_LAYOUT.md CV5-1–15; CV-04_SURFACE_DRAINAGE.md CV4-1–15, approved tables read. | Preserve applicable canonical decisions or cite supersession: importer quality visibility gate; source precedence/fingerprint/transform/units; native re-import stable identity/add-change-remove and retained Z; slab edit known crash visibility gate; TIN boundary/breaklines; joint design hidden/preview-only until rules approved; SRZ/TPZ stored treeID/radius/source/revision. Do not treat old numerical rules as new universal defaults; reconcile their authority/version explicitly. |
| COV-04 High | Civil C3 cancellation/persistence and schedule action contract describes flush-on-close without reconciling approved boundary | PS-01_PIT_SCHEDULES.md PS11–20 plus approval refinements read. Approved source-versus-override choice, stale override flag, stale-dialog gate, set revision/fingerprint, copied-instance authority, Close Apply/Discard/Continue Editing. | Add these exact transitions and preserve newer owner status. Current close/save handler observation is not approved Close behaviour. State what is draft, what is already saved, what Discard restores, and how a changed source invalidates preview. PS-01F1 source heading says visual proposal awaits Tim: do not promote it to accepted. |
| COV-05 Medium | Structural high-use contract FST Save/Cancel and generic Undo wording obscure immediate action effects | Actual root Modules/Structural/UI/FstManagerWindow.xaml.cs376–386 regenerates via service;426–524 delete/rename via services before window Save; Delete System warns 'This cannot be undone';530 Cancel only closes. | Separate library draft Save/Cancel from already executed regeneration/rename/delete/relink. Record the warning-versus-approved oneUndo conflict without assuming runtime Undo impossible. Inspect service effect boundary; add accepted action→Cancel→reopen and delete→Undo qualification. Closing cannot be described as undoing accepted work. |
| COV-06 High | root02 + root06 retain shared sheet controls by names, insufficient per-action consequences | Actual44b2 Modules/Structural/UI/Pages/CeProjectSheetsWorkspaceView.xaml.cs2186–2400: Exclude managed state differs Remove From Issue; Duplicate may create drawing or unsaved active layout; Archive confirmation, service call and persistence conditions; Reconcile changes assignments and may persist. | Complete action/recovery contract for duplicate/insert/manage/exclude/archive/reconcile/rename. Parent deeper service inspection found active-DWG partial-layout removal contradicts UI 'skipped' message; this audit does not treat UI wording as service truth. Trace external-file effects, manifest draft persistence, pending QSAVE and failure recovery separately from AutoCADUndo. Root12 is pending. |

## Requirement coverage at this checkpoint

| Required planning area | Observed coverage | Audit disposition |
|---|---|---|
| Whole-plugin denominator and module ownership | 01 inventory, source manifests, owner44b2 supplement;407 declarations/82 baselineXAML/354 registry rows are different denominators | Discovery reconciliation ongoing; counts are not completeness proof |
| New job / shared context / source adoption | 02/05 + earlier Civil lifecycle; explicit candidate/adopted/manual and module boundaries | Substantive coverage present; applicable canonical/source intake detail COV-03 open |
| Civil A–M and Water Tank last | Prior Civil annex + new C1–C8 protect current CD/PIT/CDWT ownership | Family coverage present; COV-03/04 open; no oldCivil closure extrapolation |
| Structural framing/supports/foundations | W3–W6, high-use action contract, journey scope preserved | Good relationship/independent-vs-together direction; FST boundary COV-05 open |
| Structural annotation/text/hatch/Xref/cleanup | Commands and fields inventoried | COV-01 open; approved semantics must be inherited |
| Notes/time/checklist/markup | W0/W9, root04/07 | COV-02 open; not complete modules yet |
| Schedules and spreadsheets | W8 + XCLMTXT action draft/localUndo/insert distinctions; Civil C3 | PS preservation COV-04; source workbook and multi-level scope preserved |
| Project sheets/issue/revision | 02 explicit PDF membership vs revision, failure/retry, actual owner receipt | Issue principles covered; shared sheet actions COV-06 open |
| Settings / catalogue / Help | 03/06 + new11; owner draft, Apply/Discard/Stay, reset vs engineering, fallback preserved | 11 read and relevant VM action names matched; full consumer/units qualification remains explicitly open |
| QA / repair / migration | 07 + C6; ordinary preview repair vs approved C7 automatic exception | Planning boundary covered; native mechanics untested |
| Shared transforms | 09 cites actual native owner and later no-LISP2027 direction | Source-qualified preservation, runtime/packaging not claimed; no duplicated owner |
| Support / release / assistant / cloud | 04/10 staged activation, explicit support scope; timeout/context and202stored:false distinction | Planning recovery covered; exact canonical AI/privacy/release decision mapping not yet exhaustively audited |
| Evidence learning / Pattern Atlas / benchmark | 01 cites39cards; EV01–07 headings/selected approved tables inspected | Not covered by command counts. Need explicit inherited authority + blocked/bounded research scope; no corpus execution authorised |
| Visual language and actual concept | Separate visual audit/closure29checks, opened screenshots | Bounded visual success only; no native acceptance or complete plugin UI claim |
| Completion/elapsed/morning delivery | 00 active restart,08 limited visual statement | Whole planning remains active. No6–8h elapsed or overall completion asserted |

## Next audit work

Review corrected canonical decision mappings against actual approved records, then root12 shared sheets and root Civil reconciliation, planner discovery/action corrections, and missing owner interfaces. Review all remaining canonical decisions before a final coverage disposition. A clean browser result cannot substitute for this work.


## Subsequent findings and correction status (after checkpoint)

- **COV-06 planning gap addressed by root12:** independently read the actual44b2 structure service175–325 and rename handler1743–1831. New12 accurately distinguishes full-DWG moves from bounded partial active-layout removal, backup/dirty checks, mismatched UI wording, conditional persistence and external recovery. Runtime behaviour remains unqualified; no implementation fix claimed.
- **COV-03/04 substantial correction in root13:** new mapping preserves CV5/CV7/PS1–22 and refinements. Read against the approved decision tables, including quality/visibility gates, TIN constraints, storedtreeidentity, sourceoverride staleness, PS20close and Xref/placement contracts. Final integrated closure awaits planner crosslinks and all remaining Civil authority.
- **COV-07 Medium — shared settings/assets authority omissions:** root03/11 lack explicit SH-04 #11 shareable-settings export privacy and #12 corrupt-config warning/recoverablebackup; AS-01 #12 native/dynamic object preservation and authorised-only explode, #13 governed placeholders and issue disposition. These approved requirements need exact inheritance, not fresh approval. Root notified.
- **COV-08 High — Civil hydraulic/review approval coverage:** read CV01 CV1–25/refinement tables, CV02 HD1–15 and HV1–15 plus approval caveats, CV03 CV3-1–15 and CV06 CV6-1–15. Generic cards omit explicit partialflow/self-cleansing limit, no automatic downsize, worstpointcover, catalogue/rounding/nodrift and exact profile branches/linkedupdate/exportselection semantics. Preserve values only with existing source/version/corpus qualification; no current regulatory verification occurred. CV03 source/tag split is separately assigned to planner; do not duplicate that work.
- **COV-09 High — split-plan continuation workflow:** CV-01J direct read establishes Continue on another plan, paired display markers, one logicalPipeID, full developedlength, distinct gravity/risingmain, approved mapping constraints, fragment-resolved editing, nofakepit/schedulerow, and two-DWG recovery/per-DWGUndo boundary. Whole-plugin general network cards do not preserve this complete route. Reconcile with current scopedC7 migration rather than automatically treating every old continuation upgrade as either manual-only or auto-on-open. Historical build/slice status is not current installed evidence.

Whole-plugin approval remains open. This file records actionable evidence, not an assertion that every remaining canonical card has been exhaustively audited.

## Further readback at 23:08 Sydney

- Root14 now explicitly inherits all SH-04/AS-01 requirements, including export/corruption and intelligent-object/placeholder controls: **COV-07 planning correction verified**.
- Root15 now explicitly inherits HD/HV/CV6 and CV01J and qualifies historical numeric authority, cross-DWG Undo and C7 migration scope. Its CV6-7 now names QA12 identical-reversible-drafting batching: **COV-08/09 planning corrections verified for those mapped requirements**.
- Root16/17 checked against canonical CV08/SH/FND/RS/PD/TH and SUP requirements: additional recovery/version-skew/quarantine, exactreleaseidentity, truthfulsupport and test-evidence boundaries retained. These are inherited requirements, not new tests or release certification.
- Structural approved supplement and updated high-use FST contract materially address COV-01/02/05. Compressed rows must explicitly inherit uncopied canonical details and later scoped decisions. Requested exact scheduleCOPYsnapshot and later issue-QA disposition clarification.
- **COV-10 Medium — discovery contradictions:** command_discovery_reconciliation.md Retirement state still says no Tim-approved permanent retirements, contradicting ST6-14 and its own earlier STR/BWT row. It also broadly preserves XCLMTXTINDEX expert access while structural_registry_gap_dispositions.md correctly calls it an unqualified noncallable ghost. P1 needs its approved hidden-until-lap-rule status. Parent notified; fixes pending readback.
- Read canonical EV03–07 full decision bodies and FND/CT/TH/RS/PD/SH decision sets; DATA01 privacy controls and PC01 record obligations. No corpus files/history inspected. Exact current privacy clearance/implementation is not established by historical headings.
- Independently read actual root watchdog callback/timeouts, SmartifyPipe Execute and cloud telemetry handler. Root10 correctly distinguishes abandoned-await from cancellation, then-current read from unproven latewrite, and accepted202 from stored:true.

The39-row canonical matrix is separate and counted as39. It is a **coverage audit map**, not39 passed implementation tests. Remaining Civil canonical mapping, discovery corrections, evidence interfaces and integrated journey/index remain in progress.


## Correction readback — 23:14 Sydney

COV-01–10's identified authority/action/discovery defects now have substantive corrected records. The final planner readback confirms snapshot-copy, later unresolved-QA disposition, P1/retirement/ghost status and candidate-versus-governing staleness. Root19 provides a connected reading index and original records have companion links.180 current root/planner Markdown local targets exist; earlier17 malformed Windows paths are corrected. Concept SHA256 remains identical to bounded visual closure.

**These scoped corrections are verified; whole-plugin completion remains open.** Remaining tasks are the material control/consumer qualification currently being developed, integrated scenario/decision-gap review and the final morning pack. Retention inventories are explicitly not complete UI contracts. See CORRECTION_READBACK_EVIDENCE.json, LOCAL_LINK_RECHECK.json and INDEPENDENT_JOURNEY_TRACES.md. Do not read earlier checkpoint open statuses as newer than this readback; they remain history of findings.
