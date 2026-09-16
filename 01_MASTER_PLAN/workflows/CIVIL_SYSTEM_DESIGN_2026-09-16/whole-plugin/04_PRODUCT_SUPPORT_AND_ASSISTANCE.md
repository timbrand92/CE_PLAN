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
