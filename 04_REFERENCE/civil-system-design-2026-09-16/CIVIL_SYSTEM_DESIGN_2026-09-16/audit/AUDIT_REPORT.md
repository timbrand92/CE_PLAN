# Independent Civil planning audit — first pass

FOR TIM

**The whole-job direction is useful, but this first pass is not ready to call complete.** It preserves source evidence and your overrides. The main corrections are:

- Keep your already-approved automatic pipe upgrade and the other active owners explicitly protected.
- Distinguish a changed roof that needs review from a calculation whose chosen inputs actually changed.
- Give pumps, treatment types and overland safety their own usable review detail.
- Make the visual limitations clear: changing the selected report currently keeps the council page on screen; the footer runs off a shorter desktop view.

No plugin was built, tested, installed or accepted by this audit. The morning pack is still pending. The overnight goal remains active.

---

## Scope and evidence standard

Auditor: prescribed Astra/medium independent audit. First-pass date: 16 September 2026. Audit uses actual files, independent offline Chromium interaction, opened rendered screenshots and bounded read-only source checks. This is planning review, not hydraulic/council validation or AutoCAD acceptance.

Read all root 00–05 files and all nine initial planner files; compared START_HERE, V3 §11 A–M, relevant consolidated decision/status sections, current Test Day including §6h–6o/6m-result, and the approved scoped Civil Windows handover. Source spots independently checked command declarations, calculation/schedule UI, help fallback, project-path helper and Design Package/Impact concepts. Source checks are bounded and do not establish runtime status. The installed-DLL and GitHub claims in root integration evidence were not independently re-read by this auditor; no fresh installed-state claim is made here.

## Findings requiring correction or explicit delivery disclosure

| ID / severity | File / claim | Authority and current truth | Required change |
|---|---|---|---|
| AUD-01 / high | planner/retained_command_inventory.md M: never make repair buttons automatic first-use actions; journey/repair contract only describes scan then explicit chosen repair. Active owner map stops at CD/PIT polish/CDWT. | Test Day §6j–6n approves automatic pipe upgrade on open after compatibility/reader/enabler gates, one first backup, one Undo and one count/backup line. §6h assigns expanded CD/PIT preview work; C7, K/L and windows overnight scopes are active. A blanket future manual-only migration reading would reverse Tim's decision. | Add a dated ownership/exception supplement linked from journey, inventory and repair card. Preserve approved gated upgrade separately from general repair; do not reassign C7, K/L, CD/PIT, CDWT or the current computations-sheet scope. Keep source-observed old code distinct from current owner branch/runtime. |
| AUD-02 / medium | planner/automation_override_revision_contract.md dependency diagram and complete criterion 4; representative_acceptance_scenarios.md C-03; workflow_cards F1 acceptance | Dependency map and root Reports detail correctly say new geometry/evidence with unchanged pinned input means Needs review; only a changed governing input makes numeric result out of date. Other files unconditionally call boundary-change results stale. Example: 240 m² stays pinned while outline measures 252 m²; the calculation still matches 240, although engineering suitability needs review. | Reconcile every diagram/card/scenario with the three states: Needs review / Numerically out of date / Cannot calculate. Add separate future cases for retaining a pin and adopting the new measured input. Do not clear suitability review merely by keeping a pin. |
| AUD-03 / medium | planner/workflow_cards.md F2 and representative scenarios C | A–M names are covered, but H wet-well controls/rising mains and I swales/buffer strips/sedimentation/treatment trains plus J safety have only generic device prose. Source inventory is useful but not a complete workflow review. | Complete the pending specialist delta with concrete inputs/evidence, preview/actions, overrides, dependencies, outputs and representative cases. Unknown methods/council choices must remain Unknown. No implementation authorisation implied. |
| AUD-04 / medium | civil-job-lifecycle.html document review; 04_VISUAL_REVIEW.md | Independently selecting only the draft WSUD report still displays the council advice page. Checkboxes change the loaded set, not selected evidence. The source review is a static illustrative page and cannot demonstrate source-row/page correspondence or revision comparison. | Either implement a separate focus/view action for synthetic documents with matching page/revision/status, preserving load-versus-governing separation; or prominently disclose the fixed-page limitation in the concept and morning pack. Do not call source selection/preview fidelity verified. |
| AUD-05 / medium | civil-job-lifecycle.html sizing; 04_VISUAL_REVIEW.md | All three overviews fit 1024×900 and 1920×1080. At 1280×720 the window bottom is 859–863 px, so actions are below the viewport. A 1920 display at 150% scaling may have an effective 1280×720 desktop, but this was a browser viewport test, not an AutoCAD/DPI test. Window height is content-driven, not proven 90% owner sizing. | Record exact tested viewport limits and retain a native 1920/scaling/owner-size fit gate. If the prototype is presented as meeting that layout requirement, revise and re-open at the shorter viewport. Narrow conversation reflow is fine but not evidence of native fit. |
| AUD-06 / low | planner/workflow_cards.md M1 classification: Help is Missing | Same card and retained inventory observe CDHELP, context tracking, embedded guide and old-lane browser fallback. Source spot check confirms those routes. Missing an accepted unified support experience is different from missing Help. | Classify existing Help Keep/Modify; mark only the integrated accepted support experience Missing/Unknown. |
| AUD-07 / low | planner/source_authority_and_conflicts.md final evidence requests and Drainage Items row | It still requests current retained commands after the inventory exists and refers to eight pending council decisions without stable IDs. The current OPEN_QUESTIONS file contains many more headings; the subset/count cannot be interpreted safely. Inventoried future More items are not approved additions. | Replace completed evidence requests with exact completed references and retain only unresolved links. Name relevant council question IDs or remove unsupported count. Say additional applicable item types require review; source presence is not Tim approval. |
| AUD-08 / low | planner/automation_override_revision_contract.md five-state table | Approved handover and START_HERE require Unknown, Assumed, Manual/Pinned and Display Override distinguishable. Table covers adoption/provenance states but omits Assumed and leaves Unknown outside it. Elsewhere assumptions appear, so this is an underspecified contract, not proof they were intentionally removed. | Explicitly model adoption status separately from provenance/assumption state; retain a confirmed assumption visibly as Assumed with source/reason and review consequence. |

