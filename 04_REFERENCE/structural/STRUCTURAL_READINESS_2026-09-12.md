# Structural readiness — 12 September 2026

## Decision

**14 September later authority/source:** the installed Modern Structural DLL is qualified to source anchor `5d723d412af1a3c34ec65b0df3b4a0f44c0c64f3` and exact PERF-01 artifact receipt, not whole-product reproducibility. Tim approved a shared native ObjectARX drawing core. [ST-NATIVE-01](workflows/ST-NATIVE-01_SHARED_STRUCTURAL_CORE.md) records that scope; [ST-NATIVE-02](workflows/ST-NATIVE-02_SOURCE_RECONCILIATION.md) reconciles finished fleet/adapter/PR #73 work before pilot selection. The earlier checkpoints below remain evidence with their original limits; do not treat them as the current installed source or as a full-rewrite instruction.

**Latest source checkpoint:** [ST-RDY-06](workflows/ST-RDY-06_AUTOCAD_READ_ADAPTER.md) is complete at `5fcf77abc97e1aec797cfe7e68f5f0be01c4c1bc`: actual internal AutoCAD reader implemented and compiled,27 offline focused tests passing on each net48/net10. This resolves the missing concrete reader backend from the earlier audit; permanent-ID storage/adoption authority and approved invocation still remain. No actual native execution, activation or deployment; older no-reader statements below describe prior checkpoints.

**13 September current implementation pass:** [fixed135-item reconciliation](STRUCTURAL_PROGRESS_2026-09-13.md) is complete as a bounded evidence review. [ST-RDY-05 captured-link/identity bridge](workflows/ST-RDY-05_READER_IDENTITY_BRIDGE.md) is source-complete at `3cff568255b1343cbd0f579b2ff40f25cda22e31` on isolated successor `codex/structural-reader-identity-rdy05`, with14 focused tests passing on each net10/net48. It does not read a live drawing, mint IDs or activate a command. The completed source/audit slices remain distinct from native integration and colleague readiness.

**13 September continuation:** [ST-RDY-04 native reader contract](workflows/ST-RDY-04_NATIVE_READER_CONTRACT.md) records the completed source audit. The selected-source reader's StableSourceId is a session locator based on a native database pointer, not a permanent engineering key. A direct connection is therefore not implemented: preserve the saved BeamLink graph and obtain separately verified identity through a nominated native owner before projection. No newer adapter, public route or identity minting was adopted. Reporting in this room now focuses on six Structural areas, Structural overall and its colleague package, with unmeasured percentages explicit.

**Latest result:** ST-RDY-03 source qualification is complete at `d716329806855a9093ee9b5d16ebe677a5c53e30` on isolated `codex/structural-readonly-projection-rdy03`; 43 focused tests passed on each of net10.0/net48. See [source result and limits](workflows/ST-RDY-02_SHARED_RECORD_CONTRACT.md). No native reader, COPY implementation, activation or deployment was added. The earlier assignment below is now complete; next work is reader mapping and lifecycle qualification on a nominated Structural source base.

**Continuation correction:** Claude review of `dbd4fffb..a17075dd` is deferred unless that newer delta is selected for integration/activation. It does not block the shared-record contract, existing-library qualification or first-slice preparation. Tim asked to continue on that basis. [ST-RDY-02 shared-record contract and fresh offline checks](workflows/ST-RDY-02_SHARED_RECORD_CONTRACT.md) is complete; ST-RDY-03 internal read-only projection is assigned to one Sol/high builder on isolated `codex/structural-readonly-projection-rdy03`. The earlier review prompt is retained for its scoped future use only. No native command or release work is assigned.

Proceed with reuse and a narrow connected-beam qualification slice. Do not rebuild the Structural engine or wait for the full historical drawing study. The first real gap is shared-support/copy lifecycle and its mapping to the shared CE records, not a lack of example projects.

This is a source/readiness review, not a fresh runtime pass or deployment approval. [Build-area organisation and model policy](STRUCTURAL_BUILD_AREAS.md) governs dispatch. Existing ST-01/ST-02 approvals and current release ownership remain binding.

