# SH-04A — first shared Settings and Help implementation

**Status: approved for implementation by Tim, 10 September 2026.** Tim replied “CAN WE PROCEED WITH THIS” after the recommendation to build shared Settings/Help with immediate theme preview, save only on Apply, zero-write Discard and the complete existing Structural editor/help as a temporary fallback. This records approval of this bounded first slice; no repeat workflow approval is required. Source allocation and integration remain coordinated by First Colleague Issue Control Room. Native implementation, automated verification and AutoCAD acceptance remain outstanding; this is not deployment approval.

**Parent authorities:** [SH-04 approved decisions](../CARDS/SH-04_SETTINGS_STANDARDS.md), [existing staged implementation plan](SH-04_SETTINGS_UI_IMPLEMENTATION_PLAN.md), [Tim's current shared direction](../design/V3_UI/00K_SHARED_WORKSPACES_AND_AUTOMATIC_QA_2026-09-09.md), [49 settled visual decisions](../design/V3_UI/00E_TIM_VISUAL_WORKFLOW_DECISIONS_2026-09-07.md).

## Approved first slice

Build real Civil settings pages and shared Civil/Manager Help inside the existing Manager window. Preview theme changes immediately but persist them only on Apply. Keep the complete existing Structural settings/help route as an explicitly temporary fallback until its adapter covers every control and action. This first slice is complete only for its declared Civil/Manager coverage; the whole shared-suite requirement remains unfinished until Structural is embedded too.

No launcher-only Settings/Help page is accepted as the deliverable. No new project-settings migration, engineering default, storage authority, global reset, automatic rule adoption, publishing capability, host/installer merge or deployment is authorised by this card.

## Current experience → proposed experience

| Current source-observed behaviour | First-slice result | Classification |
|---|---|---|
| Manager Module routes Civil Settings to CDS, Structural Settings to broad CEADMIN, and has no self settings route. | Settings navigation opens actual shared-container pages. Civil opens the real owner-backed editor; Manager shows actual registry/preferences/help facts, with no invented editable policy. Structural points directly to its existing settings UI through a verified existing route. | Modify routes/presentation |
| Civil AdvancedSettingsDialog hosts AdvancedSettingsViewModel; SettingsService is its sole settings writer. | Factor reusable Civil editor content/session within Drainage; both existing dialog and Manager host use that same owner. Keep all fields, validation, reset and OSNAP access. | Keep behaviour; modify hosting |
| Civil SelectedTheme currently calls ThemeService.SetPreference immediately; Cancel writes the original preference back. | Theme is a session preview. Apply writes through the same owner; Discard/Cancel restores the previously effective appearance without writing a discarded preference. | Modify this explicit save behaviour |
| Civil CDHELP shows bundled HTML with context anchors and existing WebView2/browser fallback. | Same trusted content/context inside the shared Help area where the renderer is available; retain the exact safe external fallback if not. | Keep content/security; modify hosting |
| Structural66b has an 11-tab cloned-draft settings dialog, and separate singleton searchable command help with detail/prompts/layers/Run/Copy/expert filter. | Preserve all of it untouched in this slice. An explicit temporary legacy action opens it only when its complete embedded adapter is unavailable. No pretend empty Structural page. | Keep pending complete adapter |
| Modern host appearance comes from Manager CeManagerAppearanceService and shared approved tokens. Civil ThemeService already owns a persisted personal preference. | The shared host resolves colour once per session from the Civil owner bridge when available; all embedded content consumes that resolved palette. Without a compatible owner, use current AutoCAD theme read-only. No Manager copy of the preference. | Keep writer; modify host presentation |

### Faithful first-slice sketch

`CEMANAGER → Settings → General | Civil | Structural | Manager`

- **General:** the one visible appearance choice for the shared host, ownership Personal, draft state and Apply/Discard. No duplicate theme selector in its hosted Civil page.
- **Civil:** all existing settings controls reorganised into readable sections, using the same draft/session and validation owner.
- **Structural:** clearly states that the existing full editor is used in this interim slice; open it through the exact verified settings route. It is not an embedded-page completion claim.
- **Manager:** actual available suite/registry configuration facts and links to existing permissioned controls; no synthetic update-setting editor. Shared Help uses a real searchable content/result pane for Civil/Manager.

The ordinary target remains one fully integrated Settings and Help experience for every module. The fallback is a temporary compatibility boundary, not the finished design.

## Exact source owners and coverage obligations

Source inventory supplied by First Colleague Issue Control Room, checked against integration428d34b9/current Civil source and Structural66b23137. Source wiring is verified; no new native acceptance is claimed.

| Responsibility | Existing owner / complete retained coverage |
|---|---|
| Civil settings | Drainage Dialogs/AdvancedSettingsDialog.xaml(.cs), ViewModels/AdvancedSettingsViewModel.cs, Services/SettingsService.cs. Prompt defaults, invert placement/mirror/offsets/mask, minimum/standard grade, decimal and outlet-drop defaults, Quick Mode/zoom, OSNAP, design standards, survey, appearance, CD workflow modes and diagnostics. |
| Civil appearance | ThemeService, CeThemeResolver and existing settings Theme value. SelectedTheme's immediate persistence and Cancel restoration must be replaced by the reviewed staged session for both entry paths; no second write owner. |
| Civil help | CdHelpService + CommandRegistryService + bundled Help HTML/context anchors, HelpGuideWindow and its existing renderer/path checks/fallbacks. Search result selection preserves the exact tool/topic identity. |
| Manager host | UI/Dialogs/PluginManagerWindow.xaml(.cs), UI/ViewModels/PluginManagerWindowViewModel.cs, CePluginRegistryService and CeManagerAppearanceService. Existing Status/Module/Updates/health/support/action behaviour remains with its current owner. |
| Structural settings | CeSettingsUiService/CeSettingsDialog, cloned UserSettings, existing SettingsService.Replace: General, Beam, Joint, Supports, Bracing, RafterJoist, Rebar, Annotation, XrefLayer, System, DataAutomation. Keep66b unchanged until a separate full-coverage adapter handoff. |
| Structural help | AdminCommands/CommandHelpWindow singleton, registry search, descriptions/prompts/layers, Run, Copy, expert filter. Preserve existing routes and exact command semantics. |

Before completing the slice, create an old→new control/action mapping from the exact frozen source: field/command identity, getter, draft setter, scope, validator, apply/reset owner and destination. Every existing Civil settings binding and button action must map to an embedded control or an explicitly retained exact-scope sub-editor. A count or a launcher button alone is insufficient. Record source commit/hash and prove default-dialog versus hosted-page parity. Help mapping covers all existing topics/anchors/search/actions, not only an example article. Existing OSNAP ownership must be preserved; entering a separately owned editor resolves the current dirty draft first and never silently commits it.

## Compatible optional bridge — no new shared-DLL requirement

**Corrected source premise, 9 September:** the release owner verified that installed Structural66b Modern contains no CE_SHARED, removes the reference in source/dependencies and rejects that payload in packaging. Structural66b cannot load an older CE_SHARED first and requires no rebuild for this first slice. The actual mixed-version risk is an older/frozen Civil CE_SHARED loading before current UI1 Manager, which references CeRibbonIconService/CeRibbonIconCatalog. The intended current-source Civil/Manager pair already requires identical shared binaries and hash verification; frozen9357 must not be mixed with current Manager.

The optional versioned bridge below remains a bounded design choice for module absence/capability negotiation. It is not justified by a Structural shared-DLL dependency and does not replace the existing matched Civil/Manager packaging or native startup-order checks.

Use a bounded, versioned optional bridge between already-loaded modules:

1. Manager discovers only the agreed Civil module/entry point from already-loaded assemblies at a safe UI boundary. No disk search/load, network discovery or reflection over arbitrary public members.
2. Contract carrier uses framework types already present in every participating runtime: version/module/page identifiers plus named BCL delegates and an object/view result. No new CE_SHARED, Civil or Manager custom type appears in another module's static method signature or field. This bridge does not certify older shared-DLL compatibility of other already-integrated artwork/host code; the combined candidate must separately pass its existing load-order checks or remain unreleased. Validate contract version, required keys, delegate types and returned WPF content before use.
3. Civil constructs and owns its editor/session. A proposed contract includes CreateView, IsDirty, Apply, Discard, Dispose and resolved-theme/read-only preview notification capability. Manager hosts the returned content and routes UI events; it does not deserialize or write Civil settings itself.
4. Apply reports explicit success/failure after the existing owner validates and persists. Missing/unsupported capability never means success. Dispose detaches subscriptions; closing/reopening does not retain a stale owner/session.
5. Structural66b requires no new bridge or rebuild for this first slice. Missing/old/throwing Civil bridge uses the existing CDS/CDHELP fallback and marks the embedded capability unavailable. This is a recoverable interim state, not completion of a shared page.
6. Keep current-source Civil and Manager on the release owner's existing matched CE_SHARED packaging/hash contract. Do not add CE_SHARED to Structural or substitute an older frozen Civil package. The optional bridge adds no new cross-module custom contract type and cannot make an otherwise incompatible Manager/shared pair safe.

Technical carrier details can be refined inside this boundary without another user questionnaire, provided ownership, staging, compatibility and visible outcomes remain as approved here.

## Apply, Discard, Stay and appearance contract

- Opening/searching/switching a clean page is read-only; it neither writes settings nor changes any DWG. One settings draft/session exists per hosted Civil editor.
- All staged Civil edits remain in that session. Shared General appearance uses the same draft owner. The host receives a resolved preview palette and styles embedded content consistently; it never writes AutoCAD COLORTHEME to force its appearance.
- Dirty page/owner switch, another command request, Close, Cancel or Escape presents the quiet Apply / Discard / Stay choice. Stay retains focus/draft. Apply validates and commits through the owner exactly once; only successful completion performs pending navigation. Discard removes only this session's draft/preview and then completes navigation.
- Apply failure keeps the same values, draft and page with concise inline feedback. No saved label, navigation or closing on a failed write. No warning-based drafting lockouts are introduced.
- Do not run Apply across several module owners as an implicit all-or-nothing transaction. Resolve the current owner before entering another owner's editor; future multi-owner transactions need a separate contract.
- Theme preview never marks existing drawing content dirty. Discard restores the currently authoritative saved preference and resolved AutoCAD theme, not an obsolete hard-coded starting colour after external theme changes. Another valid settings writer changing the persisted preference during a draft must not be overwritten by Discard.
- Cancel/Escape of the retained legacy fallback preserves that legacy owner's existing contract; do not claim the new host can undo a completed external dialog's save. Existing drawings do not change from new defaults. AutoCAD Undo is not misrepresented as undoing a personal settings file write.
- Personal / Project / Office provenance stays visible. Unreviewed project/firm changes remain outside this slice; no local settings value is silently promoted to project authority. Existing validation/protections remain.

## Entrances and exact fallbacks

| Trigger | SH-04A contract |
|---|---|
| CEMANAGER → Settings / Civil module Settings | Prefer the complete compatible embedded Civil session; fall back to existing CDS only when embedding is unavailable. |
| CEMANAGER → Help / Civil help | Prefer real shared Help content/context; existing CDHELP renderer/fallback remains if unavailable. |
| Manager Structural Settings | Use existing CESETTINGS/CeSettingsUiService rather than assuming CEADMIN is a shared settings page; confirm installed command availability before changing the descriptor. If unavailable, preserve the currently registered working route and explain the limited target. |
| Manager Structural Help | Existing CEHELP command guide fallback with retained content/actions until complete Structural adapter coverage. |
| CDS | May request the compatible shared Civil page only after its complete parity checks; an explicit guarded legacy-open route prevents recursion when Manager falls back. No new public alias is invented. Retain old implementation during acceptance. |
| CESETTINGS | Currently registered by Structural66b. Do not register a duplicate Manager command or steal it through load order. Full universal command ownership/redirect needs the later approved Structural adapter/command-owner change. This first slice does not claim universal CESETTINGS routing. |
| CEHELP / CE_HELP / ?CE / CDHELP / context help | Preserve current command owners. New Manager entry links can host equivalent complete content. Full suite alias unification remains pending Structural coverage; no hidden duplicate registration. |
| Manager self Settings/Help | Show only real existing facts, preferences and documented topics. Disabled/missing capabilities are explicit; no invented configuration values or article content. |

Fallback launch first resolves the shared host draft, uses the exact retained target once and suppresses recursive delegation. A failed launch keeps the host usable and the draft intact. It does not close the only working route.

## Verification and one consolidated AutoCAD check

Automated evidence before a deployable candidate:

- Exact control/action/help-topic mapping and default-dialog/embedded-owner parity; no duplicate writer or formula.
- Apply once, Discard zero writes, Stay retains draft, Apply failure retains draft, pending navigation only after success, repeated Escape, reset scope, OSNAP transition and owner disposal.
- Theme preview without persistence; Apply persistence once; Discard after external theme/preference changes; both palettes and contrast; no retained event subscriptions after close.
- Missing/old/partial/throwing bridge and wrong returned view; matched current Civil/Manager shared hashes and real startup in both orders, with Structural independently available. An old/frozen Civil shared DLL plus current Manager is a negative package-compatibility case, not a promised recoverable bridge fallback. No new static cross-module type dependency or duplicate public command owner. Offline stand-ins do not replace real AutoCAD startup acceptance.
- No settings/project/DWG changes on open, help/search or module switch; unknown settings preserve their existing interpretation; failed persistence retains recoverable state.
- All active runtime compile lanes, focused tests, 1920×1080/1440×900 and representative DPI/keyboard checks, using mandatory non-deploy build flags. No new external UI library, build/deploy helper or package layout. Current release signing rules stay with the release owner.

Tim's single representative exercise, in the combined candidate: open Manager Settings, edit a Civil label default and preview Light; switch page with Stay, then Discard and reopen to confirm unchanged saved defaults. Repeat with Apply and confirm the next-created object uses the saved default while an existing object is unchanged. Open context Help and search another module; verify real content and the temporary Structural editor/help fallback. Repeat once with Structural loaded first, test Escape/Tab/resize, and report only failures. This is a ≤10-minute target after automated parity/compatibility evidence, not a historical backlog.

## Ownership, dependencies and gate reconciliation

This card author is the CE V3 UI task; First Colleague Issue Control Room assigns isolated Manager host and Civil owner files only after its current index/worker ownership is released. Structural66b remains unchanged and has no CE_SHARED payload; Civil/Manager shared-binary matching stays with the release owner. SlabEditViewModel/SlabEditDialog are not owned by this card or this UI task.

- Tim's newer Proceed/shared-scope directions supersede interpreting the old SH-04 “Locked, nothing starts” as a global ban on all current UI work. Approved artwork/Manager/Civil work continues; no repeat approval of colours, icons or shared destinations is requested.
- The subsequent explicit 10 September “CAN WE PROCEED WITH THIS”, in response to the concrete next-stage recommendation, approves the staged-theme write change, bounded compatible embedding and temporary first-slice fallback recorded here. The repository workflow-card approval gate is satisfied for this slice; settled scope is not reopened.
- Implementation may proceed within this card once the release owner assigns non-overlapping current-source files. Preserve current QA work and the complete retained routes. No new spend, plugin, library or deployment is authorised.
- First slice estimate after source freeze (approval recorded): 2–4 focused developer days sequential, low-to-medium confidence; one implementation worker plus root review is the conservative starting point. Fan-out is not worthwhile until the bridge/session contract is frozen because Manager and Civil work depend on it. No extra worker is started by this card. Reforecast after actual parity/compatibility tests.
- Structural embedding/full shared command unification is a distinct dependency, not included in the first-slice estimate. The universal Settings/Help requirement remains open until every module has complete embedded coverage and Tim accepts the joined experience. A fallback route or launcher-only page never closes that requirement.


## First-slice file boundary proposal — 10 September handoff

Read-only inspection used release-owner integration base 043a71f70f2abb030948502d3ac7e0e51b5c7116. The integration worktree is active, not frozen: B1 schedule-edit and B2 mixed pit-label corrections plus pure QA identity work have existing owners. No SH-04A native file is reserved or modified by this UI task. The release owner supplies the final source head and exclusive reservations after those corrections are reviewed/integrated.

| Boundary | Exact existing files proposed for implementation ownership | Dependency / completion check |
|---|---|---|
| Civil draft, validation, save result | Modules/Drainage/ViewModels/AdvancedSettingsViewModel.cs; Modules/Drainage/Services/SettingsService.cs; Modules/Drainage/Services/ThemeService.cs | Freeze one owner-backed draft before host wiring. Validate every field before mutating current settings; explicit save success/failure; preview/Discard zero writes and Apply once. |
| Civil reusable controls and safe legacy entry | Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml and .xaml.cs; Modules/Drainage/Commands/CdCommand.cs | Reuse all existing bindings/buttons. OSNAP remains its exact existing sub-editor; resolve draft before entering. CDS delegation only after full parity, guarded against recursive fallback. |
| Civil Help content/view owner | Modules/Drainage/Dialogs/HelpGuideWindow.xaml and .xaml.cs; Modules/Drainage/Services/CdHelpService.cs | Retain trusted bundled guide, exact anchors, context expiry and safe browser fallback. WebView2 stays NET8-or-later; do not introduce it into net48. Registry/content files are read-only unless an exact missing mapping is demonstrated. |
| Manager host and navigation | Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml and .xaml.cs; Modules/Manager/UI/ViewModels/PluginManagerWindowViewModel.cs; Modules/Manager/Services/CePluginRegistryService.cs; Modules/Manager/Services/CeManagerAppearanceService.cs | Wait for release-owner reservation. Preserve current Drawing Repair and held Project QA page, queued-action cancellation, document checks and visibility lifecycle. Stage navigation through Apply/Discard/Stay; Manager never writes Civil settings. |
| Existing focused tests | Modules/Drainage.Tests/ViewModels/AdvancedSettingsViewModelTests.cs; Modules/Drainage.Tests/Services/ThemeServiceWiringTests.cs and ThemeGuardTests.cs; Modules/Manager.Tests/Services/CeManagerAppearanceTests.cs; Modules/Manager.Tests/UI/PluginManagerWindowViewModelTests.cs | Extend owner tests for failure, draft preservation, complete binding parity and bridge absence/version/type/exception/disposal. New focused tests may be necessary; existing test/build infrastructure remains. |

New application classes may be factored within the assigned Drainage Services/Dialogs and Manager Services/UI directories for the reusable view/session and bounded bridge. These are proposed responsibility boundaries, not an allocation or permission to edit a concurrently owned directory. No CE_SHARED/Structural edits or new helper/build/deploy scripts are proposed. Project files change only if existing compile/page inclusion rules require it; the release owner reviews any such requirement.

Two source-observed correctness dependencies must be resolved in the approved save contract:

- SettingsService.SaveSettings() currently returns void and catches file-write failures. The present TrySaveSettings() returns true after calling it, so that return value cannot prove a saved Apply. Add an explicit result through the same writer while preserving existing callers; do not create a second serializer or falsely close on failure.
- The current view model changes multiple live settings before validating survey tolerance. Validate the entire draft first and retain a failed draft without partially changing authoritative values. Tests must cover an invalid survey value after otherwise-valid edits, as well as an unwritable settings destination.

Freeze the bridge/session contract first: versioned framework-type carrier, exact already-loaded Civil entry point, CreateView/IsDirty/Apply/Discard/Dispose and resolved-theme notification. An Apply result must represent the real persistence outcome. General and Civil share one session; Manager appearance consumes its resolved preview and detaches on disposal. Then embed complete Civil content and actual Help; later Structural embedding remains distinct. This inventory is a bounded implementation handoff, not the required final field-by-field/help-topic parity proof.


## HELP-01 coordination — subsequent release-owner allocation, 10 September

The release owner reports Tim separately approved HELP-01 and assigned task 01a08853-0385-7830-a14b-5ed252726f25 the canonical offline Help core/content/search/reading-state/launch contract in Shared/CE_SHARED/Help, in worktree help-01-offline9cf. Its authority card is currently C:/Lisp Files/CE_ACAD_PLUGIN/docs/workflows/HELP-01_OFFLINE_JOURNEY_BUILD_CARD.md (read for this coordination; not copied from the dirty planning checkout).

SH-04A consumes that single Help implementation and retains complete existing content/fallbacks. It must not build a competing Help core or second window. The earlier file proposal is therefore narrowed: Civil HelpGuideWindow/CdHelpService and CDHELP Help-route changes are not independently allocated to SH-04A. The release owner will agree the joint host/entry boundary with HELP-01 before embedding. HELP-01's CDHELP/CEHELP entry adapters are likewise held pending that boundary and Structural66b compatibility; Structural66b has no CE_SHARED payload and must not acquire one by assumption.

The no-CE_SHARED-edit boundary still applies to this Settings/UI task; separately owned HELP-01 additive work does not expand its file ownership or weaken current Civil/Manager matched-binary verification. Manager host and Civil draft/save/theme session remain future release-owner reservations. The Civil session is still the first SH-04A chunk after the active correctness fixes. Shared Help consumption follows contract review; no new native work, build or deployment is claimed by this coordination note.
