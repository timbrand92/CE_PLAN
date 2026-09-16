# Structural end-user workflow cards

**Planning-only cards, grouped in the order a structural drafter works through a job.** The source command ledger is the complete declaration-level index: [structural_source_command_window_ledger.md](structural_source_command_window_ledger.md). Each `W` card below owns every ledger row carrying that `W` reference, including aliases and hidden/expert rows. A source declaration or a registry description is not proof of current AutoCAD behaviour.

**Approved-card precision supplement:** [structural_approved_card_reconciliation.md](structural_approved_card_reconciliation.md) preserves the exact ST-03/ST-04/ST-05/ST-06/ST-09 workflow decisions and corrects the FST action split. It supplements, and takes precedence over, generic retention wording in these new cards.

## Rules shared by every card

- Keep proven working drafting routes until a reviewed replacement passes an AutoCAD acceptance scenario. No source route is retired by this document.
- Distinguish a drawing observation, source/markup proposal, engineer-confirmed structural choice, manual/pinned choice, `Assumed`, `Unknown` and presentation-only label position. A newer file or a nearby object never becomes an engineering decision by itself.
- Existing Structural approvals govern framing/foundation intent: background geometry can suggest a review item but cannot establish bearing, load, support, connection, setdown depth, member size or adequacy.
- Native AutoCAD locked-layer, Xref, REFEDIT and foreign-object protections remain in force. A preview must state when it cannot edit its selected source.
- **Cancel/Escape:** must remove temporary preview only. **Accept:** one drawing change is one Undo. **Save/reopen:** must preserve only confirmed identities, source/revision and manual presentation decisions. These are future acceptance requirements unless this card says source evidence only.
- Tim-approved operation-scoped **Edit this only / Edit together** must be available where coordinated Structural edits are reviewed. Edit-this-only keeps relationships for later QA unless the user explicitly Disconnects; it neither propagates nor auto-catches-up later.

| Status wording | Meaning here |
|---|---|
| Source-observed | Command/window/field/action was read in this source pass. Runtime and acceptance remain Unknown. |
| Keep/Modify proposal | Preserve the route while its end-user workflow is reviewed; not approval to change it. |
| Expert-review | Hidden/diagnostic/experimental route. It remains available for controlled review and is not a normal drafting route. |
| Root interface | Another owner handles shared project, Manager, sheets/issue or AI behaviour. This card only protects the Structural-facing handoff. |

---

## W0 — Start work, settings, help, notes and job time

| Review item | Source-observed route / fields | Intended end-user result |
|---|---|---|
| Structural entry and command discovery | `CESTRUC`, `CETOOLS`, `CETOOLSTOGGLE`, `CE_HELP`/`CEHELP`/`?CE`, `CE_VERSION`, `CEADMIN`; `StrucSuiteWindow`, command palette/help and palette source. The main palette names Job Time, Sheets, Notes, Checklist and Commands tabs; its source has Pause/Resume, Stop, Settings and View Reports actions. | A drafter can open the existing Structural work surface or search the matching command without a compulsory new setup wizard. The one suite shell/Manager boundary remains root-owned. |
| Structural settings | `CESETTINGS`, CEADMIN SETTINGS choices for general, drafting, bracing, rafter/joist, supports, Xref and beam areas; `CeSettingsDialog`/`SettingsDialog`. | Settings remain the visible authority for configurable drafting values. A card must identify whether a field is an office setting, a project decision, an assumption or a manual override before it affects drawing output. |
| Notes/checklist | `CENOTES`, `CECHECKLIST`, `CEEXPORTNOTES`, `NotesBrowserDialog`, `NoteEntryDialog`. Registry describes note browsing, category/priority/resolution and export. | Notes stay a user-controlled job record. Export asks format and destination; it does not quietly publish or import notes as structural instructions. |
| Time | `JOBTIMEREDIT`, `JOBTIMERDEBUG`, `TimeEntryBrowserWindow`, `FloatingTimerWindow`, `IdlePromptDialog`; palette shows job/time/session status. | Time review/edit is separate from drawing engineering. The debug route is expert-only and must not expose private job details in a shared export/log. |
| Administration | `CEADMIN` source prompts UI/DEBUG/BRACING/SETTINGS/SYSTEM/WORKSPACE; source branches include system/deploy/install wording. | Keep the command source observable, but deployment/install actions are root-owned and out of this Structural planning scope. No window redesign or release action is proposed here. |