```text
Existing beam engine + dormant AutoCAD adapter
                     |
     shared support / copy / label qualification
                     |
     one reviewed mapping to shared CE records
                     |
       combined drawing test -> Tim acceptance
                     |
             schedules / details consumers
```

## Source and ownership baseline

- Planning checkout: `C:/Lisp Files/CE_ACAD_PLUGIN`, `codex/CIVIL3RESEARCH`, `d017d506186729afbac9b97a050cc91c3ce8cfb8`. Existing dirty work preserved; not the current Structural delivery source.
- Release Control Room response in task `01a0722b-fcf5-7833-ac09-45c113dd24de`: current Civil/Manager integration reference is `5570ae57`, branch `codex/first-colleague-integration`, checkout `.codex/worktrees/colleague-native-release-contract`. This does not newly authorise Structural implementation or deployment on that baseline.
- Same owner records dormant beam adapter integrated as `51de5328`, sourced from independently reviewed `6bb83669..dbd4fffb`, with 61 exact blobs and 81/81 NET10 lifecycle/document/prompt checks. These are reported existing checks, not tests rerun by this review. Public activation and native COPY/Undo/save-reopen acceptance remain held.
- Completed source audit: `e7639287a8e603174c49805ce660e782334ef129` pure recovery has equivalent cherry-pick `3f0b8a77` on the integration-derived line. The 61 files across `6bb83669^..dbd4fffb` are byte-identical in `51de5328`, `5570ae57` and observed integration head `405b180ecc745b37f4f0dd3e16462c2c6934b5a7`. `a17075ddc63e43663cef43681f3d47d1ee383dda` is one additional commit: 24 Structural production/test files differ from `dbd4fffb0717f5096b58196097b35519e703d9ac`. That newer delta is not covered by the reviewed integration. No PR was found for branch `codex/structural-beam-native-adapter-a1` in the read-only all-state PR query on 12 September.
- Historical candidate check: `71af64b2` on `codex/structural-1057-canonical-replay` is a hatch-specific 1.0.59 source candidate, not whole-Structural authority; `8ac6a9cd` is a version-display slice. Design-pack head `c0ef3107` supplies planning/UI artefacts, not a runtime baseline. The old `e661ba6` / signed 1.0.44 entry is historical evidence, not a complete current-state inventory.
- Existing CE V3 UI Control Room reports that the common native card component is missing and RBL depends on it. The Foundations room must consume that shared component when available, not build a second card system.

## Drawing-record review

The following paths are relative to the named immutable Git revision; they are not claims about the planning checkout's source.

| Fact | Verified source | Consequence |
|---|---|---|
| Native DWG geometry remains authoritative; embedded meaning and rebuildable project index have distinct roles | `codex/v3-structural-manager-design-pack:docs/STRUCTURAL_LEVEL3_PLAN.md`, section 4; current D9 | No parallel geometry database; geometry captured for a proposal must be checked against the drawing before Apply |
| Visible mark is separate from identity | `5570ae57:Shared/CE.Spine/SpineObjectRecord.cs:40`; `SpineKey.cs` | Renumbering B4 is not creating a different beam; same mark alone cannot establish identity across levels/drawings |
| Shared core supports Structural Member keys and evidence/status/relationships | `5570ae57:Shared/CE.Spine/SpineEnums.cs`, `SpineObjectRecord.cs`, `SpineRelationship.cs` | Reuse this cross-module boundary. It does not itself prove a Structural DWG reader/writer or per-end support semantics |
| Legacy beam link record stores handles/attachments/orphan state | `5570ae57:Modules/Structural/Models/BeamLinkData.cs` and `Services/BeamLinkPersistenceCodec.cs` | Preserve existing storage while its replacement/adoption is held; do not quietly dual-write a new schema |
| Older rich record is explicitly non-persisted | `e661ba6:Modules/Structural/Models/ConnectedDesign/ConnectedStructuralRecord.cs:202` | Historical reusable design includes stable IDs, shared support ownership, provenance/revisions; it is not active drawing truth and is absent from this current integration tree |
| Existing command 1/2 route remains RunSimpleBeam | `5570ae57:Modules/Structural/Commands/BeamPlacementCommands.cs:45` and `:51` | A dormant adapter passing tests does not qualify the active user workflow |
| Legacy support-move path asks for one owner beam | `5570ae57:Modules/Structural/Services/BeamLinkService.AttachmentUpdates.cs:180` | Cannot claim all connected beam ends update for a shared support; reconcile against ST1-13/ST2-10 |
| Legacy clone handler clears links and marks the beam orphaned | Same file, `ProcessClones` at `:274`, clearing at `:325` | Does not satisfy complete copied assembly relationships in ST1-14. This is source evidence; whether enabled in Tim's installed session was not measured |
| Key helper comments must not dictate copy semantics | `5570ae57:Shared/CE.Spine/SpineKey.cs:7`; `SpineObjectRecord.WithHostHandle`; `SpineUpgradePlanner` | Some comments describe stable identity through copy; upgrade code replaces duplicates. New independent member COPY needs a new key, whereas another representation of the same member is a different operation. Never use WithHostHandle as proof that native COPY identity is correct |