## Whole-scope requirement coverage

| Requirement | Evidence | Audit result |
|---|---|---|
| A project setup / documents / criteria | Journey, A1/A2, Reports detail, source-helper read | Covered for planning; ambiguous recovery remains Tim-only and source activation remains proposed. |
| B survey / surfaces / imports | B1/B2, retained survey/import/slab routes | Covered at family level; future source/coordinate/datum/units and update acceptance retained. |
| C discharge / authority | A3, single LPD record | Covered; missing invert remains Unknown and no gravity answer invented. |
| D catchments / flows | B2/B3, dependency map, historical evidence | Covered; report/measured/manual separation, existing-plan-first and no equal split/double count retained. |
| E network / grades / labels | E1/E2, inventory, Test Day | Interfaces covered; owner and migration supplement needed (AUD-01). |
| F detention / storage / outputs | F1, dependency map, council sources | Covered at planning level; no hydraulic result or compliance inferred. Unanswered engineering choices stay open. |
| G Water Tank last | Final dependency section, G1 deferral, current CDWT owner | Correctly held last with shared interface only; do not duplicate active window. |
| H pumps / SPS | F2 and dependency map | Partial; specialist delta pending (AUD-03). |
| I WSUD / multiple treatment families | F2 and dependency map | Partial beyond raingarden; specialist delta pending (AUD-03). |
| J overland / overflow / flood safety | E2/F2 and dependency map | Partial: explicitly Missing analysis is honest, but useful proposed review detail and case still needed (AUD-03). |
| K profiles | L1, retained CDPROFILE and Longitudinal tab | Covered as retained route and proposed output contract; active K/L owner must be explicit. |
| L schedules / details / issue/revision | L1/L2, source inventory, issue concept | Covered at family level. Issued record preservation is proposed; no real issue/output system exercised. |
| M repair / migration / help | M1 and inventory | Covered with corrections AUD-01/AUD-06. |
| Automatic guidance and explicit overrides | Reports detail, automation contract, concept | Strong preservation of approved direction; no unattended/product capability claim accepted. AUD-02/AUD-08 remain. |
| CE visual / big preview / visible actions / minimal tabs | Five root screenshots opened plus two independently rendered views | CE dark/gold language, groups and preview visible; no application-stage wizard. Short-height limitation AUD-05. |
| All proposals distinguished from acceptance | Headers/status tables throughout | Substantially satisfied; historical approvals attributed and no new Tim acceptance asserted. |
| Read-only safety / privacy | Audit tool actions, artifact scope, private source manifest | Auditor changed only owned audit files. Historical identifiers were not copied into audit artifacts. No plugin/build/git/deploy/AutoCAD actions. Cannot prove other agents' entire tool history from files. |
| Planner then independent audit / morning pack | This report plus pending pack | First audit executed; fixes, specialist delta and morning-pack audit pending. Goal remains active. |

## Independent rendered/interaction evidence

