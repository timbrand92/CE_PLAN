# Command-discovery reconciliation and preservation map

**Purpose.** This map reconciles the suite tool register, the three module command registries and the existing Structural/Civil source-declaration ledgers. It is an access and retirement-planning record, not runtime proof or a new master plan.

- Structural declaration/control evidence: [structural_source_command_window_ledger.md](structural_source_command_window_ledger.md) and [structural_retained_control_ledger.md](structural_retained_control_ledger.md).
- Civil declaration/control evidence: [civil_route_control_preservation_ledger.md](civil_route_control_preservation_ledger.md).
- Existing Civil authority: [../../planner/source_authority_and_conflicts.md](../../planner/source_authority_and_conflicts.md) and [../../planner/ownership_and_migration_supplement.md](../../planner/ownership_and_migration_supplement.md).
- The common register at Assets/Config/ce-tool-register.json says migrationComplete is false (line 4). Its ten tools are an approved access subset, not a complete command inventory.
- **No count means working, visible, installed or Tim-accepted.** Registry/config state and source declaration state are distinct.

## What each record actually governs

| Record | Bounded evidence | It does not prove |
|---|---|---|
| ce-tool-register | Ten named suite tools carry status Active and reviewStatus Approved. Civil uses seven; Manager uses three. Structural has no row. | That every declared command is absent, retired, hidden, available or unapproved. |
| Module command registry | Civil has 95 rows/97 command-or-alias identities; Structural 251/272; Manager 8/8. Fields include label, group, aliases and, for Civil/Structural, hidden/expert/deprecated/replacement metadata. | That a registry route loads, ribbon is visible, context menu was generated, or a replacement has passed AutoCAD acceptance. |
| Source declaration ledgers | Civil 98 and Structural 301 observed command declarations; Manager 8. | That declaration is a daily user route or that module ownership follows a duplicated command name. |
| Ribbon/CUI/help source | Civil uses explicit panels; Structural derives panels from visible registry entries; menu generators use registry/layout data and help lookups use registry identity. | Installed ribbon/menu parity or Help page availability. |

## Reconciliation result

| Module | Source declarations | Registry rows / identities | Config-only identities | Declaration-only identities | Preservation consequence |
|---|---:|---:|---|---|---|
| Civil | 98 | 95 / 97 | None | CE_TEST_RUN only | Test runner is source-observed harness, not a production route. Every user-facing Civil declaration has a registry primary or alias identity. |
| Structural | 301 | 251 / 272 | BMT2TXT, BTXT2MT, CEP, COPYROT, CR, MOVEROT, MR, XCLMTXTINDEX | 37 listed below | Configuration and declaration scope differ. Do not call either list missing/retired without resolving cross-module duplicate commands, aliases, generated paths or stale rows. |
| Manager | 8 | 8 / 8 | None | None | Bounded one-to-one current-source/config match. |
| Common suite tool register | 10 approved tool rows | 3 Manager + 7 Civil | Structural has no suite-tool row | All other module routes | The register is deliberately incomplete while migrationComplete is false. It must not be used to retire any unlisted command. |

## User-journey preservation map

