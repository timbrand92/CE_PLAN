# Civil survey candidate state and TPZ/SRZ constraint trace

> **Governing companions:** [Civil approved decisions](../13_CIVIL_APPROVED_DECISION_RECONCILIATION.md) · [Civil action boundary](civil_action_boundary_contract.md) · [survey/slab coverage](civil_surface_coverage_survey_and_slab_detail.md) · [finite source map](civil_label_style_and_remaining_source_map.md) · [network/source authority](../18_NETWORK_SOURCE_SURFACE_AND_QA_AUTHORITY.md). This trace reads current source only. It does not claim a live drawing result, acceptance, or a product violation outside the bounded source facts.

## A. Survey — current candidate storage and consumer limits

### What the source stores

| Source fact | Evidence | Contract implication |
|---|---|---|
| CDSURVEY passes a successful read result to StoreSurvey after its informational sanity check, then prints a success message. | [CdSurveyCommand.cs:149](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/CdSurveyCommand.cs:149>) [CdSurveyCommand.cs:153](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/CdSurveyCommand.cs:153>) [CdSurveyCommand.cs:155](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/CdSurveyCommand.cs:155>) | Command flow is not a persistence receipt: StoreSurvey returns void and catches its own write error. A candidate, if stored, remains neither approved nor proof a downstream consumer adopted it as governing. |
| StoreSurvey attempts to serialize one SurveyMeta record and one SurveyPayload record into CE_CVL_SURVEY in the drawing NOD, replacing same-name Xrecords; its catch logs and returns void. | [SurveyService.cs:600](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:600>) [SurveyService.cs:611](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:611>) [SurveyService.cs:614](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:614>) [SurveyService.cs:622](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:622>) [SurveyService.cs:625](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:625>) | A command success message is not proof the transaction committed. When it does commit, current storage replaces the one current payload/meta pair. No revision chain, deletion review, source fingerprint, units field, transform record or governing/adopted state appears in the inspected SurveyMeta/Payload schema. |
| SurveyMeta contains source file name, triangle count, spot-level count, load time and suspect count; payload contains triangles and spot levels. | [SurveyData.cs:28](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Models/SurveyData.cs:28>) [SurveyData.cs:46](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Models/SurveyData.cs:46>) | This is a bounded schema observation, not a whole-repository absence claim. It cannot satisfy CV7’s required revision/fingerprint/transform/units/provenance record by itself. |
| A loader reads the current NOD payload or returns false for missing/empty/failed data; dashboard status reads current meta only. | [SurveyService.cs:631](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:631>) [SurveyService.cs:659](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:659>) [SurveyService.cs:685](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:685>) | Missing data result is absence/false or not loaded status. It is not a numerical fallback, an automatic repair, or a historical-source deletion record. |
| Saving NOD data commits the in-drawing transaction; it does not itself save the DWG file to disk. | [SurveyService.cs:606](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:606>) [SurveyService.cs:622](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/SurveyService.cs:622>) | Source supports embedded drawing state only. Drawing save/reopen durability remains a future native/readback qualification. |

### Source consumer boundary

Root13 has already sampled Pit/Slab-related presentation of survey data, so this pass does not repeat those workflows. The source search found these bounded current consumers:

| Consumer | Current source behavior | Candidate/adopted distinction |
|---|---|---|
| PIT prefill | In Design workflow mode, first dialog pass reads payload and writes a suggested survey RL/note into the dialog view model before user confirmation. [PitCommand.cs:115](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/PitCommand.cs:115>) [PitCommand.cs:123](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/PitCommand.cs:123>) | A suggestion in editable dialog state is not a governing adoption record. Manual user change and final placement have separate active-owner behavior. |
| Spot level | In Design workflow mode, reads payload and presents a survey value as the prompt default; source says typed entry can override. [SpotLevelCommand.cs:59](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SpotLevelCommand.cs:59>) [SpotLevelCommand.cs:84](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SpotLevelCommand.cs:84>) | This is a prompt suggestion, not a source activation/revision decision. |
| Grade suggestion / advisory flows | When a pit cover is missing, source can use a payload RL as an in-process surface value; advisory builder separately records a nullable SurveyRl and source string. [CdCommand.GradeSuggestion.cs:408](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/CdCommand.GradeSuggestion.cs:408>) [PitEditCommand.cs:564](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/PitEditCommand.cs:564>) | No inspected method writes a CV7 governing activation state, source adoption, or revision/deletion comparison. This is a bounded absence in the named SurveyService API/schema and listed readers, not a claim about uninspected code. |

