# Codex C0–C7 handover — 15 September 2026

## Read this first

**Useful work exists and some is installed. C0–C7 as a complete programme is not finished.** The immediate Civil defect is truthful Pipe/Pit Update and retained edits after failure. The immediate window defect is PIT fitting at minimum height. The saved Structural window corrections must preserve the installed SBEAM commands.

```text
Installed Civil 10ac480d          Installed Structural 5d723d41
        |                                  |
Pipe/Pit save correction         Narrow window fixes 60c41228
PIT minimum-size correction                 |
        +---------- owner verification ----+
                           |
               One identified test installation
                           |
              Tim's drawing checks → acceptance

New shared Project/Sheets workspace stays saved separately.
```

This is a source-and-record audit, not an AutoCAD test. No plugin source was edited, branch switched, build run, merge made or bundle deployed during this handover. Earlier unfinished PIT edits remain untouched. Only this report is being published.

**Evidence words:** “source verified” means the named saved code was inspected; “recorded” means an earlier receipt or issue reports it; “Tim accepted” means a recorded AutoCAD result, limited to that scenario/build. “Installed” below means files measured on disk, not proof of what a running AutoCAD process loaded. No conclusions about undocumented Autodesk internals are made.

### Frozen identities used here

| Item | Observed source / position |
|---|---|
| CE_PLAN starting record | `main` at `db8f3bef05d2a85a602742fb4d8038f410174b33` |
| This plugin working copy | `codex/pit-no-scroll-20260915`, `10ac480d`: 0 ahead / 0 behind Civil live; three unfinished PIT files |
| Installed Civil, all three managed lanes | `10ac480df838edfe48c09334ad8837a347c4d528` |
| Installed Manager, all three managed lanes | `96e7d76ab86d59384553be837bd401b4deeec1ee` |
| Installed Structural, Modern | `5d723d412af1a3c34ec65b0df3b4a0f44c0c64f3` |
| Civil behaviour owner snapshot inspected | `origin/claude/c7-one-object` at `fbeaff484daa49f334d957c948ae660ccfcc97b1`: 51 ahead / 0 behind Civil live; not installed |
| Combined window source candidate | `codex/ui-connections-candidate-20260915`, `af0cd66a`: 14 ahead / 0 behind Civil live |
| Structural preservation candidate | `codex/structural-ui-preservation-20260915`, `60c41228`: 4 ahead / 0 behind installed Structural; 393 ahead / 995 behind Civil live |
| Original mixed window branch | `codex/v3-ui-connections-20260915`, `a21c5fd9`: **104 ahead / 22 behind current Civil live**. Earlier 20-behind count used an older live base |

The owner branch can advance after this snapshot. Re-read #78 and installed identities before any future source integration or deployment. Zero behind is only a first check; it does not establish compatibility with separately installed modules. A merge does not inherently roll files back simply because a branch is behind; installing an older or incomplete candidate tree is the concrete danger.

### Corrections to the existing consolidated record

