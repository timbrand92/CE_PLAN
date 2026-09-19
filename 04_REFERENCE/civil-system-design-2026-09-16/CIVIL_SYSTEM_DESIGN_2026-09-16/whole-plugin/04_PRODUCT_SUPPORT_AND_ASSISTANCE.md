# Product support, assistance and recovery — whole-plugin planning

FOR TIM

## Reading this record

Start with the [whole-job journey](19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). Read this record together with the [approved requirements and action qualifications](16_RECOVERY_AND_RELEASE_REQUIREMENTS.md); those explicit corrections govern where the earlier summary is incomplete. Source observations remain evidence, not approval or installed behaviour.



Daily drafting should open directly into the job. Manager handles the shared job pages and product support; it must not become another competing drafting home screen. Help works offline, and the assistant proposes changes for review.

## M-01 — start CE and find the right tool

**Approved basis:** SH-01 gives one CE product, consistent essential navigation across supported AutoCAD versions, no startup popup/network wait, isolated module failures and visible recovery. Keep useful existing palettes/actions while consolidating competing home screens only under their approved migration.

**Experience:** drawing opens → quiet CE status → use Civil/Structural drafting commands or contextual selection actions. Product status names the affected area if something fails. A failed Structural module must not remove Civil drafting or freeze AutoCAD. Do not automatically scan a whole project merely because Manager opens.

**Retain routes:** CEMANAGER, CEMANAGERADMIN, CEMANAGERUPDATES, CEMANAGERDIAG, CEMANAGERLOGS, CEMANAGERREFRESH, CEHEALTH and CESUPPORT are eight Manager declarations in the inspected checkout. Keep route meanings distinct even when they share a page. Existing version commands must resolve to actual loaded identity, not only the newest available package.

**Show:** loaded product/version/channel, installed versus pending update, health and a concise action. Detailed paths/hashes belong in expandable technical evidence, not the drafter's primary task. Unknown load identity remains Unknown; it cannot display green merely because a file exists.

**Retained module actions:** Open Hub, Open Help, Settings, Open Repair, View Commands, enable/disable, Load Now, install/update, View History and View Superseded appear in PluginManagerWindow.xaml. Each must be classified against the approved shared-workspace migration before layout replacement. Button presence does not prove safe activation or supported availability.

**Scenarios:** open an offline drawing; CE navigation remains usable. Disable a failing optional feature; other drafting stays available. An update is downloaded while AutoCAD is running; the status says restart/pending rather than claiming the newly downloaded version is loaded.

## M-02 — health and support

**Journey:** click CE Health → separate Installation / Active Drawing / Performance / optional AI connection findings → select a finding → see relevant recovery action. The drawing is not repaired by running a review. Opening Repair is distinct from applying a repair.

**Support:** collect a local bundle of the actual available logs, product identity and diagnostic evidence; list what was included and what was unavailable. No empty-success result. Review/export/upload remain clearly identified actions; the drawing itself is not included without the approved specific permission. No support action was invoked during this planning.

**Current source boundary:** CEMANAGERREFRESH invokes queued-data upload as well as refreshing product/ribbon state. Admin Refresh and Create Bundle similarly invoke outbox upload. The intended wording must accurately disclose these side effects under the existing telemetry policy; a proposed read-only refresh cannot reuse them unchanged and claim no transfer. This observation does not establish a privacy-policy violation or authorise a source fix.

**Retained auxiliary windows:** PluginCommandListWindow has search and expert/deprecated filters; PluginUpdateHistoryWindow shows update notes; PluginSupersededBuildsWindow shows archived releases. They are code-built and were not included in the82 XAML surfaces. Historical build browsing must not silently activate an older package.

**Scenarios:** missing Civil logs produce an explicit missing-evidence row; support collection can still preserve available Manager logs. If the shared upload destination is unavailable, the bundle stays local with its actual location and pending state. A user can find the relevant error without copying the entire drawing into support.

## M-03 — review updates, pilot and recovery

**Approved basis:** RS-01 and Rounds3/7/9: one exact release identity, Tim Test → Pilot → Staff Stable, preserved rollback, closed-AutoCAD activation, no hot-swapping. This planning grants no deployment or promotion permission.

**Staff journey:** see approved update → inspect concise changes → keep working → allow approved after-close installation through the established release mechanism → reopen → verify actual loaded version. No prompt on every drawing opening, no silent mid-command replacement. Offline machines retain their working installation.

