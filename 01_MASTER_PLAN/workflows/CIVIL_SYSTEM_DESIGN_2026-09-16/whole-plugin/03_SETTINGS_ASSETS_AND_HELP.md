# Settings, standards and Help — shared workflow design

FOR TIM

## Reading this record

Start with the [whole-job journey](19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). Read this record together with the [approved requirements and action qualifications](14_SHARED_APPROVED_ASSET_AND_SETTINGS_REQUIREMENTS.md); those explicit corrections govern where the earlier summary is incomplete. Source observations remain evidence, not approval or installed behaviour.



Changing a default must not redraw an existing job. A project carries its agreed rules; office standards and personal appearance remain separate.

## Authority and ownership

Approved SH-04, AS-01, SH-01 and Round8 decisions govern. The inspected shared owner's `SH-04A_SHARED_SETTINGS_HELP_IMPLEMENTATION_CARD.md` already defines staged Civil settings and a hosted Help route. Reuse that contract, not a second settings writer. Structural's CESETTINGS command owner remains unchanged unless its explicit migration is approved. Later Civil windows/ownership overrides remain in force.

## S-01 — change a setting

**Entry:** relevant object's Settings action opens its relevant page; the common Settings entry gives General / Civil / Structural / Project / Advanced access as approved. Search and context links can reduce tab hunting. Do not move controls without the retained-field ledger.

**Show:** each engineering value, units, Personal/Project/Office source, current project rule version, and whether it is an assumed value or approved source. Adoption and provenance are separate. An accepted assumption remains labelled Assumed. Read-only office standards stay visibly read-only for staff.

**Actions:** edit draft → Apply or Cancel. Leaving a dirty shared hosted page follows the already reviewed Apply / Discard / Stay contract; unsuccessful Apply retains the draft and focus. A saved default affects future work; a separate Review existing drawing action previews selected object changes before an accepted drawing update. No retroactive network/member change occurs just from Save.

**Reset:** current page, personal settings or project settings; show exact scope and changed values. A project reset is a reviewed project change, not a global reset. Cancel must leave saved settings intact. Personal-file changes must not be described as reversible with AutoCAD Undo.

**Theme:** preview without altering drawing content. Discard returns to the currently authoritative saved appearance, including any legitimate external preference change; it must not save an obsolete starting theme. Missing module capability explains its limitation and keeps the existing editor available.

**Rule revision:** retain the job's rulebook version, show a newer office version as available for review, list affected values/calculations, and adopt only the user's confirmed scope. New standards are not silently imported on opening the project.

**Source observations:** `CeSettingsDialog.xaml.cs:17–28` clones current user settings; `OnResetDefaultsClick` at364 returns an entirely new UserSettings with success and closes; `CeSettingsUiService.Open` subsequently replaces saved settings on success. Theme selection at371 directly previews through ThemeManager; Cancel at358 merely closes in this file. This is a bounded source comparison, not a live bug verdict. The scoped reset/appearance-discard contract needs parity checking with this retained fallback.

**Later owner evidence:** read-only inspection of **CE Structural - Control Room** found its15September review of candidate `f6f98733` reports failed-save retention, removal of duplicate saving and appearance restoration, with global Reset still unscoped. This is another owner's recorded source review, not independently re-run evidence. Neither the root file nor the inspected28a2 file contains that candidate's helper/change; the named preservation acceptance document is absent at28a2. Therefore do not label the candidate missing or redo it from the older root copy. Preserve it for owner-led reconciliation. Native Save/reopen, retry, Cancel/X and theme checks remain explicitly unproved in that record. No git operation was used to retrieve another revision in this overnight.

**Retained Structural sections:** General, Beam, Joint, Supports, Bracing, Rafter/Joist, Rebar, Annotation, Xref Layer, System and Data/Automation. Existing labels include offsets/detection tolerances, support snap stages, beam linking, automatic text-side choice, bracing flip prompts, joist placement, diagnostic/autosave controls, Excel schedule formatting/audit choices and MarkupAI switches. Advanced detection tolerances belong in an advanced view under SH-04; retain their functionality and explain units. Markup/provider switches do not themselves grant permission to send client data.

**Scenarios:** drafter B opens drafter A's job and retains its agreed engineering settings; changing a beam-label default leaves existing hand-placed labels untouched; cancelling a reset restores every edited field; a failed save keeps the draft available; a newer office rule marks review without altering prior results.

## S-02 — use or update an office asset

**Entry:** relevant drafting tool's part/detail picker and the approved dockable detail browser use one governed catalogue. A detail browser is not a competing standards database.

**Show:** thumbnail/large preview, name/detail number, discipline, source/version, approval state, intended scale/layer and editable variables. Distinguish editable DWG detail from reference PDF. A multi-detail source drawing needs separate identifiable detail entries with retained source references; extraction boundaries remain a reviewed capability.

**Approved states:** Not yet reviewed / Approved office standard / Needs correction / Superseded. Not yet reviewed means no recorded review, not defective. Normal choices hide historical/superseded assets; deliberate historical access remains available. No numeric confidence turns an unreviewed item into approved.

**Journey:** select/search → preview relevant detail → confirm engineering suitability → preview insertion scale/position → insert editable project copy. Source masters remain read-only. Choosing an item for a job does not approve the library master. Cancel before insertion changes nothing; an accepted insertion is one drawing Undo. Save/reopen retains source identity and subsequent project edits.

**Updates:** compare a changed library original with the project copy; show source changes separately from project edits; user chooses accepted changes. Never overwrite a project-modified detail silently. Submitting a useful project detail proposes a Not yet reviewed library item, not an immediate office standard.

**Known boundaries:** AS-01 makes DWG the authored master and DXF a derivative. Folder-file presence or a thumbnail does not establish engineering suitability. Parts-catalogue row identity must be stable across edit/save; screen row number is not identity. New part defaults must not rewrite existing pits or members.

**Scenarios:** select a standard footing detail for a project with an intentionally changed dimension; a later master revision is shown as a comparison while the project dimension stays pinned. Missing/offline office library preserves existing project copies and explains unavailable new assets, never substitutes another detail with a similar name.

## S-03 — find the right command and help

**Entry:** context Help from the current command/object; command search accepts plain drafting descriptions and legacy names. Keep existing CEHELP / CE_HELP / ?CE / CDHELP routes until the approved owner migration and content parity exist.

**Content:** what it does, exact click/type steps, before/after picture, required input, what Cancel/Undo do, limitations, related tools, engineering source where relevant. Use command-register facts for labels/routes/status so the ribbon, Help and search do not disagree. Offline Help must remain useful without AI/network.

**Retain:** topics, anchors, search, feedback/support links, known legacy aliases and current browser fallback where embedded viewing is unavailable. A common Help frame showing one sample topic is not complete migration.

**Discovery:** offer a relevant action after selection, explain why it applies, and keep existing direct commands. Hidden/review-pending tools should not appear as accepted daily tools just because the source inventory found them. Expert/deprecated command filters remain discoverable for intentional use.

**Scenario:** search 'move the beam label' from a selected beam; Help points to the label action and illustrates that beam/support positions remain unchanged. If the command is unavailable in that loaded module, show its actual availability instead of a button that silently fails.

## Design checks still required

Complete one-to-one field/action retention against SOURCE_INVENTORY and code-built controls; inspect whole-plugin visuals; reconcile exact modern/legacy fallback coverage; audit scope-specific source ownership. No new native behaviour is claimed by this document.
