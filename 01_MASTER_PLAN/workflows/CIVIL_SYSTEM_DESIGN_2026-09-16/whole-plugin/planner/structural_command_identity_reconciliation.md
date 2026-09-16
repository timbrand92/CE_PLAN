# Structural command identity reconciliation

**Bounded source reconciliation.** This compares resolved `CommandMethod` names from `Modules\Structural\Commands` with the Structural command registry. It does not prove compiled registration, ribbon exposure, runtime ownership or AutoCAD support. No route below is retired by a mismatch.

| Measure | Observed count | Meaning |
|---|---:|---|
| Source attributes | 301 | Declaration count, including aliases. |
| Unique resolved source names | 301 | Literal and same-file-constant names only. |
| Registry entries | 251 | Configured primary entries. |
| Registry primary + aliases | 272 | Configured identity names, not unique runtime commands. |
| Source names with no registry identity | 37 | Need a descriptor/alias/owner decision before UI/retirement change. |
| Registry entries with no matched source identity | 7 | Need command-truth reconciliation; they may be external, older, generated or stale. |

Source and configuration evidence are linked in [structural_source_command_window_ledger.md](structural_source_command_window_ledger.md) and [structural_configured_field_action_manifest.md](structural_configured_field_action_manifest.md).

## Source declarations without registry identity

| Command | Source evidence | Linked workflow | Required disposition |
|---|---|---|---|
| ?CE | Modules/Structural/Commands/AdminCommands.cs:16 | W0 | Keep for command-truth review; no automatic hide/retire. |
| BPC | Modules/Structural/Commands/CeTextCommands.cs:70 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| BPFC | Modules/Structural/Commands/CeTextCommands.cs:67 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| BSFC | Modules/Structural/Commands/CeTextCommands.cs:77 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| BTHC | Modules/Structural/Commands/CeTextCommands.cs:60 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| CE_FFL | Modules/Structural/Commands/LevelMarkCommands.cs:64 | W7 | Keep for command-truth review; no automatic hide/retire. |
| CE_INSPECT | Modules/Structural/Commands/InspectCommands.cs:17 | W11 | Keep for command-truth review; no automatic hide/retire. |
| CE_NGL | Modules/Structural/Commands/LevelMarkCommands.cs:76 | W7 | Keep for command-truth review; no automatic hide/retire. |
| CE_RL | Modules/Structural/Commands/LevelMarkCommands.cs:68 | W7 | Keep for command-truth review; no automatic hide/retire. |
| CE_SSL | Modules/Structural/Commands/LevelMarkCommands.cs:72 | W7 | Keep for command-truth review; no automatic hide/retire. |
| CE_STRUC_SUITE | Modules/Structural/Commands/UiCommands.cs:24 | W0/W1 | Keep for command-truth review; no automatic hide/retire. |
| CEMARKUPDWGEXPORT | Modules/Structural/Commands/MarkupAICommands.cs:418 | W9 | Keep for command-truth review; no automatic hide/retire. |
| CEPROJECTPROPS | Modules/Structural/Commands/UtilityCommands.cs:21 | W11 | Keep for command-truth review; no automatic hide/retire. |
| CEPROPS | Modules/Structural/Commands/UtilityCommands.cs:20 | W11 | Keep for command-truth review; no automatic hide/retire. |
| CESETTINGS | Modules/Structural/Commands/CeSettingsCommands.cs:8 | W0 | Keep for command-truth review; no automatic hide/retire. |
| CESHEETS | Modules/Structural/Commands/SheetsCommands.cs:15 | W10 | Keep for command-truth review; no automatic hide/retire. |
| CESHEETSCLASSIC | Modules/Structural/Commands/SheetsCommands.cs:39 | W10 | Keep for command-truth review; no automatic hide/retire. |
| CESHEETSMANAGER | Modules/Structural/Commands/SheetsCommands.cs:16 | W10 | Keep for command-truth review; no automatic hide/retire. |
| CML | Modules/Structural/Commands/CeTextCommands.cs:85 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| EXCELCAPTUREAREA | Modules/Structural/Commands/ExcelMTextCommands.cs:75 | W8 | Keep for command-truth review; no automatic hide/retire. |
| EXCELCAPTURESELECTION | Modules/Structural/Commands/ExcelMTextCommands.cs:45 | W8 | Keep for command-truth review; no automatic hide/retire. |
| JOBTIMERDEBUG | Modules/Structural/Commands/JobTimerDebugCommand.cs:22 | W0 | Keep for command-truth review; no automatic hide/retire. |
| JOBTIMEREDIT | Modules/Structural/Commands/JobTimerEditCommand.cs:17 | W0 | Keep for command-truth review; no automatic hide/retire. |
| LBW | Modules/Structural/Commands/LoadBearingWallCommands.cs:33 | W2 | Keep for command-truth review; no automatic hide/retire. |
| ML | Modules/Structural/Commands/SchedulingCommands.cs:93 | W8 | Keep for command-truth review; no automatic hide/retire. |
| NGL | Modules/Structural/Commands/LevelMarkCommands.cs:77 | W7 | Keep for command-truth review; no automatic hide/retire. |
| P1 | Modules/Structural/Commands/RafterJoistCommands.cs:66 | W3 | Keep for command-truth review; no automatic hide/retire. |
| PFC | Modules/Structural/Commands/CeTextCommands.cs:63 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| R2LTXT | Modules/Structural/Commands/CeTextCommands.cs:89 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| RL | Modules/Structural/Commands/LevelMarkCommands.cs:69 | W7 | Keep for command-truth review; no automatic hide/retire. |
| SCREWPILE | Modules/Structural/Commands/CeTextCommands.cs:94 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| SF | Modules/Structural/Commands/CeTextCommands.cs:78 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| SFC | Modules/Structural/Commands/CeTextCommands.cs:74 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| SSL | Modules/Structural/Commands/LevelMarkCommands.cs:73 | W7 | Keep for command-truth review; no automatic hide/retire. |
| STUMPFOOTING | Modules/Structural/Commands/CeTextCommands.cs:95 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| THC | Modules/Structural/Commands/CeTextCommands.cs:56 | W3/W5/W7 | Keep for command-truth review; no automatic hide/retire. |
| WALLSTRS | Modules/Structural/Commands/ReinforcementDetailCommands.cs:16 | W6 | Keep for command-truth review; no automatic hide/retire. |