**Administrator journey:** select exact prepared release → review evidence/channel/target machines → approve a bounded pilot → inspect actual health → deliberately promote the same accepted package. Show planned versus completed rollout per machine. Rollback approval and actual machine rollback are different states.

**Retain admin controls:** Overview, Updates, machine health/usage/failures/support data; refresh, upload pending, create support bundle, approve available, rollback approved, pilot machine selection, promote to all, acknowledge failure and existing publication route. Protect privileged actions and explain why staff cannot activate them; do not hide basic installed-version/health information behind administrator access.

**Source reconciliation:** current PluginAdminWindow handlers show pilot-machine entry, approval/rollback and promotion confirmation. Installer/Program.cs delegates its active Main to CeInstallerApplication; the older delete/overwrite implementation is under `#if false` and must not be treated as active. CeInstallerApplication rejects legacy install/update modes and expects one verified staged activation request. Do not expose those internal command-line parameters to ordinary drafters or create a second installer.

**Recovery states:** staged / waiting for AutoCAD to close / activating / verified / failed and restored / manual attention. Describe the actual retained old package and recovery result, not a generic 'rolled back' claim. Failed validation must not damage the current usable bundle. Existing release owner retains implementation and deployment responsibility.

**Scenarios:** AutoCAD is still closing; activation waits rather than replacing loaded files. A file check fails before activation; current installation stays intact. A pilot machine reports a failure; wider promotion remains unapproved. This document specifies acceptance cases; no installer was run.

## A-01 — Ask CE and guided automation

**Approved basis:** AI-01 retains a shared dockable non-blocking assistant, CEASK destination with existing CDASK migration, central registered tools, visible drawing/connection/permission scope, Stop and timeout handling, deterministic engineering authority and explicit preview/adoption. Historical 'MarkupAI parked from AI-01 v1' is not a cancellation of later separately approved Structural markup planning.

**Read journey:** choose the current drawing/context → ask a question → assistant reads a genuinely non-writing snapshot → show answer with source and Unknown where unsupported. 'Review' must not secretly synchronise drawing records. Changing the active drawing invalidates the old scope; no reply can silently apply to another drawing.

**Write journey:** request an outcome → show affected objects and before/after preview → allow partial acceptance and manual adjustment under the appropriate tool card → recheck governing drawing/source → explicit Apply → one accepted drawing Undo. Stale proposals are refreshed, not applied to changed geometry. Stop cancels pending work and preserves previously committed separate operations.

**Automation boundary:** only approved registered operations with checked inputs. No arbitrary LISP, shell commands or generated program execution inside the drawing. Suggested repeated-work automation creates a reviewed proposal, not new invisible behaviour. Manual drafting remains usable without the assistant or network.

**Permissions:** preserve the exact approved read/write/provider controls; do not restate historic provider-retention claims as current facts. Enabling a settings switch does not approve a new data destination. Confidential-project constraints remain explicit. The present overnight reads bounded source/planning records and already authorised evidence; it does not activate AI drawing access.

**Engineering distinction:** source extraction proposes information, the engineer confirms adoption, the appropriate calculation/QA engine evaluates it, and the assistant explains the result. Fluent explanation is not engineering approval. A missed datum cannot become zero; an unchecked sheet cannot become Ready.

**Scenarios:** request pipe review with a missing invert; show Unknown and the affected check, never an invented passing result. Request a member update then move that member before Apply; mark the preview stale. Disconnect while drafting; drawing tools remain responsive and the pending proposal cannot write later.

## Still to verify

Complete retained-control mapping, latest shared-owner reconciliation, direct-versus-embedded route distinctions, supported-version presentation and representative visual review. Product-source observations above do not claim installed behaviour or AutoCAD acceptance.
## Markup preview freshness — additional bounded source qualification

Root `Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml.cs:28–59` reads the runtime package and drawing preview. It builds a drawing snapshot only when the stored snapshot is null; `BtnRefresh_Click:334–337` calls that same loader. Thus this window's Refresh button alone does not prove a fresh snapshot of a changed drawing. Other workflow invalidation may exist and must be traced before claiming an actual stale-application defect.

The source window lists item/page/intent/text/approval/command/placement and displays confidence, but those display values do not establish engineering suitability or drawing-action approval. The Open PDF action at:339–357 checks file presence and invokes the external viewer; successful launch is not proof of correct page/revision or alignment. This overnight did not launch it.