### Approved target contract and acceptance

CV7 requires candidate discovery to be separate from Review/exclude/Unknown/governing activation; revision/fingerprint/transform/units/provenance; source differences and deletions presented for review; retained manual override with changed source visible; and Preview/Apply/Undo before drawing impact.

| Future scenario | Required evidence |
|---|---|
| A changed survey source appears | Current candidate and prior adopted basis/revision are shown separately; added/changed/removed review occurs before activation; manual values remain visible. |
| A source disappears or current NOD payload is missing | Result says Missing/Unloaded/Unknown as appropriate, identifies available retained basis without fabricating ground RL, and offers reviewed recovery. |
| A suspect point exists | Candidate remains reviewable; exclusion or Unknown is recorded before a governing output uses it. A count in meta is not sufficient. |
| User accepts or overrides a suggested level | Preview records source/manual choice and dependent impact. The suggestion does not overwrite a manual/pinned value. |
| Save/reopen | Embedded NOD state, selected adoption/revision record and manual override are each read back from the actual drawing; file-save success is separate. |

## B. TPZ/SRZ — present drawing marks versus approved stored constraints

| Area | Current source fact | Approved requirement / source limit |
|---|---|---|
| CDTPZ prompt and drawing mark | Before prompting, command ensures its circle and hatch layers. It then gets centre then positive radius; Cancel before either completion returns. It creates circle plus associative hatch and commits. [TpzCommand.cs:42](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/TpzCommand.cs:42>) [TpzCommand.cs:54](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/TpzCommand.cs:54>) [TpzCommand.cs:57](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/TpzCommand.cs:57>) [TpzCommand.cs:81](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/TpzCommand.cs:81>) [TpzCommand.cs:120](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/TpzCommand.cs:120>) | Current input is centre/radius geometry. Cancel prevents the mark, but is not evidence of zero drawing-side setup because layer ensuring precedes prompts. Command comment says it is not registered in ProjectData. [TpzCommand.cs:14](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/TpzCommand.cs:14>) |
| CDSRZ prompt and drawing mark | Before prompting, command ensures its marker layer. It then gets centre then positive radius; Cancel before completion returns; it creates one circle and commits. [SrzCommand.cs:30](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SrzCommand.cs:30>) [SrzCommand.cs:42](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SrzCommand.cs:42>) [SrzCommand.cs:44](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SrzCommand.cs:44>) [SrzCommand.cs:68](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SrzCommand.cs:68>) [SrzCommand.cs:85](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SrzCommand.cs:85>) | Current input is centre/radius geometry. Cancel prevents the mark, but is not evidence of zero drawing-side setup because layer ensuring precedes prompts. Command comment says it is not registered in ProjectData. [SrzCommand.cs:14](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/SrzCommand.cs:14>) |
| Boundaries and limited search | The bounded source search for TreeId/TreeID, TpzConstraint/SrzConstraint, and TPZ/SRZ NOD/ProjectData storage returned no matching route in Modules/Drainage. | This does not establish whole-plugin absence. It supports only this planning conclusion: no stored tree ID, entered radius source, information source, revision, edit route or deletion/review route was located for the two direct commands. |
| Intended constraint | CV5-14 already requires tree ID, entered radius, information source and revision stored as constraints, with no radius calculation absent approved method. [Civil decisions](../13_CIVIL_APPROVED_DECISION_RECONCILIATION.md) | The approval is not downgraded to a proposal. Exact edit/review gestures and durable storage design still need owner review. No automated hydraulic/catchment link is created. |

