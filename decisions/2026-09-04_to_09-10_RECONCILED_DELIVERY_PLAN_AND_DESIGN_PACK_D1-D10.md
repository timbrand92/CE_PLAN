# CE Civil v3.0 — reconciled delivery plan

**10 September 2026 — next native slice approved:** Tim said “CAN WE PROCEED WITH THIS” after the shared Settings/Help recommendation. [SH-04A](workflows/SH-04A_SHARED_SETTINGS_HELP_IMPLEMENTATION_CARD.md) is approved: actual Civil settings and Civil/Manager Help inside Manager, immediate theme preview saved only with Apply, zero-write Discard, and complete Structural settings/help retained temporarily until embedded parity. First Colleague Issue Control Room coordinates current-source ownership around the active QA fixes. Estimate: 2–4 focused developer days after source freeze, one implementation worker plus review; native tests and Tim’s combined AutoCAD acceptance remain ahead. Full Structural embedding, Project/Sheets/Issue and Time/Reports integration remain subsequent work; automatic QA work already underway continues.

**10 September 2026 — shared-suite visuals:** Tim requested the visual pack and V3 plan be updated for one Project, CESHEETS, Issue Drawings, Job Time, Time Reports and Checklist & QA across Civil and Structural, plus one Settings and Help home for all three modules. The [shared-suite visual update](design/V3_UI/00L_SHARED_SUITE_VISUALS_2026-09-10.md) records the clickable examples, retained detailed controls, automatic-evidence flow and staged native completion criteria. This is a design update; native integration, production QA and Tim’s AutoCAD acceptance remain separate.

**9 September implementation check:** [Current native source, reusable work, preservation corrections and build batches](design/V3_UI/00I_NATIVE_IMPLEMENTATION_HANDOFF_2026-09-09.md). Civil/Manager installed source is 96e7d76a; Structural installed source is 66b23137. Existing first-colleague owner has frozen 9357a1bd as a separately approved interim test candidate. New UI implementation is pending and must reuse those current owners, not the old planning checkout.

**9 September 2026 — Drawing desk direction approved and integrated into the complete clickable pack.** Tim approved the concept with “LOOKS GOOD LETS PROCEED PLEASE”; both themes remain. The 41-window inventory, 49 workflow decisions and approved icon artwork are retained. See [integration and verification](design/V3_UI/00H_DRAWING_DESK_INTEGRATION_2026-09-09.md) and [next-release inclusion requirements](design/V3_UI/00G_RELEASE_REQUIREMENTS_AND_VISUAL_DIRECTION_2026-09-09.md). Final integrated-layout review, shared Civil/Structural workspace detail, native implementation and AutoCAD acceptance remain pending.


**6 September 2026 — expanded Civil production scope:** [shared plan](DRAWING_PRODUCTION_PLAN.md), [audit-to-delivery register](DRAFTING_DELIVERY_REGISTER.md), and section 12 below include C01–C10 plus E/U requirements. Target: CE-standard drawings with fewer user steps and reliable coordinated output. Civil+Manager first; C5 before C6; R1 alongside C2 under #58/#60. Earlier dated status/route paragraphs remain historical where superseded. New output scope does not silently become a prerequisite for the current office pilot.

