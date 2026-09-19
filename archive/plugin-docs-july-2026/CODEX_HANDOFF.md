# 🤝 CODEX HANDOFF — CE_ACAD_PLUGIN

**Current planning addition — 6 September 2026:** read [CE Drawing Production Plan](DRAWING_PRODUCTION_PLAN.md), [44-item register](DRAFTING_DELIVERY_REGISTER.md) and [Manager plan](MANAGER_PRODUCT_PLAN.md), alongside the Civil and Structural extensions. Tim approved every audit recommendation: established CE output faster with fewer user steps. Reuse governed prior-job evidence and answered questions before asking Tim. Newer local control status records 31 reviewed Structural projects and a 300-project roster; reported counts, not full corpus understanding. DP-0–7 map into existing owners. R1 alongside C2 follows #58/#60; C5 before C6 and Civil+Manager first remain.

**Structural planning update — 5 September 2026:** read [Structural Level 3](STRUCTURAL_LEVEL3_PLAN.md)
before Structural planning/build work. It records Tim's intelligent-2D direction, permission to complete/publish
the plan, proposed stages and unanswered questions. Individual workflow/engineering gates remain; Civil +
Manager delivery is still first. Read #24 for the publication receipt and current delivery state.

**Purpose:** let a fresh Codex (or any AI) session continue **building and planning** the unified CE
AutoCAD plugin without re-discovering everything. Read this top-to-bottom once, then work from the
living docs it points to.

> ✍️ Written 2026-07-17 by the planning session. **This file is a MAP + RULES, not a status snapshot** —
> current status lives in the living docs (§1) so this can't go stale. When status here and a living doc
> disagree, **the living doc wins** and you should fix this file.

---

## Current delivery entry point — 2026-09-04

