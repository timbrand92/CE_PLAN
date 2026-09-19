# PROGRAM BOARD — CE_COMPSHEET fleet (single source of truth)

**Set up 17 Jul 2026 (Fable RCB chat, on Tim's instruction) after three chats spent a day
committing to `master` concurrently.** The cockpit keeps this file honest; workers read it,
never rewrite other lanes' rows.

## ▶ Finishing the program — Codex handoff (added 2026-07-20)

The remaining program is handed to **Codex** (runs locally on Tim's PC) via
`docs/CHAT_PROMPTS/CODEX_MASTER_PROGRAM.md` — one orchestrating doc, 5 phases:
**A** validate engines vs the firm's real jobs (runs the two existing per-lane briefs
`CODEX_VALIDATION_HANDOFF.md` on `fleet/rcb-ui` + `CODEX_CEFRAME_TESTING.md` on
`fleet/ce-frame`) → **B** cockpit integrates the worker branches → **C** build RCB Stage 9
(continuous) → **D** build Frame Phase 4.3 (AS 4100 member design) → **E** close-out. New
engineering in C/D is **gated on a firm engineer's sign-off** (mechanics win, never tune to
match). Workers: don't duplicate Phase A; keep your lane green for the Phase B merge.

## The shape

- `master` = **integration branch, cockpit-only.** No worker commits land here directly
  after migration (see below). The main checkout `C:\Lisp Files\CE_COMPSHEET` becomes the
  cockpit's/Tim's window onto `master`.
- Each worker chat lives in its **own branch + worktree** and never leaves its lane.
- No remote exists yet (local repo only). **Decision for Tim (D1):** add a private remote
  (GitHub/Azure DevOps) so "commit constantly" also means "backed up". Until then, the
  OneDrive-synced disk is the only backup.

## Fleet table