**Reconciled:** 2026-09-04. Tim approved this reconciliation and D1–D10 in the Codex task "Review Claude work and plans".
**Current delivery status:** [GitHub board](https://github.com/users/timbrand92/projects/2) and [WHERE WE ARE #24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24).
**Decisions and preservation record:** [September reconciliation](PLAN_RECONCILIATION_2026-09-04.md).
The board controls current status, not engineering truth: Tim's explicit decisions and approved workflow cards outrank stale board text, research and draft designs.

## 1. The result and route

| Level | AutoCAD result | Delivery |
|---|---|---|
| 0 | Existing production commands | Preserve working behaviour |
| 1 | Smart pipe/pit editors | C2 |
| 2 | Drawing relationships, explicit Unknown states and review | C1–C4; C5 remains in the Level 2 milestone |
| 3 | Assisted proposals with engineer approval | C6, after C5 |
| 4 | Drafting with engineer sign-off | Later; not this release |

Civil reports product version 3.0.0 already; that number does not prove acceptance.
Route: **C0 → C1 + C2 → C3 → C4 → C5 → C6 → Structural pilot → office pilot → single ribbon**.
C2 may start against the frozen C1 interface before C1 acceptance, but must not ship on an unaccepted integration.
M1 is independent and must be ready for S3; it is not artificially blocked until Civil finishes.
A package containing early C4 work does not close C1 or C4.

| Chunk | Issue | Purpose / completion check | Evidence at reconciliation |
|---|---|---|---|
| C0 | [#26](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/26) | Reliable grips/selection; latest exact build accepted by Tim | Earlier managed route and twin selection passed; latest combined Test Day pending |
| C1 | [#27](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/27) | Shared identity/relationships, reversible explicit upgrade, CDCHECK | Built substantially; early AutoCAD pass; final acceptance and hold-points open |
| C2 | [#28](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/28) | Pipe/pit/schedule editors, Reset Position, one Undo | Assigned to Codex; advertised branch/start not evidenced |
| C3 | [#29](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/29) | Sources, CE-aware edits, connection repair | Approved; completion not evidenced |
| C4 | [#30](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/30) | Review workspace and sourced rulebook | Project pit-drop setting/check built; broader scope remains |
| C5 | [#32](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/32) | Slab, DWG-led import, repair, settings | Fixture/testing groundwork only; importer remains defective |
| C6 | [#31](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/31) | Ranked proposals, company learning, read-only bridge first | Approved scope; not accepted |
| S1–S3 | [#33](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/33), [#34](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/34), [#35](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/35) | **2026-09-07:** Structural window design now included, aligned to Level 3 with Level 4 marked Planned; adoption, colleague workflows and pilot retained | Windows 18–33; existing runtime/engineering gates remain; no completion claim |
| M1 | [#36](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/36) | **2026-09-07:** Manager design extended to all existing status, support, company and update controls | Windows 34–35; existing safe-update/rollback ownership remains; required before S3 |

No overall completion percentage is claimed until remaining chunk work has an agreed denominator.
Time estimates belong to each active work order; do not convert test counts or approved cards into product completion.

## 2. Tim's approved decisions

| ID | Decision | Applies to |
|---|---|---|
| D1 | Store centreline; compute all six named pipe lengths from that geometry | C1/C3 |
| D2 | Explicit per-object upgrade; never silently upgrade on open | C1/C5 |
| D3 | A branch junction leaves the main as one logical pipe with an internal node | C1/C3 |
| D4 | Mark Stale after relevant edit; re-check on demand; never silently fix | C4 |
| D5 | Review workspace uses Project Explorer + Prospector + Vistas as design references | C4/UI |
| D6 | Catchment uses the Civil 3D field set plus a Stale link to source geometry | C4/C6 |
| D7 | Calculations derive from AS/NZS 3500.3 + Rational Method + council matrix | C4/C6 |
| D8 | Approve catalogue-size grip, consistent action-shape language and Reset Position | C2/grips |
| D9 | **Keep the DWG geometry as the model** | C5/#40 |
| D10 | Replace invalid LandXML fixture; keep the old one as a negative test | C5 testing |

D9 **rejects** the research recommendation "LandXML is the model, DWG is background".
Do not replace DWG geometry/topology from LandXML under this approval. Any supplementary LandXML
use needs its field-level reconciliation/preview contract recorded before implementation.
D10 approves the bounded fixture correction, not broad client-data/AI access.
D7 selects calculation authorities, not unverified velocity limits or guessed numeric defaults.
D8 does not require a broken experimental glyph path to remain live: final AutoCAD visibility/operation still gates acceptance.

Research remains useful evidence, not product requirements wholesale. Details outside these rulings
and earlier approved workflow cards require the command/workflow review gate.

## 3. One UI programme, not two competing V3 plans

The original research narrative and UI draft are preserved in [the evidence index](planning-evidence/2026-09-04/README.md).
The [master design brief](design/V3_UI/00_MASTER_BRIEF.md), [ribbon draft](design/V3_UI/windows/01_RIBBON.md)
and kit files are preserved drafts, **not blanket implementation approval**. This reconciled plan and
Tim's rulings take priority over conflicting wording inside those snapshots.

| Area | Target surface | Chunk / boundary |
|---|---|---|
| 0 | Shell, Help, Ask CE, Manager, What's New/Feedback | M1/C6 as scoped; unified ribbon after office pilot |
| 1 | One Pipe window, New/Edit, three-step new flow | C2 |
| 2 | One Pit window, New/Edit, presets | C2 |
| 3 | CDEDIT doorway, same-type batch, action grips, Civil Properties | C2/C3 |
| 4 | Sources step card and Water Tank/devices | C3 |
| 5 | Slab System, levels, joints, tree zones | C5 |
| 6 | Review: Checks, Calculations, Profiles, Proposals; pit schedule | C4/C6; schedule editor in C2 |
| 7 | Survey/consultant import and comparison, DWG geometry authoritative | C5 |
| 8 | Personal/project/firm settings and Repair & Upgrade | C5, subject to approved shared settings ownership |

Keep the approved floating/no-scroll editor aims, the 20-row pit schedule, in-canvas previews and
one Undo per accepted edit. Constant-use tools get lightweight prompts/previews; occasional
project review gets a workspace. The four preserved design files exist; the assembled clickable
pack and remaining window designs were not present in the inspected folder and remain pending.
Tim has approved D1–D10, not every unfinished screen.

Ribbon stages remain incremental: current Civil tab work within existing contracts first;
single discipline-aware CE ribbon after the office pilot and its own review/acceptance.

## 4. Preserve carried scope

| Earlier item | Destination / treatment |
|---|---|
| Standard Orifice Pit Detail (BUG-003) | Retained C4/C5 design candidate; scope placement before implementation |
| Layer/draw-order/colour/text/dimension manager (BUG-004) | Preserve existing work; settings scope, not silently transferred to release Manager |
| Multi-segment grade | D1/D3 single logical pipe and explicit derived lengths |
| Long-section grade parser | C4 one calculation/rounding authority |
| CDHELP search | Help Centre work; retain shared ownership review |
| PITSCHEDULE Excel export | C4 review export; existing CSV is not full XLSX acceptance |
| Multi-pipe CDMA | C2/C3 batch editing |
| WebView2/offline prerequisites | M1/release review; no new installer script authorised here |
| Bind-graph checks / Fusion logging diagnostics | Retained diagnostics candidates; no restart/registry change authorised here |

**2026-09-07 — later design ruling:** Tim approved extending the v3 design pack to Structural and Manager windows too — see [windows 18–35](design/V3_UI/README.md), [Manager 34](design/V3_UI/windows/34_MANAGER.md) and [Company Controls 35](design/V3_UI/windows/35_COMPANY_CONTROLS.md). This supersedes the earlier exclusion of Structural window redesign and the dashboard-only Manager design scope. All three modules use the same CE colours and design system. Structural follows the Level 3 vision and prepares explicitly labelled Level 4 review surfaces. Runtime workflow approval, engineering authority, the formal history-preserving import and the host/installer merge remain separate.

## 5. Completion and safety

- Each relevant chunk has reviewed code, exact-build test evidence and its existing consolidated Tim acceptance.
- C5 precedes C6; the Level 2 milestone is not closed with C5 still outstanding.
- Record implemented, tested, installed and accepted separately.
- The newest combined Civil record is source 9050f497 / build 2026.0904.1057, deployed by Claude
  at 11:07 Sydney on 4 September per #24; this session did not reverify the live DLLs.
- C1 rollback/project-record synchronisation, COPY identity, dormant record storage and C4
  name-based matching/multi-pipe policy remain explicit hold-points; see reconciliation record.
- DATA-01 safeguards, native AutoCAD protections and the 12 design rules stay in force.
- Claude keeps deployment authority; Codex does not build/deploy as part of this docs-only work.

---

# Part B — Design-pack programme, Codex control-plan content and rulings after the reconciliation (2026-09-04/05)

Part A above is the Control chat's reconciled delivery plan (Tim approved D1–D10). Part B carries the UI/UX design
pack that was still "pending" when Part A was written, the Codex living-control-plan content, and Tim's later
rulings of 4–5 September. **Where Part A and Part B disagree, the later dated Tim ruling wins; each such point is
listed here rather than chosen silently:**

| Part A says | Later ruling (Tim) | Now |
|---|---|---|
| Unified ribbon after the office pilot | 2026-09-04 "fix this": the single `CE` tab must not wait for the pilot | **R1** (#60, Approved) ships alongside C2; Structural/Manager join after the pilot |
| Area 4 = "Sources step card" | 2026-09-02 approved Source *window* `Source / Connection / Drawing`; 2026-09-05 review adds the `LPD` type | Source window (design 06) |
| "Assembled clickable pack and remaining window designs … pending" | All 17 windows, the prototype and the sweep exist on this branch; Tim reviewed them 2026-09-05 (#58) | Part B §8 |
| C5 precedes C6 | Board (#24 path) says C6 before C5 | **Unresolved — Control chat to confirm on #24**; Part B keeps the board order and notes Part A's |

**Status:** UI/UX visual directions approved (all Areas + CDSETUP); design pack in progress; production build gated per Area
**Updated:** 2026-09-04 (merged: Codex living control plan of 2026-09-01/02 + Claude design-pack programme of 2026-09-04)
**Target ship:** set after the audited scope and measured build sequence are approved
**Authority for status and sequence:** Tim's recorded decisions; the GitHub board (`users/timbrand92/projects/2`) and
pinned issue #24 for chunk status; this plan for scope, gates and window design state. When they disagree, record
the conflict and get Tim's decision — never choose silently.

## 0. Update log (newest first)

| Date | Change |
|---|---|
| 2026-09-05 | Tim reviewed the whole pack; answers and decisions in `docs/design/V3_UI/00C_TIM_REVIEW_2026-09-05.md` and §8.5 (CDSETUP → CDDESIGN, pre-filled Pipe window, live Civil Properties, LPD source, Systems, Fix column…). |
| 2026-09-04 | **Merged plan.** Codex's living control plan (branch `codex/civil-ui-ux-area-plan` @ `472ca53a`) is the base; Claude's board-chunk mapping (§2) and design-pack programme (§8) added; Tim's no-scroll rule recorded (§6); reconciliation in `docs/design/V3_UI/00A_CODEX_RECONCILIATION.md`. The Codex branch copy is superseded when this merges. |
| 2026-09-04 | Tim: the single `CE` ribbon tab must not wait for the office pilot — CE_SHARED contract change (R1) scheduled alongside C2. Tim: every window non-scrollable, everything visible on open, tabs allowed. Tim: keep parallel agents to 2–3. |
| 2026-09-02 | Tim approved the repeat-use visual direction for all eight primary Civil Areas and the CDSETUP cross-family workflow (Area 0A). Decisions D1–D32 recorded in `docs/CE_CIVIL_V3_UI_UX_DECISION_QUEUE.md`. |
| 2026-09-01 | Deep v3.0 audit started; full-function preservation gate, one-area-at-a-time approval/build, shared-look consistency and final assembled AutoCAD acceptance became controlling rules. |
| 2026-08-31 | CDEDIT / PIPEEDIT / PITEDIT and Drawing Intelligence briefs added to `master`. |
| 2026-05-14 | Stub created (orifice pit detail headline, deferred items). |

## 1. Purpose and what v3 is

This is the control document for CE Civil v3.0. Every Civil command, window, interaction, engineering improvement,
visual rule, rename, build stage, approval and test result must be traceable here or through a register linked from
here.

v3 is the **Civil module at Level 2 then Level 3** on the shared object spine, with **one cohesive AutoCAD-style
user interface** across every Civil window and the CE ribbon. Drainage already reports version `3.0.0`; v3 *ships*
when C4 (Civil Level 2) is accepted in AutoCAD and the Areas 1–3 windows are live.

Level ladder (Tim, 2026-09-03): 0 commands (live) → 1 smart editors → 2 understands the drawing →
3 assisted design → 4 drafts with engineer sign-off. v3 = Levels 1–3.

## 2. Board chunks that make up v3

| Chunk | Issue | What it delivers | Areas / windows |
|---|---|---|---|
| C0 | #26 | Stage 1 grips deployed and tested | grips meaning (Area 3) |
| C1 | #27 | shared spine, one-time upgrade, `CDCHECK` list | Drawing Repair & Upgrade (Area 8), Checks list style (Area 6) |
| C2 | #28 | Pipe and Pit editors on the spine, batch, grips, Reset Position | Areas 1, 2, 3 |
| C3 | #29 | sources and water-tank windows, CE-aware TRIM/EXTEND/BREAK/JOIN/MOVE, `CDCHECK` actions | Area 4, in-canvas prompts (Area 3), Checks actions (Area 6) |
| C4 | #30 | Project Review workspace + Engineering Rulebook v1 — **Civil Level 2** | Area 6 |
| C6 | #31 | proposals engine + plugin reports to Claude/Codex — **Civil Level 3** | Proposals tab (Area 6), Ask CE |
| C5 | #32 | slab, import, repair (after C6) | Areas 5, 7, 8 |
| 0A | (to be boarded) | `CDSETUP` Civil Project Start — behaviour and visual approved, build not scheduled | Area 0A |
| S1–S3 | #33 / #34 / #35 | **2026-09-07:** Structural design pack covers drafting, project, sheets and supporting workflows; Level 3 alignment, Level 4 Planned | Windows 18–33; implementation remains under existing workflow cards |
| M1 | #36 | **2026-09-07:** Manager dashboard, update, health/support and company administration designs; supersedes dashboard + one-button-only design scope | Windows 34–35; no installer/release-service change |
| R1 | (needs a board issue) | **CE_SHARED ribbon contract** — split buttons, toggle/checked state, contextual tabs on selection, keytips, status-dot button, gallery, discipline-aware panel set — built **alongside C2**, Claude-owned (shared/spine lane), so the single `CE` tab ships with the Civil windows, not after the pilot (Tim, 2026-09-04) | Ribbon (Area 0) |
| later | #24 path | office pilot → single ribbon **turned on for Structural/Manager** (Civil already on it via R1) | Ribbon (Area 0) |

## 3. Current approved direction (Tim, 2026-09-01/02, unchanged by the 2026-09-04 work)

- The everyday Civil editor uses **three clear steps as slim text tabs**, so AutoCAD remains visible:
  `Pipe / Levels & Connections / Drawing & Schedule`; `Pit / Levels & Pipes / Drawing & Schedule`;
  `Source / Connection / Drawing`; `Tank / Levels & Hydraulics / Drawing & Detail`; `Slab / Surface / Drawing &
  Panels`; Review `Project Checks / Calculations / Profiles` (+ `Proposals` for Level 3); Intake `Source &
  Alignment / Civil Items / Preview CE Drawing`. **Save and Close on every tab.**
- The real AutoCAD drawing is the main visual reference. `Inspect Drawing`, `Show where` and `Focus on…` expose the
  drawing without losing the editing session. No miniature pipe schematic (D5).
- Verified Creative Engineering branding: graphite, warm-white and gold, following the AutoCAD light/dark theme with
  a personal override (D4). Visually strong, professional, consistent with Autodesk drafting tools.
- Plain AutoCAD, drafting and engineering language — never unexplained software terminology.
- **Repeat-use premise for every Civil window:** routine editing shows values, status and the next useful action
  only. Explanations stay hidden unless the user asks for evidence or the drawing contains an Unknown, ambiguity,
  conflict or blocked action. Full control remains one plainly named action away; reducing visual noise never
  retires a function.
- High-frequency interactions are immediate and visually steady: no entrance effects, no web-style feature cards,
  no competing colour blocks, **no scrolling within the normal supported window sizes**. Engineering numbers use
  aligned digits and status is never communicated by colour alone.
- Three visible CE action grips (Slide, Offset, Flip Side) beside one exact verified child; Reset Position in the
  hover menu; native grips untouched (D6).
- A sole verified compatible editable current-drawing pit inside the enabled 75 mm tolerance connects
  automatically; ambiguity, incompatible items, locked/protected content and Xrefs always ask.

This direction is a shell decision, not a completed window design. Tim has explicitly rejected any mockup that does
not account for all current functionality.

## 4. Full-function preservation gate

A cleaner window must not reduce what CE Civil can do. Before an existing command or window is replaced, every
current button, field, menu choice, selection route, keyboard route, double-click route, grip action, drawing prompt
and saved behaviour must appear in a current-to-new **coverage register** with one outcome:

- **Kept** — same real purpose in the new experience.
- **Moved** — same purpose, with the new location recorded.
- **Combined** — a clearer action performs the complete old job.
- **Replaced** — an approved workflow demonstrably performs the same drafting/engineering task better.
- **Retired** — only after Tim explicitly approves removal because it is duplicate, unsafe or no longer required.

Unverified functions remain in scope. Visual tidying alone is never a reason to remove a capability. Every design
file in the design pack carries this register (section 8).

## 5. Authority order

1. Tim's recorded decisions and approved workflow cards (`docs/CE_CIVIL_V3_UI_UX_DECISION_QUEUE.md`, `docs/CARDS/`).
2. This living control plan and its linked registers, including the design pack's master brief
   (`docs/design/V3_UI/00_MASTER_BRIEF.md`) for presentation.
3. `CE_CIVIL_EDITOR_UI_UX_BRIEF.md` and `CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md`.
4. Approved engineering/network contracts and calculation rulebook entries.
5. Verified current production behaviour and drawing evidence.
6. Official Autodesk interaction evidence and CE project evidence used as design input.
7. Earlier mockups/branches used as inspiration only.

If evidence conflicts, record the conflict and obtain a decision. Do not silently choose.

## 6. Shared look-and-feel rule

- One verified CE graphite, warm-white and gold foundation using real CE brand assets; follows AutoCAD light/dark.
- One typography, spacing, button, field, message, highlight and status system across every Civil window (the
  design pack's kit is its prototype).
- One meaning for shared actions: `Inspect Drawing`, `Show where`, `Focus`, `Cancel`, `Save and Close`,
  `Apply to Selected`, `Reset`.
- One plain-language validation scale in editors: `Info`, `Warning`, `Cannot save` (review lists say `Blocking`).
- Engineering meaning and drawing presentation remain distinct everywhere.
- Important states use words and shape as well as colour.
- Rare actions remain discoverable under accurate names; they are not discarded.
- **No-scroll rule (Tim, 2026-09-04):** every window, palette, card and workspace is non-scrollable and everything
  on the open tab is visible on open; content that does not fit gets tabs; lists and grids show a fixed row count
  (the Combined Pit Schedule shows every row with no paging).

## 7. Area map and gates

Each area passes these stages before the next area is built: **Observe current → Research → Map every function →
Plan the area → Show visuals → Tim approval → Build only that approved area → Automated verification** with a
concise final AutoCAD checklist. Tim tests the assembled Civil experience at the end. Only one area proceeds through
visual approval and production build at a time unless Tim changes that rule.

Every checkpoint states: the exact workflow/window and retained current routes; current state (**Behaviour
reviewed / Visual approved / Built / Connected / Automated checks passed / AutoCAD accepted**); branch and commit
where production work exists; what remains unavailable, unproven or parked; the next owner and gate. A visual mockup
is not Built. Built is not Connected. Connected and automated checks are not AutoCAD accepted.

| Order | Area | Main coverage | Behaviour | Visual | Built / Connected / Checks / AutoCAD |
|---:|---|---|---|---|---|
| 0 | Shared Civil editor shell + one `CE` ribbon | theme, identity, tabs, inspection/focus, validation, read-only, Help, Cancel, Save and Close; ribbon regroup now, single tab after the pilot | reviewed | approved | no |
| 0A | CDSETUP / Civil Project Start | project/council evidence, LPD pick and note, OSD/PSD/SSR, highlighted area confirmation, Engineer/Draftsperson/Continue routes, CDCALC hand-off | approved (CV-00, `429d4632`) | approved | no |
| 1 | CDEDIT selection and batch editing | pre-selection, prompted selection, annotation ownership, routing (`Edit Civil Item(s)`), same-type batch, grouped mixed selections | decision-ready | attachment grips approved | no |
| 2 | CD / PIPEEDIT | draw-first route, all pipe types, Simple Pipe saves, engineering, flow, levels, connections, presentation, schedule | approved | approved | no |
| 3 | PIT / PITEDIT / Combined Pit Schedule | pick/rotation strip, pit engineering, connected pipes, presentation, one physical schedule, direct schedule editing | approved | approved | no |
| 4 | Sources and attachments, CDWT | shared Source window, source-first, tag rotation, CDWT plan vs construction detail | approved | approved | no |
| 5 | Slab System / surface / levels | boundary first, click-anywhere levels, conflicts, panels, joints, drains, arrows | approved | approved | no |
| 6 | Review / calculations / profiles (+ proposals) | read-only checks, Calculate/Review/Approve/Apply, propagation review, long sections, vertical proposals | approved | approved | no |
| 7 | Intake — survey / import / consultant | one Intake workspace, non-writing comparison and consultant check, provenance | approved | approved | no |
| 8 | Drawing Repair / legacy upgrade / settings / administration | read-only check, optional repair, quarantine, evidence-led upgrade, Personal/Project/Firm settings, controlled learning | approved | approved | no |

Detailed checkpoints and approval records for each Area (2026-09-01/02) are in
`docs/CE_CIVIL_V3_UI_UX_DECISION_QUEUE.md` and the Codex branch's plan history; they are not repeated here.

## 8. The V3 UI/UX design pack (Claude, from 2026-09-04)

**What it is:** the presentation authority the window builder builds from — one design file per window in the
pack's eleven-section format (including the coverage register) plus one clickable prototype page that looks like
AutoCAD 2027 with the CE ribbon. It conforms to the approved Area directions above (reconciliation:
`docs/design/V3_UI/00A_CODEX_RECONCILIATION.md`). It is *Visual approved candidate* material, not Built.

**Where:** `docs/design/V3_UI/` — `00_MASTER_BRIEF.md` (design system, window map, fragment contract),
`windows/NN_*.md` (designs), `mockups/NN-*.html` (fragments), `kit/` (shared CSS/JS + contract),
`CE_V3_UI_DESIGN_PACK.html` (assembled page, when built).

### 8.1 Window map

| Area | V3 window | Replaces today | Design | Mockup |
|---|---|---|---|---|
| 0 | CE Shell + one `CE` ribbon tab (discipline-aware, contextual tabs, `Start Civil`) | `CE Civil` / `CE Structural` / `CE Tools` tabs | 01 done | done, verified |
| 0 | Help Centre · Ask CE · Manager · status dot · What's New · Feedback | `CDHELP` + `CEHELP` + How-To window | 16 queued | queued |
| 0A | Civil Project Start (`CDSETUP`) | new | 17 queued | queued |
| 1 | Pipe (New / Edit, three tabs) | `CdDialog` (both layouts) + `PipeEditWorkshopDialog` | 02 done → rework to tabs | rework |
| 2 | Pit (New / Edit, three tabs, canvas rotation strip) | `PitDialog` + `PitEditWorkshopDialog` + `CDPIT350…1200` | 03 done → rework | rework |
| 3 | Edit doorway: `CDEDIT`, grouped mixed selection, batch, grips, in-canvas prompts | `BatchEditWorkshopDialog`, `CDMA`, `CDTEXTSEG`, `CDANNOTATIONEDIT` | 04 done → rework (D1, D2, D6) | rework |
| 3 | Civil Properties docked palette | `CDINSPECTOR` panel + Hub health strip | 05 done → no-scroll fix | fix |
| 4 | Source window (three tabs) | eleven prompt chains | 06 done as a card → rework to the approved window | rework |
| 4 | Water Tank (three tabs, plan vs detail states) | `CDWT` prompt chain | 07 queued | queued |
| 5 | Slab System (three tabs) | `SlabDialog` + `SlabEditDialog` + `CDSLABIMPORT` | 08 queued | queued |
| 6 | Project Review: Project Checks · Calculations · Profiles · Proposals (+ `CDCHECK` popup) | Dashboard, both Calculations dialogs, Profile, Civil Hub, Proposal/Cascade previews | 09–11 queued | queued |
| 6 | Combined Pit Schedule (every row, no paging, ten columns) | `PitScheduleDialog` | 12 queued | queued |
| 7 | Intake (three steps + two non-writing pages) | five separate flows | 13 queued | queued |
| 8 | Settings `CESETTINGS` (Personal · Project · Firm) | `CDS`, `CDMANAGER`, `CDLABELSTYLE`, `CDPARTS`, OSNAP | 14 queued | queued |
| 8 | Drawing Repair & Upgrade | Repair Center launcher + Link tool | 15 queued | queued |

### 8.2 Ribbon plan (Tim, 2026-09-04: do not wait for the pilot)

1. **R1 — CE_SHARED ribbon contract, built alongside C2** (Claude, shared lane): the additions listed in
   `docs/design/V3_UI/windows/01_RIBBON.md` §6 (split button with default action, toggle/checked state, contextual
   tab keyed by selected CE family, keytips, status-dot button, gallery, dialog launcher, discipline-aware panel set).
   Additive to `ICeRibbonContributor`; today's three tabs keep working until each module opts in.
2. **Civil on the single `CE` tab from C2's Test Day**: the Civil contributor moves to the new contract in the same
   chunk as the Pipe/Pit windows, so contextual `Pipe` / `Pit` / `Source` tabs are live with the editors.
3. **Structural and Manager join the `CE` tab** after the office pilot (unchanged board path); until then they stay
   on their own tabs beside `CE`.
Needs one board issue (`R1 CE_SHARED ribbon contract`, Approved column, milestone Civil Level 2) — not yet created.

### 8.3 Pack status (2026-09-04, end of day)

| Item | State |
|---|---|
| Master brief | revised: 2026-09-02 decisions, no-scroll, plain English, emphasis, cockpit test, tabs-not-hidden-pages, gold on dark / deep blue on light |
| Kit (CSS/JS/contract) + AutoCAD shell | done; windows float over the whole frame at their declared size |
| Ribbon design + mockup | done, coverage register added (four unhomed Structural items need Tim — see sweep report) |
| Windows 02–17 (all 17) | designed, browser-verified no-scroll, reworked to Tim's rulings, committed |
| Consistency sweep | done — `docs/design/V3_UI/00B_SWEEP_REPORT.md` (41 fixes, 8 structural fixes applied, 86 questions consolidated) |
| Assembled page | `docs/design/V3_UI/CE_V3_UI_DESIGN_PACK.html` (1.2 MB) — every command opens its window at size, zero console errors |
| Tim's review | done 2026-09-05 — decisions applied to the design files and prototype (#58, §8.5); PR #59 ready for merge |

### 8.4 Decisions for Tim (answer in one line each)

1. ~~Accent colour~~ **Answered 2026-09-04:** gold on dark; a new colour on light — CE deep blue `#1E5AA8` (Tim vetoed teal).
2. ~~Connection verbs~~ **Answered 2026-09-04:** the plain set everywhere; and **no software jargon anywhere** —
   plain English or AutoCAD language only (word list in the master brief §5).
3. Per-window questions (86, one-word answers) are consolidated in `docs/design/V3_UI/00B_SWEEP_REPORT.md` and
   go to the weekly decisions issue after Tim's first look at the pack.
4. Ribbon coverage register found four Structural items with no V3 home (Workspace ×5, System ×2, Standards page,
   two unnamed flyouts) and asks whether the old `CE CVL` pull-down menu and toolbars stay as a second way in.

### 8.5 Tim's review of the pack — 2026-09-05 (binding for the wiring)

Tim reviewed every window in the prototype. His feedback, the decision for each point and what the builder must do
are recorded in `docs/design/V3_UI/00C_TIM_REVIEW_2026-09-05.md`. Headline decisions:

- **`CDSETUP` becomes `CDDESIGN` — "Design"**, first button on the Civil ribbon, used at job start, during and finish;
  it owns inputs and decisions, `CDCALC` owns calculations and the report; engineers can override any value (marked
  `manual`, never blocked).
- **Pipe window opens pre-filled from context** (type, diameter, grade, known end, other IL) — a healthy pipe is
  Enter, Enter; presets renamed to what they draw (`Full · Label only · Line only · Line + arrow`); decimals as one
  pick list; text/arrow are toggles; small drawing preview on the `Drawing` tab; "How it runs" → `Drawing breaks`.
- **Civil Properties edits in place, live, like AutoCAD Properties** for safe fields; cascading levels go to the editor.
- **Plastic pit preset locks out** number, cover text, schedule, detail. **LPD** becomes a source type with its
  linked standard note. **Source tag numbering** is a project setting (default: only when scheduled).
- **Water Tank** gains add/change/remove/replace of inlets, risers, droppers, overflows; tank library in Settings.
- **Slab** gains surface outlets and a `Show flow` overlay; joint layout stays advisory pending research.
- **Project Review** rows get a recommended `Fix`; **Intake** opens quiet; **Systems** (property / outfall /
  council) on every pipe drive profiles, schedules and notes; downstream effects always previewed before Apply.
- **Help** gets the ribbon picture, a full task-guide set with pictures, Ask CE and Report a problem (with automatic
  screenshot) inside it; old command names appear nowhere; What's New lists all 3.0 changes by area.
- **Placed Pit Schedule is a linked table**: updates in place by identity (never delete-and-reinsert); double-click opens the
  Pit Schedule window at that cell; `Change the pit` vs `Change how it reads` per cell.
- **Drawing Repair opens on one question and one recommended fix** ("people use it stressed"); the full workspace sits
  behind `Show everything`; `Send this to Tim` on every screen.
- **Settings is the frozen look-and-feel reference** for every V3 window.
- Two research items for the Idea column: Civil 3D grading/outlet behaviour; slab joint cracking logic.

| Chunk | Extra acceptance from this review |
|---|---|
| C2 | pre-filled Pipe window; preset names; toggles; preview; plastic-pit lock-out; live Civil Properties edits |
| C3 | LPD source type; tag numbering setting; tank connections list; tank library |
| C4 | `Fix` column and zoom-to-object; Systems; profile detail block; modern calc report; `Explain`; linked placed schedule with in-place update and double-click-to-window |
| C5 | quiet Intake; conversion validated on past consultant jobs; slab outlets and flow overlay; one-question Repair with one recommended fix |
| C6 | detention layout proposal; Ask CE answers cite their source; downstream-effect previews |
| 0A | `CDDESIGN` with Start / During / Finish |
| M1 | update dot within a minute; feedback reports counted in Manager |

## 9. Retained v3.0 engineering candidates

- CE Standard Orifice Pit Detail and CDCALC integration remain flagship engineering work (Calculations panel +
  standard-detail intelligence, Area 6 + C6).
- Layer/draw-order/colour/text/dimension management remains in scope where not already shipped (Settings pages).
- Multi-segment pipe grades, shared grade parsing, Help search, Pit Schedule export, multi-pipe arrow movement,
  offline WebView support, dependency checks and support diagnostics remain tracked candidates.
- Each candidate must be reconciled with the complete command/workflow inventory and placed in the correct area
  before build.

## 10. Research findings still governing implementation (2026-09-01)

- The installed Civil DLL, the protected integration worktree and the clean branch describe different source states;
  reconcile by path/hash/commit before labelling any as the single current truth.
- `CdDialog` contains two complete layouts (three-column and four-step) that are not functionally equivalent;
  retirement requires field/action parity evidence.
- Broad `CDEDIT` routing (slabs, spoon drains, tanks, raingardens) and the slide/offset/flip grips exist only as
  protected-worktree/current-product evidence, not clean-branch behaviour.
- Current double-click handling deliberately bypasses CE text (earlier interception corrupted AutoCAD text); the
  approved end state needs a safe replacement, not a visual change.
- Right-click actions must show only for proven CE objects; `CDEDIT` preselection needs `UsePickSet` and a visible
  mixed-selection summary; PIPEEDIT's `Move Arrow` request must be consumed by `Adjust Drawing Positions`.
- `Recall Last` is limited to explicit Presentation and Engineering-default scopes.
- The 5 mm default pit invert drop and the 20 mm minimum outlet drop are two recorded values; do not unify without
  Tim (decisions issue #25, item 11).
- One accepted edit must be verified as one AutoCAD Undo across geometry and Civil records; cancelled preview must add
  no Undo entry or save prompt.

## 11. Out of scope for v3

The history-preserving repo import (§16.5 of the master plan) and the unified single-host installer.

**2026-09-07:** Tim approved Structural and Manager window redesign **within the modular design pack**; the previous “S1–S3 adopt the shell conventions only” exclusion is superseded. See [window designs 18–35](design/V3_UI/README.md). Shared colours/design system are settled. This authorises reviewable documents and clickable examples; it does not ship XAML/C#, change engineering behaviour or approve Level 4 automation.

## 12. CE drawing-production extension — approved for planning 6 September 2026

**Target:** familiar CE drainage drawings produced faster, with fewer repeated inputs, less label tidy-up and reliable coordinated issue outputs. Tim approved adding the full audit to all three module plans. [Shared delivery method](DRAWING_PRODUCTION_PLAN.md) and [44-item register](DRAFTING_DELIVERY_REGISTER.md) define evidence reuse and all acceptance links.

These rows extend C3–C5/C6 and existing CV/PS/QA cards; they do not claim implementation or enlarge the current office-pilot prerequisite set indiscriminately. C5 remains before C6. Existing native editing and later exact selection/commit rulings govern; new operations get a bounded workflow card.

### Shared CE project workspaces — added by Tim, 7 September 2026

**9 September clarification — authoritative shared experience:** Tim reaffirmed Job Time, Time Reports, CESHEETS and Checklists for Civil and Structural, explicitly included **Issue Drawings**, and required **one CE Settings window and one Help Centre across Civil, Structural and Manager**. These are shared destinations with context/pages, not separately branded module copies. [Shared-workspace and automatic-QA handoff](design/V3_UI/00K_SHARED_WORKSPACES_AND_AUTOMATIC_QA_2026-09-09.md) records current native routes, migration boundaries, automatic-evidence behaviour and mixed-job acceptance. Reuse approved QA-01: routine proven checks complete automatically and quietly; human engineering decisions remain distinct. No pop-ups or new warning/checklist lockouts, and no guessed pass or automatic engineering certification. Shared scope is approved; the joined visual presentation is addressed by the September 10 pass; complete native control/data integration and AutoCAD acceptance remain outstanding. The historical “five” below describes the original request, not the current scope limit.


Tim explicitly requested Project and Sheets for Civil, then added Job Time, Time Reports and Checklists. All five belong in the overall CE V3 plan as **shared CE workspaces available from Civil and Structural**. **Shared scope is approved. The September 10 clickable pack now demonstrates the joined visual direction; remaining native migration decisions and complete control/data parity stay in the relevant workflow cards.**

- Use one CE project identity and shared drawing register, with Civil, Structural and All disciplines views. Reuse the shared Project/Sheets design and issue records instead of maintaining duplicate discipline project data.
- Job Time uses one job/time record across Civil and Structural, with task and discipline context; switching discipline does not create a duplicate timer. Review allocation, pause/idle, manual correction and save/reopen before runtime work.
- Time Reports reads those same records, with person/job/date/discipline filters and combined job totals. Do not duplicate hours across the combined and discipline views. Preserve reviewed access, source and export rules.
- Checklists combines shared project/issue tasks with Civil and Structural task sets. Offer the active drawing/task view alongside the full project list; completed Civil work does not silently complete a Structural check. Checklist items stay tied to their actual drawing or project scope.
- These are project production tools; Manager retains installation/update/support and Company Controls. Shared ownership does not require moving working runtime commands before their replacements pass acceptance.
- Civil Project brings together project details, drawings, source changes, tasks/checks and recent issue history. Keep the approved CDDESIGN/CDSETUP engineering setup and CDDASHBOARD engineering review routes; reconcile their entrances in the workflow review.
- Civil Sheets covers drainage plans, pit schedules, long sections and construction details: drawing/layout links, sheet number/title, revision, titleblock mapping, selected-set issue and output preview. Show Civil checks within the Civil view.
- A sample job might include C01 Drainage plan, C02 Stormwater details, S01 Ground framing and S03 Sections. Default to the active discipline; All disciplines shows the full job. Issuing Civil sheets does not silently issue Structural sheets.
- Carry the reviewed exact-selection rule, advisory checks, retained excluded register rows, exact note **Not included in this issue.**, and ACI 251 row text into the shared issue design. Keep ordinary borders/background and explicit per-DWG recovery.
- Delivery: first review 10–15 shared-workspace/Civil workflow questions with drafting examples, then add a Civil design variant, then implement a bounded shared slice under the existing project/sheet owners. Inventory current Civil commands and data before implementation; do not retire working routes until Tim accepts the replacement in AutoCAD.

**Completion check:** start/continue one mixed-discipline sample project, record Civil and Structural time without double counting, verify combined/discipline reports and scoped checklist completion, edit shared title information once, open/zoom Civil sheets, review a revised source, issue only the selected Civil set, and verify retained excluded register rows and issue history. Mixed jobs use one shared source of project truth. Native output and AutoCAD acceptance remain future work; this addition does not automatically expand the current office-pilot prerequisites.

### Civil outcomes and how to deliver them

| Audit item | Existing destination | Build approach | Completion evidence |
|---|---|---|---|
| **C01 — Complete network editing** | C3 / CV-01 / CV-08 | Complete native/CE edit routes for MLINE/polyline, branches, curves, real pit footprints, free ends and logical continuations. | No crossing-only connection, phantom pit or accidental logical split; correct pipe-end graphics. |
| **C02 — Set-out and as-built outputs** | CV-07 / CV-06 / QA-01 | Derive selected set-out coordinates/offsets from explicit datum/transform, approved points and source precision; compare surveyed revisions. | Unit/rotation/mark checks pass; output basis and missing accuracy remain visible. |
| **C03 — Crossings and clearances** | CV-01/06 / EV-05 / QA-01 | Join known service/structure geometry with reviewed envelope and level evidence; show plan/profile/detail conflicts and unknowns. | Unknown elevation never reports clearance; known conflict highlights exact affected representations. |
| **C04 — Issue-ready long sections** | CV-06 / C4 / PS-01 | Specify route/chainage, separate scales, datum, levels, branches/crossings, bands, breaks, title links and refresh scope. | Plan breaks retain real length; route update and missing surface data are correct. |
| **C05 — Surface flow and joints** | CV-05 / C5/C6 / #61/#62 | Reuse slab/catchment sources; derive level-supported ridges/valleys/low points/outlets/overflow; rank reviewed joint layouts separately. | Outlet revision invalidates only affected flow; arrows follow known levels; unreviewed joints remain advisory. |
| **C06 — Civil construction details** | CV-04/05/06 / AS-01 / C4/C5 | Select approved detail by actual pit/pipe/device conditions; adapt allowed dimensions and link notes/levels/access/bedding assumptions. | Multi-inlet/non-square/proprietary cases do not use inapplicable graphics or invented structural suitability. |
| **C07 — Tank/pump/detention assembly** | CV-03/04 / C3/C4/C6 | Preserve later tank/pump/barrel rulings; unify footprint, components, usable-volume meaning, connections and linked representations. | Replace device without orphaning approved components; correct logical identity and capacity source. |
| **C08 — System and construction states** | CV-01/03 / SH-04 / C3/C4 | Link property/outfall/council and existing/new/abandoned state to display, schedule and relevant settings; preview membership changes. | Existing receiving point remains real; new system does not silently adopt guessed inverts. |
| **C09 — Measured quantities** | CV-06 / PS-01 / QA-01 | Aggregate physical items and explicit length basis by material/diameter/system/state; qualify trench/bedding quantities only with adequate geometry. | Twins/curves/continuations/repeated views count correctly; unknown and excluded quantities are named. |
| **C10 — Consultant intake and outbound DWG** | CV-07/08 / C5 / ST-07 | Use revision/field reconciliation around authoritative DWG; preserve deliberate changes; define ordinary-AutoCAD export and dependency packaging. | Repeat intake is stable; outputs remain usable without CE; no LandXML authority reversal. |

### Family-by-family execution

Use the following order within the relevant owners: reconcile source identity/edit/currentness → complete ordinary drainage output → qualify a bounded assisted proposal → extend set-out/construction quantities. Reuse working code on active branches; do not rebuild a tool because an old card still says Not started.

For each family:
1. Retrieve its existing Civil behaviour handoff, later Tim answers, approved source graphic and source-revision evidence.
2. Define known/default/missing inputs, physical identity, visible parts, schedule/profile/detail ownership and permitted display-only edits.
3. Specify the actual preselection/pick/default/preview/repeat path and the exact native edits it tolerates.
4. Connect the current authoritative writer and approved catalogue. All dependent displays read the same accepted values.
5. Test a small normal case plus crowded, rotated, multi-segment, missing-source and failure cases; compare issued appearance.
6. Add only the meaningful representative checks to the current Test Day.

**Proposal integration:** E01/E02/E05 are C6 requirements, not evidence C6 is complete. Include outlet relocation, sizing, tanks/barrels and joints only when each has an explicit writer and actual drawing preview. Compare alternatives with no change; separate drafting preference from checked engineering. Preserve current warning/override rulings.

**Large schedule / Properties:** E03/E04 require one resolved commit and row-access specification. Preserve the reviewed simple everyday layout while prototyping a complete-access large-table mode. No off-screen action buttons, hidden export scope or contradictory Enter/click-away rules. Record the chosen interaction before changing runtime.

**Cross-discipline:** C03 is delivered with DP-7: pipe/host/opening ownership, level-supported clearance, review of affected views and per-DWG recovery. No silent structural redesign.

**Status:** planning extension recorded; no new Civil runtime, deployment, numerical engineering rule or AutoCAD acceptance is claimed.


### Native shared card dependency — RBL, 10 September 2026

**Missing / not allocated:** the release owner requested the native shared WPF card/content interface needed by the approved RBL visual workflow. Read-only inspection of integration HEAD 1738e6ec0b2dd2bce0409033a2e2064084faa264, alongside design36ef9015 and prior UI assets67044b9c, found no reusable suite-level CeCard class/provider or frozen shared-card API known to this UI owner. Browser CE.registerWindow/ce-stepcard is design code, not a native interface.

Existing native pieces are narrower: Manager UI/Themes/Theme.Base.xaml defines UiSectionCardStyle for Border appearance, and DrawingRepairPage/PluginManagerWindow have local card styles. Drainage Controls/CeEditorShell is a Civil-owned UserControl with SectionsContent/FooterExtraContent and a Civil CeEditorShellViewModel dependency; it is not an already-shared Structural/RBL provider. These may inform reuse, but none closes this dependency.

The release Control Room must allocate one shared native card/content contract within the approved UI programme before RBL can consume it. This record does not choose a new shared-DLL dependency for Structural66b, create a private RBL window, allocate a new build task, activate RBL or change the Civil/Manager delivery order. UI owner status is dependency recorded; native owner, API, implementation commit and compatibility proof remain unassigned.