## Registry entries without a matched Structural command declaration

| Registry command | Label / group | Declared aliases | Visibility / replacement | Required disposition |
|---|---|---|---|---|
| BMT2TXT | BMT 2 TXT — Structural/Beam |  | Visible | Reconcile with command-truth owner; do not assume missing/retired. |
| BTXT2MT | BTXT 2 MT — Structural/Beam |  | Visible | Reconcile with command-truth owner; do not assume missing/retired. |
| COPYROT | COPYROT — Utilities/Legacy |  | Visible | Reconcile with command-truth owner; do not assume missing/retired. |
| CR | CR — Utilities/Legacy |  | Visible | Reconcile with command-truth owner; do not assume missing/retired. |
| MOVEROT | MOVEROT — Utilities/Legacy |  | Visible | Reconcile with command-truth owner; do not assume missing/retired. |
| MR | MR — Utilities/Legacy |  | Visible | Reconcile with command-truth owner; do not assume missing/retired. |
| XCLMTXTINDEX | XCLMTXT Index Refresh — Schedules/Import |  | Visible; Expert | Reconcile with command-truth owner; do not assume missing/retired. |

## Decisions preserved while reconciling

1. A registry/source mismatch does not delete a working command, command-palette item, ribbon item or legacy alias.
2. A hidden/deprecated flag is configuration evidence, not proof that a replacement has passed AutoCAD acceptance.
3. If a route belongs to the shared Manager, project, sheets/issue, AI or native owner, this Structural planner records the interface only and asks that owner to settle command identity.
4. Every later identity resolution retains selection/prompt/output, protections, Cancel/Escape/Undo/save-reopen and manual override/revision behaviour from its linked W card.

**Built/Tested/Installed/Tim-accepted:** not assessed.
