# CE Civil overnight morning handoff — 25 August 2026

**Status:** final handoff prepared for 08:30. Source candidate only; not deployed to AutoCAD.

Repository state: current shared branch `codex/civil-check-current-drawing` at base HEAD `0f77aa480687f1fd16083515c23e415bd212dc91`, with uncommitted wider Civil work preserved. No overnight release commit was invented from the dirty shared checkout. The clean lag oracle remains separately preserved and pushed at `codex/civil-linkservice-bounded-scans` / `851707b1e2bcfcbe58f3378b3c9a2cd87fbbe05c` / tree `c999950920eb97065afd2539bdad831393013e95`.

## Outcome first

The bounded Civil candidate now behaves more like normal AutoCAD while retaining CE ownership:

- linked pipe labels, arrows and invert text keep their normal grips and gain distinct CE placement grips;
- Flip Side uses the same above/below drafting footprint for newer MText and older proven CE text;
- linked child placement, identity and displayed-field meaning persist without changing the visible pipe type;
- ordinary and Structural drawings avoid Civil drawing-wide COPY/MIRROR/MOVE scanning;
- cancelled, empty and unchanged commands perform no clone reconciliation or cache rebuild;
- genuine CE COPY protection remains bounded to actual verified CE objects;
- `CD` keeps a reasonable route and records each physical end as Connected, Proposed, Ambiguous or Unresolved;
- where CD already knows a stable pit/source owner, that identity is stored before endpoint review so the connection is not downgraded to a proximity proposal;
- the older nearby-pit compatibility search now fills only a missing owner and cannot overwrite a proven downpipe/source identity;
- choosing not to plot a pipe in the schedule no longer removes it from CE's Civil data; it remains a linked network item with `Include in schedule = No`;
- a 2D meeting with another CE pipe is stored as plan-contact evidence, never silently promoted to a proven physical or hydraulic connection;
- mixed endpoint conditions are all explained instead of one warning hiding the other end; and
- a stale schedule row cannot promote an ordinary polyline into a CE pipe junction candidate.

## Exact Civil files changed for this bounded overnight slice

- `Modules/Drainage/Models/PipeEndpointConnectionReviewData.cs`
- `Modules/Drainage/Commands/CdCommand.Schedule.cs`
- `Modules/Drainage/Services/ExternalMutationCommandPolicy.cs`
- `Modules/Drainage/Services/PipeAttachmentFlipGripOverrule.cs`
- `Modules/Drainage/Services/LinkService.PipeAttachmentGrip.cs`
- `Modules/Drainage/Services/LinkService.ExternalAttachmentMoves.cs`
- `Modules/Drainage/Services/LinkService.PipeOwnership.cs`
- `Modules/Drainage/Services/LinkService.Cache.cs`
- `Modules/Drainage/Services/LinkService.Persistence.cs`
- `Modules/Drainage/Services/LinkService.Reactors.cs`
- `Modules/Drainage/Services/LinkService.RepairAudit.cs`
- `Modules/Drainage/Services/LinkService.SourceMoves.cs`
- `Modules/Drainage/Services/LinkService.State.cs`
- `Modules/Drainage/Services/LinkService.Utilities.cs`
- `Modules/Drainage/Services/LinkService.cs`
- `Modules/Drainage/Services/PipeEndpointConnectionPlanner.cs`
- `Modules/Drainage/Services/PipeEndpointConnectionReviewService.cs`
- `Modules/Drainage/Services/PipeEndpointConnectionReviewFormatter.cs`
- `Modules/Drainage/Services/ProjectDataService.Mutations.cs`
- `Modules/Drainage/Services/SettingsService.cs`

Exact bounded regression files:

- `Modules/Drainage.Tests/Services/PipeAttachmentFlipGripContractTests.cs`
- `Modules/Drainage.Tests/Services/PipeAttachmentLinkedEditContractTests.cs`
- `Modules/Drainage.Tests/Services/PipeAttachmentNativeMoveContractTests.cs`
- `Modules/Drainage.Tests/Services/PipeAttachmentSemanticContractTests.cs`
- `Modules/Drainage.Tests/Services/PipeEndpointConnectionPlannerTests.cs`
- `Modules/Drainage.Tests/Services/LinkServiceCommandPerformanceContractTests.cs`
- `Modules/Drainage.Tests/Services/LinkServiceDebugSilenceContractTests.cs`
- `Modules/Drainage.Tests/Services/ProjectDataUndoReloadTests.cs`

The shared checkout also contains other pre-existing Civil work from the wider programme. Those files are not silently claimed as part of this bounded grip/lag/endpoint result; a clean release checkpoint still has to separate and audit the accepted set before packaging.

Derived Civil records updated:

- `C:\CE_DrawingIntelligence\03_Review_Cards\CE_CIVIL_LINKSERVICE_COMBINED_ADMISSION_MAP_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CE_CIVIL_ENDPOINT_MODEL_CHALLENGE_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CE_CIVIL_PIPE_DIRECT_MANIPULATION_COMMAND_CARD_02.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CE_CIVIL_UNIVERSAL_CDEDIT_AND_LINKED_FIELD_CONTRACT_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CIVIL_PROJECT_MANAGER_AND_DELIVERY_OUTCOME_MAP_01.md`
- `C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_BEHAVIOUR_HANDOFF_FOR_CLAUDE_UIUX_01.md`
- `C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_OVERNIGHT_AUTOCAD_ACCEPTANCE_CHECK_01.md`
- `C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_ADDITIONAL_PLAN_INTAKE_01.md`
- `C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_CLAUDE_UIUX_START_PROMPT_01.md`
- `C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_OVERNIGHT_MORNING_HANDOFF_2026-08-25.md`