## Minimum shared contract before dependent builds

Reuse existing mechanisms; the exact mapping still needs a bounded source-owned design review.

1. **Identity:** member identity differs from visible mark and entity handle. New independent copies get new identity; renumbering retains it. Keep drawing/level/representation scope explicit rather than matching B4 globally.
2. **Ownership:** beam owns its geometry and label; support is shared. Beam-only MOVE/ERASE cannot move/delete unselected supports. Support movement updates all explicitly linked ends; support deletion leaves affected ends unresolved.
3. **References:** preserve start/end role and source revision. Generic ConnectedTo alone does not establish engineering bearing, fixity, continuity or capacity. No nearest-object inference becomes a confirmed link.
4. **Copy mapping:** originals and copies remain independent; each copied label belongs to the copied member. Whole-group copies remap relationships to the copied group. Tim's 12 September ruling: beam-only copies retain their copied owned label but leave all support connections unconnected until explicit connection.
5. **State and evidence:** distinguish observed/inferred/proposed/approved and Unknown/Conflict/Stale; preserve source, units and revision. Schedule/detail consumers read the same authority; they cannot become extra writers or engineering calculators.
6. **Storage/change:** the approved active DWG record remains sole stored authority until an explicit reviewed adoption plan exists. No startup migration or automatic second record. Cancel/Undo/save-reopen and stale-document refusals are required before activation.

## First connected-slice workflow card — ST-RDY-01

**Classification:** Modify/qualify existing behaviour; keep proven commands and reuse the existing engine/adapter. This card consolidates ST1-2/11–15 and ST2-7–10/15. It does not approve new persistence, activate dormant code or change engineering rules.

**Synthetic drawing:** two beam ends, B1 and B2, meet one DS1 support S1; each beam has its owned label and S1 retains its own label. A second unconnected support and unrelated nearby text are deliberate distractors. No client drawing or historical evidence is required.

| Action | Expected result / guard |
|---|---|
| Place/select beam 1 and confirm support links | Explicit footprint-compatible endpoints; ambiguous candidates remain visible for review; label ownership is exact |
| MOVE B1 alone / MOVE S1 | B1 label follows B1 without dragging S1; moving S1 updates both explicitly linked ends |
| COPY S1 alone | Fresh support identity and its label; original beams remain attached to original S1 |
| COPY B1 alone | Fresh beam/label identity; no original label stolen; support connections remain unconnected until explicit connection (Tim, 12 September) |
| COPY B1+B2+S1 together | Fresh group identities, copied labels owned correctly and both copied beam ends linked to copied S1; originals unchanged |
| ERASE B1 / ERASE S1 | Beam erase removes its owned label only; support erase leaves surviving affected ends unresolved |
| Cancel/Escape / Undo / save-reopen | No partial cancelled result; complete operation reverses according to approved native workflow; saved identities/links/state reopen correctly. Native COPY Multiple/Escape retention must use its reviewed native rules, not assume CR rollback rules |
| Protected content / drawing change | Locked-layer, XREF, REFEDIT and unsupported objects retain native protections; stale preview cannot write into another drawing |