- Its section 0 correctly identified Civil `10ac480d`, but **#78 now names it too**. Do not repeat the earlier stale-register accusation as the current state.
- C7 is now 0 behind live at the inspected owner snapshot; the earlier two-behind warning is historical.
- **CDPARTS Save/Reset is recorded as accepted by Tim**, not still wholly untested: [#78 ownership comment](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/78#issuecomment-5675315012).
- Manager unavailable-settings feedback, Setup template availability and Issue blocker feedback were recovered after that report, into `af0cd66a`.
- Tim already approved **“Yes—separate Structural preservation branch”**. That approval is implemented in `60c41228`; it is not a pending permission request.
- Tim already approved PIT input pages while previews/status/Update/Cancel remain visible: **“YES APPROVESD”** in this task. Layout verification remains unfinished; the approval itself is settled.
- **D1–D32 is recovered:** `codex/civil-ui-ux-area-plan` at `472ca53a`, `docs/CE_CIVIL_V3_UI_UX_DECISION_QUEUE.md`, read in full. Its named visual directory exists at `C:\Users\TimothyBrand\.codex\visualizations\2026\09\01\01a037f4-b1e4-73c3-9dec-c0a923a09ebd`. This audit recovered the written decisions; it did not rerun every visual. Later no-scroll/no-expander rules and the PIT/#75 approval supersede conflicting older presentation recommendations.
- “Twelve of thirteen areas are Planned” is too broad: the current master also describes tanks as active elsewhere, profiles as source evidence, schedules as partial foundations and repair as partial. Its September 1 percentages are historical estimates, not current measured progress.
- Help, profiles, proposals and repair are **not absent from source**. Existing routes and partial implementations are identified below; their complete approved experience is still unaccepted.

## 1. C0–C7: what exists, what remains

Code filenames in this report are developer locators [where Claude can find the operation], not instructions for Tim. Historical branch tips are preservation references. A tip not found in live ancestry does **not** prove its work is absent: several changes were separately integrated or copied. Do not merge those branches based on this table.

### C0 — normal picking, Civil grips and compound selection — issue #26

| Question | Answer |
|---|---|
| Intended result | Select the right Civil object from its line, MLINE or owned text; move only the intended label/arrow; keep normal AutoCAD grips, Cancel and Undo |
| Codex work | Exact-owned attachment actions and twin-centreline selection foundations; later exact DBText double-click routing. This is mostly command/selection work, not a new window. The resulting doorway reaches the existing Pipe/Pit editors |
| Where / integration | Historical grip checkpoints include `888959fc`, `573099f4`, `976b36ec`, `c51e60f5` and the combined correction series in the master. Later `codex/c0-dbtext-doubleclick` is preserved at `d41aae87`; that tip is not an ancestor of live, but the pinned live log records its author work `a53604b2` / `d41aae87` integrated as **`3ab2a4b1` / `19b9df15`**. Current live contains the later owner-managed grip/twin path and C7 foundations |
| Connected / installed | Managed Civil grip/twin routes have recorded real AutoCAD use. Current Civil files are `10ac480d`; this is not proof that every old Codex branch's final variation shipped |
| Tim acceptance | #26 records managed Slide/Offset/Flip and twin/MLINE acceptance, including Test Day 2 at `9050f497`; earlier failures remain history. Exact DBText follow-ups, every later variant and 2024 compatibility are not blanket accepted |
| Left / behaviour handoff | Claude owns current grip and selection behaviour. Preserve one operation behind each doorway; carry the exact drawing/object into the editor. Test accepted movement, Cancel, one Undo and save/reopen on the eventual combined build. Do not revive failed historical grip experiments |

### C1 — identity, relationships and trustworthy drawing facts — issue #27

| Question | Answer |
|---|---|
| Intended result | Each pit, pipe and source keeps its own identity; copying creates a new item; connections and labels resolve the correct item without guessing |
| Codex work | Read-only evidence contribution; copy identity guards; current plan-field authority and length-evidence guards. These support Inspector, editors, checks and profiles rather than form another spine |
| Where / integration | `codex/level2-readonly-evidence` `a0451a6f` (PR #56) and `codex/c1-copy-owned-identities` `0d705b94` are ancestors of live. So is `codex/c1-length-evidence-guard` `90c58782`. `codex/c1-live-field-authority` `322b45d3` is preserved but its tip is not an ancestor. Claude's shared spine/interface is the authority; use `docs/SPINE_INTERFACE_v1.md` and the current owner implementation |
| Connected / installed | Existing identity, Inspector, drawing checks and copy routes are in the installed source line; source presence does not prove all normal-edit and save/reopen cases |
| Tim acceptance | #24/#26 record bounded Test Day copy/upgrade/check successes. Later acceptance rounds also expose identity failures that were subsequently corrected. No full C1 acceptance is inferred |
| Left / behaviour handoff | Continue using `ProjectDataService.ApplyFieldEdit` at `Modules/Drainage/Services/ProjectDataService.FieldEdit.cs:39`, and exact existing readers. Carry truthful refusal and field source to the window; do not create a parallel record writer. C7 converted-object reads/writes, copy and refusal remain the owner's integration responsibility. The selected bent-centreline calculation basis and full physical pipe/pit fit warning still require engineering inputs; four pit-derived arc fields remain Unknown. A size-only warning must not claim a proven physical Fit/Pass |

### C2 — Pipe, Pit, Edit Civil Item and Civil Properties — issue #28; preview #75

| Question | Answer |
|---|---|
| Intended result | Draw/select first, see the real values, edit a single item or explicit same-type group, save once, cancel safely, keep useful drawing controls and no-scroll layout |
| Codex work | `CdDialog` / `CdViewModel`, `PitDialog` / `PitViewModel`; `PipeEditWorkshopDialog`, `PitEditWorkshopDialog`, `BatchEditWorkshopDialog`, editor comparison/focus/session helpers; `PitBlockPreviewControl` and the net10-only renderer. Some workshop paths are held/fallback paths, not the everyday installed window |
| Where / integration | Original `codex/c2-civil-editors` `c6fb9a47`, fixed-acceptance `a4dfec23` and material-preserving-text `8a2aeff0` are saved branches, not live ancestors at those tips. Pinned live records identify eleven editor checkpoints integrated at **`ab4c51f5`**, atomic batch at **`6c6974b3`** and automatic callout correction **`f53d700c`**. Atomic-batch `93b13dea` is an ancestor. Live owner integrations `50d94fe8` (Inspect/Move arrow return), `222b3d47` and `38842c9c` (exact Inspector Edit) are present. Preview original `a21c5fd9` was isolated and ultimately shipped as `9745f321`, followed by taller pane `63bc7207`, all in `10ac480d`. Do not replay it |
| Connected / installed | CD, CDEDIT, PIT and PITEDIT are real installed routes. Extra draft/session recovery `6e4dc2ca` is incorporated in the saved combined candidate `c2bda325` → `af0cd66a`, not a claim it is installed. Latest PIT input-page layout is uncommitted and not installed |
| Tim acceptance | #75: 7/8 original preview checks passed in AutoCAD 2027, including five close/reopens. 2024 is untested. Tim approved the taller pane in principle and input pages; **no-scroll acceptance remains open**. No blanket editor/Undo/failure-return pass |
| Left / behaviour handoff | Exact Update result/retry contract in §2; finish measured PIT minimum-height fit and preserve all controls/bindings/fallbacks. No new save writer. Claude owns drawing changes; Codex retains the same draft, comparison, tab and focus until the confirmed outcome |

### C3 — sources, tanks and connected drafting operations — issue #29

| Question | Answer |
|---|---|
| Intended result | Place sources before pipes, retain identity/tag, connect only from real evidence, edit owned attachments, and keep tank plan/detail eligibility distinct |
| Codex work | Selected-source routing and atomic drafting foundations recorded in C3A/C3B workflow cards; CDRG accepted-route work; documented Source/Water Tank window requirements. The full approved Source / Connection / Drawing window is **not delivered**. `WaterTankPlanBlockPickerDialog` is an existing picker, not proof that the whole proposed editor exists |
| Where / integration | Workflow records include `C3A_SELECTED_SOURCE_ROUTING_2026-09-09.md`, `C3B_SUPPORTED_NATIVE_EDIT_FOUNDATION_2026-09-09.md` and `C3_CDRG_ATOMIC_RAINGARDEN_2026-09-13.md` on `af0cd66a`. Pinned live log identifies prompted placement **`a7c81217`**, same-plan replacement **`0db2ad33`**, and CDRG **`7a6dc4e8`** after correction `3274f0cf`. Installed owner source includes `SourcePlacementService`, generic source commands and `aaf4c39f` window-driven tank placement. The latest C7 owner branch contains further source/split fixes, uninstalled |
| Connected / installed | CDSOURCE/CDFW and CDWT are existing installed operations. `SourceBlockGenericCommand.cs:66` calls `SourcePlacementService.Place`; `WaterTankCommand.Window.cs:93` defines `PlaceFromWindow`. There is no missing call that prevents all source placement |
| Tim acceptance | Repeated source-landing failures are recorded; later owner fixes still need their final field run. CDWT has been exercised, but its full agreed size/levels/details workflow is not accepted as complete |
| Left / behaviour handoff | Reuse existing ProposeNextTag / Assess / Place / Retag / Remove operations. The future shared Source editor needs a reviewed draft/preview/accepted-result contract, exact identity and unchanged Cancel; this is new window work, **not a dead existing Save Source button**. Claude retains CDWT behaviour and source/tank engineering integration |

### C4 — review, calculations, profiles and pit schedule — issue #30

| Question | Answer |
|---|---|
| Intended result | Read-only checks; visible evidence and uncertainty; calculate/review/approve/apply as distinct actions; profiles use a confirmed route; schedules follow the drawing |
| Codex work | `CalculationsV2Dialog`, `CalculationsV2ViewModel`, calculation draft comparison, `ProfileRouteReviewViewModel`, propagation/proposal preview windows, schedule source choices and system-scoped schedule work. These are substantial partial implementations, not merely a missing-screen list |
| Where / integration | Saved references: `codex/c4-current-level-authority` `9b940a63`, `codex/c4-profile-acceptance-r1` `99d7bf91`, `codex/c4-rules-continuation` `f19ee8d3`, `codex/c4-system-schedule` `c394f481`; those tips are not live ancestors. Pinned live records identify connected profile **`4deb31d4`**, corrections **`f79098da` / `c22a03bf`**, and current invert authority **`d2571afd`**. Live source contains `ProfileCommands.cs:60–63` constructing the route review and Calculations window, and the Apply call below. Later records include `fdbad909`, `f89572a2`, `0890f622` and calculation-save correction `403c88ea` |
| Connected / installed | Existing calculation/profile command callers are source-connected in `10ac480d`. This does not prove the entire unified Review window or profile drawing output in AutoCAD |
| Tim acceptance | Earlier schedule/core calculation use is recorded. No complete C4 profile/review/proposal/issued-output acceptance found |
| Left / behaviour handoff | **Profile Apply already exists:** `CalculationsV2Dialog.xaml.cs:227` → `ProfileRouteEvidenceCaptureService.Apply(_openingDocument, accepted)`; retain it, verify outcome and stale-drawing refusal. Read-only `ReviewReadingService.Take/CurrentFingerprint` already exists. Resolve the hard-coded TWL warning and council-specific source/settings interpretation in §2. Do not ask Claude to invent those existing services again |

### C5 — slab, intake, repair and settings — issue #32, before C6

| Question | Answer |
|---|---|
| Intended result | Work from real slab boundaries and levels, compare imports without changing accepted work, preview exact repairs and retain source/identity |
| Codex work | `SlabDialog`, `SlabEditDialog` / `SlabEditViewModel`; constrained-boundary and manual-joint ownership work; read-only import comparison; drawing-repair evidence/preview contribution. The full new Intake/Repair/Settings experience is not delivered |
| Where / integration | Read-only PR #56 `a0451a6f` is in live. Preserved branches `codex/c5-readonly-import-compare` `780a3cc6` and `codex/c5-repair-audit-evidence` `fbdd192d` are not live ancestors at their tips. Live contains `747698d9` controlled slab editor integration, `3c6c10a7` creation integration, `831ac462` manual-joint ownership and `da8ff118` ambiguous-ownership refusal; spoon ownership `dd7db7c8` and cold-cache correction `e32ad438`; survey intake `04664c90` and Manager hosting `d585c74c`. Whole-slab MOVE remains **startup-OFF** even after adapter `ced5ac62` and recorded 87/87 checks |
| Connected / installed | `SlabCommand.cs:127` opens `SlabDialog`; `HubCommands.cs:545` constructs `CdRepairDialog`. `CivilDrawingRepairContributor` has Preview/Apply members. Reachability of a dialog does not prove every approved repair, import or whole-slab operation is enabled or accepted |
| Tim acceptance | No full C5 acceptance found. Historical read-only checks do not accept the newer drawing-writing paths |
| Left / behaviour handoff | Reuse existing slab outlets, `SlabDrainageCheck`, `SlabFlowPlan` and overlay Show/Hide supplied in owner `6893a14c`. Distinguish read-only inspection from accepted repair. Claude must qualify held slab/repair/import writes and truthful outcomes before corresponding actions are exposed. Codex completes the approved windows against those contracts; DWG remains the model, not LandXML replacement |

### C6 — proposals, Ask CE and controlled learning — located at issue #31

| Question | Answer |
|---|---|
| Intended result | Explain/rank proposals with source evidence; apply only a reviewed choice; Ask CE is a read-only doorway; learning never silently changes office engineering standards |
| Codex work | `ProposalPreviewDialog` / `ProposalPreviewViewModel`; approved R03/R04 proposal work, runtime drawing facts, QA7 freshness/automatic evidence and shared Ask CE routing/close work. This is not a completed learning store or general design assistant |
| Where / integration | Preserved `codex/c6-a1-approved-proposals` `91e70c78` and `codex/c6-a2-runtime-drawing-facts` `9638ce13` are not live ancestors at their tips. Live contains **`a65e9084`** approved R03/R04 integration (author range `864f10d9..91e70c78` over `74b2fc3f`), QA7 output **`68e47088`**, automatic QA **`5570ae57`**, runtime drawing facts **`c46dfc2e`**, and `3213697b` reviewed shared Ask CE doorway record. See C6 workflow cards on `af0cd66a` |
| Connected / installed | `RulesCommand.cs:196` and `RunSolveCommand.cs:174` instantiate the proposal window. Project QA capture reads the existing Review reading. Existing source routes are not proof of all Manager-hosted runtime capabilities or current learning-store completion |
| Tim acceptance | No complete C6 acceptance found. Earlier pure-logic/host checks do not prove real-drawing proposal Apply, Ask CE window-close interaction or safe learning promotion |
| Left / behaviour handoff | Finish/accept C5 dependencies; qualify exact fresh proposal Apply and cancellation. QA7 agreement is **Advisory**, not full Ready; incomplete evidence stays Unknown and this check does not block Issue. Keep Unknown/Assumed/Manual distinct. Council/evidence studies cannot be promoted into engineering rules automatically. CDDESIGN's new guided window remains separate unfinished scope; existing command-line behaviour is not that window |

### C7 — a CE pipe as one AutoCAD object — issue #74

| Question | Answer |
|---|---|
| Intended result | A pipe/twin remains one logical object with correct graphics, grips, edits, identity and connected labels |
| Codex work | #75 pit preview is adjacent window work, not the native pipe object. The mixed UI branch imported a frozen owner enabler snapshot; **Codex did not author a competing enabler** |
| Where / integration | Installed Civil includes owner `b136bbe2` slices 1–2 and `82169b43` reading bridge. Current owner snapshot `fbeaff48` contains later work and needs matching API-v3 native files when deployed. Original UI import `c329c84c` was an intentional cherry-pick of owner `b136bbe2`, not a rebase accident; it became stale and is excluded from recovery |
| Connected / installed | Partial native pipe support is installed; latest split/edit integration is not. Installed files must not be described as the complete owner branch |
| Tim acceptance | Partial field use and failures are recorded. In particular #78 records converted-pipe CDFW split leaving overlapping geometry on live. Full C7 is not accepted |
| Left / behaviour handoff | Claude owns enabler, conversion, graphics/editing/spine/schedules/profile/check integration and deployment. Ship matching managed/native versions; keep automatic conversion on opening held until integration/acceptance. 2024 uses its supported older path, not the 2027 native module. Window consumers must distinguish a refused/unsupported write from success |

## 2. Exact window-to-behaviour handover

### Existing controls needing a truthful result

Civil line numbers below are verified at **`fbeaff48`**, unless marked otherwise; prepend `Modules/Drainage/` to Civil paths. The Pipe/Pit operations exist. The dependency is their truthful whole-operation result and the window's return lifecycle.

| Command / control Tim sees | Existing operation and exact locator | Outcome needed / visible failure | Scope and owner |
|---|---|---|---|
| **CDEDIT → Update**, Pipe editor | `Commands/PipeEditCommand.cs:169` calls boolean `UpdatePipeFromViewModel`; definition `Commands/PipeEditCommand.Update.cs:213`; line 170 prints success unconditionally | Honour false; no “Pipe updated” after refusal. Return to the same pending entries if the original drawing/object is still valid | Existing defect; Update failure path only. Claude command outcome; Codex retained window state. Batch caller at `PipeEditCommand.Batch.cs:436` already checks false |
| CDEDIT selected label wording → Update | `Commands/PipeEditCommand.cs:161` → `TryUpdateSelectedDisplayOnly` | Existing refusal is printed, but editor exits. Retain wording for correction/retry rather than losing it | Existing operation, improved failure return; not a new writer |
| **PITEDIT → Update** | `Commands/PitEditCommand.cs:307` → `UpdatePitBlock`; `:308` → `UpdatePitLabelAndCover`; `:312` rename references; `:315` update project pit | Confirm the entire accepted edit, including labels/references/data; otherwise explain refusal and retain pending values. Do not declare success for a partial/no-op edit | Existing operation; no complete result returned to the window. Whole-edit atomicity [all changes together] and one Undo need Claude verification; partial-write behaviour is not asserted as an observed AutoCAD failure |
| Pipe/Pit Update window return | `Dialogs/WorkshopEditorSession.cs:101–113`, `EndWindow`, calls `Complete(model)` at `:110` when the dialog was accepted, before the command writes | Agree completed / retryable refusal / target no longer available, then retain original comparison, tab and focus until the confirmed result | Shared lifecycle dependency, not entire-window unavailability. Never reopen against whichever drawing happens to be active |
| CDCALC detention **TWL warning** | `ViewModels/DetentionSystemViewModel.cs:904`, `UpdateTwlWarning`; `:919` subtracts literal `0.150`, following text fixes “150 mm” | Show the applicable Settings/council clearance, endpoints and source, or Unknown. Window must not impose its own universal engineering value | Codex consumer correction; Claude rule meaning. Existing `Rules/RulebookValues.cs:73` / `:150` has `DetentionFreeboardMm`; reuse/extend the agreed rule rather than invent another constant. Council freeboards are not all the same check |
| **CENOTES → Refresh**, saved combined candidate | `Modules/Structural/UI/Dialogs/NotesBrowserDialog.xaml.cs:189` → `_notesManager.GetAllUsersNotes(forceReload)` at `af0cd66a`; refresh at `:209` / `:1033` | Distinguish genuinely empty notes from failed reading and retain useful existing display on failure. Current reader `Core/Notes/SharedNotesManager.cs:274` catches scan errors and returns an empty list | Existing read operation; one feedback gap. Claude service result, Codex display. Do not present recovered force-refresh alone as complete error handling |

**One accepted drawing edit = one Undo.** This covers associated drawing labels/data, not just the main geometry. File-based catalogue/preferences saves are not undone by AutoCAD Undo. Failure must never redirect work to another drawing or bypass locked layers, Xrefs or REFEDIT.

### Fixed, existing, or genuinely new — do not commission duplicates

| Item | Verified position |
|---|---|
| **CDPARTS Save / Reset to Defaults** | **Fixed in installed `10ac480d`, Tim accepted per #78.** `PartsCatalogueViewModel.cs:168` gets `PartsCatalogueService.GetDefaults()` into cloned draft rows; no immediate save. `:191` calls `TryReplace`, retains window/error on failure and closes only on Saved. Service `PartsCatalogueService.cs:88` returns the result. Do not recreate BUG-152/153 fixes |
| CDSOURCE placement/connection | `SourceBlockGenericCommand.cs:66` → `SourcePlacementService.Place` exists. Earlier “missing Source operation” blocker is withdrawn. New Source editor Save Source / Save + Draw Pipe design has **no implemented missing-method call site to hand over** |
| Water Tank placement | `WaterTankCommand.Window.cs:93`, `PlaceFromWindow`, already exists. Current engineering catalogue/true-size/detail work remains Claude's; no second placement service |
| Inspector Edit / Pipe Move arrow | Owner integrations `222b3d47` / `38842c9c` and `50d94fe8` exist. Extra Codex comparison/tab preservation is saved in the recovery candidate. Preserve these paths while fixing failure return |
| Profile Apply | `CalculationsV2Dialog.xaml.cs:227` already calls `ProfileRouteEvidenceCaptureService.Apply`; original drawing check at `:217`. Needs native acceptance, not an invented missing Apply service |
| Structural **CESETTINGS Save** | Confirmed-write-before-close correction adapted on `60c41228`, with isolated-store checks. Still uninstalled/unaccepted. It does **not** prove all disk failures leave old bytes intact, and it does not make Reset scoped |
| Structural **Reset** | At `af0cd66a`, `CeSettingsDialog.xaml.cs:368` saves `new UserSettings()` — whole-settings reset, not Current page / Personal / Project reset. Scope-aware reset is unfinished approved design, not a completed control |
| Unified **Firm / Project parts catalogue** | New scope/data contract needed: stable row/project identity, provenance, editable Project additions, durable save/freshness and preserved old rows. Current `PartsCatalogueViewModel.cs:191` replaces per-user pit/pipe lists; it cannot enforce the proposed Firm/Project ownership. Do not relabel that list “Firm” and imply enforcement. No new scope-save call exists yet |
| Drawing review **Open drawing** | No implemented new button/call is asserted. Saved design requires exact-path open/activate, cancelled/unavailable/failed results and retained review context. `CeProjectSheetsWorkspaceView.xaml.cs:1253`, `ShowReviewedPlan`, currently displays the existing plan; a new opener is separate reviewed work, not a missing drawing writer |

## 3. Finished versus built-only

### What can honestly be credited

- Recorded C0 managed grip/twin acceptance for the bounded Test Day scenarios.
- Original #75 pit block rendering: **7/8 AutoCAD 2027 checks accepted**; remaining older-version check stays open.
- Installed CDPARTS Save/Reset correction: **recorded Tim acceptance**.
- Saved recovery source and executed focused checks below. Those are implementation evidence only.
- D1–D32 written approval record recovered, and separate Structural preservation permission settled.

### What must not be called delivered

- All C0–C7, full V3 windows, full design-pack inclusion, a colleague-ready release, or a new overall completion percentage.
- The 71 mixed-branch commits as one tested/installed UI. No Tim acceptance found for that whole recovery set.
- New PIT pages/no-scroll: latest executed check has a failure; not committed, not deployed.
- Saved Structural fixes: built and checked, not installed or driven in AutoCAD.
- Full shared Source editor, scope-aware catalogue/Reset, unified Intake/Review/Repair, new Project/Sheets integration, or full learning store.
- C4 profile writing, C5 held whole-slab movement, C6 Ask CE/proposal native lifecycle, and C7 complete converted-pipe editing merely because their files exist or builds succeeded.
- Any “tests pass” result with zero discovered/executed tests. In particular `preservation-settings-before.trx` executed **0** and proves nothing. #78 corrected its earlier blanket invalidation: explicitly configured nonzero net10 runs remain valid; do not withdraw genuine counted runs simply because they were modern-lane tests.

Existing receipts, parsed rather than inferred from exit codes:

| Receipt | Executed / passed / failed | Limit |
|---|---:|---|
| `combined-civil.trx` | 8 / 8 / 0 | Initial combination, not final-head full suite |
| `combined-manager.trx` | 14 / 14 / 0 | Same |
| `combined-structural.trx` | 64 / 64 / 0 | Same; total initial combination 86/86 |
| `issue-review-bindings.trx` | 2 / 2 / 0 | Real-record display checks |
| `validation-summary-recovery.trx` | 6 / 6 / 0 | Summary logic |
| `preservation-settings-before.trx` | **0 / 0 / 0** | Invalid verification |
| `preservation-settings-staged-before.trx` | 8 / 7 / 1 | Genuine failing guard |
| `preservation-settings-after.trx` | 8 / 8 / 0 | Isolated settings write/retry and appearance helper |
| `preservation-publish-checks.trx` | 14 / 14 / 0 | Includes overlapping Settings/summary checks; not a native Publish run |
| `pit-pages-populated2.trx` | **11 / 10 / 1** | Latest unfinished PIT layout; supersedes weaker earlier all-pass layout evidence |

Receipts: `C:\Autodesk\CERef\V3-Windows-20260915\connections`, and `pit-preview-75` beside it. Do not sum overlapping runs into unique coverage. Recorded three-lane builds concern their named checkpoints; no builds/tests were rerun during this report. Historical full-suite counts vary with branch/configuration; neither 275 nor 23 failures is a universal current baseline.

## 4. Window recovery and Structural preservation

### The 71 original non-Civil commits

They comprise **59 implementation/test commits and 12 documentation commits**. Classification: 25 wanted corrections; 19 deferred presentation changes; 12 documents; 8 supporting-test changes; 5 unconnected legacy changes; 1 appearance helper; 1 partly superseded keyboard change.

“Recovered” below means a bounded adaptation of the wanted behaviour, not whole-commit equivalence or AutoCAD acceptance.

| Original correction | Combined candidate `af0cd66a` | Structural preservation `60c41228` |
|---|---|---|
| `913419b7` Manager Escape | `41c77b38` → `c2bda325` | Not applicable to Structural |
| `f9359450` Sheets refused input | `890cf1b5` → `c2bda325`, layout hunk excluded | Banked with newer workspace |
| `254793f8` confirmed Settings save | `4db9388a` → `c2bda325` | `f6f98733` |
| `0842bc3e` actual Settings appearance + helper `e75a9ab1` | Same prerequisite recovery | `f6f98733` |
| `f169728b`, `f63bf58d` Issue Back choices | `5c21b827` → `c2bda325` | Banked; installed workflow has no Review/Back |
| `062a2ae8` Settings Escape | `9c9cf9d4` | `867b1e1b` |
| `272aed13` revalidate ticked revisions | `91814c89` | Installed direct Publish adaptation `60c41228` |
| `9008c445` real sheet/PDF display rows | `f2afa26b` | Banked |
| `c2e40c84`, `e5d90ec8` Notes selection/refresh | `1d93eb2d` | `c1ae6c0c` |
| `053dbbcf` Properties Escape | `1a057b66` | `c1ae6c0c` |
| `8f37170c` Issue keyboard | Escape only `1a057b66`; broad Enter excluded | Existing Publish Escape `60c41228` |
| `c5ace855` Settings load warning | `b935806b` | `867b1e1b` |
| `87be3ab8` scoped check summary | `0bc3c706` | `60c41228` |
| `cab25f16` Manager unavailable explanation | `38209fb9` | Not applicable to Structural |
| `1691de5c` Setup template availability | `d50f63d5` | `c1ae6c0c` |
| `6c0c3755` Issue blockers/Show problems | `c28f1992` | Banked |

Combined source therefore represents bounded recovery of **17/25 wanted corrections**, plus helper and partial Escape = **19 original IDs with recovered changes**. Another wanted correction, `1e12ba0b` explicit Issue/no global Enter, already holds on the combined base. Seven wanted corrections remain:

1. `37772040` Reissue focus/navigation.
2. `7ec6d7f6` selected full drawing/layout display.
3. `b80641e5` clean/no-selection findings feedback.
4. `21fc151f` read-only Before/After review window.
5. `9b889a4f` distinguish same-named drawings in its picker.
6. `9a2f2942` Sheets/Issue appearance.
7. `570331a9` Notes appearance.

The new Before/After window replaces an existing read-only message review; it is not a missing writer. Its Apply remains excluded. Anonymous-row test evidence from `7ec6d7f6` was superseded by real-record tests in `9008c445`; the selected-path feature remains unrecovered. Four legacy `SettingsDialog` fixes do not affect actual `CESETTINGS` → `CeSettingsDialog`; the legacy sync-preview change has no discovered caller. The full per-ID register follows in the appendix.

### PIT: measured failure remains open

- Installed taller preview came from `63bc7207`; previous measurements failed no-scroll at requested 600, actual old minimum 620 and default 780.
- Tim subsequently approved input pages. Uncommitted work changes `PitDialog.xaml` to minimum height 600 with four input tabs and keeps preview/status/footer; tests were strengthened to check populated status and footer boundaries.
- Latest `pit-pages-populated2.trx`: **11 executed, 10 passed, 1 failed**. Detention at 900 × 600: status bottom **500.45**, available body bottom approximately **495.04** in WPF layout units [screen layout measurements]; overflow about **5.41**. This is not a no-scroll pass.
- Earlier 11/11 used weaker checks and is superseded. New layout has not completed all-lane verification or AutoCAD acceptance.
- Preserve the dirty files: `Modules/Drainage/Dialogs/PitDialog.xaml`, `Modules/Drainage.Tests/Dialogs/C2PitCreationTests.cs`, `Modules/Drainage.Tests/Dialogs/PitDialogSinglePageUiContractTests.cs`.
- Remaining integration guard: removing `PitSinglePageFlow` also affects the held workshop `WorkshopFieldFeedback.AttachFallback` lookup and old long-content expectations. Preserve their intended feedback when completing the layout; do not call the prototype fully connected yet.

### Structural commands and shared files

Direct comparison **`5d723d41` → `af0cd66a`** omits `SbeamCommandRunner.cs`, `SbeamEditCommandRunner.cs` and `ArchitecturalChangeReviewCommands.cs`, and changes other Structural command source. Installed `5d723d41` is not its ancestor. **Do not install this as the Structural replacement.**

By contrast, source comparison **`5d723d41` → `60c41228`** over `Modules/Structural/Commands` and `Shared/CE_SHARED` is identical. The narrow preservation candidate retains those commands and uses installed direct Publish behaviour. This is preservation evidence, not a promise SBEAM can never fail.

Installed Modern shared-library hashes:

| Bundle | CE_SHARED.dll SHA256 |
|---|---|
| Manager | `75A26D3DC2A000EF97DC34CDD132DCB251394636BB3D5930A3A7F8141E56DE20` |
| Civil | `C4D7E1AFB6D9CE2F7AB8B2393DAB58B2D98F7AF46CAF5DD165048F3A1575268A` |

Different hashes establish different files, **not proven incompatibility**. No Structural shared DLL was found at the expected Modern location; that is not proof of absence elsewhere. Claude must establish the intended module/shared/native combination before installation.

The “Release Control Room recovery hold” was withdrawn in [#78](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/78#issuecomment-5674795322). It is a coordination task, not an installed lock or extra approval authority. #78 remains the deploy register. Multiple candidates can be saved, but no isolated simultaneous test route has been qualified; a second profile alone is not established isolation. Sequential identified installations remain the recorded method.

**One scope decision for Tim:** should the new shared **Project/Sheets workspace** be included in the next window test build, or kept for a later release while the approved smaller window fixes are tested first? **Recommendation: keep it for later.** This does not re-ask permission for the already-approved Structural preservation branch and does not block independent PIT/save work.

## 5. One AutoCAD checklist — for the eventual identified test build

**Preparation belongs to the owners, not Tim:** finish automated checks, identify exact installed Civil/Manager/Structural/native files, and supply one disposable drawing with a 375 pipe, 450 pit, twin pipe, source landing cases and known protected items. Supply an isolated refused-write fixture; do not make Tim's live catalogue read-only or deliberately damage production data. Exclude any still-held feature from a claimed ready-to-test payload.

The rows below consolidate the outstanding acceptance; they are **not a request to test uninstalled candidates now**. “Both” means AutoCAD 2027 and a separate AutoCAD 2024/net48 run. Retain existing accepted results; repeat representative guards when the final changed build warrants it.

| # | Action | Expected result | Lane |
|---|---|---|---|
| 1 | Open PIT at its default size, then its minimum height; visit every input page with detention and ordinary pit values | PIT/SECTION previews, current status and Update/Cancel remain fully visible; no scroll needed; values survive page changes | Both |
| 2 | Change Pit Type through all five, then X width; switch dark/light; close/reopen five times | 2027 actual-block picture changes appropriately, fits, follows appearance, no crash. Missing-block fixture says “No preview for this pit” | 2027; original rendering acceptance already recorded |
| 3 | Open the same pit in 2024 | Old schematic/text remains usable; no 2027 renderer error | 2024, still untested |
| 4 | CDEDIT the 375 pipe; change diameter and an invert, change page, use Move arrow/Inspect, then return | Same pending values/page and original comparison remain. Cancelling the drawing action does not silently apply engineering changes | Both |
| 5 | In the supplied refused-write case, press Pipe Update, then label-only Update, then Pit Update; correct the stated problem and retry | No false success; pending values retained; retry changes the original item once. Cancel then abandons only unsaved changes | Both |
| 6 | PITEDIT 450 to 1200; Update; Undo once | Pit, its circle/cover text and associated accepted record changes update together; label keeps its intended clearance. One Undo restores the accepted edit | Both |
| 7 | While an edit is pending, switch drawings; also close the originating drawing in the separate fixture | No write reaches the other drawing. Clear explanation; no stale success or invented replacement target | Both |
| 8 | Select a same-type batch and change only one enabled field; cancel a second attempt | Only selected enabled values change; one Undo restores the accepted batch; Cancel changes nothing | Both |
| 9 | Select an ordinary object, a locked Civil object and supplied Xref/REFEDIT content through the same edit routes | Normal AutoCAD protection remains; no unlock, replacement copy or silent bypass | Both |
| 10 | Move a Civil label/arrow with its supported action, cancel once, accept once, Undo; save/reopen | Correct owned item moves; ordinary grips keep their preview; Cancel/Undo and saved placement are correct | Both, using each lane's supported route |
| 11 | CDSOURCE/CDFW: place at free point, free pipe end and pipe run in the duplicate-tag fixture; cancel one placement | Valid placement works, existing names are reported truthfully, Cancel leaves no partial source/split. One accepted drawing operation is one Undo | Both, after owner fixes land |
| 12 | 2027: convert one ordinary and one twin pipe, place a floor waste on each, move one half aside, Undo, save/reopen | Correct two halves and labels, no unchanged stray pipe underneath, twins stay twins, identities survive. Do not run on current live's known-bad converted split | 2027; 2024 repeats ordinary supported split only |
| 13 | CDPROFILE: select a route with a branch, review the chosen route, preview/apply once; alter source evidence before a second Apply | Uses the selected route; real output matches review; stale second Apply cannot silently reuse old approval. One Undo restores accepted output | Both, after owner qualification |
| 14 | Open drawing checks/import comparison/repair preview, then close without Apply | Drawing and accepted values remain unchanged; missing levels stay Unknown. For the supplied supported repair, preview exact changes, Apply once, Undo once | Both, only qualified actions |
| 15 | Open the supplied slab, inspect a calculated level, then use a qualified boundary/joint edit; Cancel and Undo | Calculated level does not silently become a fixed control; exact owned slab items update together. Held whole-slab MOVE is not implied by this test | Both, only qualified actions |
| 16 | Review one approved proposal and its evidence; Cancel, then review/apply afresh; open/close Ask CE | Cancel writes nothing; fresh accepted proposal matches the preview and one Undo; Ask CE opening/closing does not alter the drawing | Both, after C5/C6 qualification |
| 17 | CESETTINGS: preview appearance then Cancel/Escape; change one value and Save/reopen; use supplied failed-save fixture | Cancel restores appearance; successful value persists; failed save retains entries and explains the failure. Do not describe whole-settings Reset as page-only | Both, preservation candidate |
| 18 | Notes: change selection, clear it, Refresh after a supported external note edit; simulate unavailable store using owner fixture | Details follow selection and updated contents; read failure is distinguishable from genuinely empty notes after the missing result fix | Both |
| 19 | Properties Escape; Setup with no available template; installed direct Publish with invalid revision, then Cancel | Cancel writes/publishes nothing; unavailable template is explained; invalid revision cannot masquerade as successful preparation | Both, preservation candidate |
| 20 | If the new shared Project/Sheets workspace is included: invalid cell then Move/Revision/Issue; Review→Back with changed choices; Manager dropdown Escape | Refused cell keeps values/selection; choices survive Back; Escape closes/cancels the active input before the host; no unintended publication | Both; conditional on scope decision |
| 21 | Draw SBEAM using the existing centre-anchor route; cancel a second placement; edit the first beam and Undo | Installed Structural placement/edit commands remain available; no lost accepted placement, correct Cancel/Undo | Both where supported, owner-supplied fixture |

CDPARTS Save/Reset already has recorded acceptance; retain that result. If its code/storage integration changes again, include one isolated Save/reopen and Reset→Cancel regression in this same batch. Do not add another historical per-commit checklist.

## 6. Next work, in order

1. **Claude confirms the Pipe/Pit result contract around the existing writers**; Codex then connects retained draft/comparison/tab/focus to completed/refused/target-gone outcomes. Dependency: exact originating drawing/object and one-Undo write boundary, not a new service.
2. **Codex finishes the approved PIT input pages**, starting with the remaining measured detention overflow and fallback-feedback preservation. Dependency: existing approved input-page decision, already granted. Run counted focused checks and required lanes; no deployment.
3. **Qualify the saved Structural preservation fixes against the installed command base.** Dependency: owner source/service review and matching shared files; preserve SBEAM. Keep broader Project/Sheets saved until Tim's scope choice and the owner's integration are resolved.
4. **Continue C3/C4/C5/C6 in bounded windows**, reusing existing operations identified here. Prioritise source/LPD/roof destination/tank records with Claude before guided design; council/TWL policy must come from Settings/rules, not window constants. C5 remains before complete C6 acceptance.
5. **Claude combines the qualified source and matching C7 native files**, verifies the actual package, updates #78, and deploys only after Tim's fresh closed-AutoCAD instruction and coordination with other testing tasks.
6. **Tim runs the applicable rows of the single checklist**, including 2024. Record failures against exact installed identities. Then complete independent release checks, colleague pilot, help/rollback/known limitations. No whole-program completion before those gates.

### Evidence scope and remaining record gaps

Read: CE_PLAN START_HERE, master framework, consolidated record; all 21 council-rule files and complete EV-03/decisions log through the bounded read-only audit; issues #24/#78/#26/#27/#28/#29/#30/#31/#32/#74 including comments; D1–D32 decision queue; targeted source and saved recovery/workflow records. Main-repository regression history was scanned across the file and its September entries read, then relevant delivery entries were read at pinned live `10ac480d`. **The entire historical regression log was not read verbatim**; this is an explicit limit against the requested full reading, not a claim that every historical entry was reconciled.

The main checkout is an older, dirty `codex/CIVIL3RESEARCH` at `d017d506`: its 7,926-line log has September planning entries in lines 1–470, then jumps to July. The pinned live log has 13,672 lines with the actual later delivery records. A convenient main checkout is not the live source. Relevant pinned-log locators: C0 DBText 13583–13589; C2 editor integration 1196–1202; C3 same-plan integration 13557–13570; C4 profile 896–912; C5 held MOVE 13615–13619; C6 proposals 13086–13103 and QA7 13214–13219 / 13331–13367; supplied window contracts 13648–13664; #75 13666–13672. These are earlier recorded test results, not new runs.

A historical September 14 unexpected bundle replacement is also recorded. Tests during that interval cannot automatically be assigned to the intended build. Fresh disk identities at the top of this report are separate from that incident. The pinned log's CDPARTS manual-checklist-pending text is superseded by the later #78 Tim-acceptance comment.

Council integration explicitly says its new scope is not built. Council write-up phrases such as “settles” are not Tim decisions: `OPEN_QUESTIONS.md` retains coefficient, rounding, editions and other questions. Guidebook v1.3 supersedes older v1 where recorded. Existing `DetentionFreeboardMm` is not proof that every council from/to clearance is represented. Latest Tim TWL/trench-grate rulings outrank older absolute descriptions.

EV-03 separates observed drafting patterns from engineering authority. The later approved 300-job programme is not 300 completed whole-project reviews and does not authorise silent standards promotion. No client files, raw drawing evidence or addresses were copied into this report.

Gaps retained: no complete native acceptance record for all final C0–C7 changes; no verified simultaneously isolated deployment route; no full patch-equivalence proof for every historical non-ancestor branch; no full re-render of D1–D32 visuals; no new reading of every externally referenced source PDF/older visual contract/#25 ruling beyond the records explicitly cited. These gaps prevent a blanket “all built, connected and accepted” claim, not continued bounded work.

### Installed Civil file receipts

| Lane | SHA256 |
|---|---|
| Modern | `EC84FFCA9557E9FD2E97337D189EF654CCE53D56A371D4A525402474EE691931` |
| Net8 | `BC8D99AE654F0E342A17C8C26312E691A7295FC0FB1D797C7C81ABEA1F3FBAD0` |
| Legacy | `7B44D6BF0E51C2FD7363A40ADCECFFCB3034D446867B716CF0F7FF7B76C00F80` |

Measured under `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\<lane>`. These are receipts, not permission to replace any installed files.

## Appendix — all 71 original non-Civil dispositions

The following register is carried forward from the read-only per-commit audit. Section 4 supplies the later recovery mapping; “wanted” in this historical classification means preserve for bounded review, not approved for blind merging or accepted by Tim.
| Original commit | Historical classification | Visible feature / record |
|---|---|---|
| 236b767b | DOC ONLY | Record verified water tank editor connection requirements |
| eeedb248 | DEFER presentation/layout from connection-only candidate | Use drawing-task language in Manager Help |
| cab25f16 | WANTED correction | Explain Manager settings save and unavailable actions |
| c50055e7 | RETAIN supporting tests; not independent acceptance | Add compiled settings interaction check with explicit host requirement |
| 6cd4d854 | DOC ONLY | Record unsuccessful native host preload and preserve test limits |
| 3c6ea5af | DEFER presentation/layout from connection-only candidate | Give Project Sheets folder its own full-width row |
| 7f9baa34 | DEFER presentation/layout from connection-only candidate | Group Project Sheets details into five task tabs |
| 957e5a11 | RETAIN supporting tests; not independent acceptance | Verify Project Sheets tab layout and retained input |
| 37772040 | WANTED correction | Open prepared issue details after successful reissue selection |
| 8f37170c | PARTLY SUPERSEDED | Connect issue dialog Escape and Enter actions |
| 6c0c3755 | WANTED correction | Keep issue blockers visible beside review actions |
| f169728b | WANTED correction | Retain issue choices when returning from review |
| f63bf58d | WANTED correction | Retain issue review choices in standalone Sheets host |
| 272aed13 | WANTED correction | Recheck all issue choices before opening review |
| d3cfae3a | DOC ONLY | Record combined production UI build receipts |
| 1393f5c2 | DEFER presentation/layout from connection-only candidate | Keep long issue review findings readable |
| 0f53ca99 | DEFER presentation/layout from connection-only candidate | Use readable CE header colours and render issue review evidence |
| c2d3de57 | DEFER presentation/layout from connection-only candidate | Apply readable CE heading colours across Structural windows |
| 10845de9 | RETAIN supporting tests; not independent acceptance | Verify issue review in both CE appearances |
| 08703ffa | DEFER presentation/layout from connection-only candidate | Group Drawing Properties into clear connected pages |
| 74d81b3f | DEFER presentation/layout from connection-only candidate | Guide project setup through template project and sheet pages |
| 1691de5c | WANTED correction | Explain unavailable project templates before creation |
| 8a690d7b | UNCONNECTED legacy route | Group Structural settings into four clear preference pages |
| 23eaaf23 | UNCONNECTED legacy route | Restore Structural appearance preview when settings are cancelled |
| e75a9ab1 | RETAIN helper prerequisite | Verify settings appearance preview restore lifecycle |
| 40f60b54 | UNCONNECTED legacy route | Explain partial Settings save failures without discarding entries |
| 271c2b1b | UNCONNECTED legacy route | Reveal Timer page when Settings idle-time validation fails |
| 053dbbcf | WANTED correction | Connect Drawing Properties Escape to existing Cancel action |
| 1e12ba0b | WANTED correction | Require explicit Issue action instead of window-wide Enter |
| 7ec6d7f6 | WANTED correction | Expose full selected drawing and layout in Issue review |
| 9a2f2942 | WANTED correction | Apply selected CE appearance when opening Sheets and Issue |
| 049f03c0 | RETAIN supporting tests; not independent acceptance | Record host-required compiled Issue appearance verification |
| 9008c445 | WANTED correction | Bind Issue review sheets and PDF packs through readable display rows |
| 87be3ab8 | WANTED correction | Keep Sheets validation summary within its checked scope |
| 0e922c2a | DEFER presentation/layout from connection-only candidate | Show Sheets validation findings on a selected-sheet tab |
| e960e7db | RETAIN supporting tests; not independent acceptance | Verify selected-sheet findings with production display records |
| b80641e5 | WANTED correction | Explain clean-sheet and no-selection states in findings |
| 6fc524d9 | UNCONNECTED legacy route | Keep missing or blocked drawing previews from confirming updates |
| 21fc151f | WANTED correction | Connect drawing-update plan to a read-only Before After review window |
| 19bc3d3a | DEFER presentation/layout from connection-only candidate | Make reviewed drawing comparisons readable and verify rendered layout |
| a62e7b1c | DOC ONLY | Record Structural and Manager cross-target UI build receipts |
| 9b889a4f | WANTED correction | Disambiguate drawing filenames in the update review picker |
| 0c4353af | DEFER presentation/layout from connection-only candidate | Use familiar project and drawing-register wording |
| 2b368f18 | DOC ONLY | Record exact drawing-navigation connection needed by update review |
| 678dd53a | DOC ONLY | Map unified catalogue UI work to missing ownership and save contracts |
| 570331a9 | WANTED correction | Apply selected appearance when opening Shared Notes |
| c2e40c84 | WANTED correction | Keep Shared Notes details aligned with current job selection |
| e5d90ec8 | WANTED correction | Request fresh shared notes on explicit workspace refresh |
| 15572444 | DOC ONLY | Consolidate candidate UI checks and correct legacy Settings route status |
| 0842bc3e | WANTED correction | Restore appearance preview on closing the actual CESETTINGS dialog |
| d619f9ea | DEFER presentation/layout from connection-only candidate | Label and arrange General values in the actual CESETTINGS window |
| e5e35e05 | RETAIN supporting tests; not independent acceptance | Verify General Settings inside the complete minimum-size layout |
| 062a2ae8 | WANTED correction | Connect actual Settings Escape to Cancel |
| 97659024 | DEFER presentation/layout from connection-only candidate | Label Rebar Annotation and Xref settings fields |
| b9a22eea | DOC ONLY | Record Settings page compilation and consolidated acceptance |
| 5320d8bd | RETAIN supporting tests; not independent acceptance | Verify labelled drafting settings fit in both appearances |
| df276c86 | DEFER presentation/layout from connection-only candidate | Label joint and rafter settings while preserving controls |
| 30600308 | DEFER presentation/layout from connection-only candidate | Group System settings into labelled task pages |
| 862cef45 | DEFER presentation/layout from connection-only candidate | Organize data automation settings into labelled task pages |
| a17cab9a | RETAIN supporting tests; not independent acceptance | Check every revised Settings page inside the full window |
| 0de7d2da | DEFER presentation/layout from connection-only candidate | Group Beam settings into visible task pages |
| f346a52d | DEFER presentation/layout from connection-only candidate | Fix Settings clipping and tab contrast found by rendered review |
| db869876 | DEFER presentation/layout from connection-only candidate | Align Settings navigation with the V3 left page list |
| 6dda7cb7 | DOC ONLY | Record confirmed Settings save and scoped reset integration gaps |
| c5ace855 | WANTED correction | Surface Settings load reset warning before UI connection handoff |
| 26fccc1c | DOC ONLY | Record Claude ownership of Water Tank command |
| f9359450 | WANTED correction | Connect sheet actions to cell validation refusal |
| 7dd3392a | DOC ONLY | Record verified C7 and UI source integration boundaries |
| 913419b7 | WANTED correction | Share Manager input Escape handling before workspace close |
| 254793f8 | WANTED correction | Keep Structural settings open until save is confirmed |
| a5382bff | DOC ONLY | Consolidate unresolved UI connection handoff requirements |
