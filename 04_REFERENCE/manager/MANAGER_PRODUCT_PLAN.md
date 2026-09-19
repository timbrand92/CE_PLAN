# CE Manager — professional product and staff-readiness plan

**Recorded:** 6 September 2026. **Status:** Tim approved inclusion of the full drafting audit across Civil, Structural and Manager. This develops M1 and the shared product services; it does not create a new release lane or a competing drawing/project engine.

**User result:** a colleague opens AutoCAD, gets the correct CE tools and standards, can work offline, understands any problem and can obtain a verified update or recovery with minimal help from Tim.

```text
Approved product + approved standards
      → correct loaded tools on the colleague's machine
      → quiet useful Help and status
      → meaningful report if something fails
      → verified update / recovery / confirmation
```

Read the [shared production plan](DRAWING_PRODUCTION_PLAN.md), [complete register](DRAFTING_DELIVERY_REGISTER.md), [M1 #36](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/36) and current [Window 16 design](design/V3_UI/windows/16_HELP_MANAGER.md). Existing MGR-APP-A decisions, SH-01, RS-01, PD-01, AS-01 and SH-04 remain authoritative.

## 1. Ownership without duplicate workflows

| Responsibility | Authority to reuse | Manager's user-facing role |
|---|---|---|
| Software health, version, updates and support | Manager / RS-01 / PD-01 | Own the state, recipient/action flow and recovery |
| Firm/project/personal standards | SH-04 + AS-01 governed catalogue | Show availability, version and repair; open the one settings surface |
| Civil engineering checks and proposals | Approved Civil review/QA authorities | Direct link with correct project context; never a second calculator |
| Structural context, sheets and issue | ST-07 / SL3 / CESHEETS + shared QA | Direct link and shared status; no second sheet register |
| Project identity / separate Job Manager exchange | Existing approved exchange owners | Use documented identifiers/receipts, not duplicated client/project records |
| Ask CE and Help | One Help/AI authority under AI-01 | Contextual guidance, source links and offline fallback |

The exact QA-01 Manager-home versus discipline-review presentation conflict E07 is resolved in the shared ownership review before changing screens. This table defines the intended separation of responsibilities, not a silent rewrite of older card approval wording.

## 2. Seven outcomes and their implementation route

| Audit item | Existing destination | Build approach | Completion evidence |
|---|---|---|---|
| **M01 — Product/project ownership** | SH-01 / QA-01 / M1 / ST-07 | Implement shared service ownership and one doorway per task; define exchange with separate Job Manager without copying its authority. | Health, project checks and issue have distinct meanings and consistent navigation. |
| **M02 — True staff readiness** | M1 / RS-01 / PD-01 | Join approved/installed/loaded/staged identities with dependency/asset and last-contact evidence; keep software and engineering status separate. | Old-loaded/new-staged and offline colleague states are correctly reported. |
| **M03 — Fresh-machine standards** | AS-01 / SH-04 / M1 | Package approved assets and inspect catalogue dependencies; pin project versions; use clear repair route for missing content. | New machine matches CE output without personal paths or substitute shapes. |
| **M04 — Offline and sync conflicts** | SH-04 / AI-01 / M1 | Specify local approved cache, queued reports, absent evidence, conflict resolution and reconnection; don't infer receipt from folder presence. | Disconnect/reconnect/restart loses no accepted decision and falsely acknowledges nothing. |
| **M05 — Colleague update and recovery** | RS-01 / M1 | Expose who/what/when and per-machine outcome using current signed staging/activation/rollback machinery. | Interrupted/locked/unsupported install leaves known usable or explicit recoverable state. |
| **M06 — Feedback closure** | PD-01 / M1 / #58 | Use stable report identity and Draft/Local/Pending/Received/In review/Fixed/Awaiting confirmation stages; preserve screenshot preview choices. | Offline retry avoids duplicates; fix names exact build and remains unaccepted until confirmed. |
| **M07 — Useful support history** | PD-01 / CV-08 / M1 | Connect failed tool/build to scoped previewable support evidence and plain recovery; separate software, drawing and engineering matters. | Missing collectors cannot claim complete support; installation success cannot close drawing defects. |

## 3. Build through the existing five M1 slices

| Existing slice | Work to include | Finished user journey |
|---|---|---|
| Catalogue truth | Resolve approved product/module/runtime lanes, dependency and asset catalogue, exact installed/loaded identities | Status distinguishes what is installed from what is actually running; missing standards explained |
| Update decision | Preserve approved recipient/permission/ignore decisions; show release content, affected users and timing | User approves the exact update without accidental live activation; ignored updates remain ignored |
| Activation handoff | Reuse signed staging, closed-process activation and preserved rollback; record per-machine outcome | Pending restart, activated, failed and restored states are truthful; no forced restart |
| Per-action permission and consent | Reuse named roles and support-preview choices; distinguish product repair, drawing repair and engineering review | Users see permitted actions and a specific reason for unavailable actions; ordinary drafting stays usable |
| Evidence admission | Correlate version/action/run evidence and feedback receipt; use explicit complete/incomplete status | A support report or release receipt is not declared complete when collectors or recipients are missing |

Reconcile implementation already present on Manager branches before estimates or edits. No replacement installer/helper script, update channel or log authority is proposed.

## 4. State and recovery contract

Each status must name scope and observation time. Software state is separate from engineering readiness.

- **Approved:** the release/catalogue authority permits this version/channel.
- **Installed:** files are present and identified.
- **Loaded:** this running AutoCAD session uses this exact identity.
- **Prepared / restart pending:** verified staged package exists; live files have not been replaced.
- **Offline / not recently observed:** last evidence is shown, current recipient state unknown.
- **Failed / restored:** the exact attempted operation and recovery result are recorded.
- **Ready for drafting:** approved required runtime/assets available for the scoped tools; never a claim the drawing design is checked.

A OneDrive file is not delivery acknowledgement. Preserve stable operation IDs, duplicate-safe retry and explicit conflicts. Cache only approved necessary product data. Record changes through existing durable services; raw source/evidence project records do not move into the plugin.

Feedback states: Draft → Saved locally → Awaiting transfer → Received → In review → Fixed in build → Awaiting confirmation → Confirmed. Use appropriate subsets if some states lack backend evidence; never fabricate receipt. Screenshot and DWG inclusion follow approved preview choices. A support upload or message is sent only through the approved user action/destination, not by reading this plan.

## 5. CE appearance and minimal staff effort

Use Window 16 and the frozen Settings look-and-feel reference. Status words accompany colour. Show the three most useful actions for the actual problem rather than a large technical dashboard. Help uses current approved names and screenshots of shipped behaviour; legacy command handling follows the newer #58 decision.

Normal startup has no blocking network/AI dependency or mandatory popup. A first-run standards problem should offer the precise repair while retaining unaffected tools. Do not require staff to interpret DLL paths, raw hashes, internal services or registry terminology; exact technical evidence stays available in Support for the owners.

Measure fresh-machine setup time, support interventions, report completion and recovery time. Reuse issue/context information already known instead of asking staff to retype it.

## 6. Verification and delivery

Prepare disposable tests for old-loaded/new-staged, missing asset, corrupt/partial download, insufficient space, locked activation, unsupported runtime, offline/reconnect, duplicate feedback retry and failed support collector. Confirm exact identity/recovery and unchanged live bundle through existing release gates.

Tim's M1 representative acceptance remains the existing short journey: open Manager, inspect identity, stage without activation, ignore one update, preview/cancel Support, then perform authorised closed-AutoCAD activation/reopen and verify the outcome. Office pilot adds one actual colleague and recovery rehearsal.

M1 proceeds independently of Civil C6 and is required for S3. Civil + Manager office delivery remains first. DP-4 is the planning wrapper, not another chunk issue. Forecast runtime effort from the current five-slice implementation inventory; the shared plan's 2–3 days covers specification, not delivery.

**Planning complete for inclusion; implementation/automated tests/install/Tim acceptance remain separate.** No deployment or external report transmission is authorised by this document.