**Classification:** Keep/Modify proposal for normal help/settings/notes/time routes; Expert-review for debug/admin system paths. **Unknown:** actual palette/ribbon visibility, persistence and help completeness.

**Future acceptance:** on a synthetic drawing, open Help filtered to a command family; open Settings and return without changing a field; add then cancel a note edit; open job-time history without any project metadata being exported; close/reopen each surface and verify only deliberate saved changes remain.

## W1 — Recognise the Structural workspace and job context

| Review item | Source-observed route / fields | Intended end-user result |
|---|---|---|
| Workspace shell | `CESTRUC` / UI command routes, `StrucSuiteWindow`, `MainPalette`, `CeProjectSetupDialog`, palette job header fields. | The existing workspace can show drawing/job context, but source fields do not prove an identity match. An ambiguous job remains unresolved rather than being silently attached to another project. |
| Project setup interface | `CeProjectSetupDialog` is a discovered Structural UI surface; shared project authority is root-owned. | Structural routes read the shared project decision and clearly say which data is project-wide versus drawing-specific. This card does not create a rival project record or a folder-first gate. |
| Background/view context | Approved Structural journey requires plan/elevation/section source, scale/orientation, represented level, source/revision and confidence to remain distinct. | The drafter can inspect/correct context before it informs a proposal. A wall, void or setdown remains source geometry until confirmed. |

**Classification:** Root interface. **Unknown:** current project-recognition and cross-drawing persistence behaviour.

**Future acceptance:** open two synthetic drawings with different context; inspect each without merging their data; choose the correct drawing context explicitly; Escape a context preview; save/reopen and check that source identity and manual/context decisions remain distinguishable.

## W2 — Prepare backgrounds, layers, walls and site context

| Review item | Source-observed route / fields | Intended end-user result |
|---|---|---|
| Layers and Xrefs | `LAYERMANAGER`, `LAYERMANAGERXREF`, `XRL*`/Xref-related registry routes, `LayerManagerWindow`, `NativeXrefLayerService`; CEADMIN exposes an Xref settings area. | Retain layer/Xref inspection and any existing safely reviewed controls. An Xref/background can be inspected and used as evidence, but it is never detached, unlocked, exploded or rewritten by an inference workflow. |
| Architectural wall/context | `LoadBearingWallCommands.cs`, wall/service source and approved journey’s wall/opening/void/setdown/elevation requirements. | Show source object, level, interpretation and confidence separately. A wall is not automatically bearing; an opening/void/setdown is not an automatic structural design input. |
| Site/linework | `BATTER`, `BATLINE`, and supporting breakline/utility routes. | Existing drafting linework remains a direct route. Any prospective automation should preview only the selected geometry and preserve ordinary editing. |

**Classification:** Keep/Modify proposal for source routes. **Wrong/missing:** an accepted architectural interpretation workflow is not established by declarations. 

**Future acceptance:** inspect locked local linework, an Xref wall, a void/hatch ambiguity and conflicting plan/elevation notes. Confirm they remain read-only/evidence until selected; cancel overlay; use an allowed local layer operation and Undo it once.

