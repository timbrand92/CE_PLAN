# Structural registry-gap dispositions

**Scope.** This is a source-backed disposition for the 37 Structural declaration-only and eight Structural-registry-only identities reported in [structural_command_identity_reconciliation.md](structural_command_identity_reconciliation.md). It does not claim the commands load, appear in a running ribbon, work in AutoCAD or have been accepted. “Direct command route” means only that a `[CommandMethod]` declaration was observed. It is not runtime proof.

## Authority and discovery boundary

- The central `Assets/Config/ce-tool-register.json` is intentionally incomplete: `migrationComplete` is `false` (line 4), and currently names ten qualified tools only. It is not a decision to retire anything unlisted.
- Approved `CT-01` resolves the register’s intended completeness. The three module registries are migration inputs (`CT1`); source discovery reports commands but cannot create a user-facing tool (`CT6`); off-register working commands migrate **Hidden + Review Pending** while legacy access remains (`CT8`); ribbon, Help, search and AI move to the central register incrementally (`CT11`, `CT15`). Therefore this record makes no new Tim question out of the central-register purpose.
- A Structural registry row is source evidence for the existing registry-driven Structural ribbon/palette/help path (`CeStrucRibbonContributor.cs:70-246`; `CommandPalette` registry description). Off-registry declarations have no such registry route proven by this pass. Their retained direct command route and any code-built window/button are recorded below.
- Shared project, Settings, Sheets/Issue, Manager/Coordination and Transform implementation retain their named owners. A source location is not an ownership transfer.

## Declaration-only identities — 37

| Identity | Observed method / retained semantic route | Discovery and approved disposition |
|---|---|---|
| `?CE` | `AdminCommands.cs:16`; help command branch. | Keep callable during CT-01 migration. It is a direct Help route; a new central Help exposure waits for `CT7` qualification. |
| `BPC`, `BPFC`, `BSFC`, `BTHC` | `CeTextCommands.cs:70,67,77,60` dispatch to `CeTextService.Run`. | Preserve aliases and their existing text/tag intent under `ST-04`; no registry/ribbon/Help route is proven. `ST4-3` requires alias→preset mapping and `ST4-5–14` require preview, explicit parent relation, clean Escape and one Undo before promotion. |
| `CE_FFL`, `CE_RL`, `CE_SSL`, `CE_NGL` | `LevelMarkCommands.cs:64,68,72,76`; same command family as `FFL/RL/SSL/NGL`. | Retain legacy long names as direct aliases while `ST-03` migrates the level-mark family. `ST3-7/8` require a trusted source or Manual/Unknown, recognised marks only for update, preview and one Undo. |
| `CE_INSPECT` | `InspectCommands.cs:17`; selection export route. | Keep as controlled inspection/export route, with direct typing only proven here. It is an evidence/diagnostic boundary, not a project/issue editor; shared diagnostics ownership remains outside this card. |
| `CE_STRUC_SUITE` | `UiCommands.cs:24`; opens the legacy Structural suite surface. | Preserve as a transition doorway. `SH-01` owns shell consolidation, so it cannot be retired or reclassified here. |
| `CEMARKUPDWGEXPORT` | `MarkupAICommands.cs:418`; drawing-markup export. | Retain as a source-observed specialist route under `ST-09`, hidden/review-pending for any new discovery surface. `ST9-3–8` prohibit unapproved external transmission/execution and require exact target, preview and batch Undo. |
| `CEPROJECTPROPS`, `CEPROPS` | `UtilityCommands.cs:20–21`; same project-properties method. | Direct aliases to the existing project-properties dialog. Root owns shared project/sheets semantics; preserve entry until that owner’s reviewed transition. |
| `CESETTINGS` | `CeSettingsCommands.cs:8`; `CeSettingsUiService` opens settings. | Existing settings entry remains. Root owns settings authority; no proposal to treat drafting settings as engineering decisions. |
| `CESHEETS`, `CESHEETSMANAGER` | `SheetsCommands.cs:15–16`; same manager route. | Retain transition aliases to shared Sheets owner. The registry-driven Structural ribbon currently has a Sheets group mapping, but this is not runtime proof. |
| `CESHEETSCLASSIC` | `SheetsCommands.cs:39`; legacy sheets route. | Preserve as a legacy route until shared Sheets transition acceptance; no duplicate sheet workflow is proposed. |
| `CML` | `CeTextCommands.cs:85` dispatches `CeTextService.Run`. | Preserve as a direct legacy utility. `ST-05` owns the reviewed closed-Mline result; discovery/Help remains pending qualification. |
| `EXCELCAPTUREAREA`, `EXCELCAPTURESELECTION` | `ExcelMTextCommands.cs:75,45`; Excel/MText capture paths. | Keep controlled source-capture aliases under `ST-07`. The future route must show source/range/mapping/output before accept; no claim of file compatibility or rendered output. |
| `JOBTIMERDEBUG` | `JobTimerDebugCommand.cs:22`; diagnostic route. | Expert-review only. Keep out of normal discovery until `ST9-13–15` stable-identity, idle and append-only-record acceptance is in place. |
| `JOBTIMEREDIT` | `JobTimerEditCommand.cs:17`; time-entry editor. | Preserve a direct time-edit route while coordination owner migrates it. It must not quietly rewrite records: `ST9-13–14` govern. |
| `LBW` | `LoadBearingWallCommands.cs:33`; compile-time command constant. | Preserve direct wall-marking route under `ST-02` review. Architectural geometry cannot become a bearing decision without explicit confirmation. |
| `ML` | `SchedulingCommands.cs:93`; structural schedule/member-label route. | Retain under `ST-07`; schedule source, manual rows and refresh/sync are separately reviewed. No issue output is implied. |
| `NGL`, `RL`, `SSL` | `LevelMarkCommands.cs:77,69,73`; short legacy level aliases. | Same `ST-03` disposition as the `CE_*` long aliases: direct source route only; Manual/Unknown rather than a fabricated value. |
| `P1` | `RafterJoistCommands.cs:66`; rafter/joist placement family. | Retain under `ST-02` review. Connection/load meaning, source and drawing output need explicit workflow evidence. |
| `PFC`, `SFC`, `SF`, `THC` | `CeTextCommands.cs:63,74,78,56` dispatches text/foundation-family actions. | Preserve familiar aliases through `ST-04`/`ST-06` transition. `ST4-1` splits text from footing geometry; `ST6-5–9` require explicit host, full preview and compound identity. |
| `R2LTXT` | `CeTextCommands.cs:89`; selected TEXT conversion route. | Keep only as a controlled conversion candidate under `ST-04`. `ST4-11` requires recognised eligible text, count + preview, preserved content/position/ownership, one Undo. |
| `SCREWPILE`, `STUMPFOOTING` | `CeTextCommands.cs:94–95`; foundation placement entries. | Retain under `ST-06`; an Approved asset is required. `ST6-12` prohibits an approximate-circle fallback. |
| `WALLSTRS` | `ReinforcementDetailCommands.cs:16`; reinforcement detail declaration. | Retain identity under `ST-06`; source comments do not prove a working detail. It remains review-pending, not a claim of calculated reinforcement. |