Required planning check: bind reviewed markup, page/revision, alignment and target drawing state; invalidate or rebuild the relevant preview before Apply when that basis changes. Keep missing PDF, stale drawing snapshot, unresolved interpretation and pending approval distinct. Existing Structural markup authority and manual overrides govern; no automatic send or drawing action is authorised by viewing a preview. Next source work is the workflow's snapshot invalidation and execute-group guards, not another review of this window's controls.

### Execution handoff read-back

Root `MarkupAIWorkflowService.cs:470–505` does provide separate placement-context rebuild routes; successful rebuild enriches plans and replaces the snapshot, failure clears it. Therefore the preview-window finding is not a claim that no refresh capability exists. The execution route at:169–183 passes the stored package/snapshot/plans onward; it does not itself call that rebuild first.

`Commands/MarkupAICommands.cs:217–242` performs normal preflight, previews the next batch and asks Yes/No before execution. `MarkupAIExecutionService.cs:53–200` chooses pending group/sub-batch, refuses Manual executor, obtains the active document and dispatches native/Python work. Native results are mapped per action; missing native results become failures unless an approved fallback applies. Python result mapping skips actions without a returned result and bases success on returned executed/failed counts, so requested-versus-returned identity completeness needs separate qualification.

`MarkupAINativeExecutionService.cs:33–103` checks document/package/plans, prepares drawing standards and executes each action under document lock, retaining individual failures. The inspected boundary does not compare the reviewed snapshot's drawing path/content with the active drawing. Python batch construction at `MarkupAIPyAutocadWorkerService.cs:125–165` sets DrawingPath from the active document while transforming actions using the supplied snapshot. Other downstream guards and exact action mutations remain to be qualified; these observations are not a proven wrong-drawing runtime event.

Proposed acceptance contract: before execution, verify exact reviewed package revision, selected action identities, target drawing and relevant drawing state. A switch of job, changed drawing, changed alignment or replan requires fresh scoped review rather than silent retargeting. Execution receipt distinguishes every requested action as completed, failed, pending or unknown; partial success is not a whole-batch pass. Preserve manual choices and protected-object rules, and qualify actual Undo separately from a source attempt to group actions. No markup parsing, external worker, command or drawing execution occurred in this planning read.

Direct-command fallback qualification: `MarkupAIExecutionService.cs:13` defines an empty whitelist; its predicate checks that list and this file contains no additions. Thus no direct fallback is enabled by this inspected list. The conditional branch and code wording “approved” are not evidence of Tim approving a fallback or of one being available.

## Manager enable, load and update — distinct action meanings

Additional root read: `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:163–268`, `Services/CePluginRegistryService.cs:157–224`, `Services/CePluginInstallerService.cs:208–254`. No manager action was invoked and no installed manifest was read or changed.

| Button | Inspected current effect | Target scope and receipt |
|---|---|---|
| Enable/disable | Changes every ComponentEntry's LoadOnAutoCADStartup in the descriptor's manifest, writes it and flags RestartRequired | Startup preference, not unloading the currently running module. Do not say a loaded failing tool has stopped merely because its next-start setting changed. |
| Load Now | Rejects already-loaded descriptor or missing DLL path; queues NETLOAD in active drawing; host schedules a later refresh | Queued load is not verified loaded identity. Existing RS no-hot-swap/activation rules govern eligibility; a button is not permission to replace a loaded version. |
| Install/update | Active service stages outside plugin scan folders, optionally obtains a remote bundle, returns PendingRestart; legacy live mutation is inside `#if false` | Staged, activated and loaded stay separate. Reuse exact staged identity and existing closed-process owner. Do not describe the inactive legacy branch as a current live overwrite. |
| Close after any action | Does not undo a manifest preference already saved, a queued command or completed staging | Explain completed effect and current state. Cancel applies to pending action only; recovery belongs to that action's owner. |

The startup toggle still writes its descriptor manifest in this inspected route, whereas active update staging does not. This distinction needs reconciliation with current release ownership and preference location; do not generalize staging's no-live-manifest claim to every Manager button. Planning does not authorise changing installed files or relaxing release controls.

Future synthetic acceptance: disable an already loaded optional module and verify truthful current-versus-next-start state; denied manifest write; queue load with no active drawing; attempt already-loaded route; stage update then keep drafting; reopen only after approved closed-process activation and verify actual loaded identity. No running processes, bundles or deployment state were touched in this read.