| Future scenario | Required evidence |
|---|---|
| Place TPZ/SRZ then Cancel before radius | No mark/constraint record; layer ensuring already ran, so inspect it separately. A committed mark has one drawing Undo, tested separately from stored-constraint readback. |
| Store a tree constraint | Tree ID, entered radius, information source, revision and drawing identity remain distinct from geometry. No radius is calculated. |
| New tree report revision | Comparison presents old/new source/revision and leaves current entered radius/pinned values intact until reviewed. |
| Missing/corrupt constraint data | Geometry remains visible; constraint status is Missing/Unknown and unsafe automatic use is disabled. No replacement circle or numeric radius is fabricated. |
| Copy/edit/delete/reopen | Copied entity has a separate constraint identity; edit/delete/revision are explicit, reviewed actions. Drawing save/reopen proves geometry and record independently. |

## C. Resulting finite source map and next whole-plugin gap

| State | Source-answerable area | Result |
|---|---|---|
| Closed by this trace | Survey storage/current consumers | Current source has one replace-in-place NOD candidate payload and several suggestion/advisory readers. An explicit governing activation/revision/deletion record was not found in this bounded API/schema/reader trace. |
| Closed by this trace | TPZ/SRZ direct commands | Current source is centre/radius geometry; no direct stored-constraint route was found in bounded searches. CV5-14 remains governing target. |
| Next substantive whole-plugin gap beyond Civil | **None safely owned by this planner.** Remaining high-impact shared Project/Issue/Settings/Help/utility-export contracts are root-owned and already linked. | Do not duplicate root-owned implementation planning. The next useful work within this planner is future owner/audit follow-up on activation and constraint targets, not another source sweep. |

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.


---

## D. Proposed C1 governing-survey review — interaction detail awaiting Tim review

**Status:** proposal for owner/Tim review only. It makes the approved CV7 distinction between discovered candidate and governing basis reviewable; it does not approve a new window, source store, numeric default or source activation. It follows the [change/adoption handoff](../23_CHANGE_ALLOCATION_AND_ISSUE_HANDOFF.md): a candidate is Needs review, while only a confirmed governing change makes a consumer numerically Out of date.

### Entry and visible review surface

- Automatic project-folder recognition discovers documents across all relevant job folders in the background. It does **not** create a project by fallback or decide which source governs.
- The familiar Civil entry shows a compact **Survey basis** review in the existing work surface when a candidate is discovered, or when the user chooses the existing **Select/change document** control. It is not a compulsory wizard or stage selector.
- The larger pane is a source-page preview while evidence is reviewed. The working drawing remains the preview while the user works on geometry. Keep the layout minimal: a current-basis summary, a candidate summary and visible actions; no duplicate window or competing source register.
- The review shows, where known: current governing basis and its adopted scope; candidate document/page or source identity; stated revision/version evidence; load/change evidence; units/transform/provenance state; suspect/Unknown state; affected scope and dependent outputs; and whether a current value is manual or pinned. An unavailable item says Missing or Unknown, not a made-up value.

| User decision/action — **proposed** | Result that must be visible before Apply | Apply/result boundary |
|---|---|---|
| **Keep current basis** | Candidate stays Needs review with its reason; current governing basis and manual/pinned values remain shown. | No governing-input change and no numerical-staleness claim. Candidate remains available for later review. |
| **Exclude candidate item / mark Unknown** | Preview identifies the exact unadopted candidate item/scope excluded or Unknown. It explicitly shows that the unchanged adopted basis and its current consumers remain as they were. | No candidate value quietly enters a calculation. Excluding an unadopted candidate does **not** mark an unchanged adopted basis or its consumers Cannot calculate. If no usable adopted basis exists for prospective work, that prospective scope remains Cannot calculate or Needs review. |
| **Adopt confirmed candidate for the selected scope** | Preview compares prior versus proposed governing fact, source/revision evidence, manual/pinned state, affected consumers and expected review state. | Adoption records the confirmed basis/scope and its evidence. Only consumers of that confirmed changed fact become numerically Out of date; unrelated outputs remain unchanged. |
| **Keep or enter a manual/pinned value** | Preview shows the manual value beside the candidate and explains that the candidate will remain evidence, not an overwrite. | Manual/pinned value remains governing until the user explicitly changes it. A changed source leaves it Needs review rather than resetting it. |
| **Open a different document** | Current and candidate documents stay distinguishable; no newest-file rule is implied. | The Select/change document choice changes the review candidate only. It does not silently adopt it. |