| Chat | Model | Branch | Worktree | Lane (owned paths) | Status |
|---|---|---|---|---|---|
| **Cockpit** | Opus (interactive, Tim) | `master` | main checkout | `docs/PROGRAM_BOARD.md`, merges, queues | prompt: `docs/CHAT_PROMPTS/COCKPIT_CE_COMPSHEET.md` |
| **rcb-engine** | Fable | `fleet/rcb-engine` | `.claude/worktrees/fleet-rcb-engine` | `CE_BEAM_DESIGNER/src/.../Services/Design/Concrete/**`, `As3600FootingChecks` (in PadFootingDesignEngine.cs — announce, see hazards), tests `Rcb*Tests.cs`, `As3600Tests.cs`; `docs/RCB_PHASE2_PLAN.md`; RCB stages 9–10 later | stages 0–5 + A2 basis DONE, dormant until Stage 9 |
| **rcb-ui** | Opus | `fleet/rcb-ui` | `.claude/worktrees/fleet-rcb-ui` | `Models/Beams/ReinforcedConcreteBeam.cs`, `Models/Results/RcbResult.cs`, `Views/RcbInputView*`, `ViewModels/RcbDesignViewModel.cs`, `Services/Design/Concrete/RcbDesignEngine.cs`, `PdfReportService.Rcb.cs`, §7 integration switch files (BeamProject, MainWindowViewModel, MainWindow.xaml, cascade switches, API, marks, takeoff), their tests | **Stage 7 on master: code `565e604` (cockpit rescue) + REGRESSION_LOG `5e05eb7` (rcb-ui — STILL committing on master 2026-07-20); MIGRATE NOW — relay one-liner, then `git merge master` in worktree** |
| **ce-frame** | (Tim's frame chat) | `fleet/ce-frame` | `.claude/worktrees/fleet-ce-frame` | `Services/Calculation/Frame/**`, `Models/Frame/**`, `Frame*` tests, Structure-tab views/VMs (`Frame3DSceneBuilder`, `FrameModelViewModel`), `docs/CE_FRAME_PHASE41_42_PLAN.md` | S1–S9 DONE (second-order engine); S10 UI next |

## Migration steps for the two LIVE chats (Tim relays; one line each)

- **rcb-ui (Opus):** *[2026-07-20: cockpit checkpointed the Stage 6/7 WIP code as `565e604`;
  rcb-ui then committed its Stage 7 REGRESSION_LOG entry as `5e05eb7` — STILL on master.
  `5e05eb7` is rcb-ui's last master commit; it must stop committing on master now.]* Relay:
  *"Stage 7 is fully committed on master (`565e604` code + `5e05eb7` log). STOP committing on
  master. Switch to `C:\Lisp Files\CE_COMPSHEET\.claude\worktrees\fleet-rcb-ui`; first command
  there `git merge master` (picks up both). All future commits go on `fleet/rcb-ui` only.
  Note `565e604` is a WIP checkpoint — reconcile it with your finished Stage 7."*
- **ce-frame:** *"Before your next S10 edit: move to
  `C:\Lisp Files\CE_COMPSHEET\.claude\worktrees\fleet-ce-frame`, run `git merge master`
  first, and commit only on `fleet/ce-frame` from now on."*
- **This chat (rcb-engine)** works from `.claude/worktrees/fleet-rcb-engine` when Stage 9
  starts.

## Golden rules (baked into every prompt; enforced here)

1. Stay in lane; **announce in FLEET_STATUS.md before touching a shared file** (below).
2. Commit every logical unit on YOUR branch; never commit on master; never force-push;
   never merge other branches — merges are the cockpit's job.
3. **Irreversible-action lock:** no installer build/publish/release, no history rewrite,
   no mass delete, no pushing to any remote that later exists — without Tim, interactively.
4. Every change: failing test → code → green → REGRESSION_LOG entry (see conflict rule).
5. Park anything needing Tim under "NEEDS TIM" in your `FLEET_STATUS.md` and keep moving.

## Shared-file hazards + rules

| File | Hazard | Rule |
|---|---|---|
| `MainWindow.xaml` | rcb-ui (toolbar/DataTemplates) AND ce-frame S10 (analysis-type selector) both need it | **rcb-ui owns it** until Stage 8 lands; ce-frame announces in FLEET_STATUS and waits for a cockpit merge, or puts S10 controls in Structure-tab view files it owns |
| `REGRESSION_LOG.md` | everyone prepends entries → guaranteed merge conflicts | prepend-only, one entry per commit; conflicts are trivially both-kept — cockpit resolves on merge, workers NEVER delete others' entries |
| `PadFootingDesignEngine.cs` (`As3600FootingChecks`) | rcb-engine owns, footing behaviour ships | any edit = announce + full footing test filter green |
| `DesignSettings.cs`, `ServiceLocator.cs`, `App.xaml.cs` | small shared registration files | announce in FLEET_STATUS before editing; keep edits additive |
| Test csproj | none — SDK-style glob auto-includes new `.cs` | add test FILES freely, never edit the csproj |
| memory files (`~/.claude/.../memory/`) | all chats write | keep to your own sections; cockpit reconciles contradictions |

## Tim's queues (cockpit refreshes from REGRESSION_LOG statuses)

- **DECISIONS:** D1 remote/backup (above) · E2–E10 engineer questions (RCB plan §10) ·
  CE Frame T-questions (its plan) · E12 EB/IB mark confirm.
- **TEST BACKLOG (in-app, all AWAITING TIM):** Phase 0 entries · RCB-STAGE0 footing
  sanity · AS3600-A2 footing size checks (footings get SMALLER — expected) · CEFRAME-S1/S6
  checks · everything rcb-ui ships from Stage 7 on.

## FLEET_STATUS.md protocol

Each worker keeps `FLEET_STATUS.md` at its worktree root, committed on its branch, updated
every run: current unit, last commit, NEEDS TIM list, shared-file announcements. The
cockpit aggregates all three every session and rewrites this board's status column.
