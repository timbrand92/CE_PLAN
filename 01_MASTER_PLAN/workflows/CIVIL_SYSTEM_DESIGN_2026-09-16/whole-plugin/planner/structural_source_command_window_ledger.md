# Structural source command and window coverage ledger

**Planning-only, source-backed inventory.** This ledger records declarations and configuration observed in the checked-out source on 16 September 2026. It does **not** prove that a command loads, appears on the ribbon, runs safely, survives save/reopen or has been accepted in AutoCAD.

## Scope and authority

- Read authority: `C:\CE_PLAN\START_HERE.md`, `V3_0_PLAN.md`, repo `docs\CODEX_HANDOFF.md`, `docs\STRUCTURAL_DELIVERY_PLAN_2026-09-14.md`, `docs\workflows\STRUCTURAL_DRAWING_JOURNEY_2026-09-14.md`, command registry and Structural source. Later Tim approvals in the Structural drawing journey control where older registry prose conflicts.
- Source roots: `Modules\Structural\Commands`, `Modules\Structural\Services`, `Modules\Structural\UI`, `Modules\Structural.DesignCore` and the Structural command registry. No client folder, drawing corpus, AutoCAD process, build or deployment was read/run.
- Root whole-plugin inventory independently records **301 Structural command attributes** and **47 Structural XAML surfaces**. The local extraction below produces **301 source rows** in **41 command files** and the registry contains **251 entries**. These are declaration/surface counts, not runtime or unique-command counts.
- Classification labels are planning triage only. They are not Tim approval to retain, modify, retire or implement a route.

## Job-sequence card map

| Card | Actual job moment / route group | Detailed follow-up |
|---|---|---|
| W0 | Start, settings, command hub, notes, help, administration and time | `structural_workflow_cards.md` W0 |
| W1 | Open/understand Structural workspace and job context | `structural_workflow_cards.md` W1 |
| W2 | Background, Xref/layer, wall and site context | `structural_workflow_cards.md` W2 |
| W3 | Frame: beams, rafters/joists, marks and local edits | `structural_workflow_cards.md` W3 |
| W4 | Supports, bracing and experimental comparison proposals | `structural_workflow_cards.md` W4 |
| W5 | Footings, slab and foundation text/detail route | `structural_workflow_cards.md` W5 |
| W6 | Sections, reinforcement, columns and steel details | `structural_workflow_cards.md` W6 |
| W7 | Annotation, dimensions, leaders, levels, breaklines and hatches | `structural_workflow_cards.md` W7 |
| W8 | Excel/MText and Structural schedules | `structural_workflow_cards.md` W8 |
| W9 | Markup/drawing-intelligence interface | Root-owned AI interface; coverage only here |
| W10 | Sheets, publish/issue interface | Root-owned sheets/issue interface; coverage only here |
| W11 | Inspect, recovery, diagnostics, export and migration | `structural_workflow_cards.md` W11 |
| W-legacy | Legacy-port declarations | `structural_workflow_cards.md` W-legacy |

## Every discovered command declaration