### Cancel, missing source and lifecycle proposal

| Situation | Proposed end-user contract |
|---|---|
| **Cancel / Escape before Apply** | Close the review and retain the current governing basis, manual/pinned values and drawing. A discovered candidate can remain listed as Needs review, but there is no adoption receipt or drawing impact. |
| **Source missing, deleted or cannot be read** | Show Missing/Unloaded/Unknown with the last known evidence identity where available. Do not fabricate ground level, source revision or a substitute source. A retained governing basis is visibly retained; if it cannot be qualified, dependent work is Needs review or Cannot calculate as applicable. |
| **Changed source with manual override** | Show the old adopted evidence, new candidate and manual/pinned value together. No automatic replacement or automatic recalculation. |
| **Copy drawing / copied geometry** | A copied drawing must not infer a new governing survey from filename or location. Its retained basis is shown as carried evidence pending qualified review; any unresolved identity is Needs review. |
| **Save and reopen** | Read back candidate, adopted basis, manual/pinned state, source evidence and selected scope separately from ordinary DWG file-save success. No timestamp or display label alone proves currentness. |
| **Partial failure while applying** | Show whether the adoption record and any dependent status update completed, failed or is unknown. Do not print a completed adoption receipt, clear the prior basis, retry silently or overwrite a manual value. The next action is Review basis. |

### Interaction choices still for Tim

**Recommendation:** make Review basis a visible action in the existing Civil surface, use an explicit scope list with optional drawing highlighting, and show a passive Needs review badge on copied drawings until the user opens review. These choices keep the work fast while preserving the approved candidate-versus-adopted boundary. **Tim-only choices:** exact button wording/icon and whether the initial scope list or drawing selection has focus. Each option preserves the same approved contract.

## E. Proposed C7 TPZ/SRZ constraint review — interaction detail awaiting Tim review

**Status:** proposal for owner/Tim review only. CV5-14 already requires stored tree ID, entered radius, information source and revision; this proposal only makes that requirement reviewable. It creates no arborist formula, numeric radius default, automatic catchment/hydraulic link or new active-owner implementation.

### Entry and visible review surface

- Retain CDTPZ/CDSRZ as familiar direct mark-entry routes while their active owner decides the delivery sequence. A user can also select an existing TPZ/SRZ mark and, under this proposal, invoke **Review constraint** from a retained Civil action context. **Review constraint is proposed, not observed source-built functionality.** The exact command/context trigger is a Tim-only gesture choice below.
- The proposed review appears in the existing Civil work surface, with a large drawing preview of the selected mark and a source-page preview only while reviewing evidence. It uses a compact summary and visible actions rather than a compulsory wizard, main-page scroll or duplicate data owner.
- Shown fields are: constraint type; selected mark/drawing identity; Tree ID; **entered** radius with its explicit displayed units; information source; source revision; current evidence versus candidate source; manual/pinned indicator; status Current/Needs review/Missing/Unknown; and whether the proposed action affects geometry, constraint record, or both. No units, scale, radius or other numeric value is calculated or defaulted.

| User decision/action — **proposed** | Preview and selection requirement | Apply/result boundary |
|---|---|---|
| **Place or select mark, then review** | Explicitly identify the selected mark and show whether it has a stored constraint or only geometry. Existing command prompts remain distinguishable from the proposed review. | Selection alone does not invent a stored tree record or change geometry. |
| **Add/update entered constraint facts** | Compare old and proposed Tree ID, entered radius **with explicit units**, information source and revision. Preview makes geometry-plus-record versus record-only scope explicit, with selected-mark geometry, manual/pinned values and source candidates side by side. | Proposed default is **update selected mark and record together** after preview. A deliberately chosen record-only update leaves the existing geometry unchanged and status **Needs review**, never Current, until a reviewed geometry reconciliation. No automatic network/catchment recalculation, radius derivation, units conversion or scale assumption. |
| **Review a changed source** | Show current record and candidate evidence/revision together, with Changed/Needs review rather than automatic adoption. | Keep entered/manual values until an explicit confirmed update. A source candidate does not redraw a mark. |
| **Mark source Missing / retain manual basis** | Large drawing preview preserves the mark while the information state becomes Missing/Unknown. | No replacement circle, radius or source is fabricated; unsafe automatic use stays disabled. |
| **Remove stored link or delete mark** | Preview states separately whether it removes only evidence/constraint data or the selected drawing mark and its associated constraint. | Either destructive action requires explicit reviewed confirmation and a clear scope. No unrelated mark, source or hydraulic data is deleted. |

