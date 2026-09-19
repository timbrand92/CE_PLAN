# CE Plugin — Implementation Roadmap

**6 September 2026 — approved planning extension:** [shared drawing-production plan](DRAWING_PRODUCTION_PLAN.md) and [delivery register](DRAFTING_DELIVERY_REGISTER.md) assign all 44 audit items to existing owners. DP-0 evidence baseline → DP-1 concrete gaps → DP-2 shared finish; DP-3 Civil and DP-4 Manager follow current delivery; DP-5 C6 after C5; DP-6 Structural through SL3; DP-7 cross-discipline pilot when ready. These are planning packages, not new commands or a replacement release route. Purpose, dependencies, completion checks, effort allowances and status are in the shared plan's delivery table. Product completion remains unmeasured.

**Future Structural Level 3:** [project context → coordinated views → learned details → sections/proposals
→ revision/issue → pilot](STRUCTURAL_LEVEL3_PLAN.md). Planning/publication authorised 5 September 2026;
SL3-0–6 are proposed slices with explicit dependencies and preliminary effort ranges. Civil + Manager office
delivery remains first; existing S1–S3 scope and individual workflow approvals remain authoritative.

**Delivery reconciliation — 2026-09-04:** implementation and partial AutoCAD acceptance are active. [GitHub #24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24) owns live delivery status; [V3_0_PLAN.md](V3_0_PLAN.md) owns reconciled Civil scope. [Tim's D1–D10 decisions](PLAN_RECONCILIATION_2026-09-04.md) govern: C5 before C6; Claude behaviour/spine/deploys, Codex windows; **D9 keeps DWG geometry as the model**. Explicit Tim rulings outrank stale summaries. The 12 design rules, approved workflow gates and DATA-01 restrictions remain binding. No overall completion percentage is asserted.

**Authority:** `docs/CLEAN_SLATE_REBUILD.md` Rounds 0–9 + Permanent Command Review Gate

## 1. Foundation framework and current delivery route

Current Civil delivery: **C0 → C1 + C2 → C3 → C4 → C5 → C6**. M1 is independent and required for S3.
R1's single CE/contextual ribbon contract runs alongside C2 under newer #58/#60; this does not authorise a big-bang host/installer merge. The P0–P6 diagram below is the retained architectural framework,
not an instruction to repeat completed foundations or merge the host before the staged programme.

```text
G0 DATA-01 privacy/history clearance
        ↓
P0 Safety + automated test platform
        ↓
P1 One command truth + unified AutoCAD shell
        ↓
P2 Engineering Rulebook + project/data foundations
        ↓
P3 Civil workflows  ←→  P4 Structural workflows
        ↓
P5 Contextual help + completeness QA + Codex/Claude bridge
        ↓
P6 Tim Test → Pilot → Staff Stable → legacy retirement
```

No user-facing command enters a build phase until its current real AutoCAD workflow is reviewed and Tim
approves its command/workflow card. Working behaviour remains live until the replacement is AutoCAD-confirmed.

The durable workflow/ID authority is [`docs/CARDS/INDEX.md`](CARDS/INDEX.md); GitHub owns current delivery status. A transcript-approved card marked
`Record incomplete` is not implementation-ready even though its planning decision is approved.

## 2. Tim-testing minimisation policy

Tim's time is the final engineering/AutoCAD acceptance gate, not the primary debugging system.

```text
pure logic checks
      ↓
offline DWG/drawing-output checks
      ↓
test-profile AutoCAD batch runner + screenshots/report
      ↓
Tim reviews only exceptions + one representative workflow acceptance
```

| Evidence class | Who/what proves it | Target Tim effort |
|---|---|---:|
| Calculation, parsing, rules, registry, data migration | automated tests | 0 minutes |
| Layers, blocks, text, locations, rotations, stored data | offline drawing-output comparison | 0 minutes |
| Cancel/Undo/reactors/native command interaction | automated AutoCAD test-profile scenarios | review report only |
| Visual drafting quality and engineering intent | Tim reviews representative before/after evidence | 2–5 minutes |
| Complete interactive workflow acceptance | Tim runs one final checklist per 5–10-command batch | 10–15 minutes |

Old “awaiting Tim AutoCAD test” items will not be handed back individually. Each is sorted into:

1. superseded/archive;
2. provable automatically;
3. folded into the relevant workflow's single batch acceptance;
4. genuinely safety/engineering-critical and requiring Tim's direct check.

### Test timing

- Tim's normal workday: **8:40 am–5:30 pm Australia/Sydney time**.
- Short/targeted automated checks may run whenever useful.
- Long/full automated suites should normally run **after 5:30 pm** so they do not compete with drafting work.
- Nothing deploys unless Tim explicitly says **`AutoCAD is closed, deploy`**.

## 3. Gate 0 — DATA-01 privacy and history clearance

Before broad AI/corpus access, corpus extraction or corpus/AI implementation:

1. sanitise/de-identify the approved corpus, including arbitrary coordinate translation and metadata removal;
2. review warning-positive samples and keep scanner output privacy-preserving;
3. inspect and remediate committed history—not only current files;
4. record provider-specific permission independently for Claude and OpenAI/Codex.

The 2026-07-22 local audit found 141 current corpus files, 142 historical corpus paths and 163 historical
corpus objects, reachable through 65 local/remote refs. Gate 0 therefore fails. A history rewrite or approved
history-access restriction is a separate disruptive operation and is not authorised by this roadmap update.
Isolated P0 safety work may proceed only when it does not inspect or expose corpus content; completed
`CT-01A/B/C`, `TH-01` platform work and `RS-01A1/A2/B1/B2/C1/C2` meet that boundary.

## 4. P0 — safety and automated test platform

**Purpose:** stop invalid field tests and reduce future manual testing before changing command behaviour.

| Work card | Outcome | Tim involvement |
|---|---|---|
| `CT-01 Command Truth` | Reconcile source registrations, aliases, central registry, ribbon and Help; validate every ghost/off-register/duplicate/placeholder. Tool status uses `Preview`, never the release-channel word `Pilot`. | Approve ownership/retirement decisions only. |
| `TH-01 Test Separation + AutoCAD Evidence` | Remove test commands from Staff Stable; run strict scenarios on synthetic/sanitised disposable fixtures and emit safe screenshots, timings and plain results. | Approve the test-profile experience and review exceptions. |
| `RS-01 Release Safety` | Normal builds cannot touch the live bundle; staged verified deploy and hash checks. | No AutoCAD check until the first official Tim Test deploy. |
| `PD-01 Performance + Diagnostics` | Baseline startup/drafting/plot performance; one capped log, truthful health/support and exact loaded identity. | One representative baseline and confirm the report is useful. |

**Current P0 progress:** `CT-01A/B/C/D/E` has completed the compiled-command baseline, proved exact command-name
parity across AutoCAD 2022–2024, 2025–2026 and 2027+, and made Manager the sole compiled/registry/manifest owner
of `CEMANAGER`, `CEHEALTH` and `CESUPPORT`. TH-01 removes both historical test commands from Staff Civil DLLs,
supplies a separate three-lane `CE_TEST_RUN` package, and adds a fail-closed hash/fixture/scenario/evidence runner.
The visible command backlog is now 80 differences. The central Tool Register foundation owns the three approved
Manager tools and the first six approved Civil workflow destinations (`CD`, `PIT`, `CDEDIT`, `CDINSPECTOR`,
`PITSCHEDULE`, `CDDASHBOARD`). It hash-pins all legacy inputs and proves each qualified tool still matches its
current owner command and aliases; remaining tool qualification and surface migration are pending.
`RS-01A1/A2` now captures exact loaded CE path/version/hash/MVID, supplies a
tested fail-closed command-owner activation plan and routes update preparation into a validated, per-file-hashed
whole-bundle staging tree outside AutoCAD. Live pending-DLL/manifest mutation, startup swap and automatic restart
are excluded from compiled builds. `RS-01B1` adds the tested standalone closed-process
preserve/swap/verify/restore core, including enabled command-owner re-check and automatic restoration. B2 wiring
now provides one explicit staged activation entry point, durable start/final recording inside the rollback window,
and compiled retirement of the legacy delete/overwrite modes. CT-01C cleared the three approved Manager-owner
overlaps without deleting the Civil/Structural service logic. PD-01A/B supplies the shared run/PID/time/artifact
crash classifier used by TH-01 and Manager's atomic run ledger, 60-second heartbeat, clean close and exact managed-
fatal artifact. An unfinished old record is unknown, not a crash. Native external-artifact correlation,
performance baselines, consolidated logs and support remain pending. TH-01's first synthetic AutoCAD run and Tim
visual acceptance remain pending.
`RS-01C1` removes automatic build-to-live deployment: normal builds compile only, release staging and publishing
are separate explicit opt-ins, and the old Civil direct-deploy target fails closed. `RS-01C2` adds a trusted signed
record binding committed-source/check evidence, all 2022–2027 runtime lanes and every package hash; unsigned,
changed or untrusted candidates stop before installation. `RS-01C3` enrols the non-exportable Windows-held release
authority, embeds only its public identity and supplies fail-closed, never-overwrite package minting from clean
committed source and four evidence files. TH-01 AutoCAD evidence remains before the first official Tim Test package.
`RS-01C4` closes the remaining Manager first-load gap: Manager now has a tracked, explicit-only three-lane release
payload and must ship the same independently audited `CE_SHARED` bytes as Civil and Structural before coordinated
activation. Its outer build validates the complete 72-file payload and all six Manager/shared lane DLL hashes
before the separately authorised IT Admin publish can run; the Legacy range begins at AutoCAD 2022 (`R24.1`).
The prior complete Manager bundle remains the rollback source.

**Gate to P1:** command inventory reconciled; test-only commands cannot ship; automated evidence runner can
prove at least one drawing-output workflow; normal builds cannot overwrite the live plugin.

Locked foundation decisions and privacy/calculation refinements are recorded in
`docs/workflows/FND-01_FOUNDATION_REVIEW.md`. Calculation gates prove conformance to the cited rulebook entry;
they may claim standards/council compliance only when its authority and applicability are confirmed.

`CT-01` command-truth behaviour is locked in the legacy-named record
`docs/workflows/FND-001_COMMAND_TRUTH_REVIEW.md`. Its
compiled-DLL metadata comparison runs without AutoCAD. The first historical-difference report is non-blocking;
after ownership and approved duplicate cleanup reach zero unexplained differences, the promotion gate becomes
permanently blocking.

`TH-01` behaviour is locked in the legacy-named record
`docs/workflows/FND-002_003_TEST_EVIDENCE_REVIEW.md`. Test-only code is a
separate package; original/project DWGs are rejected; scenario passes fail closed; failure evidence belongs to
the exact run rather than the old crash heuristic; daytime favours DesignCore-style offline logic; and testing
references the same immutable artifact/hash record later promoted unchanged.

`RS-01` behaviour/classification is locked in the legacy-named record
`docs/workflows/FND-004_RELEASE_SAFETY_REVIEW.md`. Normal builds
become physically unable to deploy; Manager's sound download/approval/canary/rollback core is verified and
reused while live mutation/restart retires; installed assets update by hash; closed-AutoCAD replacement is
pre/post-verified and auto-restoring. Until implemented, `-p:SkipDevBundle=true` remains mandatory.

`PD-01` behaviour is locked in the legacy-named record
`docs/workflows/FND-005_006_PERFORMANCE_DIAGNOSTICS_REVIEW.md`. Start with
CE-off/current baselines and fill the unified column when it exists; use one shared run/crash correlation path
for Manager and harness; batch timings at idle but persist minimal warnings/errors immediately; report actual
loaded identity; consolidate/cap logs; and make support archive presence, validity and sanitisation truthful.

## 5. P1 — one command truth and unified AutoCAD shell

Build one validated tool registry that drives command identity, aliases, ribbon, search, help, permissions,
maturity and AI exposure. Resolve global collisions and remove “last loaded wins.” Then incrementally harden the
unified host, startup, ribbon, Manager, version display, settings and recovery shell.

**First AutoCAD workflow review ✅ locked:** Product shell — `CEMANAGER`, `CEHEALTH`, `CESUPPORT`,
`CEHELP/CDHELP`, `CE_VERSION/CDVER`, `CETOOLS/CESTRUC`. Manager owns Health and Support; one CE ribbon is
identical across supported AutoCAD versions; startup has a ≤1.0-second hard ceiling.

**SH-01R1/R2 modern ribbon coded; AutoCAD review pending:** the shared modern ribbon supports large, compact and
labelled-flyout items. Civil and Structural follow the approved job-stage layouts with complete registry-command
mapping. CE Tools contains every Manager command plus Version and the compact shared MR/CR destinations, so the
temporary `CE Suites` source is retired. Ribbon contributor failures are traced and isolated. The AutoCAD
2022–2024 CUIX presentation remains live until its aligned replacement is reviewed and verified.

Current-state evidence and locked `SH1–SH15` decisions are recorded in
`docs/workflows/SH-01_PRODUCT_SHELL_REVIEW.md`.

**TF-01 Shared Transform review ✅ locked:** legacy-named record
`docs/workflows/SH-05_SHARED_TRANSFORM_REVIEW.md`. CE Shared owns
`MR/MOVEROT/CR/COPYROT`; the proven LISP MR/CR path is the migration baseline; native C# must earn parity;
Escape fully rolls back and Enter/0° commits without rotation. `C` is not a CE command—Tim maps it to native
AutoCAD `COPY` in PGP. Native object protections are a plugin-wide transform/edit rule.

**Gate to P2:** one product shell loads without duplicate commands/ribbons, reports exact identity, has an
instant disable/recovery path, and adds no noticeable startup/drawing lag.

## 6. P2 — engineering and drawing-data foundations

Create the sourced/versioned Rulebook, project decisions, standard drawing-object contracts and migrations.
Use current tested calculation/data services; do not combine this with visual command redesign.

Priority foundations:

1. rule authority and project/council scope;
2. one project-data lifecycle and corruption recovery;
3. common units, rounding, coordinate/UCS and transaction rules;
4. layer/block/text/detail catalogues;
5. change plan: `plan → preview → apply → one Undo`;
6. safe offline drawing snapshots for QA and AI.

## 7. P3 — Civil workflow migration order

Each row is a separate Command Review Gate; 5–10 related commands at a time.

**Planning gate:** CV-01→CV-08 is 8/8 approved and the exact transcript records are banked. Implementation
remains behind the P0/P1 dependency gates.

### Current Civil smart-stack queue — 2026-07-24

Exact pre-build evidence is in the
[Civil smart-stack audit ledger](workflows/CIVIL_SMART_STACK_PREBUILD_AUDIT_LEDGER.md).

| Order | Increment | Current state | Next gate |
|---:|---|---|---|
| 0 | Current coordinated release | Civil 2.1.17 / Structural 1.0.43 / Manager 1.0.2 deployed and hash-audited | Tim AutoCAD visual acceptance |
| 1 | CT-01E central Civil Tool Register | Complete; independent PASS | None |
| 2 | NH-01B Civil Hub | B1/B2 complete; independent PASS at `eb39b12` | Tim AutoCAD visual acceptance |
| 3 | NH-01C one network-health/audit authority | C1/C2 independently PASS at `e871790` / `cf6a0ed` | Tim AutoCAD acceptance |
| 4 | CV-01F Pit Level Assistant | F1/F2/F3/F4 independently PASS; Order 4 complete | Tim AutoCAD visual/interaction acceptance |
| 5 | CV-01G design-change impact | G1/G2/G3 independently PASS | Tim AutoCAD visual/interaction acceptance |
| 6 | CV-01H relocated-LPD redesign | H1–H4 independently PASS; H5A/H5B1 PASS at `89d4bf9` / `ab372dc`; final H5B2 PASS `dc9e971`; H5B3 exact endpoint/Inspector warning PASS `e827290`, integrated at `3342dd0`; joined source re-audit PASS `34d5e3c` | Tim H5C visual approval, then the remaining consumer/writer gates |
| 7 | CV-01J multi-level continuations | J1/J2/J3 safety and storage plus J5A/J5B1 read-only discovery independently PASS; integrated command/lock/full-shape guards PASS at `422e9e0`; J5B2 two-DWG writer independently PASS at `89a46f5` and integrated at `7c628e8` | Live AutoCAD proof, then J6 staging/confirmation UI |
| 8 | PS-01E XREF watcher | E1 coordinator and E2 lifecycle adapter independently PASS at `57c5ab4` / `113f812`; integrated at `36074a3` | Tim PS-01F1 visual approval; then E3/E4 |
| 9 | CV-01I annotation tidy-up | Hardened plan plus current/proposed and three-tier state visuals ready; no product code | Fresh Tim visual/plan approval before I1 |
| 10 | CV-02A assisted sizing | Hardened plan + current/proposed and mode/runtime/accessibility visuals ready; no product code | Fresh Tim visual/plan approval before A1; production Pass/Fail, rule pack and Apply remain blocked |

This queue does not override the command/workflow review gate. No listed
visual PASS is permission to implement, deploy or access DATA-01.

### Mandatory gate before the CD window rebuild

| Increment | Current state | Next gate |
|---|---|---|
| CV-01E4 CD draw-first AutoCalc + connected-end preview | Source complete and independently PASS at `130c00f`; integrated at `896510c` | Tim live AutoCAD checklist before changing the CD WPF layout |

CV-01E4 must make the existing draw-first path reliable, display connections
such as `PP → P3` in Preview and Flow / Inverts, and ask before accepting an
opposite hydraulic direction. It reuses the one connected-flow, annotation
and schedule authority; it does not create another CD command or window.

| Order | Workflow | Representative commands |
|---:|---|---|
| 1 | Pipe/pit lifecycle | `CD`, `PIT`, `CDEDIT`, `CDINSPECTOR`, `CDRUNSOLVE` |
| 2 | Pipe annotations and editing | `CDFALL`, `CDANNOTATIONEDIT`, `CDMA`, `CDTEXTSEG`, breakline actions |
| 3 | Drainage sources | `DP`, `IO`, `OF`, `FO`, `CDTG`, `GIO`, `CDTAG` |
| 4 | Surface/site drainage | `CDSTRIP`, `CDFW`, `CDWT`, `CDAGI`, `CDSOURCE` |
| 5 | Slab/site layout | `CDSLAB`, `CDSLABIMPORT`, `CDSPOON`, `CDJOINT`, `CDCJ`, `CDSC` |
| 6 | Review and issue readiness | `PITSCHEDULE`, `CDHUB`, `CDPROFILE`, `CDDASHBOARD`, `CDCALC` |
| 7 | Survey/import/consultant | `CDSURVEY`, `CDCHECKDWG`, X-Civil/LandXML import/compare |
| 8 | Repair/migration/admin | `CDREPAIR`, `CDSYNC`, `CDREBUILD`, `CDUPGRADE`, recovery/diagnostics |

## 8. P4 — Structural workflow migration order

**Planning gate:** ST-01→ST-09 is 9/9 approved and the exact transcript records are banked. Implementation
remains behind the P0/P1 dependency gates.

| Order | Workflow | Representative commands |
|---:|---|---|
| 1 | Beams and beam links | `1`, `2`, `4`, `5`, `BEXT`, `BDL`, `BTX`, beam link tools |
| 2 | Supports/bracing/joists | `C1/C2/DS/DS1/TS1`, switch tools, `AB/BB/BT1`, `R1/FJ1` |
| 3 | Annotation/dimensions | section/level marks, `AD/LD/Q/QD`, MLeaders, breakline |
| 4 | Text placement | the CE text-placement families, consolidated behind workflow choices/search |
| 5 | Hatching/utilities/Xrefs | hatch presets, `H2A`, `XRL`, `CXREF`, clean/save and transforms |
| 6 | Foundations/rebar | Foundation service, rebar line/circle/stirrup/weight workflows |
| 7 | Schedules/sheets/Excel | `EXCELMTEXT`, XCLM, structural schedules, `CESHEETS` |
| 8 | Section/details | working RC/steel sections first; placeholders remain hidden until designed |
| 9 | Markup/checklists/notes/time | CEMARKUP, checklist, notes and job-time workflows after safety review |

## 9. P5 — contextual help, QA and assistant bridge

Only expose tools whose workflow cards are approved. Build contextual discovery and Help Centre from the same
registry. QA first checks complete, coordinated, logically arranged drawing sets. Codex/Claude connects through
the local permissioned MCP bridge; read-only first, write via preview and Tim/user approval.

AI-01, QA-01 and EV-01→EV-07 are planning-approved. AI write access still requires the local MCP permission
bridge, real non-writing snapshots, provider privacy clearance and the approved Plan → Preview → explicit
approval → Apply → one Undo boundary.

## 10. P6 — release and office migration

Promote the same verified package through `Tim Test → Pilot → Staff Stable`. Migrate machines incrementally,
retain old bundles as reversible safety, and reserve `1.0.0` for the completed office cutover.

## 11. Implementation rule

The roadmap establishes order, not blanket coding approval. Every work card still needs:

- current AutoCAD behaviour and Tim's intended result;
- Keep/Modify/Rebuild/Retire/Missing decision;
- exact owned files and dependencies;
- automated evidence plan and minimum Tim acceptance;
- performance budget and contextual discovery trigger;
- explicit Tim approval before implementation.