| User need / job moment | Existing primary access | Preserved alternate / expert access | Help, context or ribbon evidence | Planning contract |
|---|---|---|---|---|
| Start, status and support | CEMANAGER; CEHEALTH; CESUPPORT are approved suite-tool rows. | Manager refresh/diagnostics/log/admin/update commands remain configuration-backed. | Tool register locations: CE > Manager / Help & Support. Manager ribbon/context exposure is outside this bounded scan. | Keep Manager as shared-owner interface; no duplicate root/suite shell. |
| Civil survey/import and evidence | Civil ribbon Import: CDSURVEY large, with CDIMPORTCOMPARE and CDCHECKDWG in Import & Check (CeCvlRibbonContributor.cs:26-31). | Hidden/expert source import/export: CDIMPORTXCIVIL, CDIMPORTLANDXML, CDEXPORTCORPUS; CDTRIAGE. | Civil registry help URL supports context lookup; CdHelpService.cs:135-165 uses command/alias identity and requires HTTPS. | Keep direct specialist routes while CDDESIGN provides review. Discovery is not adoption. |
| Civil daily drafting | Ribbon Draw: CD and PIT large, Drainage Sources flyout, Surfaces & Joints flyout, Site Markers flyout (CeCvlRibbonContributor.cs:33-59). | PP, presets, TG alias and legacy direct commands retained. CD/PIT active owner paths stay untouched. | CDHELP opens context URL if registry entry has HTTPS URL, otherwise general Help dialog (CdHelpService.cs:127-165). | Drainage Items is already approved: main DP/IO/GIO/FW/TG/AGI/OF and More FO/Strip/custom/Raingarden/LPD; do not use ribbon/config inventory to reopen it. |
| Civil levels, edit and link | Levels & Falls includes CDSL, CDFALL, CDRUNSOLVE/CDINSPECTOR; Edit & Link includes CDEDIT, annotation, repair/standards (CeCvlRibbonContributor.cs:61-74). | PIPEEDIT/PITEDIT aliases route to CDEDIT. Hidden repair/link/migration commands stay available to their owner/review path. | Civil CUI generator resolves source/run command through registry then creates macro/menu/toolbar access (CuiMenuGeneratorService.cs:208-236). | Preserve exact selection, preview, Cancel, Undo and native protection contracts. Do not reclassify hidden as retired. |
| Civil outputs and review | Output includes PITSCHEDULE, CDCALC, CDHUB/CDPROFILE/CDDASHBOARD, export (CeCvlRibbonContributor.cs:76-85). | CDLPD/CDLPDRESET, propagation, diagnostics and audit routes are hidden expert/review routes. | Hub/Inspector/help buttons are source-observed secondary access, not proof of current screen behaviour. | Keep report/schedule/profile/calculation access distinct; root owns project-to-issue and shared QA. |
| Structural framing through foundations | CE Structural ribbon derives visible entries from registry and maps Beams, Columns & Footings, Rebar & Bracing panels (CeStrucRibbonContributor.cs:15-29; :70-102; :155-192). | Structural aliases preserve established short commands. Seven hidden diagnostic/migration/autosupport routes remain source-configured. | Structural Command Help and CUI generation are source-observed in the existing Structural ledger. | Preserve reviewed routes through transition, **except approved `ST6-14` ordinary-registration retirement of `STR` and `BWT`**. Source map itself does not decide further retirements. |
| Structural annotation, schedules and CE support | Derived Annotate, Schedules and CE panels use registry group/subgroup mapping (CeStrucRibbonContributor.cs:103-149; :193-246). | Expert markup and workspace diagnostics remain separately discoverable only as configured. `XCLMTXTINDEX` is excluded: registry metadata has no observed command declaration. | Structural ribbon takes visible non-deprecated registry entries; it separately reserves a few suite-owned utility commands (…:36-64). | Root owns shared sheets/issue/settings/Manager/AI flows. Do not duplicate from a Structural source location. |

## Aliases and intentionally constrained routes

| Module | Alias/replacement evidence | Preservation status |
|---|---|---|
| Civil | CDEDIT → PIPEEDIT, PITEDIT; PIPEPITLINK → LINKPIPEPIT; PIPEPITUNLINK → CLEARPIPEPITLINK. | Aliases are command identity compatibility, not a separate preferred UI. CDEDIT is the approved suite-tool route; active CD/PIT owner controls editor behaviour. |
| Civil deprecated metadata | CDLABELSTYLE → CDS; PIPEPITLINK → CDPIPEOVERRIDE; PIPEPITUNLINK → CDPIPEOVERRIDECLEAR. | This is registry metadata only. Earlier Civil card says none is proposed for permanent retirement without Tim approval (workflow_cards.md:9-15). Keep redirect/access/evidence until a replacement is AutoCAD-accepted. |
| Structural aliases | CEHELP → CE_HELP; CEADMINSETTINGS → CEADS; CE_SECTIONMARK → SECTION/SM; CE_LEVELMARK → LM; CE_LEVELUPDATE → LMU; CE_REBARLINE → RBL/REBARLINE; CE_REBARCIRCLE → RBC/REBARCIRCLE; CE_STIRRUP → STR/STIRRUP; CE_BARWEIGHT → BWT/BARWEIGHT; CE_MLEADERRIGHT → MLR; CE_MLEADERLEFT → MLL; BEXT → BEXTEND; BTX → BTXT2MT/BMT2TXT; AB/ABS/BB legacy aliases; and remaining registry aliases in the Structural ledger. | Preserve alias evidence during transition; `ST6-14` separately retires ordinary `STR`/`BWT` registration, while current source shows the `CE_STIRRUP`/`CE_BARWEIGHT` names share those methods. Do not collapse those facts into a blanket keep/retire claim. |
| Structural deprecated metadata | EXCELMTEXTNEW → XCLMTXT. | Config replacement candidate only; do not delete legacy entry without owner review and accepted schedule workflow. |