| Command declaration | Registry label/group when matched | Source evidence | Planning classification | Card |
|---|---|---|---|---|
| CE_HELP | Command Help — Administration/Help | Modules/Structural/Commands/AdminCommands.cs:14 | Keep/Modify proposal — source route | W0 |
| CEHELP | Command Help — Administration/Help | Modules/Structural/Commands/AdminCommands.cs:15 | Keep/Modify proposal — source route | W0 |
| ?CE | No exact registry match observed | Modules/Structural/Commands/AdminCommands.cs:16 | Unknown — no exact registry descriptor | W0 |
| CE_VERSION | Version Information — Administration/Help | Modules/Structural/Commands/AdminCommands.cs:22 | Keep/Modify proposal — source route | W0 |
| CEADMIN | Admin Hub — Administration/Diagnostics | Modules/Structural/Commands/AdminCommands.cs:32 | Keep / expert-review route | W0 |
| CEAUTOSUPPORT | Auto-Support (Preview) — Structural/Supports | Modules/Structural/Commands/AutoSupportCommands.cs:32 | Keep / expert-review route | W4 |
| CEAUTOSUPPORTCLEAR | Auto-Support Clear — Structural/Supports | Modules/Structural/Commands/AutoSupportCommands.cs:82 | Keep / expert-review route | W4 |
| CEAUTOSUPPORTREF | Auto-Support Reference (Snapshot) — Structural/Supports | Modules/Structural/Commands/AutoSupportReferenceCommands.cs:26 | Keep / expert-review route | W4 |
| CEAUTOSUPPORTREFCLEAR | Auto-Support Reference Clear — Structural/Supports | Modules/Structural/Commands/AutoSupportReferenceCommands.cs:53 | Keep / expert-review route | W4 |
| BATTER | Batter Lines — Structural/Site | Modules/Structural/Commands/BatterCommands.cs:20 | Keep/Modify proposal — source route | W2 |
| BATLINE | Batter Lines — Structural/Site | Modules/Structural/Commands/BatterCommands.cs:26 | Keep/Modify proposal — source route | W2 |
| BEXTEND | BEXTEND — Structural/Beam | Modules/Structural/Commands/BeamExtendCommands.cs:19 | Keep/Modify proposal — source route | W3 |
| BEXT | Beam Extend — Structural/Beam | Modules/Structural/Commands/BeamExtendCommands.cs:124 | Keep/Modify proposal — source route | W3 |
| BSET | Beam Set Inside Point — Structural/Beam | Modules/Structural/Commands/BeamInsidePointCommands.cs:19 | Keep/Modify proposal — source route | W3 |
| BSETRESET | Beam Reset Inside Points — Structural/Beam | Modules/Structural/Commands/BeamInsidePointCommands.cs:57 | Keep/Modify proposal — source route | W3 |
| BSETLIST | Beam List Inside Points — Structural/Beam | Modules/Structural/Commands/BeamInsidePointCommands.cs:80 | Keep/Modify proposal — source route | W3 |
| BEAMLINKDEBUG | Beam Link Debug — Administration/Diagnostics | Modules/Structural/Commands/BeamLinkDebugCommand.cs:21 | Keep / expert-review route | W11 |
| BEAMLINKMIGRATE | Beam Link Migrate — Administration/Diagnostics | Modules/Structural/Commands/BeamLinkMigrateCommand.cs:26 | Keep / expert-review route | W11 |
| 1 | Beam Regular — Structural/Beam | Modules/Structural/Commands/BeamPlacementCommands.cs:44 | Keep/Modify proposal — source route | W3 |
| 2 | Beam Lower — Structural/Beam | Modules/Structural/Commands/BeamPlacementCommands.cs:50 | Keep/Modify proposal — source route | W3 |
| 4 | Beam Special — Structural/Beam | Modules/Structural/Commands/BeamPlacementCommands.cs:56 | Keep/Modify proposal — source route | W3 |
| 5 | Beam Offset — Structural/Beam | Modules/Structural/Commands/BeamPlacementCommands.cs:62 | Keep/Modify proposal — source route | W3 |
| BDL | Beam Dual Layer — Structural/Beam | Modules/Structural/Commands/BeamPlacementCommands.cs:68 | Keep/Modify proposal — source route | W3 |
| 8 | Beam Settings — Structural/Beam | Modules/Structural/Commands/BeamSettingsCommand.cs:22 | Keep / expert-review route | W3 |
| BTX | Beam Text Convert — Structural/Beam | Modules/Structural/Commands/BeamTextConvertCommands.cs:18 | Keep/Modify proposal — source route | W3 |
| AB | A-Bracing — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:13 | Keep/Modify proposal — source route | W4 |
| STRUCAB | STRUCAB — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:115 | Keep/Modify proposal — source route | W4 |
| BB | B-Bracing — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:121 | Keep/Modify proposal — source route | W4 |
| STRUCBB | STRUCBB — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:217 | Keep/Modify proposal — source route | W4 |
| BT1 | Bracing Truss — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:223 | Keep/Modify proposal — source route | W4 |
| ABS | Switch A/B Bracing — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:337 | Keep/Modify proposal — source route | W4 |
| STRUCABS | STRUCABS — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:343 | Keep/Modify proposal — source route | W4 |
| ABSWITCH | ABSWITCH — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:349 | Keep/Modify proposal — source route | W4 |
| ABFLIPAUTO | ABFLIPAUTO — Structural/Bracing | Modules/Structural/Commands/BracingCommands.cs:487 | Keep/Modify proposal — source route | W4 |
| BL | Breakline — Annotation/Linework | Modules/Structural/Commands/BreaklineCommands.cs:17 | Keep/Modify proposal — source route | W7 |
| CESETTINGS | No exact registry match observed | Modules/Structural/Commands/CeSettingsCommands.cs:8 | Unknown — no exact registry descriptor | W0 |
| EBT | EBT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:8 | Keep/Modify proposal — source route | W3/W5/W7 |
| EBB | EBB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:9 | Keep/Modify proposal — source route | W3/W5/W7 |
| BEBT | BEBT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:10 | Keep/Modify proposal — source route | W3/W5/W7 |
| BEBB | BEBB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:11 | Keep/Modify proposal — source route | W3/W5/W7 |
| IBT | IBT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:13 | Keep/Modify proposal — source route | W3/W5/W7 |
| IBB | IBB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:14 | Keep/Modify proposal — source route | W3/W5/W7 |
| BIBT | BIBT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:15 | Keep/Modify proposal — source route | W3/W5/W7 |
| BIBB | BIBB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:16 | Keep/Modify proposal — source route | W3/W5/W7 |
| SFT | SFT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:18 | Keep/Modify proposal — source route | W3/W5/W7 |
| SFB | SFB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:19 | Keep/Modify proposal — source route | W3/W5/W7 |
| BSFT | BSFT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:20 | Keep/Modify proposal — source route | W3/W5/W7 |
| BSFB | BSFB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:21 | Keep/Modify proposal — source route | W3/W5/W7 |
| THL | THL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:23 | Keep/Modify proposal — source route | W3/W5/W7 |
| THR | THR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:24 | Keep/Modify proposal — source route | W3/W5/W7 |
| PFL | PFL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:25 | Keep/Modify proposal — source route | W3/W5/W7 |
| PFR | PFR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:26 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPL | BPL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:27 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPR | BPR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:28 | Keep/Modify proposal — source route | W3/W5/W7 |
| CL1 | CL 1 — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:30 | Keep/Modify proposal — source route | W3/W5/W7 |
| CR1 | CR 1 — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:31 | Keep/Modify proposal — source route | W3/W5/W7 |
| PCL | PCL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:32 | Keep/Modify proposal — source route | W3/W5/W7 |
| PCR | PCR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:33 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25L | 25 L — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:35 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25R | 25 R — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:36 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25LC | 25 LC — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:37 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25RC | 25 RC — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:38 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25C | 25 C — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:39 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25T | 25 T — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:40 | Keep/Modify proposal — source route | W3/W5/W7 |
| 25B | 25 B — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:41 | Keep/Modify proposal — source route | W3/W5/W7 |
| 18L | 18 L — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:42 | Keep/Modify proposal — source route | W3/W5/W7 |
| 18R | 18 R — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:43 | Keep/Modify proposal — source route | W3/W5/W7 |
| 18T | 18 T — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:44 | Keep/Modify proposal — source route | W3/W5/W7 |
| 18B | 18 B — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:45 | Keep/Modify proposal — source route | W3/W5/W7 |
| SL | SL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:47 | Keep/Modify proposal — source route | W3/W5/W7 |
| SR | SR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:48 | Keep/Modify proposal — source route | W3/W5/W7 |
| DSL | DSL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:49 | Keep/Modify proposal — source route | W3/W5/W7 |
| DSR | DSR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:50 | Keep/Modify proposal — source route | W3/W5/W7 |
| TSL | TSL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:51 | Keep/Modify proposal — source route | W3/W5/W7 |
| TSR | TSR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:52 | Keep/Modify proposal — source route | W3/W5/W7 |
| THCL | THCL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:54 | Keep/Modify proposal — source route | W3/W5/W7 |
| THCR | THCR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:55 | Keep/Modify proposal — source route | W3/W5/W7 |
| THC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:56 | Unknown — no exact registry descriptor | W3/W5/W7 |
| FTHC | Thickening (Registered) — Foundations/Raft Elements | Modules/Structural/Commands/CeTextCommands.cs:57 | Keep/Modify proposal — source route | W3/W5/W7 |
| BTHCL | BTHCL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:58 | Keep/Modify proposal — source route | W3/W5/W7 |
| BTHCR | BTHCR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:59 | Keep/Modify proposal — source route | W3/W5/W7 |
| BTHC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:60 | Unknown — no exact registry descriptor | W3/W5/W7 |
| PFCL | PFCL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:61 | Keep/Modify proposal — source route | W3/W5/W7 |
| PFCR | PFCR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:62 | Keep/Modify proposal — source route | W3/W5/W7 |
| PFC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:63 | Unknown — no exact registry descriptor | W3/W5/W7 |
| FPFC | Pad Footing (Registered) — Foundations/Footing Elements | Modules/Structural/Commands/CeTextCommands.cs:64 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPFCL | BPFCL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:65 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPFCR | BPFCR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:66 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPFC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:67 | Unknown — no exact registry descriptor | W3/W5/W7 |
| BPCL | BPCL — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:68 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPCR | BPCR — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:69 | Keep/Modify proposal — source route | W3/W5/W7 |
| BPC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:70 | Unknown — no exact registry descriptor | W3/W5/W7 |
| SFCT | SFCT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:72 | Keep/Modify proposal — source route | W3/W5/W7 |
| SFCB | SFCB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:73 | Keep/Modify proposal — source route | W3/W5/W7 |
| SFC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:74 | Unknown — no exact registry descriptor | W3/W5/W7 |
| BSFCT | BSFCT — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:75 | Keep/Modify proposal — source route | W3/W5/W7 |
| BSFCB | BSFCB — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:76 | Keep/Modify proposal — source route | W3/W5/W7 |
| BSFC | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:77 | Unknown — no exact registry descriptor | W3/W5/W7 |
| SF | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:78 | Unknown — no exact registry descriptor | W3/W5/W7 |
| FSF | Strip Footing (Registered) — Foundations/Footing Elements | Modules/Structural/Commands/CeTextCommands.cs:79 | Keep/Modify proposal — source route | W3/W5/W7 |
| REB | External Beam (Registered) — Foundations/Raft Elements | Modules/Structural/Commands/CeTextCommands.cs:80 | Keep/Modify proposal — source route | W3/W5/W7 |
| RIB | Internal Beam (Registered) — Foundations/Raft Elements | Modules/Structural/Commands/CeTextCommands.cs:81 | Keep/Modify proposal — source route | W3/W5/W7 |
| FADOPT | Adopt Foundations — Foundations/Manage | Modules/Structural/Commands/CeTextCommands.cs:82 | Keep/Modify proposal — source route | W3/W5/W7 |
| FREGEN | Regenerate Selected System — Foundations/Manage | Modules/Structural/Commands/CeTextCommands.cs:83 | Keep/Modify proposal — source route | W3/W5/W7 |
| FREGENALL | Regenerate All Systems — Foundations/Manage | Modules/Structural/Commands/CeTextCommands.cs:84 | Keep/Modify proposal — source route | W3/W5/W7 |
| CML | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:85 | Unknown — no exact registry descriptor | W3/W5/W7 |
| COPYM | COPYM — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:87 | Keep/Modify proposal — source route | W3/W5/W7 |
| CEMCOPY | CEMCOPY — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:88 | Keep/Modify proposal — source route | W3/W5/W7 |
| R2LTXT | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:89 | Unknown — no exact registry descriptor | W3/W5/W7 |
| CEDEBUG | CEDEBUG — Structural/Text Tags | Modules/Structural/Commands/CeTextCommands.cs:90 | Keep / expert-review route | W3/W5/W7 |
| FST | FST Manager — Foundations/Size Library | Modules/Structural/Commands/CeTextCommands.cs:91 | Keep/Modify proposal — source route | W3/W5/W7 |
| FEDIT | Edit Foundation Element — Foundations/Manage | Modules/Structural/Commands/CeTextCommands.cs:92 | Keep/Modify proposal — source route | W3/W5/W7 |
| BP | Bored Pier — Foundations/Piers | Modules/Structural/Commands/CeTextCommands.cs:93 | Keep/Modify proposal — source route | W3/W5/W7 |
| SCREWPILE | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:94 | Unknown — no exact registry descriptor | W3/W5/W7 |
| STUMPFOOTING | No exact registry match observed | Modules/Structural/Commands/CeTextCommands.cs:95 | Unknown — no exact registry descriptor | W3/W5/W7 |
| FDELETE | Delete Foundation System — Foundations/Manage | Modules/Structural/Commands/CeTextCommands.cs:96 | Keep/Modify proposal — source route | W3/W5/W7 |
| FSTEXPORT | Export Footing Schedule — Foundations/Size Library | Modules/Structural/Commands/CeTextCommands.cs:97 | Keep/Modify proposal — source route | W3/W5/W7 |
| RCRECTCOL | Rect Column — Section Details/Column Sections | Modules/Structural/Commands/ColumnDetailCommands.cs:25 | Keep/Modify proposal — source route | W6 |
| RCCIRCCOL | Circ Column — Section Details/Column Sections | Modules/Structural/Commands/ColumnDetailCommands.cs:167 | Keep/Modify proposal — source route | W6 |
| CERECOVERY | Review Recovery Snapshots — Administration/Diagnostics | Modules/Structural/Commands/DiagnosticsCommands.cs:76 | Keep/Modify proposal — source route | W11 |
| Q | Leader (Closed Filled) — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:96 | Keep/Modify proposal — source route | W7 |
| QD | Leader (Dot) — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:102 | Keep/Modify proposal — source route | W7 |
| LD | Linear Dimension — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:108 | Keep/Modify proposal — source route | W7 |
| AD | Aligned Dimension — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:114 | Keep/Modify proposal — source route | W7 |
| CE_ARCDIM | Arc Dimension — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:120 | Keep/Modify proposal — source route | W7 |
| RD | Arc Dimension — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:121 | Keep/Modify proposal — source route | W7 |
| DUP | DUP — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:165 | Keep/Modify proposal — source route | W7 |
| DSET | DSET — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:262 | Keep/Modify proposal — source route | W7 |
| DSET1 | DSET 1 — Annotation/Dimensions | Modules/Structural/Commands/DimensionCommands.cs:317 | Keep/Modify proposal — source route | W7 |
| EXCELMTEXTNEW | EXCELMTEXTNEW — Schedules/Import | Modules/Structural/Commands/ExcelMTextCommands.cs:10 | Keep / expert-review route | W8 |
| EXCELMAPFLOOR | EXCELMAPFLOOR — Schedules/Import | Modules/Structural/Commands/ExcelMTextCommands.cs:28 | Keep/Modify proposal — source route | W8 |
| EXCELCAPTURESELECTION | No exact registry match observed | Modules/Structural/Commands/ExcelMTextCommands.cs:45 | Unknown — no exact registry descriptor | W8 |
| EXCELMAPFLOORAREA | EXCELMAPFLOORAREA — Schedules/Import | Modules/Structural/Commands/ExcelMTextCommands.cs:51 | Keep/Modify proposal — source route | W8 |
| EXCELCAPTUREAREA | No exact registry match observed | Modules/Structural/Commands/ExcelMTextCommands.cs:75 | Unknown — no exact registry descriptor | W8 |
| XCLMTXT | XCLMTXT — Schedules/Import | Modules/Structural/Commands/ExcelMTextCommands.cs:81 | Keep/Modify proposal — source route | W8 |
| EXCELMTEXT | Excel to MText — Schedules/Import | Modules/Structural/Commands/ExcelMTextCommands.cs:82 | Keep/Modify proposal — source route | W8 |
| EH | EH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:179 | Keep/Modify proposal — source route | W7 |
| CH | CH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:182 | Keep/Modify proposal — source route | W7 |
| WH | WH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:185 | Keep/Modify proposal — source route | W7 |
| 21H | 21 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:188 | Keep/Modify proposal — source route | W7 |
| 51H | 51 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:191 | Keep/Modify proposal — source route | W7 |
| 74H | 74 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:194 | Keep/Modify proposal — source route | W7 |
| 201H | 201 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:197 | Keep/Modify proposal — source route | W7 |
| 31H | 31 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:200 | Keep/Modify proposal — source route | W7 |
| 10H | 10 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:203 | Keep/Modify proposal — source route | W7 |
| 238H | 238 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:206 | Keep/Modify proposal — source route | W7 |
| 242H | 242 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:209 | Keep/Modify proposal — source route | W7 |
| 141H | 141 H — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:212 | Keep/Modify proposal — source route | W7 |
| LBH | LBH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:215 | Keep/Modify proposal — source route | W7 |
| BLH | BLH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:218 | Keep/Modify proposal — source route | W7 |
| LBUH | LBUH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:221 | Keep/Modify proposal — source route | W7 |
| PH | PH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:224 | Keep/Modify proposal — source route | W7 |
| 21LH | 21 LH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:227 | Keep/Modify proposal — source route | W7 |
| 21DH | 21 DH — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:230 | Keep/Modify proposal — source route | W7 |
| H2A | H 2 A — Hatching/Patterns | Modules/Structural/Commands/HatchCommands.cs:233 | Keep/Modify proposal — source route | W7 |
| CE_INSPECT | No exact registry match observed | Modules/Structural/Commands/InspectCommands.cs:17 | Unknown — no exact registry descriptor | W11 |
| JOBTIMERDEBUG | No exact registry match observed | Modules/Structural/Commands/JobTimerDebugCommand.cs:22 | Unknown — no exact registry descriptor | W0 |
| JOBTIMEREDIT | No exact registry match observed | Modules/Structural/Commands/JobTimerEditCommand.cs:17 | Unknown — no exact registry descriptor | W0 |
| CEADMINSETTINGS | Drafting Standards — Administration/Standards | Modules/Structural/Commands/LayerManagerCommands.cs:11 | Keep/Modify proposal — source route | W2 |
| CEADS | Drafting Standards — Administration/Standards | Modules/Structural/Commands/LayerManagerCommands.cs:14 | Keep/Modify proposal — source route | W2 |
| CLEAN | Clean + Save — Utilities/Cleanup | Modules/Structural/Commands/LegacyPortCommands.cs:11 | Keep/Modify proposal — source route | W-legacy |
| FASTSAVE | FASTSAVE — Utilities/Cleanup | Modules/Structural/Commands/LegacyPortCommands.cs:14 | Keep/Modify proposal — source route | W-legacy |
| XRL | XREF Layer Manager — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:17 | Keep/Modify proposal — source route | W-legacy |
| XRLFAST | XRLFAST — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:20 | Keep/Modify proposal — source route | W-legacy |
| XRLCONFIG | XRLCONFIG — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:23 | Keep / expert-review route | W-legacy |
| XRLINFO | XRLINFO — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:26 | Keep / expert-review route | W-legacy |
| XRLSILENT | XRLSILENT — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:29 | Keep / expert-review route | W-legacy |
| CXREF | Copy/Paste XREF — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:32 | Keep/Modify proposal — source route | W-legacy |
| PXREF | PXREF — Utilities/Xrefs | Modules/Structural/Commands/LegacyPortCommands.cs:35 | Keep/Modify proposal — source route | W-legacy |
| CPB | CPB — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:45 | Keep/Modify proposal — source route | W-legacy |
| RC | RC — Annotation/Markup | Modules/Structural/Commands/LegacyPortCommands.cs:48 | Keep/Modify proposal — source route | W-legacy |
| CL | CL — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:51 | Keep/Modify proposal — source route | W-legacy |
| CENTERLINE | CENTERLINE — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:54 | Keep/Modify proposal — source route | W-legacy |
| CENTRELINE | CENTRELINE — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:57 | Keep/Modify proposal — source route | W-legacy |
| CLINE | CLINE — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:60 | Keep/Modify proposal — source route | W-legacy |
| FFLMARKER | FFLMARKER — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:63 | Keep/Modify proposal — source route | W-legacy |
| FLMK | FLMK — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:66 | Keep/Modify proposal — source route | W-legacy |
| REBAR | REBAR — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:69 | Keep/Modify proposal — source route | W-legacy |
| RB | RB — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:72 | Keep/Modify proposal — source route | W-legacy |
| SCABBLE | SCABBLE — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:75 | Keep/Modify proposal — source route | W-legacy |
| SCAB | SCAB — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:78 | Keep/Modify proposal — source route | W-legacy |
| CJ | CJ — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:81 | Keep/Modify proposal — source route | W-legacy |
| SSC | SSC — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:84 | Keep/Modify proposal — source route | W-legacy |
| CJSS | CJSS — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:87 | Keep/Modify proposal — source route | W-legacy |
| LU | LU — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:90 | Keep/Modify proposal — source route | W-legacy |
| SPW | SPW — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:93 | Keep/Modify proposal — source route | W-legacy |
| SPW3 | SPW 3 — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:96 | Keep/Modify proposal — source route | W-legacy |
| SPW6 | SPW 6 — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:99 | Keep/Modify proposal — source route | W-legacy |
| SPWC | SPWC — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:102 | Keep/Modify proposal — source route | W-legacy |
| DIV | DIV — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:105 | Keep/Modify proposal — source route | W-legacy |
| DIVX | DIVX — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:108 | Keep/Modify proposal — source route | W-legacy |
| MTS | MTS — Utilities/Legacy | Modules/Structural/Commands/LegacyPortCommands.cs:111 | Keep/Modify proposal — source route | W-legacy |
| CE_LEVELMARK | Level Mark — Annotation/Markers | Modules/Structural/Commands/LevelMarkCommands.cs:28 | Keep/Modify proposal — source route | W7 |
| LM | Level Mark — Annotation/Markers | Modules/Structural/Commands/LevelMarkCommands.cs:29 | Keep/Modify proposal — source route | W7 |
| CE_FFL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:64 | Unknown — no exact registry descriptor | W7 |
| FFL | FFL — Utilities/Legacy | Modules/Structural/Commands/LevelMarkCommands.cs:65 | Keep/Modify proposal — source route | W7 |
| CE_RL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:68 | Unknown — no exact registry descriptor | W7 |
| RL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:69 | Unknown — no exact registry descriptor | W7 |
| CE_SSL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:72 | Unknown — no exact registry descriptor | W7 |
| SSL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:73 | Unknown — no exact registry descriptor | W7 |
| CE_NGL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:76 | Unknown — no exact registry descriptor | W7 |
| NGL | No exact registry match observed | Modules/Structural/Commands/LevelMarkCommands.cs:77 | Unknown — no exact registry descriptor | W7 |
| CE_LEVELUPDATE | Level Update — Annotation/Markers | Modules/Structural/Commands/LevelMarkCommands.cs:80 | Keep/Modify proposal — source route | W7 |
| LMU | Level Update — Annotation/Markers | Modules/Structural/Commands/LevelMarkCommands.cs:81 | Keep/Modify proposal — source route | W7 |
| LBW | No exact registry match observed | Modules/Structural/Commands/LoadBearingWallCommands.cs:33 | Unknown — no exact registry descriptor | W2 |
| CEMARKUPVIEW | CEMARKUP Visual Preview — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:30 | Keep/Modify proposal — source route | W9 |
| CEMARKUPPARSE | CEMARKUP Parse PDF — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:53 | Keep/Modify proposal — source route | W9 |
| CEMARKUPLOAD | CEMARKUP Load Package — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:113 | Keep/Modify proposal — source route | W9 |
| CEMARKUPPLAN | CEMARKUP Replan — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:159 | Keep/Modify proposal — source route | W9 |
| CEMARKUPPREVIEW | CEMARKUP Preview Next — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:185 | Keep/Modify proposal — source route | W9 |
| CEMARKUPRUN | CEMARKUP Run Next — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:216 | Keep/Modify proposal — source route | W9 |
| CEMARKUPUNDO | CEMARKUP Undo Last — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:251 | Keep/Modify proposal — source route | W9 |
| CEMARKUPSTATUS | CEMARKUP Status — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:268 | Keep/Modify proposal — source route | W9 |
| CEMARKUPREGISTER | CEMARKUP Register Drawing — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:285 | Keep/Modify proposal — source route | W9 |
| CEMARKUPBENCH | CEMARKUP Benchmark — Administration/Markup | Modules/Structural/Commands/MarkupAICommands.cs:304 | Keep / expert-review route | W9 |
| CEMARKUPDWGEXPORT | No exact registry match observed | Modules/Structural/Commands/MarkupAICommands.cs:418 | Unknown — no exact registry descriptor | W9 |
| CE_MLEADERRIGHT | MLeader Right — Annotation/Dimensions | Modules/Structural/Commands/MLeaderCommands.cs:15 | Keep/Modify proposal — source route | W7 |
| MLR | MLeader Right — Annotation/Dimensions | Modules/Structural/Commands/MLeaderCommands.cs:16 | Keep/Modify proposal — source route | W7 |
| CE_MLEADERLEFT | MLeader Left — Annotation/Dimensions | Modules/Structural/Commands/MLeaderCommands.cs:22 | Keep/Modify proposal — source route | W7 |
| MLL | MLeader Left — Annotation/Dimensions | Modules/Structural/Commands/MLeaderCommands.cs:23 | Keep/Modify proposal — source route | W7 |
| R1 | Rafter Marker — Structural/Rafter/Joist | Modules/Structural/Commands/RafterJoistCommands.cs:54 | Keep/Modify proposal — source route | W3 |
| FJ1 | Floor Joist Marker — Structural/Rafter/Joist | Modules/Structural/Commands/RafterJoistCommands.cs:60 | Keep/Modify proposal — source route | W3 |
| P1 | No exact registry match observed | Modules/Structural/Commands/RafterJoistCommands.cs:66 | Unknown — no exact registry descriptor | W3 |
| RJSET | Rafter/Joist Settings — Structural/Rafter/Joist | Modules/Structural/Commands/RafterJoistCommands.cs:72 | Keep / expert-review route | W3 |
| CE_REBARLINE | Rebar Line — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:23 | Keep/Modify proposal — source route | W6 |
| RBL | RBL — Utilities/Legacy | Modules/Structural/Commands/RebarCommands.cs:24 | Keep/Modify proposal — source route | W6 |
| REBARLINE | REBARLINE — Utilities/Legacy | Modules/Structural/Commands/RebarCommands.cs:25 | Keep/Modify proposal — source route | W6 |
| CE_REBARCIRCLE | Rebar Circle — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:28 | Keep/Modify proposal — source route | W6 |
| RBC | Rebar Circle — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:29 | Keep/Modify proposal — source route | W6 |
| REBARCIRCLE | Rebar Circle — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:30 | Keep/Modify proposal — source route | W6 |
| CE_STIRRUP | Stirrup — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:33 | Keep/Modify proposal — source route | W6 |
| STR | Stirrup — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:34 | Keep/Modify proposal — source route | W6 |
| STIRRUP | Stirrup — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:35 | Keep/Modify proposal — source route | W6 |
| CE_BARWEIGHT | Bar Weight — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:38 | Keep/Modify proposal — source route | W6 |
| BWT | Bar Weight — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:39 | Keep/Modify proposal — source route | W6 |
| BARWEIGHT | Bar Weight — Footings/Rebar | Modules/Structural/Commands/RebarCommands.cs:40 | Keep/Modify proposal — source route | W6 |
| LIGS | Ligatures — Section Details/Reinforcement | Modules/Structural/Commands/ReinforcementDetailCommands.cs:13 | Keep/Modify proposal — source route | W6 |
| COLTIES | Column Ties — Section Details/Reinforcement | Modules/Structural/Commands/ReinforcementDetailCommands.cs:14 | Keep/Modify proposal — source route | W6 |
| WALLREO | Wall Reo — Section Details/Reinforcement | Modules/Structural/Commands/ReinforcementDetailCommands.cs:15 | Keep/Modify proposal — source route | W6 |
| WALLSTRS | No exact registry match observed | Modules/Structural/Commands/ReinforcementDetailCommands.cs:16 | Unknown — no exact registry descriptor | W6 |
| CE_MEMBERLABEL | Member Label — Scheduling/Labels | Modules/Structural/Commands/SchedulingCommands.cs:18 | Keep/Modify proposal — source route | W8 |
| LABEL | Member Label — Scheduling/Labels | Modules/Structural/Commands/SchedulingCommands.cs:19 | Keep/Modify proposal — source route | W8 |
| ML | No exact registry match observed | Modules/Structural/Commands/SchedulingCommands.cs:93 | Unknown — no exact registry descriptor | W8 |
| SBEAM | Steel/Timber Section — Section Details/Beam Sections | Modules/Structural/Commands/SectionDetailCommands.cs:26 | Keep/Modify proposal — source route | W6 |
| RCBEAM | RC Beam Section — Section Details/Beam Sections | Modules/Structural/Commands/SectionDetailCommands.cs:381 | Keep/Modify proposal — source route | W6 |
| CE_SECTIONMARK | Section Mark — Annotation/Markers | Modules/Structural/Commands/SectionMarkCommands.cs:19 | Keep/Modify proposal — source route | W6 |
| SECTION | Section Mark — Annotation/Markers | Modules/Structural/Commands/SectionMarkCommands.cs:20 | Keep/Modify proposal — source route | W6 |
| SM | Section Mark — Annotation/Markers | Modules/Structural/Commands/SectionMarkCommands.cs:21 | Keep/Modify proposal — source route | W6 |
| CESHEETS | No exact registry match observed | Modules/Structural/Commands/SheetsCommands.cs:15 | Unknown — no exact registry descriptor | W10 |
| CESHEETSMANAGER | No exact registry match observed | Modules/Structural/Commands/SheetsCommands.cs:16 | Unknown — no exact registry descriptor | W10 |
| CESHEETSCLASSIC | No exact registry match observed | Modules/Structural/Commands/SheetsCommands.cs:39 | Unknown — no exact registry descriptor | W10 |
| BSSLAB | RC Slab Section — Section Details/Slab Details | Modules/Structural/Commands/SlabDetailCommands.cs:13 | Keep/Modify proposal — source route | W5 |
| STLCONN | Steel Connection — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:13 | Keep/Modify proposal — source route | W6 |
| STLCONN1 | Steel Connection — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:14 | Keep/Modify proposal — source route | W6 |
| STLCONN3 | Steel Connection — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:15 | Keep/Modify proposal — source route | W6 |
| PORTAL | Portal Frame — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:16 | Keep/Modify proposal — source route | W6 |
| TRUSS | Truss — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:17 | Keep/Modify proposal — source route | W6 |
| PURLINS | Purlins — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:18 | Keep/Modify proposal — source route | W6 |
| PPURLINS | Purlins — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:19 | Keep/Modify proposal — source route | W6 |
| ANGLES | Angle Detail — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:20 | Keep/Modify proposal — source route | W6 |
| BOLTS | Bolt Pattern — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:21 | Keep/Modify proposal — source route | W6 |
| BRACE | Bracing Detail — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:22 | Keep/Modify proposal — source route | W6 |
| SWBRACE | Bracing Detail — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:23 | Keep/Modify proposal — source route | W6 |
| BASEDET | Base Plate — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:24 | Keep/Modify proposal — source route | W6 |
| GUSSETS | Gussets — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:25 | Keep/Modify proposal — source route | W6 |
| RIDGE | Ridge Detail — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:26 | Keep/Modify proposal — source route | W6 |
| KNEE | Knee Joint — Section Details/Steelwork | Modules/Structural/Commands/SteelworkDetailCommands.cs:27 | Keep/Modify proposal — source route | W6 |
| DS | DS — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:109 | Keep/Modify proposal — source route | W4 |
| DS1 | DS 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:110 | Keep/Modify proposal — source route | W4 |
| TS1 | TS 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:111 | Keep/Modify proposal — source route | W4 |
| C1 | C 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:112 | Keep/Modify proposal — source route | W4 |
| C2 | C 2 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:113 | Keep/Modify proposal — source route | W4 |
| SDS | SDS — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:115 | Keep/Modify proposal — source route | W4 |
| SDS1 | SDS 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:116 | Keep/Modify proposal — source route | W4 |
| STS1 | STS 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:117 | Keep/Modify proposal — source route | W4 |
| SC1 | SC 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:118 | Keep/Modify proposal — source route | W4 |
| SC2 | SC 2 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:119 | Keep/Modify proposal — source route | W4 |
| TDS | TDS — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:123 | Keep/Modify proposal — source route | W4 |
| TDS1 | TDS 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:130 | Keep/Modify proposal — source route | W4 |
| TTS1 | TTS 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:137 | Keep/Modify proposal — source route | W4 |
| TC1 | TC 1 — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:144 | Keep/Modify proposal — source route | W4 |
| SUPTEXTAUTO | SUPTEXTAUTO — Structural/Supports | Modules/Structural/Commands/SupportBlockCommands.cs:185 | Keep/Modify proposal — source route | W4 |
| CESTRUC | CESTRUC — Administration/Workspace | Modules/Structural/Commands/UiCommands.cs:13 | Keep / expert-review route | W0/W1 |
| CE_STRUC_SUITE | No exact registry match observed | Modules/Structural/Commands/UiCommands.cs:24 | Unknown — no exact registry descriptor | W0/W1 |
| CETOOLS | Open Command Hub — Administration/Workspace | Modules/Structural/Commands/UiCommands.cs:33 | Keep/Modify proposal — source route | W0/W1 |
| CETOOLSTOGGLE | CETOOLSTOGGLE — Administration/Workspace | Modules/Structural/Commands/UiCommands.cs:42 | Keep/Modify proposal — source route | W0/W1 |
| CENOTES | CENOTES — Administration/Workspace | Modules/Structural/Commands/UiCommands.cs:51 | Keep/Modify proposal — source route | W0/W1 |
| CECHECKLIST | CECHECKLIST — Administration/Workspace | Modules/Structural/Commands/UiCommands.cs:71 | Keep / expert-review route | W0/W1 |
| CEMARKUP | CEMARKUP Panel — Administration/Markup | Modules/Structural/Commands/UiCommands.cs:80 | Keep/Modify proposal — source route | W0/W1 |
| CEPALETTE | Command Palette — Administration/Help | Modules/Structural/Commands/UiCommands.cs:92 | Keep/Modify proposal — source route | W0/W1 |
| CEPROPS | No exact registry match observed | Modules/Structural/Commands/UtilityCommands.cs:20 | Unknown — no exact registry descriptor | W11 |
| CEPROJECTPROPS | No exact registry match observed | Modules/Structural/Commands/UtilityCommands.cs:21 | Unknown — no exact registry descriptor | W11 |
| STRSCHEDCREATE | STRSCHEDCREATE — Schedules/Schedule Tools | Modules/Structural/Commands/UtilityCommands.cs:62 | Keep/Modify proposal — source route | W11 |
| STRSCHEDREFRESH | STRSCHEDREFRESH — Schedules/Schedule Tools | Modules/Structural/Commands/UtilityCommands.cs:68 | Keep / expert-review route | W11 |
| STRSCHEDSYNC | STRSCHEDSYNC — Schedules/Schedule Tools | Modules/Structural/Commands/UtilityCommands.cs:89 | Keep/Modify proposal — source route | W11 |
| STRUCEXPORTCSV | Export Schedule to Excel — Utilities/Export | Modules/Structural/Commands/UtilityCommands.cs:95 | Keep/Modify proposal — source route | W11 |
| STRUCEXPORTBLOCKS | STRUCEXPORTBLOCKS — Utilities/Export | Modules/Structural/Commands/UtilityCommands.cs:116 | Keep/Modify proposal — source route | W11 |
| STRUCEXPORTPDF | Export Layout to PDF — Utilities/Export | Modules/Structural/Commands/UtilityCommands.cs:130 | Keep/Modify proposal — source route | W11 |
| STRUCLINKTEXT | STRUCLINKTEXT — Administration/System | Modules/Structural/Commands/UtilityCommands.cs:147 | Keep/Modify proposal — source route | W11 |
| STRIPLAYERSMERGE | STRIPLAYERSMERGE — Administration/System | Modules/Structural/Commands/UtilityCommands.cs:177 | Keep/Modify proposal — source route | W11 |
| CEEXPORTNOTES | Export Drawing Notes — Utilities/Export | Modules/Structural/Commands/UtilityCommands.cs:183 | Keep/Modify proposal — source route | W11 |