**Initial coverage:** `1`, `DS1`, native `MOVE`, `COPY`, `ERASE`, `UNDO`, save/reopen. `BTX`, `BEXT` and support switching follow after the minimal slice; this first card does not certify all framing commands or all AutoCAD versions. The release owner selects supported runtime qualification lanes; no new compatibility promise is made here.

**Engineering clarification resolved:** Tim answered **"Yes — copy beam and label; leave supports unconnected (recommended)."** Recorded in [ST-01](CARDS/ST-01_BEAMS_LINKS.md). Whole-group and support-only rules already have ST-01/ST-02 authority and are not reopened. No further engineering question is identified for this narrow copy rule.

**Required next technical gate:** release owner confirms the exact source/worktree and scope for qualification; shared identity/copy mapping and native lifecycle are proven before public activation. A future independent Claude review receives an exact repository/base/head/file-scope prompt for Tim to run. This source/readiness audit is not that independent review.

**Tim's eventual acceptance:** one consolidated representative native drawing session after automated guards and authorised installation, not a historical backlog. Nothing needs running in AutoCAD during this readiness pass.

## Area disposition and model assignments

| Area | Readiness outcome | Next assignment |
|---|---|---|
| Framing | Reuse found; shared-support/copy qualification is first | Astra/high for this acceptance/ownership card; implementation stays behind the exact source/workflow gate |
| Foundations | Approved rules available; identity/host mapping and common native card dependency remain | Sol/medium coordination; do not independently rebuild shared cards |
| Drafting | Standards-first work need not wait for full drawing corpus | Sol/medium coordination; reconcile existing approved work before Sol/high bounded implementation |
| Sections & Details | Consume member/provenance interfaces and approved assets | Sol/medium coordination; no guessed engineering or new parallel records |
| Schedules & Sheets | Depends on shared member identity/revision authority and Project-to-Issue owner | Sol/medium coordination; no second schedule engine |
| Job Coordination | Existing shared project/QA/time owners retained | Sol/medium coordination; no duplicate workstream |

All six rooms received explicit Sol/medium policy handoffs and acknowledged. Framing was subsequently switched to Astra/high for the bounded lifecycle card and returned it, then was explicitly returned to Sol/medium for the readiness-result handoff. All six received the final readiness/ruling handoff. Background existing-source auditor: gpt-5.6-sol/high, completed. No implementation builders launched. Main active-turn model setting cannot be changed/verified through a separate callable tool; the master must not claim such a change. Recommended master setting is Astra/high, selected in the task's model control if needed.

## Progress and checks

Readiness scope has three outputs: source reuse inventory, shared-record gap map, and first-slice card. **All three are complete (readiness deliverables 3/3); implementation is not complete.** Forecast at start: 15–25 minutes with one background auditor versus 25–40 sequential, moderate confidence. Framing card review was a bounded area-room assignment; no source edits were made by that room. No whole-Structural implementation percentage is claimed. Continuation proceeds through ST-RDY-02 and the read-only projection work order; the [exact Claude review prompt](workflows/ST-RDY-01_CLAUDE_REVIEW_PROMPT.md) is only for later selection of the newer 24-file delta, not an immediate stop gate.

Checks in this pass: targeted Git source reads, exact-blob existing-source audit, release-owner handoff, explicit model-setting dispatch receipts and completed area acknowledgements. No dotnet build/test, AutoCAD run, merge, commit or deployment. Documentation local-link/card coverage guard is required at closeout. Engineering copy clarification is resolved; independent review, source-owner implementation qualification and native acceptance remain pending. Historical test counts above are not fresh results.

Closeout guard passed: new document links resolve, all nine ST cards appear exactly once in the area map, the Claude prompt includes all 25 changed files (24 source/test plus regression log), and git diff whitespace check passed for this pass's tracked changes. Release owner reaffirmed no future Structural implementation base is nominated beyond the reviewed dormant subset; the exact read-only review range is recorded, with no activation/deployment authority transferred. Opening the complete prompt in Codex was requested; the app returned queued, so the final response also links directly to it. No remaining historical-project evidence collection is required for ST-RDY-01; source review and native behaviour qualification are the next dependencies.