## Registry-only identities — eight

| Identity | Source reconciliation | Discovery and approved disposition |
|---|---|---|
| `BMT2TXT`, `BTXT2MT` | Both have standalone Structural registry rows, and both are aliases of observed `BTX` (`BeamTextConvertCommands.cs:18`; registry `BTX.aliases`). There is no separate `[CommandMethod]` for either name in the observed source. | Exact duplication is source-resolved: retain one semantic Beam Text Convert route with both aliases during migration. `ST-01` owns the beam relation; do not expose two separate product tools. Qualification must prove alias resolution, selection, visual placement/suffix behaviour, Cancel/Undo and reopen. |
| `CEP` | Alias of observed `CEPALETTE` (`UiCommands.cs:92`; registry `CEPALETTE.aliases`). | Keep as the same Command Palette identity, not a missing command. Its registry description says it searches registry entries; central discovery remains staged under CT-01. |
| `COPYROT`, `CR`, `MOVEROT`, `MR` | Structural registry retains four legacy transform rows. Observed declarations for these names are in `Modules/Drainage/Commands/CopyRotateCommands.cs:38–47`; Transform source owner has already verified the normal AutoCAD command bridge. | `TF-01` already settles the factual destination: one Shared owner/registration/asset, familiar aliases retained, duplicate Civil/Structural registrations retire only after parity evidence and Tim feel check. Do not reopen a LISP implementation proposal or create another transform route here. Help is the quiet Shared Transform entry after qualification. |
| `XCLMTXTINDEX` | Registry-only expert row; no observed `[CommandMethod]`. The existing `XCLMTXT` path calls corpus-refresh services (`XclmTxtService.cs:337–355`; `XclmTxtCorpusIndexService.cs:26–353`) and dialog refresh controls (`XclmTxtDialog.xaml.cs:759–813`). | Treat as an unqualified ghost/duplicate, not a callable expert command. Retain its capability concept within `XCLMTXT`/`ST-07` review, including visible progress/cancel and privacy gating. A separate command needs CT-01 identity, owner, Help, permission and guard before exposure. |

## What remains unresolved

1. The central register’s destination and migration treatment are already approved by `CT-01`; the remaining task is per-route qualification/evidence, not a new product choice.
2. Direct command presence has been traced above, but current ribbon/palette visibility, Help rendering, execution, file side effects and AutoCAD acceptance are still Unknown.
3. Shared-owner transitions for project/settings/sheets/coordination and Transform implementation are intentionally not duplicated in this Structural planner.