## User-facing windows and palettes discovered

| Window/palette | Source evidence | Card / status boundary |
|---|---|---|
| AboutDialog | UI/Dialogs/AboutDialog.xaml(.cs) | W0; source-opened from Admin command route |
| AdminHubWindow | UI/Dialogs/AdminHubWindow.xaml(.cs) | W0; source-opened from CEADMIN |
| BeamSettingsDialog | UI/Dialogs/BeamSettingsDialog.xaml(.cs) | W3; source-opened from beam settings |
| CeProjectSetupDialog | UI/Dialogs/CeProjectSetupDialog.xaml(.cs) | W1; shared project setup boundary, root owns project integration |
| CePropsDialog | UI/Dialogs/CePropsDialog.xaml(.cs) | W11; source-opened from utility/property route |
| CeSettingsDialog / SettingsDialog | UI/Dialogs/CeSettingsDialog.xaml(.cs), SettingsDialog.xaml(.cs) | W0; settings boundary |
| CommandHelpWindow / CommandPaletteWindow | UI/Dialogs/CommandHelpWindow.xaml(.cs), CommandPaletteWindow.xaml(.cs) | W0; help and command-discovery routes |
| ExcelSheetPickerDialog / XclmTxtDialog / XclmTxtAdvancedEditDialog | UI/Dialogs/*Excel* and *XclmTxt* | W8; source-opened schedule import route |
| FstManagerWindow | UI/FstManagerWindow.xaml(.cs) | W5; source-opened by foundation service |
| LayerManagerWindow | UI/LayerManagerWindow.xaml(.cs) | W2; source-opened layer route |
| MarkupPreviewWindow / MarkupWindow | UI/Dialogs/MarkupPreviewWindow.xaml(.cs), UI/MarkupWindow.xaml(.cs) | W9; root-owned AI interface |
| NotesBrowserDialog / NoteEntryDialog | UI/Dialogs/NotesBrowserDialog.xaml(.cs), NoteEntryDialog.xaml(.cs) | W0; notes route |
| RCBeamPickerDialog / RCMemberDialog / RCLigDialog | UI/Dialogs/RCBeamPickerDialog.xaml(.cs), RCMemberDialog.xaml(.cs), RCLigDialog.xaml(.cs) | W6; source-opened detail route |
| ReportsDialog | UI/Dialogs/ReportsDialog.xaml(.cs) | W11; report/diagnostic route requires detailed source review |
| SteelSectionPickerDialog | UI/Dialogs/SteelSectionPickerDialog.xaml(.cs) | W6; source-opened section-detail route |
| StrucSuiteWindow / MainPalette | UI/StrucSuiteWindow.xaml(.cs), UI/Palette/MainPalette.xaml(.cs) | W0/W1; shell/palette route, preserve root-owned suite boundaries |
| TemplateEditorDialog / TemplateSelectorDialog / CeSharedTitleMappingWindow | UI/Dialogs/*Template*, CeSharedTitleMappingWindow.xaml(.cs) | W10; sheets/title interface, root-owned integration |
| CeSheetsWindow / Manager / SyncPreview / ValidationReport / IssuePublish | UI/Dialogs/CeSheets*.xaml(.cs) | W10; root-owned sheets/issue interface |
| TimeEntryBrowserWindow / FloatingTimerWindow / IdlePromptDialog | UI/*TimeEntry*, UI/Dialogs/*Timer*, IdlePromptDialog.xaml(.cs) | W0; job-time route |
| ViewSuggestionsDialog / SuggestEditDialog | UI/Dialogs/ViewSuggestionsDialog.xaml(.cs), SuggestEditDialog.xaml(.cs) | W9; source window presence, drawing-intelligence/AI owner boundary |
| CeAlertDialog / CeProgressDialog / ScreenSnipOverlayForm / ColumnVisibilityPickerDialog | UI/Dialogs/ | Support surfaces; source presence does not establish a primary workflow |

## Supporting design and drawing-intelligence evidence

| Source area | Observed responsibility | Planning consequence |
|---|---|---|
| Modules/Structural.DesignCore | Pure-logic project present under the Structural module; source files define calculation/design-support services rather than AutoCAD command declarations. | Treat as reusable support brain only after each user route identifies inputs, authority and output. Its presence is not proof of a UI or calculation approval. |
| Modules/Structural/Services/CeStrucRibbonContributor.cs and CommandRegistryService.cs | Registry-driven Structural ribbon/command discovery and default grouping are source-observed. | Registry labels/hidden flags aid inventory. They do not prove ribbon visibility, current command ownership or AutoCAD usability. |
| Structural markup parser/render services | Markup/document parsing and rendering source is present. | Root owns whole-suite AI/drawing-intelligence integration. Structural planning preserves evidence/preview/confirmation boundaries; no AI action is assumed. |
| NativeXrefLayerService and UI layer routes | Xref/layer inspection or change routes are source-present. | Cards retain locked/Xref/REFEDIT protections and require explicit preview/confirmation before any allowed local change. |
| FoundationService and CeTextService | Foundation manager and text command dispatch are source-present. | Cards distinguish drawing text, engineer-confirmed geometry, labels and schedule relationships; source alone does not prove coordinated-edit behaviour. |

## Inventory gaps to close before implementation

1. **Runtime truth:** this source pass cannot say which declarations load or work in each AutoCAD lane. Unknown remains Unknown until a constrained test record exists.
2. **Registry drift:** source declaration and registry counts differ. Detailed review must reconcile aliases, constants, hidden expert tools and declarations without exact descriptors before a route changes.
3. **Legacy ports:** 32 declarations in `LegacyPortCommands.cs` are not retired by this inventory. Each needs a focused retained-behaviour review before consolidation or removal.
4. **Active owner boundaries:** AI, sheets/issue, project authority and suite/Manager integration remain root-owned. This ledger captures Structural-facing routes without a competing design.
5. **Native/grip transition:** approved shared-native Structural direction remains staged future work. Existing managed command source and planned native interaction are not treated as the same runtime route.

---

**Planning status:** source inventory complete for declared command files; workflow review continuing. **Built/Tested/Installed/Tim-accepted:** not assessed by this ledger.