## Hidden and expert access needs a doorway, not silent disappearance

| Module / route family | Current registry evidence | Future access contract |
|---|---|---|
| Civil hidden expert (49 hidden; 44 expert) | Source import/export, link/rebuild/recover/upgrade/audit, LPD, parts/presets, propagation, slab regen/editor and move/copy rotation are mostly hidden/expert. Three are deprecated as listed above. | Keep command-line/Help/support discoverability and a visible reason when hidden from daily ribbon. Each remains Preserve for review, except active owner routes. “Hidden” does not mean approved retirement. |
| Civil non-hidden daily routes | 46 registry entries are visible/non-deprecated. Explicit ribbon panels consume selected registry commands and throw if a named ribbon command is absent (CeCvlRibbonContributor.cs:107-119). | Preserve ribbon-to-registry identity. Any new entry must have one command identity, one label/help route, permissions and its AutoCAD workflow card. |
| Structural hidden | EXCELMTEXTNEW, BEAMLINKMIGRATE, BEAMLINKDEBUG, CEAUTOSUPPORT, CEAUTOSUPPORTCLEAR, CEAUTOSUPPORTREF, CEAUTOSUPPORTREFCLEAR. | Keep support/debug migration access until review. Autosupport remains experimental/source-observed, not a daily automatic placement route. |
| Structural expert metadata | Registry labels 18 rows expert. **17 source-backed expert candidates** are CEADMIN, CEMARKUPBENCH, CECHECKLIST, CESTRUC, STRSCHEDREFRESH, 8, RJSET, CEDEBUG, XRLCONFIG, XRLINFO, XRLSILENT, BEAMLINKMIGRATE, BEAMLINKDEBUG and four autosupport routes. `XCLMTXTINDEX` is the remaining unqualified metadata row. | Preserve expert/support access with Help/context labelling for the 17 candidates. `XCLMTXTINDEX` is an unqualified registry ghost with no observed command declaration: not callable/expert access and hidden pending a real qualified identity. |
| Manager | No hidden/expert/deprecated flags in its eight-row registry. | This is a schema difference, not proof all Manager routes are equally suitable for everyday ribbon exposure. Root remains owner. |

## Concrete gaps requiring an owner contract

| Gap | Evidence | Required contract before a change |
|---|---|---|
| Suite-tool register incomplete | migrationComplete false; 10 rows, no Structural tool entries. | `CT-01` already resolves intent: this is the incremental permanent register, with current module registries as migration inputs. Per `CT6/CT8/CT15`, source discovery cannot invent a product entry and off-register routes remain legacy-accessible / Hidden + Review Pending until qualified. It cannot gate visibility or retirement of 407 observed declarations today. |
| Structural config-only identities | Eight names listed in reconciliation. Four (MR/MOVEROT/CR/COPYROT) are also Civil declarations, so module-scoped config-only does not equal missing globally. | Resolve primary owner, namespace/collision behaviour, Help/ribbon entry and backward compatibility. |
| Structural declaration-only routes | ?CE, BPC, BPFC, BSFC, BTHC, CE_FFL, CE_INSPECT, CE_NGL, CE_RL, CE_SSL, CE_STRUC_SUITE, CEMARKUPDWGEXPORT, CEPROJECTPROPS, CEPROPS, CESETTINGS, CESHEETS, CESHEETSCLASSIC, CESHEETSMANAGER, CML, EXCELCAPTUREAREA, EXCELCAPTURESELECTION, JOBTIMERDEBUG, JOBTIMEREDIT, LBW, ML, NGL, P1, PFC, R2LTXT, RL, SCREWPILE, SF, SFC, SSL, STUMPFOOTING, THC, WALLSTRS. | Classify each as alias, code-built/legacy route, shared-owner interface or retained specialist command. Never infer retirement from registry absence. |
| Civil CE_TEST_RUN declaration-only | Only Civil declaration with no registry identity. | Keep as harness-only and omit from daily discovery unless a separate test/diagnostic owner explicitly needs it. |
| Context/menu parity | Civil CUI uses toolbar layout/registry dynamic resolution; Structural CUI has its own generator. Current source does not prove installed CUIX/menu or all context routes. | Each product command needs one selected discovery path and a documented fallback; test it in AutoCAD before removing another access route. |
| Help parity | Civil context help depends on prior tracked CE command, registry identity and HTTPS helpUrl; Structural has a separate help window. | Define visible Help fallback for hidden/expert/config-only routes and verify the actual page/window, not only registry text. |

