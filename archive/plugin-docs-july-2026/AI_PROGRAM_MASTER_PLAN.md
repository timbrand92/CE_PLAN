# CE_ACAD_PLUGIN — Program Master Plan (target: v1.0)

**Created:** 2026-07-01
**Branch:** `claude/autocad-ai-backend-59ysbb` (CVL + STRUC)
**Owner:** Tim (sole developer, distributor, and manager)
**Status:** Planning approved · implementation 0% · DATA-01 Gate 0 failed. Current status and canonical IDs:
`docs/CARDS/INDEX.md`.
**Scope:** Unify CE_CVL_SUITE (drainage) + CE_STRUC_SUITE (structural) + CE_SUITE_MANAGER into a
**single distributable plugin, `CE_ACAD_PLUGIN`**, with an embedded Claude AI assistant, central
Mission Control, and a hardened, tested command set. **Executing this entire plan = CE_ACAD_PLUGIN v1.0.**

> This document defines *what we are building and why*, and gives a concrete **Day 1 plan** (§13).
> It sits **above** the existing per-suite plans and audits, which it consolidates rather than replaces
> (see §9 *Reconciliation with existing docs*).
>
> **The end state:** one plugin (`CE_ACAD_PLUGIN`), one ribbon, one update channel, one AI brain, one
> backend — replacing three separately-distributed plugins. §16 covers the unification; §17 defines v1.0.
> Governance and the workstreams that make this shippable (data confidentiality, cost, liability, evals,
> corpus pipeline, backend ops, adoption) are in §15, with two standalone decision docs:
> `docs/AI_DATA_GOVERNANCE.md` and `docs/AI_COST_MODEL.md`.
>
> **2026-07-22 control:** AI-01 is provider-neutral and uses a local permissioned MCP bridge. DATA-01 blocks
> broad corpus/AI access until current files and Git history are cleared. The earlier Claude approval does not
> transfer to OpenAI/Codex. No implementation is authorised merely by this older master plan.

---

## 1. North Star (the one sentence)

> **A drainage/structural design assistant, invisibly embedded in a single CE plugin (`CE_ACAD_PLUGIN`),
> that learned how *Tim* draws from his own past projects — so any colleague can produce
> senior-engineer-quality drawings by describing intent in plain English, while every accepted and rejected
> suggestion feeds back to improve the next drawing and the plugin itself; all of it managed centrally from
> one backend that also reports every install, version, and error back to Tim's machine.**

Two ideas carry the whole strategy:
- **Your conventions, not generic CAD** — the corpus of past projects is the moat.
- **A feedback loop** — every human accept/edit/reject is a new labelled example. It compounds.

---

## 2. The program is ONE backbone serving THREE pillars

This is not three projects. It is one backend and one data engine producing three outcomes.

```
                     ┌───────────── CE CLOUD (one backend) ─────────────┐
                     │  AI proxy · telemetry ingest · update delivery ·  │
                     │  remote config · feedback ledger · dashboards     │
                     └───────▲───────────────▲───────────────▲──────────┘
                             │               │               │
        ┌────────────────────┴───┐   ┌───────┴────────┐   ┌──┴─────────────────┐
        │ 1. AI ASSISTANT        │   │ 2. MISSION      │   │ 3. QUALITY / TEST  │
        │  understand/draw/QA    │   │    CONTROL      │   │    ENGINE          │
        │                        │   │  fleet+versions │   │  what works/doesn't│
        └────────────────────────┘   └────────────────┘   └────────────────────┘
                     └──────── shared: CORPUS + TELEMETRY + HARNESSES ──────────┘
```

- The **corpus** feeds the AI *and* becomes the regression suite.
- **Telemetry** powers Mission Control *and* tells us which half-baked function to fix first.
- **One backend** does the AI calls, the phone-home, the update push, and the config.

---

## 3. Pillar 1 — The AI Assistant

### 3.1 What it does (four capabilities)

| Capability | Meaning | Risk | Ships |
|---|---|---|---|
| **Understand** | Explain the drawing/project/selection in plain English; in-context help | read-only | first |
| **Smartify** | Live QA + suggestions (sizes, inverts, naming, schedule anomalies) | read-only → suggest | second |
| **Draw** | Emit validated tool-calls that existing services execute (plan→preview→apply) | write | after hardening |
| **Bug-fix** | (a) fix the *drawing* via validated edits; (b) fix the *plugin code* via Claude Code | both | ongoing |

