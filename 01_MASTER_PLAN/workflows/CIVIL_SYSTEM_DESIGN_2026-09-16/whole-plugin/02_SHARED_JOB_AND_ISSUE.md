# Shared job, sheets and issue — detailed planning in progress

FOR TIM

One job record should serve Civil and Structural. The user starts from their drawing, works with the appropriate discipline tools, and returns to the same sheet register and issue history. This is a proposal for joining existing approved workflows; it does not create a new competing home window.

## Authority and present source

Approved intent: SH-04 settings, ST-07 schedules/sheets, QA-01 issue review, and the later Structural drawing-journey decisions of 14 September. Existing Project-to-Issue owner remains responsible for implementation.

Source observed: `Modules/Structural/Commands/SheetsCommands.cs:15–17` gives CESHEETS/CESHEETSMANAGER a shared entry; CESHEETSCLASSIC remains separately declared at line39. `CeProjectSetupDialog.xaml` exposes project root, profile, project metadata, initial revision, sheet titles and optional shared title Xref. `CeSheetsSyncPreviewWindow.xaml` exposes Cancel and Apply Sync. `CeSheetsValidationReportWindow.xaml` exposes per-sheet findings, Export Report and Close. `CeIssuePublishDialog.xaml` exposes disciplines, date, council purpose, separate/combined pack-folder choices, preview, Publish and Cancel. These are source observations, not proof those paths are installed or working.

## J-01 — recognise the job and prepare drawings

**Retain:** the existing project setup and layer setup routes; profile/template choices; project metadata; optional sheet suggestions. Automatic job recognition is approved, not a request for a folder-link wizard in CDDESIGN.

**Journey:** open/save the drawing in its project → show identified job → suggest missing metadata from folder evidence → user corrects values where needed → preview proposed setup → create only accepted project copies. Existing drawings take the review/update route instead of being treated as blank.

**Fields retained:** job number, job name, address, suburb, optional client, drawn/designed by, template profile, initial revision, title sheet title, additional sheet titles, shared-title-Xref choice. Checked-by is also an approved shared requirement; its absence in the inspected setup layout is a source-to-intent gap, not evidence it is absent everywhere.

**Automatic assistance:** identify context, suggest metadata and a relevant editable starting sheet list. Never infer a universal filename, sheet count, level arrangement or stage from one example. Prepared architectural backgrounds and project host drawings are distinct stages; recognise background editing without silently resetting the host's job.

**Manual control:** correct metadata once in the shared record; confirm background scale/alignment; keep optional client insertion explicit. Ambiguous/unsaved project recognition remains a visible unresolved case; no automatic folder creation based on guessed identity.

**Preview/output:** list exact new files and standards changes, alongside the drawing/background preview. Show existing file conflicts before acceptance. Library/template masters remain read-only. Cancel creates nothing. File creation and multi-drawing changes need an explicit recovery contract; do not promise one AutoCAD Undo can undo external files.

**Representative scenario:** a synthetic job already has two drawings. Opening a third must offer the same project metadata and sheet list without generating a second project or overwriting either existing drawing. Saving outside that project must not silently adopt another project's rules.

## J-02 — keep the drawing register and title blocks together

**Retain:** sheet manager, classic route pending approved migration, validation report, sync preview, shared-title mapping and project properties. No broad replacement is proposed merely because multiple windows exist.

**Journey:** add/rename/reorder/remove sheets in one shared list → review affected register and title-block changes → Apply the confirmed set → report exactly what changed and what could not be updated.

**Identity:** sheet identity must survive a changed title or drawing path. Display order is distinct from printed sheet number and PDF page number. Numbering gaps are legitimate; never renumber merely to remove them. A drawing can contain multiple layouts; a project can have one or multiple DWGs.

**Preview:** old/new sheet number, title, revision/date, drawing/layout and whether the target is open, closed, unavailable or protected. An unavailable sheet is not a successful update. Preserve user-reviewed mapping; no silent title-block guess.

**Lifecycle:** discard edits on Cancel; recheck targets immediately before Apply; stale previews require refresh. Single-drawing accepted edits follow one Undo; the shared owner's multi-file recovery design must explicitly handle partially unavailable files. Save/reopen must preserve the same sheet identities and pending conflicts.