## W3 — Frame the job: beams, rafters/joists, marks and local edits

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Beam placement | `1`, `2`, `4`, `5`, `BDL`, beam settings `8`; `BeamPlacementCommands`, `BeamSettingsDialog`, `StrucSuiteWindow` Beam tab. | Preserve regular/lower/special/offset beam distinctions and familiar prompts. The approved shared feedback direction requires live placement evidence, final-position recheck, clean cancellation and no invented bearing/span limits. |
| Beam local tools | `BEXTEND`/`BEXT`, `BSET`, `BSETRESET`, `BSETLIST`, `BTX`, `BMT2TXT`/`BTXT2MT`, plus CE text tag routes in ledger W3/W5/W7. | A selected beam can be edited without forcing a global rebuild. Preserve beam-only COPY behaviour: its copied label stays with it and no support relationship is guessed. |
| Rafter/joist | `R1`, `FJ1`, `RJSET` and source rafter/joist settings. | Preserve existing marker/settings routes pending a reviewed complete interaction. They must identify level/source and drawing output rather than infer a load path. |
| Contextual edit and grips | Approved journey: selected beam shows mark, size, level, linked supports and source instruction; endpoint/body/label/support grips have explicit preview actions. | Endpoint moves preview the affected connection; body moves owned label with the beam; label move is independent and remembered; support move highlights affected beams without stretching them; explicit connection changes preview first. Escape changes nothing; each accepted grip action is one Undo. |

**Classification:** Keep/Modify proposal. **Current source evidence:** commands/settings/palette exist. **Unknown:** live grip implementation, current linked-data persistence and full DrawingCore/native interaction route.

**Future acceptance:** synthetic framing plan: place one of each beam type; preview a support relationship but leave one unresolved; move endpoint/body/label/support separately using Edit-this-only and Edit-together; verify no nearby support becomes connected by proximity; test beam-only COPY; save/reopen and check label placement, source decision and quiet QA mismatch record.

## W4 — Supports, bracing and comparison proposals

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Supports | `C1`, `C2`, `DS`, `DS1`, `SC1`, `SC2`, `SDS`, `SDS1`, `STS1`, `TC1`, `TDS`, `TDS1`, `TS1`, `TTS1`, `SUPTEXTAUTO`; `SupportBlockCommands`. | Keep the established support command family and its output types until reviewed. A chosen support may be linked only by explicit/confirmed association, not endpoint proximity. |
| Bracing | `AB`, `BB`, `BT1`, `ABS`/`ABSWITCH`, `ABFLIPAUTO`, `STRUCAB`, `STRUCBB`, `STRUCABS`; source bracing settings/action routes. | Retain A/B/transition and flip/switch routes while reviewing their actual prompts, rotation and layer effects. The approved support-rotation direction is preview + manual override + no guessing at ambiguous walls/corners. |
| Experimental auto-support | `CEAUTOSUPPORT`, Clear, Reference and ReferenceClear are hidden expert routes. Registry says preview markers/reference snapshot are non-issued comparison aids. | Preserve strict preview-versus-accepted distinction. It may propose locations from selected evidence; it must not place real supports, alter originals or imply structural adequacy. |

**Classification:** Keep/Modify proposal for direct support/bracing commands; Expert-review for auto-support/reference. **Wrong/missing:** full source-qualified support-rotation and approved connection workflow remains unverified.

**Future acceptance:** use a synthetic wall corner/two competing wall directions; run only the preview route, inspect marker/reference layer and clear it; select one support to rotate with manual angle override; accept one explicit connection then Undo; verify a crossing/nearby beam is not linked.

## W5 — Footings, slab and foundation record

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Foundation manager | `FST`, `FEDIT`, `BP`, `SCREWPILE`, `STUMPFOOTING`, `FDELETE`, `FADOPT`, `FREGEN`, `FREGENALL`; `FoundationService`, `FstManagerWindow`. | Preserve manager/edit/regeneration entry points while reviewing actual fields, source/geometry scope and object relationships. A regenerate action cannot be assumed to be a safe whole-job update. |
| Foundation detail/text family | Foundation dispatch in `CeTextCommands`: `THC`/`FTHC`, `PFC`/`FPFC`, `SF`/`FSF`, `REB`, `RIB` and the other footing/tag aliases captured in ledger W3/W5/W7. | Keep known drafting codes but group them by footing type and drawing output for review; no broad retirement of terse commands. |
| Slab | `BSSLAB` and `SlabDetailCommands`; registry marks some slab detail capability as planned/placeholder. | A placeholder is not a working route. Keep its identity visible, identify the source/Unknown status and do not present a planned field set as built. |
| Approved foundation editing | Journey approval requires contextual property/grip review, wall/edge/void/setdown proposals, confirmed supports, previewed edge-beam/hatch/annotation changes and missing-depth/thickness warnings. | A confirmed footing mark/size may feed schedule review; source geometry does not fill missing depth/thickness. Independent edits do not propagate or erase relationships; they surface quiet QA discrepancies. |