## CDTAG/CDSOURCE inline-split finding — corrected trigger classification

The earlier planner note correctly flagged a risk, but this source pass now identifies the trigger precisely.

| Question | Source finding |
|---|---|
| Is a pipe explicitly selected by the user? | **No.** CDTAG selects a block/tag owner (SourceTagCommand.cs:26-29) then calls TryAutoSplitNearestPipeAtOwner at :128. CDSOURCE prompts source ID/inserts an owner block then calls it at SourceBlockGenericCommand.cs:113-115. Neither route asks user to select the pipe. |
| Is the owner explicit? | **Yes.** It is the selected CDTAG block or newly inserted CDSOURCE block. The split search uses that owner's position/connection point. |
| How is the pipe chosen? | LinkService.Split.cs:154-203 loops model-space polylines, recognises pipe candidates, chooses the nearest eligible geometry, then requires split point inside an owner hitbox. Tagged-owner tolerance uses the tag radius/fallback/tolerance calculation at :258-270. |
| Is drawing changed without a separate preview/confirmation? | **Source suggests yes.** On successful candidate, the method replaces/clones pipe geometry and writes links/data inside transaction (:273-467); callers immediately invoke it after owner registration. No source-observed pipe-selection, proposal preview or confirmation appears on these command paths. Runtime result remains Unknown. |
| Does it conflict with approved direction? | **Yes, as a planning conflict.** Approved card says “Exact touch may connect; crossing/proximity never does” (existing workflow_cards.md:120-126). Owner-hitbox/nearest-pipe automatic split is broader than an explicit user-selected exact connection and needs owner review before it is preserved as a future workflow. |
| What is not claimed | This does not claim every current split is wrong, does not inspect a client drawing, and does not change active CD/PIT implementation. It records a bounded source-to-approved-direction gap. |

**Required owner contract:** retain a direct source-item action; make candidate pipe/endpoint and exact evidence visible; treat any non-exact/crossing/ambiguous candidate as no connection; provide Preview / Connect / Keep unlinked / Cancel; record manual override/source/revision; apply one explicit drawing action with Undo and save/reopen check. This is a proposed review contract, not an approved redesign.

## Retirement state

| State | Result |
|---|---|
| Tim-approved permanent retirements found in this pass | Structural `ST6-14` approves removal of **`STR` and `BWT` from ordinary command registration**. Their source/alias evidence remains retained through transition. Civil permanent-retirement status remains separately governed by Civil cards. |
| Config-deprecated aliases | Three Civil and one Structural metadata rows have replacement names. They remain retained compatibility routes pending accepted replacement. |
| Proposed retirements | **None.** This map proposes access clarification and owner contracts only. |
| Active-owner exclusions | CD/PIT polish is Claude-owned and Water Tank window work is Claude-owned (ownership_and_migration_supplement.md:19-20). Root owns shared Manager/settings/help/project-QA/issue interfaces. |

## Coverage limits

- This pass reads source configuration/declarations only. It does not open AutoCAD, run a build/test, inspect deployed bundles, generate a CUIX, access client data, or inspect LISP/native/ribbon installation state.
- Dynamic menu/layout, code-built dialog and external owner-worktree routes need their owner’s own source/review evidence.
- Registry row count, source declaration count, and the ten approved suite-tool rows are different populations and must stay separate.

**Built:** not assessed. **Tested:** no runtime or AutoCAD testing. **Installed:** not assessed. **Tim-accepted:** not assessed.