## Mechanical checks

- expanded bounded Civil checks: **113/113 passed net10** and **113/113 passed net48**, including the guard that full-drawing legacy clone repair remains explicit `CDREBUILD` work only;
- focused endpoint checks: **19/19 passed net10** and **19/19 passed net48**;
- final AutoCAD-target net8 Release source build at 04:47: **0 errors** (100 existing warnings), DLL SHA256 `33772A0536BEF3BABEFA2C9E75B7A6221A5DE1453EA871600C837E3D63D63658`;
- final full net10 Civil run: **3689 passed, 5 known unrelated failures, 13 skipped, 3707 total**;
- bounded source/test files were unchanged after 04:46, so the 06:00 full replay and recorded payload hashes correspond to the same candidate source;
- the five failures remain repository/module-state guards: Manager module absence in two duplicate-command checks, Structural command-count drift, differing `Copy Rotate.lsp`, and the existing `18.50`/`18.51` formatting expectation;
- every build/test used the skip-live-bundle flag; and
- safe net10 build and non-live Modern payload match exactly: `1DB025E59972B4218F5FFD09A06F7E56AD4282EAE356CC11698A3F36236FDF5B`;
- safe net48 build and non-live Legacy payload match exactly: `242E339B43D2BF46F55DAD14F346DA5C2B5A4E9B06A3663D350BA138C7F5A938`;
- live Modern remains `BE8C6109C65661119FF90C781D7E619EC674736DCEB7E5EA71A95C443B721DB9` and live Legacy remains `43A27232539E13745476212325D3E4E5367EF16FE6F8FD0E1F9DE2637CFB6B84`, proving no overnight deployment occurred.

## Source-complete but not field-proven

- distinct child grips and Flip Side on real older/newer drawing text;
- save/reopen and one-Undo placement behaviour in AutoCAD;
- no perceptible Civil lag in an ordinary 200+ polyline drawing;
- genuine CE COPY/MIRROR protection in a disposable Civil drawing; and
- downpipe/source-to-mid-pipe, free-end, ambiguous and overlapping-Xref route behaviour.

Use the prepared acceptance check after deployment:

`C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_OVERNIGHT_AUTOCAD_ACCEPTANCE_CHECK_01.md`

## Questions saved for Tim — do not block overnight work

1. **Plan-contact tolerance:** the current evidence reviewer treats a drawn endpoint within 2 mm of a verified CE pipe as 2D plan-contact evidence. It never calls that a proven physical connection. Approve 2 mm for CE millimetre drawings, or require exact AutoCAD snap coincidence?
2. **Confirmed mid-pipe junction:** when the user accepts `Connect here`, should CE initially store a logical branch point without splitting the visible pipe, or split the pipe into two connected physical pipe items? This must be a deliberate workflow choice.
3. **Older unlinked Civil-looking geometry:** recommendation is to keep it as normal AutoCAD geometry and show `Not linked — review link`, never silently adopt it. Confirm this as the migration rule.

## Known safe remaining gaps

- exact Xref endpoint evidence remains Unresolved; a future immutable Xref candidate must carry the attached Xref instance, source drawing/revision, external entity identity and transformed point without writing into the Xref. Overlapping references must remain separate candidates rather than being chosen by proximity;
- locked/reference availability-at-review is now stored separately from candidate identity, so contact evidence remains visible without changing the protected pipe; any future drafting action must recheck current protection first;
- no endpoint-resolution UI is built; Claude owns its visual design after this behaviour handoff;
- the combined dirty Civil worktree is not yet a clean audited release checkpoint;
- no independent Claude source audit, packaging or deployment has occurred; and
- no engineering value, hydraulic direction or LPD is selected by this endpoint work.

## One simple morning action

Do **not** deploy the dirty combined checkout directly. Tell this Control Room:

`Proceed with the clean Civil checkpoint and independent audit prompt.`

The Control Room will isolate the accepted Civil files, return an exact head/tree and give you the required copy/paste independent Claude source-audit prompt. Only after that audit and the new non-live package audit pass should AutoCAD be closed for a verified deployment. Then follow Parts A–F of the prepared acceptance check and reply with `PASS` or a short description of anything different.

## Additional-plan intake

Use:

`C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_ADDITIONAL_PLAN_INTAKE_01.md`

Priority additions remain mixed Civil/Structural plans, multi-level continuations, pumped/charged systems, multiple LPDs, difficult council chains, old drafting and known CE ACAD failures.

## Claude UI/UX next step

The read-only design-start prompt is ready at:

`C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_CLAUDE_UIUX_START_PROMPT_01.md`

It starts Claude with visual design and implementation planning only. UI source work remains blocked until Tim approves the visible design and the Civil Control Room supplies an exact clean checkpoint and permitted UI file list.

The read-only Claude design pass can begin immediately after this handoff and can run while the clean Civil checkpoint/audit path is being prepared; it does not depend on deployment. UI building still waits for Tim's visible approval and the exact clean source boundary.

## Honest progress

- bounded overnight source/test scope: **about 90%** — mechanical work is strong; live acceptance and release control remain;
- live deployment/AutoCAD acceptance: **0% overnight by design**;
- complete long-term Civil Drawing Intelligence end goal: **not complete** — this is one controlled foundation slice, not the finished Civil product.