**Classification:** Keep/Modify proposal for source manager/text routes; `BSSLAB` status follows its registry placeholder, not a runtime claim. **Unknown:** complete coordinated foundation editing and schedule linkage.

**Future acceptance:** synthetic footing/slab with a wall, void, setdown of unknown depth and one Xref edge. Propose then reject an outline; confirm one supported wall; Edit-this-only a footing mark and see QA mismatch without propagation; Edit-together a reviewed slab edge and preview affected hatch/annotation; Undo, save/reopen.

## W6 — Sections, reinforcement, columns and steel details

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Steel/timber sections | `SBEAM`, `SPEDITSECTION`; `SteelSectionPickerDialog`; registry describes type/catalogue selection and insertion point. | Retain section selection, drawing-scale output and any stored section identity. Catalogue presence is not design adequacy or automatic selection. |
| RC beams/columns | `RCBEAM`, `RCRECTCOL`, `RCCIRCCOL`; `RCBeamPickerDialog`, `RCMemberDialog`, `RCLigDialog`; registry exposes dimensions, bar/tie/stirrup/cover and insertion prompts. | Dialog fields must remain visible for review before drawing. A proposed/typed dimension or reinforcement entry needs its source/Assumed/Manual state; no engineering default is invented. |
| Rebar/reinforcement | `CE_REBARLINE`, `CE_REBARCIRCLE`, `CE_STIRRUP`, `CE_BARWEIGHT`, `LIGS*`, `COLTIES`, `WALLREO` and reinforcement-detail source families. | Retain separate line/circle/stirrup/tie/detail routes. Registry placeholders remain Missing/phase-labelled until source/runtime review proves otherwise. |
| Steel details | `STLCONN*`, `PORTAL`, `TRUSS`, `PURLINS`/`PPURLINS`, `ANGLES`, `BOLTS`, `BRACE`/`SWBRACE`, `BASEDET`, `GUSSETS`, `RIDGE`, `KNEE` and related `SteelworkDetailCommands`. | Preserve every existing command identity in ledger. Detail/library search, source/version, suitability confirmation and inserted/project-copy revision must be reviewed before replacement. |
| Markers | `CE_SECTIONMARK`, section mark commands and related drawing details. | A section mark is presentation/coordination evidence; it must not fabricate a section/detail relationship. |

**Classification:** Keep/Modify proposal where source route is present; Missing/Unknown for registry-declared Phase/placeholder routes. **Future acceptance:** choose steel, RC beam and RC column fixtures; inspect each picker’s fields; Cancel no insertion; place selected detail once, Undo; set one manual/pinned reinforcement value with a reason; save/reopen; verify source/version and label placement stay visible without proving calculation adequacy.

## W7 — Annotate the structural drawing

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Dimensions and leaders | `AD`, `DSET`, `DSET1`, `DUP`, `LD`, `Q`, `QD`, `CE_MLEADERRIGHT`, `CE_MLEADERLEFT`; `DimensionCommands`, `MLeaderCommands`. | Preserve direct drawing commands and their familiar prompt/selection output. A label position is presentation-only unless the established label contract makes its text authoritative. |
| Levels/section marks | `CE_LEVELMARK`, `CE_LEVELUPDATE`, level-mark command family and `CE_SECTIONMARK`. | A level/mark is linked only where a reviewed source relationship exists. Edited text must be parsed/reconciled or shown as a conflict; it is not silently overwritten. |
| Hatches and breaklines | 19 hatch declarations, `BL`, `BreaklineCommands`, `HatchCommands`. | Keep pattern/linework family distinctions. Selection is explicit; protected/Xref content stays protected; cancel clears preview. |
| Text tags | The broad CE text tag aliases in `CeTextCommands` include beam, support, footing and annotation tags. | The ledger preserves every alias under W3/W5/W7. Detailed workflow review groups them by their drafting result, rather than forcing users into an alphabetic command list. |

