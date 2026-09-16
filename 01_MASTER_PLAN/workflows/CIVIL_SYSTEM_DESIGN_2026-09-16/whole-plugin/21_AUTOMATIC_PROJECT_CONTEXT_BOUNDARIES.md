# Automatic project linking — drawing and folder boundaries

FOR TIM

The project should follow the drawing automatically. Switching to another drawing in the same job should retain the job draft. Switching jobs must not apply that draft to the new job. Selecting reports remains a separate action from identifying the job.

This supplements [the job journey](19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md) and [synthetic walkthrough](20_INTEGRATED_SYNTHETIC_JOB_WALKTHROUGH.md). It records inspected source and proposed acceptance checks, not an AutoCAD test or a new folder-selection workflow.

## Read-only source evidence

Owner copy inspected: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN`. Paths below are relative to that exact copy. No source was changed.

| Source and line | Observed effect | Planning consequence |
|---|---|---|
| `Modules/Structural/Services/CeSheetsPathService.cs:55` | Existing file uses its parent directory; otherwise the supplied full path is treated as a directory. A recognised office projects marker is parsed using optional year/client segments. Without the marker, returns that directory. | This is a bounded path heuristic, not proof of universal project identity. Unsaved, missing, moved and nonstandard-folder drawings need explicit qualification. |
| `Modules/Structural/Services/CeDrawingPropertiesService.cs:222` | Its resolver also requires an existing directory and either the office marker or a manifest. | Drawing Properties and the shared bridge do not have identical admission checks. Do not assume all pages resolve every path identically. |
| `Modules/Structural/Project/CeProjectSheetsWorkspaceBridge.cs:35` | Resolves path, requires directory, constructs passive view and rejects blank project root. | Shared page opening is intended to avoid a scan. This is not report discovery or confirmation of a saved manifest. |
| `Modules/Manager/UI/Dialogs/PluginManagerWindow.ProjectSheets.cs:75` | Reads active drawing; same path restores session. A different path creates candidate, compares roots and retains existing session for same root. Different root resolves departure before replacing session. | Preserve same-job draft. Keep old job draft isolated during a job change; do not transfer values automatically. |
| Same file `:308` and `:415` | Action context revalidation compares admitted session and exact active path, retrying context resolution if necessary. | Save/discard must target the admitted job. This check alone does not prove every internal file action has the same guard. |
| `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:115` | Hooks document activation and impending destruction; callback invalidates QA/repair and notifies Project/Sheets. | These observed hooks do not establish Save As notification. Action-time path revalidation exists; same-document Save As and pending internal actions still need native evidence. |
| `Modules/Structural/UI/Pages/CeProjectSheetsWorkspaceView.xaml.cs:2745` | Shared-mode root changes rejected; Manager owns context change. Classic recovery exempt. | Retain owner responsibility; CDDESIGN must not introduce an independent competing folder picker. Civil standalone remains a separate approved requirement. |
| `Modules/Structural/Services/CeSheetsPathService.cs:10` | Sheet-scanning exclusions include Survey, Background, Architectural, Xref, archived and issued folders. | These are sheet-discovery exclusions. They must not be reused as blanket report/background-ingestion exclusions: precisely those folders may hold governing design evidence. |

## Required planning scenarios — not executed

| Scenario | Expected user experience / retained authority |
|---|---|
| Switch between two saved drawings in one job | Automatic same-job context; retained project draft; drawing-specific actions use the current drawing only. |
| Switch to a different job with an unsaved shared draft | Apply / Discard / Stay under the approved departure contract; no silent draft transfer. |
| Save As within the job | Revalidate exact drawing identity and any pending drawing action; retained report adoption is not automatically duplicated into unrelated drawing records. Exact native behaviour remains unproved. |
| Save As into another job | Re-resolve job before any write. A copied drawing's old project metadata is evidence to reconcile, not permission to overwrite the destination job. |
| Unsaved drawing or unavailable network folder | Explain why job-dependent action is unavailable; retain permitted manual drafting. No fabricated folder, zero value, or automatic replacement job. |
| Job folder renamed or moved | Reconcile stable job/document identity with new location before writing or adopting. Exact current implementation is not established by the inspected path heuristic. |
| Reports live in Survey / Background / Xref folders | Discover relevant document candidates separately from the sheet scan, retaining document/page/revision evidence and confirmation before adoption. |
| Civil loaded without Structural/Manager | Civil's approved standalone operation must remain; this Structural bridge is not the universal prerequisite for Civil design. |

## Qualification still required

The exceptional ambiguous-project recovery interaction is **not approved**. See [pending recovery decision](../planner/decisions_for_tim.md), row9. Ordinary automatic linking is approved; visible unresolved identity must not silently become a guessed job or a newly invented recovery picker. This decision gap is separate from source-answerable lifecycle checks below.

Source establishes a useful existing shared-window context boundary, not complete automatic identity for every CE window. Remaining checks include standalone Civil context ownership, same-document Save As, nonstandard root recognition, internal action guards, and move/rename reconciliation. No new engineering decision is inferred and no current owner's implementation is interrupted.