Opened root screenshots: new job, area change, issue, document review and narrow view. Then ran audit/independent-interactions.cjs against the actual current HTML without running root's script or overwriting root artifacts.

- 13 named observations succeeded, including one deliberately confirming the fixed-preview limitation; they are not 13 product passes.
- 15 layout observations cover 5 viewports × 3 overview states. All had no horizontal overflow. Three short desktop views and three narrow reflow views exceeded viewport height.
- Back discards unaccepted document loading; Keep retains it in this browser session; Escape preserves prior selection. Source reviewed does not mean criteria confirmed.
- Select outline / Draw boundary / Manual area are honestly labelled conceptual. Keeping pinned area retains review. Calculation review makes recalculation conditional on governing input change. Previous issue is shown preserved in illustrative data.
- Zero browser script errors observed. No actual persistence, refresh extraction, bidirectional drawing selection, native preview, AutoCAD Undo or hydraulic calculation exercised.
- Independent screenshots audit-document-selection.png and audit-desktop-1920.png were opened visually. The 1920 view has large unused horizontal preview space around a small paper; this is an illustrative layout, not a validated full-page document reader.

## Historical evidence and new walkthrough

Read private TRIAL_FINDINGS and source manifest; independently re-hashed exactly the same eight source files at 19:12:52 Sydney: 8/8 matched. Opened existing private site overlay, paving overlay and roof-catchment plan render. The overlays visibly distinguish measured candidates from governing values; the source sheet visibly contains explicit roof/treatment allocations. No new corpus search, measurement or native DWG access occurred.

The added private START_FROM_SCRATCH_WALKTHROUGH is consistent with the bounded trial's reported/measurement distinctions and unresolved governance. Its opening explicitly says the process has not run in AutoCAD. The heading “What automation actually saves” is best changed to “What the proposed automation would save”: evidence was gathered by this assistant-led bounded study, not by an integrated product. Figures are not reproduced in this repository audit.

I did not re-render/re-read all historical report pages, rerun vector extraction or independently validate each historical reported quantity. This audit confirms the scope/status distinction and visible examples, not a fresh engineering validation of the old project.

## Delivery status

- Changed: audit report, independent browser receipt/script and two synthetic screenshots only.
- Needs Tim later: one reviewed planning choice at a time; no AutoCAD testing is requested for this planning-only block. Actual implementation acceptance belongs to each approved owner/card.
- Pending/parked: fixes and closure audit, specialist delta, final morning pack; native drawing/ingestion/persistence/preview proof remains future work. No invented overnight duration and no goal-complete claim.

## Additional source-preservation finding — AUD-09 / medium

**Files:** journey map one-record ownership/LPD door; workflow A3; automation contract/outlet allocations.

**Claim at risk:** repeated “one LPD record” language can be read as one outlet per project. It correctly seeks to avoid duplicate records across windows, but does not distinguish that from outlet count.

**Authority/current truth:** Consolidated record §B4 records Tim: “IT CAN HAVE MORE THAN ONE BUT OFTEN JUST ONE” for LPD count. Each outlet has its own authority and each pit/pipe belongs to one outlet in the recorded model. The same section records “ITS ALWAYS ONE DESTINATION” for one DP's tank-versus-LPD destination.

**Required correction:** say one shared record **per outlet**, accessible through Design/LPD/Drainage Items. Preserve multiple project outlets, selected outlet/network membership and separate authority/catchment/calculation basis. Keep exactly one confirmed destination per DP; a roof may still have unequal portions assigned to different DPs. Add a synthetic two-outlet future scenario that detects authority/allocation mixing. This does not reopen Tim's decisions.

## Specialist delta reviewed after initial report

Read planner/specialist_workflow_details.md in full. It adds concrete review groups/actions and future scenarios for pumps/wet-well controls/rising mains, charged systems, raingardens, swales/buffers/sedimentation, soakage and overland/safety; Water Tank interface summary remains last with active ownership retained. **AUD-03 substantive planning-depth gap is closed by this delta**, subject to links from the original cards and unchanged proposal/acceptance boundaries. No hydraulic methods or numerical defaults are invented by these workflow groups.

Independent source spot checks confirm Calculations V2 labels WSUD an estimator and directs formal MUSIC modelling to a specialist. IFD_RAINFALL_HOW_IT_WORKS §7 supports a visibly named Melbourne office block only for its appropriate zone; appropriateness elsewhere remains unresolved. The specialist delta does not justify universal fallback.

The delta also names current migration safeguards, but AUD-01 remains open until the contradictory original repair/ownership wording is reconciled and linked. Subsequent owner fixes and concept changes are not yet closure-audited.