**Delivery reconciliation — 2026-09-04:** implementation and partial AutoCAD acceptance are active. [GitHub #24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24) owns live delivery status; [V3_0_PLAN.md](V3_0_PLAN.md) owns reconciled Civil scope. [Tim's D1–D10 decisions](PLAN_RECONCILIATION_2026-09-04.md) govern: C5 before C6; Claude behaviour/spine/deploys, Codex windows; **D9 keeps DWG geometry as the model**. Explicit Tim rulings outrank stale summaries. The 12 design rules, approved workflow gates and DATA-01 restrictions remain binding. No overall completion percentage is asserted.

Built, tested, installed and accepted are separate facts. Existing branches, draft PRs and uncommitted
design work are preserved; do not reimplement or delete them. Current delivery instructions supersede
historical status below, not enduring safety rules.

## 0. Your mission (in one paragraph)

Turn three messy, separately-shipped AutoCAD plugins into **one** clean plugin — one install, one CE
ribbon, one update channel, one version — that is **correct** (tools that draw the right thing),
**maintainable** (one code path per behaviour), and **extensible** (a tool/plug-in API + an AI
assistant that helps make *engineering* calls). Do it **incrementally**, never big-bang. Keep the code
that works; bin what doesn't. The whole plan lives in **`docs/CLEAN_SLATE_REBUILD.md`** — that is the
master document; everything else supports it.

---

## 1. 📖 READ THESE FIRST (the living state — always current)

| Doc | What it gives you |
|-----|-------------------|
| **`docs/CLEAN_SLATE_REBUILD.md`** | **THE master plan.** Rounds 0–9, all decisions, the audit, the 12 design rules (§6.10), the engineering rulebook (§11), the ribbon (§10). Start here. |
| **`docs/CARDS/INDEX.md`** | **Workflow-card status truth.** Canonical IDs, 38 approvals, record-completeness, implementation/AutoCAD status and DATA-01 Gate 0. |
| `docs/CARDS/COMMAND_TO_CARD_COVERAGE.md` | Current 353 registry rows + aliases mapped to canonical cards; unmapped rows fail closed pending CT-01 surface reconciliation. |
| `CLAUDE.md` (repo root) | House rules, the monorepo status, and the **bundle-deploy HARD RULE** (§6 below). |
| `BUG_CARPARK.md` (workspace root `C:\Lisp Files\`) | Every deferred bug. Read before touching any tool. |
| `REGRESSION_LOG.md` (repo root + `CE_CVL_SUITE/` + `CE_STRUC_SUITE/`) | Per-fix history + buried engineering rulings. |
| `docs/CONFIDENCE_MATRIX.md` | Living "what's trustworthy / what's known-broken" per tool. ⚠️ Known to be **stale in places** (rates CDFALL green while it's 8 rounds deep) — verify against the bug logs. |
| Memory: `C:\Users\TimothyBrand\.claude\projects\C--Lisp-Files-CE-ACAD-PLUGIN\memory\` | Cross-session facts. Read `MEMORY.md` (the index) first. |

**Before "fixing" anything from the audit (§6.9), verify it's still broken.** Several audit findings
were mined from bug *records*, not current code, and some are already fixed on **unmerged branches**
(e.g. `claude/confident-boyd-beb394` holds finished JobTime + Structural fixes). Check the owning branch
before you touch it, or you'll redo done work.

---

## 2. 👷 Who Tim is, and how to work with him

- **Civil/structural engineer, not a coder.** He describes problems in AutoCAD/engineering terms.
- **He does ALL testing in AutoCAD.** You cannot run the plugin. He is the only one who can confirm a
  fix works.
- **Explain every change in AutoCAD terms** — what he'll *see* differently — not class names or stack
  traces. First use of any unavoidable jargon gets a plain-English bracket.
- **His style:** batch your questions; give **tick-lists** he can answer tersely ("1 yes, 2 cut, 3b");
  lead with **visuals/tables/checklists**; one thing at a time — park the rest with a note, don't chase
  it. Interpret terse rulings against the evidence and **log your interpretation** so he can correct it.
- **After every change, give an explicit "what to test in AutoCAD" checklist** — specific ("open a pipe
  with a 375 mm diameter and check the Edit dialog shows 375 pre-filled"), not vague.

---

## 3. 🗺️ Repo map

```
CE_ACAD_PLUGIN/                     ← the monorepo (the single future home)
├── Modules/
│   ├── Drainage/    (CE_CVL_SUITE)   civil: CD* commands, ProjectData, Xcivil import, corpus
│   ├── Structural/  (CE_STRUC_SUITE) beams, sheets, Excel, MarkupAI
│   │   └── ../Structural.DesignCore  pure-logic "support brain" (best-factored code, keep)
│   └── Manager/     (CE_SUITE_MANAGER) unified ribbon + auto-update delivery (keep — it's good)
├── CE.AI.Core/  (+ .Tests, ../CE.AI.Harness)  AI runtime: ICeTool seam, agent loop, streaming
├── CE.Cloud/worker/                 Cloudflare Worker (AI proxy + telemetry) — built, NOT deployed
├── Shared/CE_SHARED/                cross-suite glue (ICeModule, ribbon registry, paths)
├── corpus/                          READ-ONLY drawing-parse regression truth
└── docs/                            plans + this handoff
```

⚠️ **folder ≠ project ≠ assembly today** (`Modules/Drainage` → `CE_CVL_SUITE.csproj` → ns
`CE_CVL_SUITE`). Round 2 approved standardizing to `CE.Drainage`/`CE.Structural`/`CE.Manager` — pending
an AutoCAD bundle/registry compat check. Don't rename blind.

---

## 4. 📌 Where the plan stands (see the master doc for detail)

- **Round 0 ✅** clean-slate *design* we migrate toward (keep working code); stay in this monorepo,
  restructure in place; never big-bang.
- **Round 1 ✅** reuse audit + behaviour audit + logs/diagnostics audit. Headline: **good tools on
  broken plumbing.** Output = **the 12 design rules (§6.10)** — the hard constraints for everything.
- **Round 2 ✅** architecture: **one plugin, discipline-aware ribbon** (most users have BOTH civil &
  structural), stage→object panels, **AI on both tabs scoped to help make ENGINEERING CALLS**, clean
  naming. Ribbon approved.
- **§11 Engineering Rulebook — the critical path.** The tools encode engineering rules that were never
  written down, so they're subtly wrong; an AI advisor on unconfirmed rules is *confidently wrong at
  scale*. Build order is firm: **rulebook → correct tools → assistant.** Rulebook v0.1 mined; the big
  open item is the **AS/NZS scour velocities** (BUG-080: UPVC 3.0 vs 6.0 m/s — currently placeholders
  driving live pipe sizing; auto-sizing is now advisory-only until Tim confirms).
- **Round 3 ✅** version management: one CE product version, exact build identity, `Tim Test → Pilot →
  Staff Stable` promotion, in-AutoCAD verification, Git deployment tags, rollback, and one central authority.
- **Round 4 ✅** tool/API design: one validated tool registry; vetted third-party behaviour rebuilt into CE;
  one local MCP bridge for Codex + Claude; two-axis read/write security; context-aware automation discovery;
  completeness/coordination QA; no arbitrary generated-code execution; smooth AutoCAD is priority #1.
- **Round 5 ✅** multi-chat coordination: one master board and lead; maximum three disjoint workers; separate
  branches/worktrees and file ownership; controlled handoffs/merge queue/deployment authority; every feature
  must define contextual discovery and meet the no-noticeable-lag budget.
- **Round 6 ✅** testing: automated logic + drawing-output checks + explicit AutoCAD checklist; protected
  small/typical/large/problem drawing sets; Cancel/Undo/save/reopen/Xref/security/AI/QA/performance coverage;
  every supported AutoCAD version; Tim confirmation then real-work pilot before Staff Stable.
- **Round 7 ✅** build/deploy: one controlled non-live build path; explicit AutoCAD-closed deploy lock;
  immutable signed package promoted unchanged; staged verified install + recovery; Tim-confirmed selected pilot;
  waved Staff Stable rollout; quiet after-close updates; fleet health, offline installer, rollback, feature
  emergency disable, and consolidation of duplicated deployment machinery.
- **Round 8 ✅** documentation/memory: one contextual visual offline Help Centre; central-registry facts;
  plain-language/legacy search; one Active Register; distinct Rulebook, Project Memory, Release Register, and
  read-only evidence archive; standard traceable records; repository-based Codex/Claude handoff and conflict
  checks; approved records always outrank AI memory.
- **Round 9 ✅** migration/rollout: full legacy destination map; isolated/reversible migration and settings
  backup; existing data/DWG compatibility; Tim daily-driver gate; 2–3-user real-project Pilot; small staff waves;
  defined stop/rollback triggers; 30-day + two-stable-release safety period; coordinated plugin/update/security
  identity cutover; measured success; `1.0.0` reserved for Tim-approved completed office cutover.
- **Rounds 0–9 and 38 workflow/planning cards are locked.** Civil planning is 8/8; Structural is 9/9;
  EV-01→EV-07 is complete. The July 0% statement is historical; implementation is active; headless CT-01A/B/C command evidence/owner
  cleanup, TH-01 test separation/strict runner and RS-01A1/A2/B1/B2/C1/C2 release safety are complete.
- **Planning-record status:** 38 of 38 cards have complete durable decision wording. The five previously
  blocked records — `SH-04`, `CV-01`, `CV-02`, `PS-01` and `QA-01` — now contain their approved source cards
  and Timothy's approvals verbatim, not reconstructed from summaries or code.
- **DATA-01 Gate 0 failed:** the local history audit found 141 current corpus files, 142 historical corpus paths
  and 163 historical corpus objects, reachable at 65 local/remote ref tips. Do not broadly inspect or expose the
  corpus. A history rewrite or history-access restriction needs a separate approved operation.
- **Permanent Command Review Gate ✅:** before any user-facing command/workflow is built, changed, migrated,
  or retired, review its current real AutoCAD behaviour with Tim; classify Keep/Modify/Rebuild/Retire/Missing;
  agree intended result, discovery trigger, performance, examples, guards, and AutoCAD checklist; then obtain
  Tim's approval of the workflow card. Review roughly 5–10 related commands at a time and keep question batches
  around 15. Working behaviour stays in place until its replacement is AutoCAD-confirmed.
- **Implementation roadmap reconciled:** `docs/IMPLEMENTATION_ROADMAP.md`; current evidence inventory and
  workflow groups: `docs/COMMAND_WORKFLOW_INVENTORY.md`; durable status and canonical IDs:
  `docs/CARDS/INDEX.md`. DATA-01 clearance remains mandatory before corpus/AI work; isolated foundation safety
  work that reads no corpus may proceed in roadmap order—not another command-planning pass.
- **First current-state workflow review ✅ locked:** `docs/workflows/SH-01_PRODUCT_SHELL_REVIEW.md`. Manager owns
  the one Health and Support commands; one CE ribbon/navigation is identical across AutoCAD 2022–2027; useful
  palettes stay but rival home screens retire; one Help/log/version truth; module isolation/kill switches; no
  startup network/AI; typical added startup ≤0.5 s and hard ceiling ≤1.0 s; 90% automation target and one
  ≤10-minute Tim acceptance. Fix newest-AutoCAD version reporting before the status display can pass.
- **P0 foundation decisions ✅ locked:** `docs/workflows/FND-01_FOUNDATION_REVIEW.md` records `F1–F15` plus Tim's
  refinements. One Tool Register blocks source/ribbon/Help drift; `Preview` is tool status while `Pilot` remains
  a release channel; synthetic/sanitised drawings are the default evidence; real-client content requires
  explicit approval and full evidence sanitisation; calculation tests claim only what the cited rulebook
  authority supports. Foundation behaviour is approved, but individual implementation slices are not yet.
- **CT-01 command truth ✅ locked:** legacy-named record `docs/workflows/FND-001_COMMAND_TRUTH_REVIEW.md` records `CT1–CT15` plus
  Tim's refinements. Tool identity is permanent and separate from commands/labels/locations. Start with a
  non-blocking baseline report, assign/clear known conflicts, then permanently enable the zero-difference gate.
  Expect a small Active set and large `Hidden + Review Pending` backlog. Inspect compiled DLL metadata without
  AutoCAD/Autodesk runtime loading; include constant-based command names; never scan source during startup.
- **CT-01A/B/C/D/E compiled evidence, global owners and central-register foundation complete:** Civil, Structural and Manager DLLs are compared
  headlessly with their registries and identified by SHA-256. Exact command sets match across AutoCAD 2022–2024,
  2025–2026 and 2027+. Manager alone now owns `CEMANAGER`, `CEHEALTH` and `CESUPPORT` in compiled code, registries
  and manifests. After TH-01 removes both test commands, the backlog is 80 differences, including only the two
  TF-01 transform-owner overlaps. No live
  bundle changed. The central register now owns the three approved Manager tools plus seven approved Civil
  workflow destinations and pins the 353 legacy input rows by count/hash; remaining tools and runtime surfaces
  have not migrated.
- **Older-loaded-plugin safety is implemented in RS-01:** Manager records loaded path/version/hash/MVID; activation
  fails on incomplete identity or old/new command-owner overlap; no loaded DLL is hot-swapped; the verified whole
  bundle waits outside AutoCAD scan roots for a closed-process activation; restart is required; the exact old
  bundle is preserved and automatically restored on failure.
- **TH-01 test evidence ✅ locked:** legacy-named record `docs/workflows/FND-002_003_TEST_EVIDENCE_REVIEW.md` records `TH1–TH15`
  plus Tim's refinements. Separate Test-only package; reject originals/client paths; unknown/deferred/no-assertion
  scenarios fail; correlate failure only to that run—not the 81%-false-positive crash heuristic. Interactive
  AutoCAD makes headless tests wait/skip, so push logic into offline DesignCore-style services. Test and promote
  the same immutable artifact/hash record; any changed byte resets evidence.
- **TH-01 platform implementation complete:** Staff Civil DLLs contain no test command in any runtime lane;
  `CE_TEST_HARNESS.dll` is a separate three-lane package owning only `CE_TEST_RUN`; the official Staff release
  gate rejects test content. The runner requires exact staged DLL/fixture hashes, copies only an approved
  synthetic/sanitised fixture, fails unknown/deferred/no-assertion/error cases, and writes run-owned JSON/HTML
  evidence. First closed-AutoCAD scenario and Tim visual acceptance remain pending.
- **RS-01 release safety ✅ locked:** legacy-named record `docs/workflows/FND-004_RELEASE_SAFETY_REVIEW.md` records `RS1–RS15`.
  Invert build safety so ordinary builds cannot deploy; verify/reuse Manager download + approval/canary/rollback,
  but retire live pending-DLL/manifest changes and auto-restart. Install on next AutoCAD open via preserved,
  pre/post-hash-verified swap with auto-restore; SH11 kill-switch is the emergency path. Assets update by hash.
  C1 now implements/proves RS1/RS2, but continue mandatory `-p:SkipDevBundle=true` on every build/test through the
  first official AutoCAD-confirmed release.
- **RS-01A1/A2/B1/B2/C1/C2/C3 implementation complete:** Manager can capture/report the exact loaded CE path, versions,
  session-observed SHA-256 and MVID, and a pure safety planner fails closed on incomplete identity, staged
  duplicates and old/new command-owner overlap. Update/background preparation now stages a validated whole bundle
  outside AutoCAD scan roots with per-file hashes and target intent. The compiled Manager has no live
  `_pending.dll`/manifest mutation, startup swap or automatic restart method. The standalone B1 cutover core now
  checks `acad` + `accoreconsole`, rechecks hashes/enabled command owners, preserves the whole old bundle and
  verifies/restores a whole-folder swap. B2 connects the staged record through one explicit installer entry point,
  records start/final outcomes inside the rollback window and excludes legacy delete/overwrite modes from the
  compiled binary. C1 detaches and hard-blocks Civil's old build-to-live target; normal module builds compile only,
  while release staging and publishing require separate opt-ins. C2 requires a trusted signed release record that
  binds committed-source/check evidence, AutoCAD 2022–2027 lanes and every file hash; Manager/installer fail closed
  on unsigned, altered or untrusted evidence. C3 enrols the Windows-held non-exportable release authority, embeds
  only its pinned public identity and supplies clean-source/four-evidence, never-overwrite package minting outside
  AutoCAD scan paths. TH-01 AutoCAD evidence still blocks the first official package/deployment.
- **PD-01 performance + diagnostics ✅ locked:**
  `docs/workflows/FND-005_006_PERFORMANCE_DIAGNOSTICS_REVIEW.md` records `PD1–PD15`. CE-off/current baseline starts
  now; unified column fills when loadable. One PD14 run/PID/heartbeat/crash correlator serves Manager and TH9.
  Timings batch at idle; minimal warnings/errors persist immediately; crash path best-effort flushes. Actual
  loaded runtime/path/hash, one 70 MB/14-day log, truthful sanitised support and Manager ownership are required.
- **PD-01A shared correlation foundation complete:** `CE.Diagnostics` classifies only same-run-ID, same-PID,
  in-window, existing crash artifacts as confirmed crashes. An unfinished prior session is incomplete/unknown.
  TH-01 consumes that authority; PD-01B adds the live Manager producer described next.
- **PD-01B live Manager run ledger complete:** Manager atomically records unique run ID, actual PID, start,
  60-second heartbeat and clean completion. A terminating managed event writes only schema/run/PID/time; next start
  uses the shared classifier and queues only confirmed crashes. Native abrupt crashes without exact evidence remain
  unknown; performance/log/support work is still pending.
- **TF-01 Shared Transform ✅ locked:** legacy-named record `docs/workflows/SH-05_SHARED_TRANSFORM_REVIEW.md` records `TF1–TF15` plus
  Tim's refinements. Shared owns `MR/MOVEROT/CR/COPYROT`; proven LISP MR/CR is migration baseline; native C# must
  earn parity. Escape fully rolls back, Enter/0° commits without rotation, and commit is one Undo. CE must not
  register/define `C`: Tim's PGP maps `C` to native COPY. TF13 native protections are plugin-wide for transforms.
- **Minimise Tim testing:** automate first, use a Tim-Test-only batch AutoCAD harness, and request one short
  representative acceptance per workflow batch. Tim works 8:40 am–5:30 pm Australia/Sydney time; short tests
  may run anytime, long/full suites preferably after 5:30 pm.

---

## 5. ⛓️ The 12 design rules (NON-NEGOTIABLE — from `§6.10`)

Every one is paid for in months of real bugs. Build against them:

1. **One code path per behaviour** (a rule lived in 3–4 places → fixes kept missing copies).
2. **One authority** — XData is truth; JSON is a rebuildable cache, never a second truth.
3. **Blocks are immutable masters** — never rewrite a shared block definition at runtime.
4. **Reactors never read DBObjects** — pre-built handle cache only.
5. **Fail loud** — no bare `catch`; defaults fail closed.
6. **Cleanup mirrors creation** — same predicate both directions.
7. **Convert units/coords once, at the boundary** — one mm/m + UCS/WCS policy.
8. **One rounding helper**, one policy, everywhere.
9. **UI-thread discipline** — no `StaticResource`/resource lookup at construction; no work on the wrong thread.
10. **Enforce the 800-line file limit in CI** (big files were named as the regression cause).
11. **A test must fail when the bug exists** — or it isn't a test.
12. **Nothing is "done" until it's driven in AutoCAD** — one deploy → one Tim-confirm → one log entry.
    (~60 fixes sat coded/green/undriven — the #1 reason the tools feel broken. Do not add to that pile.)

---

## 6. 🚨 BUILD & DEPLOY SAFETY (read before any `dotnet build`)

**The hazard:** building `Modules/Drainage/CE_CVL_SUITE.csproj` for `net10.0-windows` WITHOUT
`-p:SkipDevBundle=true` **overwrites Tim's live AutoCAD bundle** in
`%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\...`. This has silently invalidated a field
test before. Therefore:

1. **ALWAYS pass `-p:SkipDevBundle=true`** on every build/test. No exceptions for "quick checks".
2. **Only ONE session deploys** — and only after Tim says, in that conversation, "AutoCAD is closed,
   deploy." Deploying = building once without the skip flag.
3. **After deploying, verify**: SHA256 of the bundle DLL must equal the just-built bin DLL.
4. **Build/version reality:** versions are **hand-edited per project** (no central `Directory.Build.props`
   yet), and the deploy MSBuild targets **silently no-op in the monorepo** because they look for
   `..\Installer\` as a module sibling but it's at the repo root. Fixing this is core Round-7 work.
5. **Worktree builds** need explicit AutoCAD ref paths or you silently build the wrong checkout; the
   net10 lane's ref folder is `autocad-net8-ref` (it holds the AC2027 v26 DLLs despite the name). Check
   `CLAUDE.md` + memory `worktree-build-refpaths` before building from a worktree.

**Never create a new build/deploy/versioning script** without Tim's explicit approval — search first.

---

## 7. 🔒 Secrets — the drawer

- **All keys/tokens live in `C:\Users\TimothyBrand\Keys\keys.txt`** (`KEY_NAME=value` per line). Read
  them at runtime by name. **Never** put a real secret in a repo file, a commit, or a chat message.
- A **global gitignore** (`C:\Users\TimothyBrand\.gitignore_global`) + `~/.claude/rules/common/secrets.md`
  back this up. Repos ship **placeholders** (`*.example`) only; machine-only real config uses
  `*.local.json` (gitignored).
- **Azure two-tier:** `AZURE_READ_SAS` (Read+List) may ship inside the plugin; `AZURE_ADMIN_SAS`
  (Write/Delete) stays on Tim's PC only (`%APPDATA%\CE_SUITE\blob-config.local.json`). The past leak was
  an **admin** SAS committed to the repo — if you ever find a committed secret, **stop, tell Tim, have
  him rotate it** (deleting the file does not un-leak it).

---

## 8. 🔁 Working discipline (every change = 3 deliverables)

Per Tim's plugin-work rule, a change is not done unless it has all three:
1. **Code change.**
2. **Docs:** a `REGRESSION_LOG.md` entry (symptom in AutoCAD terms · root cause · fix · test · "what
   Tim should test in AutoCAD" · what's still at risk); update `BUG_CARPARK.md` / `PARKING_LOT.md` /
   the plan's status.
3. **Tests:** unit tests for any pure logic (NUnit, no AutoCAD runtime); a manual AutoCAD checklist for
   AutoCAD-coupled code.

Bug workflow: **failing test that captures the bug → fix → verify → REGRESSION_LOG entry → the AutoCAD
test checklist.** Never mark a bug FIXED until Tim confirms it in AutoCAD.

---

## 9. ✅ Open items / next actions (verify against the living docs before starting)

**Immediate / small:**
- Ribbon tweaks from Tim (big-tile choices, panel placement, names) — see `§10`.
- **AS/NZS scour velocities** (BUG-080) — the one number-set that unblocks real pipe sizing (rule #1).
- Confirm the naming standardization compat check (bundle/registry names) before renaming.

**Spun-off tasks (may already be underway in their own sessions):** rotate/relocate the Azure SAS;
JobTime billing fix (Centrum/Ben+Ben folder-number collision — real money); pipe auto-sizing
advisory-only flagging.

**The program spine (Rounds 4–9):**
- **Plumbing rebuild** (Round 7 + rules #1/#10): central build config (`Directory.Build.props` /
  `Directory.Packages.props` / `global.json`), fix the `..\Installer\` path so deploy stops no-op'ing,
  de-triplicate the inline-PowerShell build targets, generate manifests from `command-registry.json`.
- **Logs/diagnostics rebuild** (`§6.11`): fix the PID-less false-crash detector, fix the outbox drain,
  put logs in the support bundle, one root + one logger + rolling size caps, cap DWG backups.
- **The plug-in / tool-registry API** (Round 4 design locked; implementation pending) — build the one
  validated registry + local Codex/Claude MCP bridge incrementally on the existing `ICeModule`/`ICeTool` seams.
- **The engineering rulebook build-out** (`§11`) — one sourced/versioned/council-aware authority read
  by tools AND the AI. This is the highest-value artefact; sequence everything after it.

---

## 10. 🪤 Traps & gotchas

- **CONFIDENCE_MATRIX is stale in places** — trust the bug logs over it for "is this tool broken?".
- **Audit §6.9 was mined from records** — verify each item is still broken (and not already fixed on a
  branch) before acting.
- **The update channel silently drops block/DCL updates** (`AssetDeployer`'s `if (!File.Exists(dest))`)
  — a shipped fix may never reach the user's machine. Factor this into "why didn't my fix land?".
- **AI is wired to Drainage only** today (7 hard-coded tool registrations in one file) despite being a
  shared library — a cross-module tool seam is needed for the "AI on both tabs" decision.
- **MarkupAI is parked** (Tim doesn't use it) and calls OpenAI per-workstation + spawns a Python
  process — keep it out of v1; don't invest.
- **Don't reopen settled decisions** — Rounds 0–2, the 12 rules, the ribbon, and the drawer are locked.

---

## 11. 🎯 Definition of done (for the program, from Tim's North Star)

One install · one CE ribbon (discipline-aware) · one auto-update channel · a version you can always
answer "what's live?" for · a plug-in API to add tools without touching the core · a clean structure a
newcomer navigates in <2 min · **no half-built commands** · **multi-chat-safe** · and every kept tool
**confirmed correct in AutoCAD**, not just compiling.

*If you're unsure, ask Tim in a batched tick-list — don't guess on engineering values.*