**Classification:** Keep/Modify proposal. **Unknown:** exact live text/label ownership and refresh behaviour.

**Future acceptance:** place a level, section mark, dimension/leader, hatch and beam/footing tag on a synthetic drawing; manually move one label; update a confirmed member in Edit-together; confirm only dependent label/schedule review occurs; Escape a hatch preview; Undo one accepted item; save/reopen.

## W8 — Build, import and review schedules

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Excel/MText | `XCLMTXT`, `EXCELMTEXT`, `EXCELMTEXTNEW`, `XCLMTXTINDEX`, `EXCELMAPFLOOR`, `EXCELMAPFLOORAREA`; `ExcelSheetPickerDialog`, `XclmTxtDialog`, advanced editor; registry describes file/sheet/floor mapping/import prompts. | Retain picker, mapping and advanced-edit routes. Selected source sheet, range/mapping and output are visible before accept. Source import does not overwrite confirmed drawing labels or structural choices. |
| Structural schedules | `STRSCHEDCREATE`, `STRSCHEDREFRESH`, `STRSCHEDSYNC`, member-label source route. | Keep create/refresh/sync distinct. A refresh must identify its source record, manual row/presentation overrides and dependencies; it may not quietly generate an issue output. |
| Schedule relationship | Approved journey requires member mark/size changes to update schedule in coordinated mode and flag affected details for review. | Edit-this-only retains relationship and creates quiet QA mismatch; Edit-together uses the reviewed coordinated update. No blanket catch-up occurs afterwards. |

**Classification:** Keep/Modify proposal; `EXCELMTEXTNEW` is registry-hidden/deprecated with `XCLMTXT` replacement and stays visible for migration review. **Unknown:** real Excel/file compatibility, rendered output and cross-drawing persistence.

**Future acceptance:** import a synthetic spreadsheet via picker, inspect mapping then Cancel; accept one mapped schedule, set a manual row/presentation override, Edit-this-only the linked member and see QA mismatch, then use a reviewed coordinated member change; preview/create/refresh/sync; open rendered output; Undo/save/reopen.

## W9 — Review markup and drawing-intelligence proposals (Structural interface)

| Review item | Source-observed route / fields/actions | Structural handoff contract |
|---|---|---|
| Markup commands | `CEMARKUP`, `CEMARKUPBENCH`, `CEMARKUPLOAD`, `CEMARKUPPARSE`, `CEMARKUPPLAN`, `CEMARKUPPREVIEW`, `CEMARKUPREGISTER`, `CEMARKUPRUN`, `CEMARKUPSTATUS`, `CEMARKUPUNDO`, `CEMARKUPVIEW`. | Root owns whole-suite AI/drawing-intelligence behaviour. Structural cards require that an interpreted item shows source page, type/intent, confidence, status and the proposed matching command before any drawing change. |
| Preview surface | `MarkupPreviewWindow` source exposes page picker, Open PDF, Refresh, raw/overlay canvases and a grid with Page, Type, Command, confidence, approval, status and text. | Preserve review-before-apply. Selecting a row may highlight the proposal/evidence, but cannot imply that a wall/support/load path is confirmed. |
| Architectural/load-path context | Tim-approved journey requires plan/elevation/section relationship, candidate structural path and missing/conflict visibility. | A candidate path stays a traceable proposal. No structural analysis, numerical load, bearing, connection or adequacy is inferred or reported by markup automation. |