### 3.2 Architecture — ground-up, not built on `MarkupAIChatService`

`MarkupAIChatService` (STRUC) works but has sync-over-async (`.GetAwaiter().GetResult()` on the UI thread),
per-call `HttpClient`, no streaming/cancellation/retry, and raw-JSON-as-exception. We build clean instead.

A small **agent runtime**, factored into a shared library so both suites share one brain:

```
SURFACES     WPF palette · CDASK/CEASK · right-click "explain" · headless   (thin, per-suite)
AGENT LOOP   conversation state · system prompt · tool-use cycle · budget   ← CE.AI.Core
TOOLS        ICeTool: name + JSON schema + Execute()  (read verbs, write verbs)
CONTEXT      IContextProvider: drawing→JSON (reuse export serializers) · vision · corpus few-shots
CAD BRIDGE   CadExecutor: marshal work onto AutoCAD's document thread; one transaction / one undo  ← linchpin
PROVIDER     IChatClient: streaming · cancellation · retry/backoff · typed errors · pooled HttpClient
TRANSPORT    direct Anthropic API  ─OR─  CE Cloud proxy (see §5)
```

**The two hard layers:**
- **CAD Bridge (`CadExecutor`)** — the AutoCAD managed API is single-threaded. HTTP must run *off* the UI
  thread (so CAD never freezes), but drawing objects may only be touched *on* the document thread. The bridge
  marshals tool execution back via `Application.DocumentManager.ExecuteInApplicationContext`. Getting this
  wrong produces the fatal `e0434352h`-class crashes STRUC's CLAUDE.md already warns about.
- **Provider (`IChatClient`)** — fully async, `CancellationToken` throughout, single pooled `HttpClient`,
  SSE streaming via **callbacks (not `IAsyncEnumerable`)** so it compiles on net48 as well as net8/net10,
  retry/backoff on 429/529, typed exceptions. Vendor-agnostic behind the interface.

### 3.3 Packaging: a new shared assembly `CE.AI.Core`

- **In `CE.AI.Core`** (triple-target net48/net8/net10): `IChatClient` + Anthropic impl, agent loop,
  `ICeTool`/`ICadExecutor`/`IContextProvider` interfaces, retry/streaming/secrets/audit.
- **In each suite:** the concrete *tools* (`InsertPitTool` vs `PlaceBeamTool`), the concrete *context
  provider* (CVL `ProjectData` vs STRUC schedules), and the *surfaces* (palette, commands).

### 3.4 Safety model for writes (non-negotiable)
1. Structured tool-calls only — Claude never emits raw entities; it calls verbs.
2. Validate args through `DesignValidationService` **before** executing.
3. **Plan → preview → explicit Apply** (mirrors the existing MarkupAI plan/execute flow).
4. One transaction, one `U` undo.
5. Full audit log (prompt, tool call, result) via Serilog.
6. **AI may only call 🟢 Trusted commands** (see Pillar 3). It never drives half-baked code.

---

## 4. The learning engine — "learn from old projects"

Three flywheels. Only the first is available on day one. In an engineering context, **every learning step
stays human-verified and auditable** — the assistant proposes, a human disposes, the disposal is the lesson.

**Flywheel 1 — Retrieval (now, no training).** The `corpus/` of labelled past projects
(`ground_truth.json` pit/pipe records, entity dumps) becomes searchable memory. On each job, retrieve the
most similar past jobs and few-shot Claude with them. ~80% of the value; the corpus is the moat.

**Flywheel 2 — The feedback ledger (the "ML" that matters).** Every suggestion gets an outcome —
**accepted / edited / rejected** with the human's correction captured. That stream (a) grows the corpus with
fresh labelled examples automatically, and (b) shows exactly where the assistant is wrong. Continuous
improvement with zero training runs — a human-in-the-loop learning loop.

**Flywheel 3 — Fine-tuning / distillation (later, optional, gated).** Once the ledger is large and clean,
optionally fine-tune a smaller/cheaper model on accepted outputs to encode house style cheaply. Augments
retrieval; never replaces validation. **Do not build early.**

```
   past projects ─┐
                  ▼
        [ CORPUS / memory ] ──retrieve──▶ Claude ──suggest──▶ engineer
                  ▲                                              │
                  └──────── accepted/edited/rejected ◀───────────┘
                              (feedback ledger = new labels)
```