### Cancel, copy, save/reopen and partial-failure proposal

| Situation | Proposed end-user contract |
|---|---|
| **Cancel / Escape before Apply** | Retain current geometry and constraint facts. Existing direct command behavior remains separately qualified: its pre-prompt layer setup may already exist even though no mark is placed. |
| **Cancel an edit or source review** | Retain the active stored constraint, source evidence and manual/pinned values. Candidate evidence may remain Needs review; it is not adopted on close. |
| **Undo after confirmed drawing impact** | A confirmed mark/constraint operation produces one visible operation receipt and one drawing Undo target, with constraint readback checked separately from geometric erase. This is a future acceptance requirement, not source proof. |
| **Copy selected mark or drawing** | Do not silently treat the copy as the same tree or a new approved constraint. The proposed default status is Needs review with the copied record shown as candidate evidence; whether the copy starts blank or carries fields as review-only candidate is a Tim-only choice. |
| **Save/reopen** | Read back selected-mark identity, geometry, stored tree facts, evidence revision, manual/pinned state and review status separately. Missing/corrupt constraint data leaves geometry visible and status Missing/Unknown. |
| **Partial failure** | Show a truthful receipt for geometry and constraint record separately: Complete, Partial, Failed or Unknown as evidenced. Do not claim both changed, retry automatically, replace a manual value or create a duplicate mark. Offer Review constraint as the recovery route. |

### Interaction choices still for Tim

**Recommendation:** provide a visible Review constraint action beside the retained direct commands, with a selected-mark context action as a secondary shortcut; copied marks retain read-only candidate fields and start Needs review; confirm record-only removal and mark-plus-record deletion with distinct clear wording. **Tim-only choices:** exact icon/labels and the final confirmation wording. Each option retains CV5-14 facts, manual/pinned values, revision evidence, explicit units and the no-automatic-link rule.

## F. Proposal acceptance scenarios

| Scenario | Reviewable expected result — not a performed test |
|---|---|
| Suspect survey candidate beside an unchanged adopted survey basis | Source preview exposes the candidate and suspect state; Keep current or Cancel leaves governing values and calculated outputs unchanged. |
| Survey candidate adopted for one confirmed scope with a pinned manual value elsewhere | Preview names the changed scope and preserved manual value; only affected confirmed consumers become Out of date. |
| Source deleted after adoption | Review shows Missing evidence and retained basis; no ground level or replacement source is fabricated. |
| Existing TPZ mark receives first stored facts | Selected geometry remains visible; preview shows entered facts with explicit units and explicit geometry-plus-record scope before Apply; no radius calculation or hydraulic link appears. |
| New tree-report candidate conflicts with a manual entered radius | Review preserves the manual radius with its displayed units and shows candidate revision as Needs review until explicit update. |
| Record-only radius edit against existing TPZ geometry | Preview labels old/new entered radius with units and shows the retained geometry. After explicit record-only Apply, status is Needs review, never Current, until reviewed geometry reconciliation. |
| Copy TPZ mark, Cancel constraint review, then save/reopen | Copy cannot silently become a second approved tree constraint; Cancel preserves prior facts; reopen reports each mark/constraint identity and any Needs review state. |
| Constraint update has an incomplete write | Result distinguishes geometry from constraint outcome, does not duplicate/retry silently, and returns to proposed Review constraint. |

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.

| 2026-09-16T23:58:21.4181772+10:00 | Proposed | civil_survey_activation_and_tree_constraint_trace.md | Added reviewable C1 governing-survey and C7 TPZ/SRZ interaction proposals: automatic discovery with Select/change document control, minimal review/preview, explicit Apply/Cancel/manual/source-loss/copy/save-reopen/partial-failure contracts, and Tim-only gesture choices. |