**Classification:** Root interface. **Future acceptance handoff:** synthetic marked page with one clear beam note, one uncertain size and conflicting source item; select each row, inspect source/overlay, approve only clear item, leave uncertainty in Needs clarification, Cancel remaining preview and save/reopen revision evidence.

## W10 — Sheets, issue and publication (Structural interface)

`CeSheetsWindow`, manager/sync/validation/publish windows and `SheetsCommands` are declared/observed and indexed in the ledger. Root owns sheets, issue, shared project authority and publication behaviour. Structural planning requires only this interface contract: select an explicit output set; show source drawing/revision, selected Structural records and manual presentation choices; preview the real artifact before issue; preserve previous issue identity; warning/decision path for mismatches; no automatic issue or overwrite from a drawing refresh.

**Classification:** Root interface. No competing sheet/issue card, command redesign or implementation claim is made here.

## W11 — Inspect, recover, export and migrate safely

| Review item | Source-observed route / fields/actions | Intended result and preservation door |
|---|---|---|
| Inspect/recovery | `CEINSPECT`, `CERECOVERY`, command/diagnostic/utility sources; `CERECOVERY` source lists stale snapshots and prompts Clear all [Yes/No]. | Inspection is read-only. Recovery identifies incomplete command state and lets the user retain/clear the named snapshot. It must not replay drawing changes or treat a snapshot as a confirmed structural decision. |
| Beam migration/debug | `BEAMLINKMIGRATE`, `BEAMLINKDEBUG` are hidden expert source routes. Registry describes legacy beam/link diagnostic/migration. | Preserve only for controlled review. Migration must scan/preview scope, respect protection, identify source/relationship uncertainty and make accepted changes reversible; no proximity-created support link. |
| Utility/export | `CEPROPS`, `CEEXPORT*`, `STRUCEXPORTPDF`, `STRUCLINKTEXT`, `STRIPLAYERSMERGE`, drawing-note export, report/utility surfaces. | Retain explicit file/type/selection prompts. Export is not issue; layer merge/link text must state selection, preview, protected-content limit and Undo/reopen behaviour before change. |
| Diagnostics | CEADMIN diagnostics, `CEDEBUG`, `JOBTIMERDEBUG`, reports/health source routes. | Expert diagnostics must report facts without copying sensitive job/client material into a shared planner or export. They do not prove a drawing is engineer-checked. |

**Classification:** Expert-review or Keep/Modify proposal by registry/source visibility. **Future acceptance:** synthetic legacy beam with one explicit support and one nearby unlinked support; run scan/preview, reject then accept one permitted migration, Undo, reopen; view recovery snapshot and retain it; export a synthetic note/PDF to a chosen folder; verify no issue status or source overwrite occurred.

## W-legacy — Legacy-port command declarations

`LegacyPortCommands.cs` contributes 32 declarations captured individually in the ledger. They are not a soundness finding, an automatic retirement list or evidence of runtime support. Before any consolidation, each declaration needs a small review card recording actual prompt, selection, drawing output, linked route, protection/Undo/reopen behaviour, user discovery and a representative test. Until then: **classification = Unknown / retain for review**.

---

## Cross-card acceptance batch

Run later on a synthetic structural job only, after implementation work and before Tim acceptance:

1. Open workspace/help/settings; inspect context/background without adopting it.
2. Draft beam/support/bracing/footing/section/annotation/schedule in that order, confirming source/Unknown/manual states are visible.
3. Use one allowed direct edit, one Edit-this-only change and one Edit-together change. Confirm they have different, recorded outcomes.
4. Exercise preview, Cancel/Escape, one accepted Undo and save/reopen across framing, foundation, detail and schedule routes.
5. Inspect markup/issue interfaces without applying or issuing; leave one uncertainty unresolved.
6. Exercise Xref/locked/foreign-content cases and verify no bypass, duplicate object or inferred relationship.

**Built:** not assessed. **Automated checks:** not run. **Installed:** not assessed. **Tim-accepted:** no. These cards are proposed review material, not a change authorisation.