**Representative scenario:** rename one sheet in a four-sheet set with one unavailable drawing. Preview must show the intended rename and unavailable target. It must not claim all title blocks are synchronised while one remains unchanged.

## J-03 — prepare and complete an issue

Approved Structural behaviour: combined PDF normally contains the full current set, including unchanged sheets, with smaller selection allowed. Suggest affected sheets; user confirms which receive a new revision. Unchanged sheets retain revision and date. Preliminary/tender/construction revision sequences are configurable, not a mandatory P-to-T-to-A chain.

**Journey:** select issue purpose and sheet membership → review proposed changed-sheet revisions/dates → review unresolved QA and remembered departures → inspect combined PDF preparation → publish → verify output → explicitly finalise the issue record under the shared owner's reviewed boundary.

**Keep two choices separate:** separate/combined discipline folders in the current Publish dialog is not the same question as one combined PDF versus individual sheet PDFs. A combined folder option cannot prove the approved combined-PDF requirement is satisfied.

**Preview:** every included sheet in order, current/proposed revision and date, issue description, output filename/folder, missing resources and unresolved checks. Suggested naming remains editable. No transmission of a real issue is authorised by this planning.

**Revision graphics:** after A, show only changes since the previous issued revision; when issuing C, replace B's clouds/triangles with B-to-C changes. Historic issued PDFs retain prior marks. Temporary review highlights never print; intentional issue annotations do.

**Failure/cancel:** retain drafting work, leave the issue unfinalised, allow retry without another revision increment. Do not report success solely because a plot command finished; prove the expected PDF exists with the intended sheets before finalisation. Exact publication/commit boundary and multi-file rollback need the existing owner's implementation contract.

**Remembered decisions:** scope to the relevant item/job and governing evidence. Recheck when that evidence changes. Provide a list to see/correct/remove remembered decisions. Repeated choices may suggest an office preference, but only Tim's approval makes it general policy.

**Representative scenario:** issue B changes two of six sheets. All six go into the combined PDF; four keep their previous dates/revisions. A cancelled plot creates no completed issue and retry does not move the two changed sheets to C.

## Next source checks

Read the current sheet-manager actions and project/issue services, inspect the complete code-built controls, map every action to the retained-control ledger, and reconcile with the shared owner's current planning contract. Do not mark this card complete from the XAML inventory alone.

## Source reconciliation — 16 September, inspected continuation

These are observations in the inspected checkout, not claims about the live installed version or other owners' pending work.

| Exact source | Observed behaviour | Planning consequence |
|---|---|---|
| `CeSheetsManagerWindow.xaml.cs:505` | Sync Drawings calls `CeSheetsUpdateService.UpdateAllDrawings` directly; the separate sync-preview XAML is not used in this handler | A preview window existing on disk does not establish this invocation previews changes. Preserve the working update route and reconcile the approval boundary before modifying it |
| `CeSheetsManagerWindow.xaml.cs:1175` | Create Issue Snapshot runs before Publish; it updates history and reports a created issue | User-visible Proposed / Prepared / Published / Finalised states need explicit reconciliation; do not equate a snapshot with a successfully issued PDF |
| `CeSheetsManagerWindow.xaml.cs:1290` vicinity | Code-created publish options retain plot-style choice, paper override, combine checkbox (on), open-folder choice, Publish and Cancel | Add these to retained controls; XAML-only inventory missed them |
| `CeSheetsIssueService.cs:25–79` | CreateIssue sets snapshot and every included sheet's IssueDate to the supplied date, replaces same-ID entry and saves manifest before plotting | Does not preserve the approved unchanged-sheet-date distinction in this path. Preserve earlier issued history; model retry/reissue separately from a new issue |
| `CeSheetsIssueService.cs:82` | Invalid/unrecognised date falls back to today | Proposed review must show and require correction of an invalid date, not silently replace an explicitly entered date |
| `CeSheetsIssueService.cs:134–149` | Combined mode is documented as one PDF per DWG, with returned count being files | Verify actual publishing grouping next. Approved full-set combined PDF may require joining multiple drawings; label must distinguish scope |

None of these observations authorises a fix or bypasses the shared Project-to-Issue owner. They are concrete comparison cases for the whole-plugin planning audit.