---

## 5. Pillar 2 — CE Mission Control (manage every install back to Tim's machine)

**Goal:** one dashboard shows *every* colleague's install — suite, version, AutoCAD release, health,
usage — and pushes updates and config from there.

### 5.1 Build on what already exists (client side is largely done)
STRUC already ships `AdminTelemetryService`, `InstallMetadataService`, `RuntimeDiagnosticsService`,
`FoundationMonitor`, `CEADMIN`, and `CE_SUITE_MANAGER`/`CEMANAGER` (update delivery). CVL has Serilog.
This is mostly *wiring existing client signals to a central store*.

### 5.2 What each install phones home (lightweight heartbeat)

| Category | Fields | Feeds |
|---|---|---|
| Identity | hashed machine/user id, suite, **assembly version + BuildTimestamp**, AutoCAD release, .NET target | version fleet view |
| Health | last-seen heartbeat, crash count, exception fingerprints, foundation-monitor status | reliability triage |
| Usage | command counts, feature usage, AI accept/reject | **hardening priority + AI ledger** |
| Config drift | settings hash, **which bundle path loaded** (catches the ProgramData-shadow bug) | support |
| Errors | Serilog error events (message + stack fingerprint, **no drawing IP**) | bug-fix loop |

### 5.3 What Tim can do from the dashboard
- See the whole fleet (who's on which version; who's crashing on what; what's used vs never used).
- Push updates via the existing `CE_SUITE_MANAGER` channel with **stable/beta rings** (test on self first).
- **Remote config / kill-switch** — disable a flaky command or AI tool for everyone without shipping a DLL.
- Version pinning & rollback.

### 5.4 Design rules for this context
- **Privacy line:** telemetry is *engineering metadata only* — versions, counts, error fingerprints.
  **Never drawing content or client data.** Say this explicitly to colleagues.
- **Fail-soft:** offline → queue locally, sync later; the plugin never blocks on the backend.
- **Same identity as the AI proxy** — one install identity unlocks AI *and* registers in the fleet.

---

## 6. Pillar 3 — Quality / Test engine (knowing what actually works)

Honest state: ~143 commands (43 CVL + 100 STRUC), uneven quality — "some work great, others are
half-baked." We **cannot** ship AI write-tools on top of unproven functions. Quality is a **gate**, not a phase.

### 6.1 The Confidence Matrix (single source of truth)
Every command classified on two axes — *does it work* and *is it proven*:

| Confidence | Meaning | Consequence |
|---|---|---|
| 🟢 **Trusted** | works + covered by unit/smoke/headless test | AI may call it; ship freely |
| 🟡 **Works, unproven** | seems right, no test | manual use OK; **AI read-only**; needs a test |
| 🟠 **Half-baked** | known-incomplete / edge cases wrong | flagged; not exposed to AI; hardening backlog |
| 🔴 **Broken/unknown** | untested / suspected broken | quarantine; audit before use |

This matrix drives (a) what to fix, (b) what the AI may touch, (c) what to label "beta" to colleagues.
**It consolidates existing audits** — CVL `COMMAND_ARCHITECTURE_AUDIT_2026.md` command status map,
STRUC `AUDIT_AND_REMEDIATION_PLAN.md` + the "half-baked audit batches 1 & 2" — into one live artifact.

### 6.2 Prioritize by telemetry × risk
Harden **used × failing**, not alphabetically. `CDFALL` at 400×/week throwing 5% → top. A 🟠 nobody uses →
ignore. Mission Control *is* the test-prioritization engine (which is why Pillar 2 comes early).

### 6.3 Corpus as the correctness oracle
The corpus is real projects with known-good `ground_truth.json`. A test becomes: *run the command headless
over corpus 22547 and assert the resulting network matches ground truth* — **correctness**, not just
"didn't crash." The existing `accoreconsole` headless/smoke harnesses run this without opening AutoCAD.

### 6.4 AI writes the tests to close the gap
For every 🟡/🟠 command, Claude Code generates smoke scenarios + unit tests **to the existing patterns**
(drop JSON in `Scenarios/`, add a `case` in the dispatcher). Corpus supplies real inputs.

### 6.5 Release gate + the loop
- **CI gate:** no promotion to the stable ring unless smoke + headless are green (`dotnet msbuild /t:Smoke`).
- **Loop:** telemetry surfaces a real failure → Claude Code reproduces in harness → patches →
  the fix **becomes a new corpus regression case** → ships through the ring.

---

## 7. Roadmap (crawl → walk → run)

| Stage | Deliverable | Unification step | Learning | Beneficiary |
|---|---|---|---|---|
| **0 — Backbone** | CE Cloud backend (AI proxy + telemetry ingest + update/config) + install identity | shared solution; `CE.AI.Core` referenced by both suites | none | Developer |
| **0.5 — Truth** | **Confidence Matrix** consolidated + telemetry heartbeat live | — | none | Manager |
| **1 — Understand** | `CE.AI.Core` + `CadExecutor` bridge + `CDASK`/`CEASK` read-only + fleet dashboard v1 | unify host/startup/mutex/**one ribbon** under one bundle | retrieval | End user |
| **2 — Harden** | corpus-regression + AI-generated tests on 🟡/🟠, prioritized by usage | merge assets/config/corpus; single `command-registry.json` | ledger starts | Manager + user |
| **3 — Draw** | AI write-tools — **only 🟢 commands** — behind plan→apply | single installer + update channel; retire separate bundles | ledger grows | End user + manager |
| **4 — Self-improving** | telemetry→fix→corpus loop closes; optional fine-tune | — | flywheels 2 & 3 | Everyone |
| **→ v1.0** | **`CE_ACAD_PLUGIN` released** — unified, AI-enabled, hardened, governed | one plugin ships | — | Everyone |

Each stage is independently shippable and useful alone. Note the reordering forced by Tim's needs:
**quality (0.5/2) and Mission Control (0) come before AI writes (3)** — you can't safely automate drawing on
half-baked commands, and you need telemetry to know what to harden first. **Unification runs as a parallel
thread across the stages** (§16) so it never becomes a risky big-bang; v1.0 is the point where all threads
converge (§17).

---

## 8. Value by point of view (why it's worth it)

**End user (colleague, non-technical):** never sees a key/model/setting — just a chat box and smarter
buttons. Types intent instead of memorising 100+ commands; gets proposed sizes/inverts with reasons; errors
caught live; unblocked without waiting for a senior. A junior produces closer-to-house-standard work on day one.

**Manager (Tim):** consistency at scale (conventions encoded once, applied by everyone); QA before drawings
leave the building (less rework, lower liability); knowledge capture (design judgment becomes an asset, de-risks
single-point-of-failure); visibility (manage by the ledger + fleet data, not anecdote); throughput (the boring
60% of drafting compresses).

**Developer (Tim + Claude Code):** telemetry-driven bug-fixing verified against the headless harness; corpus
doubles as regression suite; new tools scaffolded to established patterns; self-documenting plugin.

**Automation of the drawing process (drainage example):**
```
Survey import → Pit placement → Pipe layout → Invert/grade design → Schedule → Profiles → Calcs → Export
     │           ⚡suggest       ⚡draft from    ⚡solve inverts/     ⚡auto-    ⚡auto-  ⚡auto-
   ⚡read RLs,   type/size      brief+survey    grades to meet       gen+QA    gen+QA   check+explain
   propose      from context                   cover & min-fall
   catchments
```
Framing for expectations: **80% draft in 20% of the time; the engineer reviews and finishes.** The human
review step is a feature (liability + it *is* the feedback loop), not a limitation.

---

## 9. Reconciliation with existing docs (do NOT reinvent)

This program **consolidates and continues** prior work:

| Existing doc | Role going forward |
|---|---|
| CVL `V2_1_PLAN.md` / `V2_FIX_PLAN.md` (active) | remain the day-to-day CVL fix plans; feed Pillar 3 backlog |
| CVL `COMMAND_ARCHITECTURE_AUDIT_2026.md` | **seed of the CVL Confidence Matrix** (command status map already exists) |
| CVL `AUTO_DESIGN_*` (roadmap/backtest/calibration) | prior art for Pillar 1 "Draw"; review before building drainage auto-draft |
| CVL `JOB_ARCHETYPE_CENSUS.md`, `GOLD_STANDARD_DRAWINGS_SPEC.md` | corpus/retrieval design inputs (Flywheel 1) |
| STRUC `AUDIT_AND_REMEDIATION_PLAN.md` (45 issues) + "half-baked audit batches 1 & 2" | **seed of the STRUC Confidence Matrix** + Pillar 3 backlog |
| STRUC `DEVELOPMENT_PLAN.md` | remains the STRUC feature roadmap; phases feed Pillar 3 |
| STRUC MarkupAI (`MarkupAIExecutionService`, `pyautocad_worker.py`, `CommandPlan`) | prior art for the tool-call/plan-apply pattern in Pillar 1 |

**Day-1 task 1 is to reconcile these into the unified Confidence Matrix**, not to start auditing from scratch.

---

## 10. Decisions — LOCKED 2026-07-02 (Tim)

| # | Decision | Outcome |
|---|---|---|
| 1 | Distribution / key | ✅ **CE Cloud proxy** — key server-side, metering, remote config; designed in from Stage 0 |
| 2 | First suite to host `CE.AI.Core` | ✅ **CVL first**, STRUC references the same assembly next |
| 3 | First capability | ✅ **Understand/Smartify read-only first**; Draw only after Confidence-Matrix hardening |
| 4 | Data policy (dev + pilot) | ✅ **Full drawing data, no scrubbing** — owner's call, recorded in `AI_DATA_GOVERNANCE.md` §3 with the verified Anthropic API no-train/retention posture. Per-job AI-off switch still recommended as a control. |
| 5 | Repo layout for unification | ✅ **Monorepo `CE_ACAD_PLUGIN`**, cut over after Stage 1 (see §16.5) |

**Still open (small):**
- **Backend hosting** — where CE Cloud runs (VPS / serverless) + install identity method.
- **Pilot colleagues** — name the 1–2 people for the first real-world test.
- **Per-seat AI budget** — pick the monthly number that drives quotas (`AI_COST_MODEL.md` §6).
- **"Bug-fix" priority** — drawing vs plugin-code loop first *(default in force: code-fix loop first — it hardens everything else)*.

---

## 11. Risks & guardrails

- **Liability:** AI-proposed engineering must be human-signed-off. Plan→preview→apply + audit log exist for
  this. Internally: *"assistant, not engineer of record."*
- **Over-trust by non-experts:** surface confidence + the "why" + the source past-job; keep validation hard.
- **Cost drift:** many users × many calls → proxy metering/quotas is the control.
- **Corpus quality:** garbage in, garbage out — the ledger must allow *curating* (rejecting) bad examples.
- **Scope creep on Flywheel 3:** fine-tuning stays optional and gated on a large clean ledger.
- **Threading:** every AutoCAD touch through `CadExecutor`; every event handler guarded (STRUC rule).
- **Fail-soft everywhere:** AI/telemetry down ⇒ plugin behaves exactly as today. AI is strictly additive.

---

## 12. Success metrics

- Time-to-first-draft for a standard drainage layout (target: hours → minutes for the draft).
- Revision cycles / QA defects per job (from ledger + review outcomes).
- New-colleague ramp time (productive without shadowing a senior).
- **Suggestion acceptance rate** climbing over time (direct readout the flywheel works).
- Mean-time-to-fix for plugin bugs (telemetry → Claude Code loop).
- % of commands at 🟢 Trusted (Pillar 3 progress).

---

## 13. TOMORROW — the Day 1 plan

Goal for the day: **turn "some functions are half-baked" into an evidenced, ranked matrix, lock the five
decisions, and stand up the skeleton of `CE.AI.Core` with a working read-only console harness — zero risk to
any drawing.** Ordered so each task is useful even if the day is cut short.

### Track A — Truth (highest value, do first)
- [x] **A1. Consolidate the Confidence Matrix.** Fan-out audit both suites; merge existing audits
  (CVL `COMMAND_ARCHITECTURE_AUDIT_2026.md`, STRUC `AUDIT_AND_REMEDIATION_PLAN.md` + half-baked batches)
  into one `docs/CONFIDENCE_MATRIX.md` — every command classified 🟢/🟡/🟠/🔴 with the **specific reason**
  (no test / unguarded handler / incomplete logic / TODO) and existing test/harness coverage cross-referenced.
- [x] **A2. Rank the hardening backlog** from A1 (worst-confidence × likely-usage). This is the Pillar 3 queue.
- [x] **A3. Mark the AI allow-list** — the subset of 🟢 commands the assistant may call in Stage 3.

### Track B — Backbone skeleton (parallel-safe; no AutoCAD needed)
- [x] **B1. Create `CE.AI.Core`** project (triple-target net48/net8/net10) with the interfaces:
  `IChatClient`, `ICeTool`, `ICadExecutor`, `IContextProvider`, plus DTOs.
- [x] **B2. Implement `IChatClient` (Anthropic)** — async, streaming via callbacks, cancellation,
  retry/backoff, typed exceptions, single pooled `HttpClient`. **Verify exact Messages/tool-use wire format
  against the live Anthropic API docs before coding** (don't trust memory).
- [x] **B3. Console harness** (no AutoCAD): send a prompt, stream a reply, exercise a fake tool round-trip.
  This proves the whole provider + agent loop with zero CAD risk.

### Track C — Decisions & shape (Tim + Claude together)
- [x] **C1. Lock the five decisions** in §10 (distribution/proxy, first suite, first capability, bug-fix
  priority, backend hosting).
- [x] **C2. One-page CE Cloud spec** — the single backend's responsibilities (AI proxy, telemetry ingest,
  update delivery, remote config, feedback ledger) + identity model + hosting pick.
  → `docs/CE_CLOUD_SPEC.md` (3 items still open for Tim: hosting pick, install-identity method, per-seat budget).

### Stretch (only if A–C land)
- [x] **S1. `CadExecutor` bridge** + one read tool (`get_selection`) wired behind a `CDASK` command stub.
  → Delivered beyond the stub: `AutoCadExecutor` + `GetSelectionTool` + a **dockable "CE Assistant" chat
  panel** (CDASK toggles it). Confirmed live in AutoCAD 2027 (2026-07-02) — read-only "Understand" is now
  usable. Fixed two AC2027 gotchas en route: Newtonsoft version skew (use `JsonConvert.SerializeObject`) and
  command-line thread affinity (own the palette's Dispatcher, never write to AutoCAD's command line).
- [ ] **S2. Telemetry heartbeat** — minimal install-identity + version ping from one suite to a stub endpoint.

**Definition of done for Day 1:** `docs/CONFIDENCE_MATRIX.md` exists and is ranked; the five decisions are
recorded here in §10; `CE.AI.Core` compiles and the console harness streams a real Claude response and
completes a fake tool round-trip. Everything read-only. No drawing touched.

---

## 15. Open workstreams & governance (the things that make it shippable)

The architecture (§3) is solid; these are the load-bearing workstreams *around* it. 🔴 = can sink the
project if unplanned; 🟠 = important; 🟡 = one-paragraph placeholder that matures as we go.

### 🔴 Showstopper-class — decide before real drawing data flows

- **15.1 Data governance & client confidentiality** → `docs/AI_DATA_GOVERNANCE.md`.
  Telemetry carries *no* drawing IP, but the AI assistant **by design sends drawing/project data to a US
  API**. For an engineering consultancy under client confidentiality and Australian privacy expectations,
  this is a decision to make and defend: what leaves the building, whether we scrub/anonymise, the
  provider's retention/no-train posture, and a per-job "AI off" switch for sensitive work.
  **Interim rule: no real client data to any AI endpoint until this policy is signed off.**
- **15.2 Cost model & token economics** → `docs/AI_COST_MODEL.md`.
  "The proxy meters usage" is not a cost plan. Levers to decide now: **prompt caching** (system prompt +
  corpus few-shots are reused constantly), **model tiering** (cheap model for classify/name/QA, top model
  only for hard design reasoning), per-user/day budgets with a graceful "quota reached" UX, and a rough
  $/seat/month estimate.
- **15.3 Liability / professional standards.**
  Engineer-of-record sign-off flow, UI disclaimers, the audit log as a professional record, and a check on
  whether PI insurance cares about AI-assisted design. Framing: *assistant, not engineer of record.*

### 🟠 Important — plan before/with the relevant stage

- **15.4 AI evaluation harness (distinct from the plugin tests).**
  The Confidence Matrix tests the *plugin*; nothing yet tests whether the *AI's answers* are correct. Need a
  golden eval set ("given this survey, the good invert solution is X") to catch hallucination/bad design and
  to **safely upgrade models**. Without evals we can never change the model with confidence.
- **15.5 Corpus data pipeline & consent.**
  The learning loop assumes a clean, growing corpus. Plan the ETL: finished job → corpus entry, PII/client
  scrubbing, versioning, curation (reject bad examples), and **consent** to use past client projects as
  training data.
- **15.6 CE Cloud backend as its own product.**
  Real infrastructure: hosting choice, deploy/CI, uptime/monitoring, backups, the dashboard app itself,
  secrets storage. Needs its own mini-SDLC.
- **15.7 Prompt & model management (server-side registry).**
  The house-style system prompt, tool descriptions, and few-shot logic are the product's brain — versioned,
  staged rollout, rollback, A/B, owned server-side (tune for everyone without shipping a DLL). Plus a
  model-upgrade/deprecation policy to stay on the latest Claude.
- **15.8 Adoption / change management / pilot.**
  Non-technical users; the best tool unused is a failure. **Pilot with 1–2 colleagues** before firm-wide;
  in-app onboarding; trust-building (show the "why" + the source past-job); a support path
  ("report issue" → telemetry → Tim/Claude).

### 🟡 Smaller — a line in the plan now, detail later

- **15.9 Feedback-capture UX** — how accept/edit/reject is captured without nagging (implicit signals + light thumbs).
- **15.10 Proxy auth & abuse** — per-install identity, token revocation (colleague leaves), rate-limit/abuse protection.
- **15.11 `CE.AI.Core` distribution** — how the shared assembly deploys into the unified bundle and stays version-matched.
- **15.12 Degraded-mode UX** — latency, streaming, cancel button, "backend offline" behaviour beyond fail-soft.
- **15.13 Assistant naming/branding** — e.g. "CE Copilot"; a real product surface.

---

## 16. Unification into `CE_ACAD_PLUGIN`

**Goal:** collapse the three separately-distributed plugins (CE_CVL_SUITE, CE_STRUC_SUITE, CE_SUITE_MANAGER)
into **one plugin, one bundle, one ribbon, one update channel** — with the AI assistant and CE Cloud client
built in. For a non-technical audience, "install one thing, get everything" is a large usability win, and it
is the natural home for `CE.AI.Core` and Mission Control.

### 16.1 Why now, and why it's feasible
- **Command namespaces already don't collide** — CVL uses the `CD` prefix; STRUC uses `CE`/structural names.
  This was a deliberate design choice (see both CLAUDE.md files), so merging can't clash on command names.
- **STRUC is already the "master"** (mutex, crash handlers, ribbon host, asset deploy) — it's the natural shell.
- **Both already source the same AutoCAD API DLLs**; STRUC's `lib/` is already the shared fallback.
- **One AI brain + one telemetry identity** want a single host process anyway.

### 16.2 Target shape
```
CE_ACAD_PLUGIN  (one bundle, one Plugin.cs host, one mutex, one ribbon "CE" tab)
├── Modules/
│   ├── Drainage/     ← former CE_CVL_SUITE  (CD* commands, ProjectData, corpus)
│   ├── Structural/   ← former CE_STRUC_SUITE (CE*/structural commands, MarkupAI)
│   └── Manager/      ← former CE_SUITE_MANAGER (update delivery, admin)
├── CE.AI.Core/       ← shared AI runtime (provider, agent loop, CadExecutor, tools API)
├── CE.Cloud/         ← backend client (AI proxy, telemetry, config, feedback ledger)
├── Assets/           ← merged blocks / DCL / LISP / config; single command-registry.json
└── corpus/           ← READ-ONLY, merged per-discipline
```
Ribbon: one **CE** tab with **Drainage** and **Structural** panel groups + a shared **AI / Admin** panel.

### 16.3 Migration strategy — incremental, never big-bang
The half-baked state means a big-bang merge is dangerous. Unification rides the roadmap (§7) as a parallel thread:
1. **Shared solution first** — one solution referencing both suites + `CE.AI.Core`; no behaviour change.
2. **Unify the host** — single `Plugin.cs`, mutex, startup sequence, crash handlers, **one ribbon** built
   from a merged layout; module code stays where it is. Guard with smoke/headless harnesses at each step.
3. **Merge assets/config/corpus** — one `command-registry.json`, one `ce_toolbar_layout.json`, deduped
   blocks/DCL/LISP, corpus namespaced per discipline.
4. **Single installer + update channel** via the Manager module; retire the separate bundles (clean up any
   ProgramData shadows — see STRUC CLAUDE.md).
5. **Retire the old bundle names** once the fleet (Mission Control) confirms everyone is on `CE_ACAD_PLUGIN`.

### 16.4 Build targets — reconcile
Unify on **net48 + net8.0-windows + net10.0-windows** (CVL's set). STRUC is currently net48/net10 — **add
net8** so AutoCAD 2026 (confirmed .NET 8) is first-class across the whole plugin.

### 16.5 Repo decision — DECIDED 2026-07-02
**Monorepo `CE_ACAD_PLUGIN`** (one branch, one CI, one release), importing both repo histories with pre-merge
tags. Cut over **after Stage 1** (unified host/ribbon proven); until then, work continues in the two repos.

### 16.6 Risks & mitigations
- *Regression during merge* → do it **after** the Confidence Matrix + harness coverage exist (Stage 0.5/2).
- *Mutex/ribbon/asset collisions* → single host owns all three; merge is mechanical once namespaces are clean.
- *Larger blast radius* → Mission Control rings (beta→stable) + kill-switch de-risk each promotion.
- *Two histories* → monorepo import preserves both; tag the pre-merge states.

---

## 17. Versioning & the definition of v1.0

**`CE_ACAD_PLUGIN` v1.0 = the end state of executing this entire plan.** Product versioning starts fresh at
1.0 for the unified plugin; the former per-suite versions (e.g. CVL 2.1.x, STRUC v2.x) become internal module
history. Pre-1.0 milestones map to the roadmap stages as `0.x` previews (dogfooded by Tim, then the pilot).

### 17.1 v1.0 acceptance checklist (exit criteria)
- [ ] **One plugin** — `CE_ACAD_PLUGIN` installs as a single bundle; old bundles retired; fleet confirms cutover.
- [ ] **One ribbon / one update channel** via the Manager module.
- [ ] **AI assistant live** — Understand + Smartify (read-only) for everyone; **Draw** enabled for the 🟢
      allow-list only, behind plan→preview→apply→single-undo.
- [ ] **Mission Control live** — heartbeat, versions, crash/usage telemetry, remote config + kill-switch.
- [ ] **Governance in place** — `AI_DATA_GOVERNANCE.md` signed off; `AI_COST_MODEL.md` with budgets/quotas;
      liability/disclaimer flow shipped.
- [ ] **Quality bar** — no 🔴 commands in the shipped set; CI gate (smoke + headless green) enforced;
      corpus-regression running.
- [ ] **AI eval harness** green on the golden set; documented model-upgrade path.
- [ ] **Pilot passed** — 1–2 colleagues used it on real jobs; adoption + support path validated.
- [ ] **Docs** — end-user guide + in-app onboarding for the AI features.

### 17.2 Milestone map to 1.0
`0.1` Backbone + shared solution · `0.3` Confidence Matrix + telemetry · `0.5` Understand + unified host/ribbon ·
`0.7` Harden + merged assets/corpus · `0.9` Draw (🟢) + single installer + governance signed ·
**`1.0`** all §17.1 boxes ticked, fleet fully cut over.

---

## 18. Appendix — what already exists to build on

**CE_STRUC_SUITE:** working HTTP AI pattern (`MarkupAIChatService` → OpenAI, *configurable base URL/model*);
subprocess-worker pattern (`pyautocad_worker.py`, JSON-in/out, timeout/kill); MarkupAI vision parser concept;
`CommandPlan` plan/execute model; Serilog `LoggingService`; `AdminTelemetryService` / `InstallMetadataService`
/ `RuntimeDiagnosticsService` / `FoundationMonitor`; `CeStrucCommandBase`; ribbon from `ce_toolbar_layout.json`;
`CE_SUITE_MANAGER` update delivery. Targets net48 + net10.

**CE_CVL_SUITE:** **no network code yet** (clean slate) but rich structured serialization —
`CDEXPORTENTITIES` (entity→JSON), `CDEXPORTCORPUS` (`ground_truth.json` pit/pipe model), `corpus/` of labelled
real projects; `ProjectDataService` (single source of truth); strong domain models (`PitData`, `PipeData`,
`SurveyData`, …); `DesignValidationService` (topology/invert checks); `CeCommandBase`; headless + smoke
harnesses (`accoreconsole`); already ships `WPF-UI` + `WebView2`. Targets net48 + net8 + net10.
Packages: Newtonsoft.Json, ACadSharp (headless DWG), CommunityToolkit.Mvvm, NetTopologySuite, MathNet.Numerics, Serilog.

**Shared:** `command-registry.json` schema in both; `CE_SUITE_MANAGER` as the update/ribbon hub; corpus is
READ-ONLY ML data; both suites already on branch `claude/autocad-ai-backend-59ysbb`.
