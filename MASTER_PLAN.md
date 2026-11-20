# MASTER PLAN — CE_ACAD, the AutoCAD plugin

**This is the map only. No status lives here.** Status, bugs, parked items, test steps and regression lists live
in the area files under `areas\`. Tim's decisions live under `decisions\`, in his words, dated. Built-but-not-tested
work is `PENDING_TESTS.md`. Superseded plans and chat records are under `archive\`, never deleted.

**Assembled 19 Sep 2026** from the two documents that both carried the name `V3_0_PLAN.md`: the Codex "Master
Control Framework" of 15 Sep (its framework text is Part C below; its status log moved to
`areas\civil-stage1-foundation-status-log.md`; the original is archived at
`archive\superseded-plans\V3_0_PLAN_2026-09-15_master-control-framework.md`) and the Claude "reconciled delivery
plan" of 4 to 10 Sep (Tim's decisions D1 to D10, the window map and the design pack, now
`decisions\2026-09-04_to_09-10_RECONCILED_DELIVERY_PLAN_AND_DESIGN_PACK_D1-D10.md`). The whole-program overview and
questionnaire map that says which document answers which question is `04_REFERENCE\V3_OVERALL_PLAN.md`.

---

## A. What Version 3 delivers, and in what order

One CE plugin (Civil drainage, Structural and Manager) in one bundle, one ribbon, one update channel, ready for
normal office use by staff. The definition of 100% is Part C, section 13. The delivery order is
`IMPLEMENTATION_ROADMAP.md`. The engineering rules every part obeys are `ENGINEERING_RULEBOOK.md`.

The required delivery sequence (detail in Part C, section 8):

1. Stage 1 — Stabilise the deployed foundation
2. Stage 2 — Complete the core editors
3. Stage 3 — Complete topology and Drawing Intelligence
4. Stage 4 — Integrate completed specialist slices
5. Stage 5 — Project-wide workflows
6. Stage 6 — Staff release

## B. The areas — one file each

1. **A** — Project setup, planning documents, council rules and project evidence (CDSETUP). File: `areas\civil-A-project-setup-council-evidence.md`
2. **B** — Survey, surfaces, existing/proposed RLs and consultant imports. File: `areas\civil-B-survey-surfaces-imports.md`
3. **C** — Legal point of discharge/outfall and authority connection. File: `areas\civil-C-lpd-outfall-authority.md`
4. **D+F** — Catchments, roof/impervious areas, flow paths, CDCALC, OSD/detention design, orifice sizing and storage (area plan written 15 Sep). File: `areas\civil-D-F-catchments-cdcalc-osd.md`
5. **E** — Pits, pipes, grades, sizes, labels and connected-network editing. File: `areas\civil-E-pits-pipes-network-editing.md`
6. **G** — Water tanks, reuse, underground/underdeck tanks and complete standard details (CDWT). File: `areas\civil-G-water-tanks-cdwt.md`
7. **H** — SPS/pump stations, wet wells, pump controls and rising mains. File: `areas\civil-H-pump-stations.md`
8. **I** — WSUD/treatment: raingardens, swales, buffer strips, sedimentation and treatment devices. File: `areas\civil-I-wsud-treatment.md`
9. **J** — Overland flow, overflow paths, flood/surcharge evidence and surface safety. File: `areas\civil-J-overland-flow.md`
10. **K** — Profiles/long sections and plan-profile coordination (CDLPD). File: `areas\civil-K-profiles-long-sections.md`
11. **L** — Schedules, construction details, notes, issue QA and drawing-wide review. File: `areas\civil-L-schedules-details-notes-qa.md`
12. **M** — Repair/legacy migration and linked-object integrity. File: `areas\civil-M-repair-legacy-migration.md`
13. **W** — The CE windows, ribbon and design pack. Codex builds windows, Claude builds behaviour (Ruling B, 15 Sep); the CDWT window is the exception (Tim, 16 Sep). File: `areas\windows-and-ribbon.md`
14. **S** — Structural (S1 to S3 and Level 3): project understanding, connected framing, details library, drawing journey. File: `areas\structural.md`
    - *18 Oct 2026 (Tim, CEMEMBER design session):* SBEAM is to be replaced by **CEMEMBER** ("yep sounds good": "its not only steel beams"): section, side and top elevation, layers 25cont / 18cont / 18hidden / 9hidden2 / HATCH 10, "we never put two lines on top of each other", four orientations for odd shapes, one window with an always-on live preview, scale from DIMSCALE. Design recorded only: `decisions\2026-10-18_CEMEMBER_DESIGN.md`; card DRAFT (not approved): `areas\release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md`; section-list findings BUG-818 and BUG-819; open questions in the decisions file section E2. Nothing built, installed or tested. Ruling A (pause new items) applies; SBEAM and SBEAMEDIT keep working until CEMEMBER passes Tim's AutoCAD test.
    - *19 Oct 2026 (Tim's answers):* CEMEMBER card approved ("yes"), subject to the lip line positions; warn (not stop) on a DIMSCALE/LTSCALE mismatch; purlin lips shown; tees and bars deferred; no paid ASI tables. No code started; ruling A pause still applies until Tim says build. See `decisions\2026-10-19_CEMEMBER_ANSWERS.md`.
15. **M1** — Manager: dashboard, one-button update, safe updates and rollback. File: `areas\manager.md`
16. **CR** — Council rulebook workstream: every council value on the Settings page, nothing hard-coded (R-00). File: `areas\council-rulebook.md`
17. **DI** — Drawing intelligence: connectivity, CDCHECK, learning from real drawings safely (DATA-01). File: `areas\drawing-intelligence.md`
18. **DP** — Drawing production extension across Civil, Structural and Manager (approved for planning 6 Sep). File: `areas\drawing-production.md`
19. **L3** — Level 3 external-tool integration and reuse (10 Sep). File: `areas\level3-external-tools.md`
20. **S1** — Civil Stage 1 foundation: the status log carried out of the old master plan (1 to 3 Sep). File: `areas\civil-stage1-foundation-status-log.md`
21. **REL** — Version 3 to colleagues: which build, who, packaging, install, rollback and colleague notes (Stage 6; opened 23 Sep for Tim's Tuesday 29 Sep target). File: `areas\release-v3-colleagues.md`
22. **AI** — Claude API and learning inside the plugin, council RFIs first (opened 29 Oct 2026, planned only). File: `areas\claude-api-and-learning.md`
23. **TRUST** — A plugin you can trust: small core for colleagues, Civil first, eight steps from the opening line to Check this drawing, with the test set, the fixed-rule reader, the release process and the five trust rules (opened 12 Nov 2026 from Tim's 5 to 7 Nov decisions; PROPOSAL, each step needs his approval). File: `areas\trust-plan.md`
24. **RULES** — The plugin's own rule files brought up to the TimOS rulebook (Rules rev 2): what points back to `C:\TimOS\RULES.md`, what stays the plugin's own, what Tim ruled (opened 20 Nov 2026; Tim: "Rest agreed"). File: `areas\rules.md`

## C. The control framework (carried from the 15 Sep master control framework, status removed)

## 1. Mandatory continuity rule

This document controls every Version 3 session.

Tim reaffirmed on 2026-09-01 that this master must be consulted on every work turn, not only after a chat handoff
or context compaction. Before selecting or resuming work, Codex must confirm that the action advances the first
incomplete release gate recorded here. New requests are added to the correct stage or Parking lot without silently
replacing the active gate. Material source, audit, package, deployment and AutoCAD results must be recorded here
before the next task is selected.

After context compaction, a new chat, a handoff or a resumed task:

1. read this document first;
2. confirm the current branch, commit, deployed version and active gate;
3. continue the first incomplete item in the approved sequence;
4. classify new ideas as Current, Next, Version 3 scope change or Parking lot;
5. update this document before a material handoff.

A chat summary, automation prompt or worker handoff may add current evidence, but it never replaces this plan.
No session may declare Version 3 complete using source tests alone.

## 2. Purpose

This framework combines the approved Civil Drawing Intelligence model, project evidence/data model, editor UI/UX
contract, workflow cards, implementation roadmap and release gates into one Version 3 delivery sequence.

It does not rewrite detailed engineering decisions. It identifies the controlling document, present implementation
state, next gate and definition of completion.

## 3. Version 3 outcome

Version 3 is complete only when colleagues can install and use CE Civil without CE Manager or CE Structural.

The staff-ready release must provide:

- its own CE Civil ribbon and command loading;
- no runtime DLL or command dependency on Manager or Structural;
- reliable native AutoCAD grips and previews;
- complete Pipe, Pit and CDEDIT workflows;
- identity/evidence-driven Drawing Intelligence with no nearest-object guessing;
- visible Unknown, ambiguity and provenance rather than invented values;
- safe Preview, Cancel, one Undo and exact save/reopen behaviour;
- independent source and package audits;
- standalone install, help, diagnostics, rollback and release notes;
- Tim acceptance followed by a controlled colleague pilot.

The deployed v3.0.0 foundation is the first integrated field baseline. It is not the completed Version 3 program.

## 4. Authority order

When requirements conflict:

1. Tim's latest explicit decision recorded in a current approved brief/card.
2. Approved engineering, topology, calculation and drawing-data contracts.
3. This document for Version 3 scope, sequence, status and release gates.
4. [Civil Drawing Intelligence brief](./CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md).
5. [Civil editor UI/UX brief](./CE_CIVIL_EDITOR_UI_UX_BRIEF.md).
6. [Consolidated Civil UI/UX behaviour contract](</C:/Users/TimothyBrand/.codex/visualizations/2026/08/19/01a0185e-7339-78e2-ad52-57980b223827/CE_CIVIL_CLAUDE_UI_UX_CONTRACT.md>).
7. [EV-03 project evidence model](./CARDS/EV-03_EVIDENCE_MODEL.md).
8. [Workflow-card index](./CARDS/INDEX.md) and individual approved cards.
9. [Implementation roadmap](./IMPLEMENTATION_ROADMAP.md).
10. Existing shipped behaviour unless a higher authority changes it.

Entry point: [Civil Editor Workshop Context](./CE_CIVIL_EDITOR_WORKSHOP_CONTEXT.md).

The UI contract cannot weaken engineering rules. Historical frequency cannot promote a drafting pattern into an
engineering rule. Conflicting or missing evidence remains Unknown.

## 5. Shared intelligence, data and evidence backbone

~~~text
Project sources + accepted user decisions
                    ↓
Evidence + provenance + confidence + revision
                    ↓
Stable Civil identity + relationships
                    ↓
Canonical engineering data
                    ↓
Drawing presentation + regenerable views
                    ↓
QA + review + schedule + profile + calculation outputs
~~~

Non-negotiable rules:

- engineering data and presentation are separate;
- stable identity outranks proximity;
- touching/termination may prove a connection; crossing alone does not;
- Xrefs are evidence, never live Civil connection targets;
- important values expose provenance;
- Unknown, Assumed, Manual/Pinned and Display Override remain distinct;
- accepted manual edits outrank later conflicting imports until reviewed;
- evidence extraction is read-only, reproducible and privacy-governed;
- learning may propose but never silently changes engineering rules;
- one accepted operation maps to one AutoCAD Undo step.

## 6. Completion gates

Every work item keeps separate states:

| Gate | Evidence required |
|---|---|
| Behaviour approved | Tim decision recorded in a current brief/card |
| Source complete | Implementation plus focused regression checks |
| Integrated | Present on the Version 3 integration branch |
| Source audited | Genuinely independent all-zero review |
| Package audited | Exact clean lanes, assets, manifest and hashes verified |
| Tim accepted | Representative real-drawing AutoCAD checklist passes |
| Staff pilot accepted | Standalone colleague install and workflow passes |
| Staff ready | Help, rollback, release notes and known limitations complete |

Only Staff ready counts as 100%.

## 8. Required delivery sequence

### Stage 1 — Stabilise the deployed foundation

1. Civil ribbon loads once without the toolbar-name prompt.
2. Ordinary AutoCAD grips show normal moving previews.
3. Civil label, invert and flow-arrow movement works.
4. Cancel, Undo and save/reopen retain exact placement.
5. Pit compounding and CDPARTS remain working.
6. Twin pipes compound and schedule correctly; record centreline-grip gap.
7. CDEXPORTENTITIES no longer crashes.
8. Correct any failure, re-audit and redeploy before widening the candidate.

### Stage 2 — Complete the core editors

**Visual approval gate:** before production WPF changes for each core editor slice, show Tim a realistic visual
mockup covering Insert/Update, drawing preview, engineering review and Cancel/Undo wording. Record his approval or
requested changes here; a written description alone is not approval.

**Autodesk-style visual checkpoint — 2026-09-01:** Tim approved a medium floating Properties-style window for
single-object Pipe/Pit editing, with `Inspect Drawing` temporarily moving it aside; the real AutoCAD drawing provides
zoom, highlight and ghost preview, with no permanent duplicate plan preview inside the editor. CDEDIT batch editing
uses a Panorama-style grid with explicit enabled fields and protected rows left visibly unchanged. Tabs versus one
stacked scrolling form remains open pending Tim's comparison of both visuals. No production WPF is approved yet.

~~~text
Shared editor shell
        ↓
CD Insert mode + PIPEEDIT Update mode
(one Pipe window)
        ↓
PIT Insert mode + PITEDIT Update mode
(one Pit window)
        ↓
CDEDIT routing + same-type batch editing
~~~

Tim authorised Codex on 2026-09-01 to own layout, hierarchy, wording and WPF build as well as engineering/data
services, topology, transaction, preview, Undo and highlighting. Visual controls still cannot invent Civil meaning;
the WPF-to-engineering authority boundary remains explicit and testable.

**UI/UX Control Room ownership — 2026-09-01:** task `01a037f4-b1e4-73c3-9dec-c0a923a09ebd` now controls all
Civil window, ribbon, command-discovery, editor-shell, wording, interaction, highlight, preview and presentation
decisions. This release Control Room retains engineering logic, evidence/data behaviour, integration and release
gates. Each area sends its required fields, actions, states, current behaviour and constraints to the UI/UX Control
Room before production UI work. No competing visual system may be started and no current function may be removed.

**Planning-only checkpoint — 2026-09-02:** the UI/UX Control Room has completed mockups and decision packets for
CD/PIPEEDIT, Pit/Schedule, Sources/CDWT, Slab System and Review/Calculations/Profiles at checkpoint `77ea1b55` on
`codex/civil-ui-ux-area-plan`. Survey/Import and Repair/Legacy/Settings are being prepared read-only. CD/PIPEEDIT
remains Tim's first visual approval gate. These packets do not authorise production window changes, builds or a
change to the Stage 1 release order.

### Stage 3 — Complete topology and Drawing Intelligence

1. Stable identity, relationships and provenance.
2. Exact/ambiguous connection criteria.
3. Bounded local reassessment after normal AutoCAD edits.
4. Explicit Connect/Disconnect/Ignore/Resolve decisions.
5. Pipe-to-pit physical fit warning from accepted pipe envelope, invert/level evidence and pit clear geometry.
6. CDCHECK and Show Where.
7. CDTRIM, CDEXTEND, CDBREAK, CDJOIN and CE-aware movement.
8. Locked-layer, Xref and REFEDIT protection.

#### Approved pipe-to-pit physical fit warning — 2026-09-02

When a pipe is connected to a pit, CE must check whether the proposed physical opening can fit within the pit and
coexist with its other connected pipes. This is always a **warning**, never a restriction: the user may continue and
the connection remains available.

- Use the accepted pipe outside envelope, wall thickness/shape where known, invert and crown/obvert evidence, plus
  the pit's accepted internal clear dimensions, base, walls and cover/lid structure. Nominal pipe diameter alone must
  not be presented as a proven physical fit.
- Check clashes with the pit base, walls, corners and cover/lid zone, and clashes or insufficient space between
  multiple pipe openings.
- Where the physical pipe envelope, pit clear geometry, levels or required clearances are missing or conflicting,
  report **Fit cannot be confirmed** rather than guessing or reporting Pass.
- Required wall, edge and pipe-to-pipe clearances must come from an approved part/manufacturer, company or project
  setting with visible provenance. Historical frequency must not silently create an engineering clearance.
- Show the exact pit and affected pipe(s) in the drawing through highlighting and **Show where**, with plain wording
  stating what may not fit and which evidence caused the warning.
- Recheck after an accepted pipe size, pipe type, invert, pit type/size/level or connection change. Surface the same
  result in PIPEEDIT, PITEDIT, CDCHECK and Project Review without blocking unrelated Civil work.
- Keep the user's accepted connection unchanged when the warning is acknowledged or left unresolved. Record the
  unresolved fit risk for later review; do not silently consume it as a confirmed fit.

#### Approved council rulebook (CR) — 2026-09-15

Tim's instruction: *"make sure all these documents and information is included in V3 plan and the plugin reads,
understands them and CE based design and drafting is working with this context."*

Thirteen council documents across ten councils have been read from the councils' own sources and written up in
`docs/workflows/COUNCIL_*.md`. The full specification — every rule extracted, every field the plugin has nowhere
to put, the errors found in the shipped data, the build order and the decisions Tim still owes — is
[COUNCIL_RULES_V3_INTEGRATION.md](workflows/COUNCIL_RULES_V3_INTEGRATION.md). That document governs this item.

The binding points:

- **Three kinds of council, not two.** Values *published* (Kingston, Frankston, Darebin, Banyule), values *issued
  on request* (Bayside, Monash, Boroondara, Manningham), or *computed by the designer to Australian Rainfall and
  Runoff and shown* (Mornington Peninsula, Whitehorse). The third has no representation in the data model. For the
  second, the plugin should **produce the enquiry from the drawing** — Boroondara names the five figures it needs
  and all five are measurable on plan.
- **Councils disagree in direction, not just in value.** Frankston gives multi-dwelling the shortest time of
  concentration (3 minutes) and Kingston the longest (7). Darebin publishes a discharge coefficient of 1.0 for a
  round orifice where CE applies 0.6 everywhere. Manningham requires storage pipes no flatter than 1:180 where
  Darebin and Banyule say 1:200. An office default is therefore wrong in both directions, and every engineering
  value must be held **per council with its source**, per the settings-first rule.
- **Most published rules currently land in free-text `warnings`.** The plugin can print them; it cannot check
  them. Turning them into fields is what makes design and drafting actually work with this context.
- **Freeboard is not one number.** Nine distinct rules are now recorded, each with a different *from* and *to*;
  several apply to the same job at once. Tim's ruling that floor level does not *set* the top water level stands —
  these are checks the top water level must **pass**.
- **Twelve confirmed errors exist in the shipped `council-profiles.json`**, each found by reading a council's own
  document against the stored value. `minUndergroundPct` was already wrong for Boroondara and fixed; the identical
  error at Banyule proves it is a pattern, so the file is to be **swept**, not corrected council by council as
  documents arrive.
- **Two councils independently confirm CE's own top water level rule** (obvert of the highest storage pipe at or
  below the top of the baffle wall — Darebin and Manningham), and three independently confirm the 1 m step-iron
  depth (Banyule, Manningham, CE office rule). Those office rules can be promoted from assumption to sourced.
- Every new check is a **warning that records, never a block** (R-27), and every new value is a **Settings entry
  with visible provenance** — Sourced, Assumed or Office rule — so the user can see which council document a
  number came from and override it with a recorded reason.

Build order and the eight gating decisions are in §5 and §6 of the integration specification. Steps 1 and 7 (sweep
the known errors; surface the council, document and edition on the job) do not depend on any pending decision.

### Stage 4 — Integrate completed specialist slices

1. CDWT complete CE detail families and automatic level evidence.
2. CDPROFILE content evidence, route confirmation and linked drawing output.
3. Slab System evidence, insertion, regeneration and material/feature views.
4. Calculation/catchment provenance and reviewed drawing application.

Integrate, retest, audit and field-accept each slice separately.

### Stage 5 — Project-wide workflows

1. CDSETUP guided start, LPD evidence and design sequence.
2. CDSURVEY and the single CDIMPORT workflow.
3. Project Review/issue readiness.
4. CDREPAIR, upgrade and Civil settings.
5. CDHELP visual guidance, diagnostics and safe support/error submission.

### Stage 6 — Staff release

1. Full automated suite and release builds.
2. Independent source and exact-package audits.
3. Tim representative-project acceptance.
4. Clean standalone colleague installation without Manager/Structural.
5. Small colleague pilot with rollback.
6. Correct findings and repeat affected gates.
7. Publish staff help, release notes and known limitations.

## 9. Tim testing policy

Tim is the final AutoCAD/engineering acceptance gate, not the primary debugger. Codex completes all safe automated
checks and audits first. Tim receives one short representative checklist per release slice:

~~~text
Action → expected drawing result → Pass/Fail
~~~

Cancel, Undo, save/reopen, locked layers, Xrefs and ordinary AutoCAD behaviour are explicit checks where relevant.

## 10. Release and change control

- A version number does not mean the full Version 3 program is complete.
- Controlled foundation candidates may use v3.0.x while the approved scope is completed.
- No deployment occurs without Tim explicitly confirming AutoCAD is closed.
- Every deployed DLL must match the exact independently audited package hash.
- New ideas enter the correct stage or Parking lot; they do not silently replace the active task.
- A workstream leaves Version 3 only through Tim's explicit decision recorded here.

## 11. Civil guided-workflow area register

Detailed research/planning may use separate area chats, controlled by this master task:
'01a0185e-7339-78e2-ad52-57980b223827'.

Every area chat must:

1. read this master first and quote its current gate/checkpoint;
2. treat this master as authority over chat summaries;
3. report findings, decisions, source status, checks and AutoCAD acceptance back to the master task;
4. update the master before handoff or context compaction;
5. inspect old projects and CE standard DWGs read-only before defining workflow;
6. use complete CE standard model-space detail groups where applicable, never a nested geometry component as if it
   were a complete standard detail;
7. fail safe on unproven engineering decisions;
8. never deploy without Tim explicitly confirming AutoCAD is closed and authorising that exact deployment;
9. avoid overlapping file edits and normally use no more than two active area workers at once.

(The area list, one file per area, is section B of this master plan. Their state lives in each area file, never here.)

First planned independent pair after this master checkpoint:

1. **CE Civil V3 - Plan - Project Setup & Site Evidence** — areas A+B+C.
2. **CE Civil V3 - Plan - Catchments, CDCALC & OSD** — areas D+F.

These chats perform bounded read-only research/planning first. They must not compete with the current Stage 1
runtime stabilisation or edit the same production files.

## 13. Definition of 100%

Version 3 reaches 100% when:

- every retained workstream is implemented and integrated;
- source and exact package audits are all-zero;
- standalone Civil ribbon/commands work without Manager/Structural;
- real drawings pass Tim's representative acceptance;
- Cancel, Undo, save/reopen and native AutoCAD interaction are proven;
- a colleague installs and completes representative workflows;
- help, support, rollback, release notes and limitations are ready;
- GitHub contains the exact released source and immutable release identity.

Until then, resume from the first incomplete gate in this document.

